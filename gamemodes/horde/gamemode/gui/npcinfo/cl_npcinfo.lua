--[[

Author: tochnonement
Email: tochnonement@gmail.com

14/05/2022

--]]

local _R = debug.getregistry()

local cvEnabled = CreateClientConVar('cl_snoi_enabled', '1')
local cv3D2D = CreateClientConVar('cl_snoi_3d2d', '0')
local cvDistance = CreateClientConVar('cl_snoi_distance', '512', nil, nil, nil, 256, 1024)
local cvShowLabel = CreateClientConVar('cl_snoi_show_labels', '1')
local cvShowHealth = CreateClientConVar('cl_snoi_show_health', '1')
local cvMaxRenders = CreateClientConVar('cl_snoi_max_renders', '3', nil, nil, nil, 1, 10)
local cvNPCMaxHeight = CreateClientConVar('cl_snoi_npc_height_limit', '256', nil, nil, nil, 100, 512)
local cvBarLength = CreateClientConVar('cl_snoi_bar_width', '120', nil, nil, nil, 60, 180)
local cvBarColorR = CreateClientConVar('cl_snoi_bar_r', '214', nil, nil, nil, 0, 255)
local cvBarColorG = CreateClientConVar('cl_snoi_bar_g', '48', nil, nil, nil, 0, 255)
local cvBarColorB = CreateClientConVar('cl_snoi_bar_b', '49', nil, nil, nil, 0, 255)

local colorHealth = Color(214, 48, 49)
local colorRed = Color(colorHealth.r, colorHealth.g, colorHealth.b)
local colorHostile = Color(255, 4, 4)
local colorFriendly = Color(119, 255, 88)
local colorNeutral = Color(255, 255, 255)
local nearNPCs = {count = 0}
local distance = cvDistance:GetInt() ^ 2
local fadeStart = distance * .75
local slightOffset = Vector(0, 0, 2)
local fontFamily = 'Nunito'

cvars.AddChangeCallback('cl_snoi_distance', function()
    distance = cvDistance:GetInt() ^ 2
    fadeStart = distance * .75
end)

-- Variables connected to convars bc it's faster
local bEnabled = cvEnabled:GetBool()
local b3D2D = cv3D2D:GetBool()
local bShowLabel = cvShowLabel:GetBool()
local bShowHealth = cvShowHealth:GetBool()
local iMaxRenders = cvMaxRenders:GetInt()
local iBarLength = cvBarLength:GetInt()
local iMaxHeight = cvNPCMaxHeight:GetInt()

do
    local function rebuildColor()
        colorRed = Color(cvBarColorR:GetInt(), cvBarColorG:GetInt(), cvBarColorB:GetInt())
    end
    rebuildColor()
    cvars.AddChangeCallback('cl_snoi_bar_r', rebuildColor)
    cvars.AddChangeCallback('cl_snoi_bar_g', rebuildColor)
    cvars.AddChangeCallback('cl_snoi_bar_b', rebuildColor)

    cvars.AddChangeCallback('cl_snoi_enabled', function() bEnabled = cvEnabled:GetBool() end)
    cvars.AddChangeCallback('cl_snoi_3d2d', function() b3D2D = cv3D2D:GetBool() end)
    cvars.AddChangeCallback('cl_snoi_show_labels', function() bShowLabel = cvShowLabel:GetBool() end)
    cvars.AddChangeCallback('cl_snoi_show_health', function() bShowHealth = cvShowHealth:GetBool() end)
    cvars.AddChangeCallback('cl_snoi_max_renders', function() iMaxRenders = cvMaxRenders:GetInt() end)
    cvars.AddChangeCallback('cl_snoi_bar_width', function() iBarLength = cvBarLength:GetInt() end)
    cvars.AddChangeCallback('cl_snoi_npc_height_limit', function() iMaxHeight = cvNPCMaxHeight:GetInt() end)
end

-- Relationship Enums
local D_ERR = 0
local D_HATE = 1
local D_FEAR = 2
local D_LIKE = 3
local D_NEUTRAL = 4

do
    local function createFont(name, size, font)
        font = font or fontFamily
        surface.CreateFont(name, {
            font = font,
            size = size,
            extended = true
        })

        surface.CreateFont(name .. '.blur', {
            font = font,
            size = size,
            extended = true,
            blursize = 3
        })
    end

    createFont('snoi.3d2d.font', 40)
    createFont('snoi.font', ScreenScale(8))
    createFont('snoi.smallFont', ScreenScale(6))
end

local drawText do
    local SimpleText = draw.SimpleText
    function drawText(text, x, y, color, alx, aly, b3D2D, font)
        local font = font or (not b3D2D and 'snoi.font' or 'snoi.3d2d.font')
        SimpleText(text, font .. '.blur', x, y + 3, color_black, alx, aly)
        SimpleText(text, font, x, y, color, alx, aly)
    end
end

local drawMatGradient do
    local matGradient = Material('vgui/gradient-u.vtf', 'noclamp ignorez')

    local SetMaterial = surface.SetMaterial
    local SetDrawColor = surface.SetDrawColor
    local DrawTexturedRect = surface.DrawTexturedRect

    function drawMatGradient(x, y, w, h, color)
        SetMaterial(matGradient)
        SetDrawColor(color)
        DrawTexturedRect(x, y, w ,h)
    end
end

local function findNPCName(npc)
    if npc.IsZetaPlayer then
        return npc:GetNW2String('zeta_name')
    end

    local model = npc:GetModel()
    local npcList = list.Get('NPC')

    --[[------------------------------
    Search by a model
    --------------------------------]]
    for _, data in pairs(npcList) do
        if data.Model == model then
            local name = data.Name
            name = name:gsub('%(Friendly%)', '', 1)
            name = name:gsub('%(Enemy%)', '', 1)
            name = name:gsub('%(Hostile%)', '', 1)
            name = name:Trim()

            return name
        end
    end

    --[[------------------------------
    Search by a class
    --------------------------------]]
    local npcData = npcList[npc:GetClass()]
    if npcData then
        return npcData.Name
    end

    return 'Unknown'
end

local drawHealthBar do
    local DrawRect = surface.DrawRect
    local SetDrawColor = surface.SetDrawColor
    local colorShade = Color(0, 0, 0, 150)
    local ceil = math.ceil
    local floor = math.floor

    function drawHealthBar(x, y, w, h, npc, hpFraction)
        local snoiOldHealth = npc:GetVar('snoiOldHealth', 0)

        if (CurTime() - npc:GetVar('snoiLastDamage', 0)) > .2 then
            npc.snoiOldHealth = Lerp(RealFrameTime() * 4, snoiOldHealth, hpFraction)
        end

        SetDrawColor(0, 0, 0, 150)
        DrawRect(x, y, w, h)

        local hpLineWidth = ceil(w * hpFraction) - 4
        local whiteLineWidth = floor(w * snoiOldHealth) - 4
        local whiteLineWidthActual = whiteLineWidth - hpLineWidth

        SetDrawColor(color_white)
        DrawRect(x + 2 + hpLineWidth, y + 2, whiteLineWidthActual, h - 4)

        SetDrawColor(colorRed)
        DrawRect(x + 2, y + 2, hpLineWidth, h - 4)

        drawMatGradient(x + 2, y + 2, hpLineWidth, h - 4, colorShade)
    end
end

--[[------------------------------
Receive health/relationships updates (the engine updates health on the clientside with large delay)
--------------------------------]]
local getNPCHealth do
    local ReadUInt = net.ReadUInt
    local IsValid = IsValid
    local Entity = Entity

    net.Receive('snoi:UpdateHealth', function()
        local entIndex = ReadUInt(16)
        local hp = ReadUInt(15)
        local npc = Entity(entIndex)

        if IsValid(npc) then
            npc.snoiHealth = hp
            npc.snoiLastDamage = CurTime()
        end
    end)

    net.Receive('snoi:UpdateRelations', function()
        local entIndex = ReadUInt(16)
        local relations = ReadUInt(3)
        local npc = Entity(entIndex)

        if IsValid(npc) then
            npc.snoiRelations = relations
        end
    end)

    net.Receive('snoi:SetDead', function()
        local entIndex = ReadUInt(16)
        local npc = Entity(entIndex)

        if IsValid(npc) then
            npc.snoiIsDead = true
        end
    end)

    function getNPCHealth(npc)
        -- engine delay is about 60ms
        if npc.IsZetaPlayer then
            return npc:GetNW2Int('zeta_health', 0)
        end
        if npc.snoiLastDamage and (CurTime() - npc.snoiLastDamage) < .6 then
            return npc:GetVar('snoiHealth', npc:Health())
        end
        return npc:Health()
    end
end

--[[------------------------------
A timer to collect the nearest NPCs
--------------------------------]]
do
    local rate = 1 / 10

    local LocalPlayer = LocalPlayer
    local IsValid = IsValid
    local GetPos = _R.Entity.GetPos
    local GetRenderBounds = _R.Entity.GetRenderBounds
    local DistToSqr = _R.Vector.DistToSqr
    local GetNormalized = _R.Vector.GetNormalized
    local GetAimVector = _R.Player.GetAimVector
    local Dot = _R.Vector.Dot
    local TraceLine = util.TraceLine
    local sort = table.sort
    local zOffsetVector = Vector(0, 0, 0)
    local math_min = math.min

    local traceOut = {}
    local traceIn = {
        output = traceOut,
        filter = true,
        start = true,
        endpos = true,
        mask = MASK_VISIBLE
    }

    local function getOffset(ent)
        local _, max = GetRenderBounds(ent)
        zOffsetVector.z = math_min(max.z, iMaxHeight)
        return zOffsetVector + slightOffset
    end

    timer.Create('snoi.StoreNearestNPCs', rate, 0, function()
        if not bEnabled then return end
        if snoiNPCs.count < 1 then return end

        local client = MySelf
        if IsValid(client) then
            local pos = client:EyePos()
            local vec = GetAimVector(client)

            nearNPCs = {count = 0}

            for i = 1, snoiNPCs.count do
                local ent = snoiNPCs[i]
                if IsValid(ent) then
                    local offset = getOffset(ent)
                    local entpos = GetPos(ent) + offset
                    local dist = DistToSqr(pos, entpos)

                    if dist <= distance then
                        local index = nearNPCs.count + 1
                        local dot = Dot(vec, GetNormalized(GetPos(ent) - GetPos(client)))

                        ent.snoiName = ent.snoiName or findNPCName(ent)
                        ent.snoiDistance = dist
                        ent.snoiDotProduct = dot
                        ent.snoiRenderOffset = offset

                        traceIn.filter = client
                        traceIn.start = pos
                        traceIn.endpos = entpos
                        TraceLine(traceIn)

                        if not traceOut.Hit then
                            nearNPCs[index] = ent
                            nearNPCs.count = index
                        end
                    end
                end
            end

            if nearNPCs.count > 1 then
                sort(nearNPCs, function(a, b)
                    return a.snoiDotProduct > b.snoiDotProduct
                end)
            end
        end
    end)
end


--[[------------------------------
Display info (3D2D)
--------------------------------]]
do
    local GetPos = _R.Entity.GetPos
    local GetRenderBounds = _R.Entity.GetRenderBounds
    local EyeAngles = EyeAngles
    local Start3D2D = cam.Start3D2D
    local End3D2D = cam.End3D2D
    local min = math.min

    local scale = .05
    local angle = Angle(0, 0, 90)
    local infoWidth = 400
    local infoHeight = 25

    local function renderInfo(npc)
        local _, max = GetRenderBounds(npc)
        local zOffsetVector = Vector(0, 0, max.z)
        local pos = GetPos(npc) + zOffsetVector + slightOffset
        local ang = angle

        local hpFraction = min(1, getNPCHealth(npc) / npc:GetMaxHealth())

        if hpFraction <= 0 then
            return
        end

        local color = colorNeutral
        local relations = npc:GetVar('snoiRelations', 0)

        if relations == D_LIKE then
            color = colorFriendly
        elseif relations == D_HATE then
            color = colorHostile
        end

        Start3D2D(pos, ang, scale)
            local x, y = -infoWidth * .5, 0

            --drawHealthBar(x, y, infoWidth, infoHeight, npc, hpFraction)
            --drawText(npc.snoiName, 0, -40, color, 1, 1, true)

            surface.SetMaterial(Material("materials/status/break.png"))
            surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
            surface.DrawTexturedRect(0, 0, 64, 64)
        End3D2D()
    end

    --[[hook.Add('PostDrawTranslucentRenderables', 'snoi.RenderInfo', function()
        --if not bEnabled then return end
        angle.y = EyeAngles().y - 90
        local count = min(nearNPCs.count, iMaxRenders)
        for i = 1, count do
            local npc = nearNPCs[i]
            if IsValid(npc) then
                renderInfo(npc)
            end
        end
    end)]]--
end