surface.CreateFont("Icon", { font = "arial", size = 64 })
surface.CreateFont("Rank", { font = "arial", size = 32 })

net.Receive("Horde_OnEnemyDebuffRemove", function ()
    local ent = net.ReadEntity()
    local debuffs = net.ReadTable()
    ent.Horde_Debuffs = debuffs
end)

local holdout_mat = Material("status/hold.png")
local hold_zones = {}

net.Receive("Horde_SyncHoldLocation", function ()
    local zone_id = net.ReadUInt(4)
    local holdoutzone_pos = net.ReadVector()
    local obbmins = net.ReadVector()
    local obbmaxs = net.ReadVector()
    local indicator_pos

    local tr = util.TraceLine({
        start = holdoutzone_pos,
        endpos = holdoutzone_pos + Vector(0,0,-1) * 1000,
        mask = MASK_NPCWORLDSTATIC
    })

    if tr.Hit then
        indicator_pos = tr.HitPos + Vector(0,0,75)
    else
        indicator_pos = holdoutzone_pos
    end

    hold_zones[zone_id] = {IndicatorPos = indicator_pos, Pos = holdoutzone_pos, OBBMins = obbmins, OBBMaxs = obbmaxs, Progress = 0}
end)

net.Receive("Horde_SyncHoldEnd", function ()
    local zone_id = net.ReadUInt(4)
    hold_zones[zone_id] = nil
end)

net.Receive("Horde_SyncHoldProgress", function ()
    local zone_id = net.ReadUInt(4)
    hold_zones[zone_id].Progress = net.ReadUInt(8)
end)

local obj_mat = Material("status/objective.png")
local payloads = {}
local payload_destinations = {}

net.Receive("Horde_SyncPayloadEnd", function ()
    payloads = {}
    payload_destinations = {}
end)

net.Receive("Horde_SyncPayloadSpawnEnd", function ()
    local spawn_id = net.ReadUInt(4)
    payloads[spawn_id] = nil
end)

net.Receive("Horde_SyncPayloadLocation", function ()
    local id = net.ReadUInt(4)
    if not payloads[id] then
        payloads[id] = {}
    end
    payloads[id].Pos = net.ReadVector()
    if not payloads[id].Icon then
        payloads[id].Icon = Material(HORDE.Payload_Icon[0])
    end
end)

net.Receive("Horde_SyncPayloadDestinationLocation", function ()
    local id = net.ReadUInt(4)
    local pos = net.ReadVector()
    local obbmins = net.ReadVector()
    local obbmaxs = net.ReadVector()
    local indicator_pos

    local tr = util.TraceLine({
        start = pos,
        endpos = pos + Vector(0,0,-1) * 1000,
        mask = MASK_NPCWORLDSTATIC
    })

    if tr.Hit then
        indicator_pos = tr.HitPos + Vector(0,0,75)
    else
        indicator_pos = pos
    end

    payload_destinations[id] = {IndicatorPos = indicator_pos, Pos = pos, OBBMins = obbmins, OBBMaxs = obbmaxs, Progress = 0}
end)

net.Receive("Horde_SyncPayloadIcon", function ()
    local id = net.ReadUInt(4)
    local mat = net.ReadUInt(4)
    payloads[id].Icon = Material(HORDE.Payload_Icon[mat])
end)

local escape_mat = Material("status/escape.png")
local escape_zones = {}
net.Receive("Horde_SyncEscapeLocation", function ()
    local zone_id = net.ReadUInt(4)
    local pos = net.ReadVector()
    local obbmins = net.ReadVector()
    local obbmaxs = net.ReadVector()
    local indicator_pos

    local tr = util.TraceLine({
        start = pos,
        endpos = pos + Vector(0,0,-1) * 500,
        mask = MASK_NPCWORLDSTATIC
    })

    if tr.Hit then
        indicator_pos = tr.HitPos + Vector(0,0,75)
    else
        indicator_pos = pos
    end

    escape_zones[zone_id] = {IndicatorPos = indicator_pos, Pos = pos, OBBMins = obbmins, OBBMaxs = obbmaxs, Progress = 0}
end)

net.Receive("Horde_SyncEscapeEnd", function ()
    escape_zones = {}
end)

local shldmat = Material('models/horde/antimatter_shield/wall')
local function Render(bdepth, bskybox)
    if bskybox then return end

    for _, ply in pairs(player.GetAll()) do
        if not IsValid(ply) or (ply == MySelf) or (not ply:Alive()) then
            goto cont
        end

        local attachment_id = ply:LookupAttachment("anim_attachment_head") or 0 -- Can't take any chances with nils here
        local attachment = ply:GetAttachment(attachment_id)

        local base_pos = Vector()

        if attachment and attachment.Pos then -- Would've been too ugly with a ternary
            base_pos = attachment.Pos
        else
            base_pos = (ply:LocalToWorld(ply:OBBCenter()) + ply:GetUp() * 24)
        end

        local render_pos = base_pos + ply:GetUp() * 15

        -- Distance fading
        local render_mindist = 500
        local render_maxdist = render_mindist + 80

        local dist = (render_pos - EyePos()):Length()
        local dist_clamped = math.Clamp(dist, render_mindist, render_maxdist)
        local dist_alpha = math.Remap(dist_clamped, render_mindist, render_maxdist, 200, 0)

        if dist_alpha == 0 then goto cont end -- Nothing to render

        -- Colors
        local fade_white = Color(255, 255, 255, dist_alpha)

        -- Render ang
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)

        local subclass_name = ply:Horde_GetCurrentSubclass()
        if not subclass_name then return end
        local subclass = HORDE.subclasses[subclass_name]
        if not subclass then subclass = HORDE.subclasses["Survivor"] end
        local mat = Material(subclass.Icon, "mips smooth")
        local loc_class = translate.Get("Class_" .. subclass.PrintName) or subclass.PrintName
        local len = string.len(loc_class) * 6
        local rank = ply:Horde_GetRank(subclass.PrintName) or HORDE.Rank_Novice
        local rank_level = ply:Horde_GetRankLevel(subclass.PrintName)
        local loc_rank = "[" .. translate.Get("Rank_" .. rank) .. "]"

        cam.Start3D2D(render_pos, render_ang, 0.1)
            surface.SetMaterial(mat)
            surface.SetDrawColor(HORDE.Rank_Colors[rank])
            local pos = - 64 - len - 20
            surface.DrawTexturedRect(pos, -64 / 2, 64, 64)
            
            if rank == HORDE.Rank_Master then
                draw.SimpleText(rank_level, "Trebuchet24", pos - 5, -32 + 15, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(loc_class, "Icon", len + 8, 0, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                if rank_level > 0 then
                    local star = Material("star.png", "mips smooth")
                    surface.SetMaterial(star)
                    local y_pos = 15
                    for i = 0, rank_level - 1 do
                        surface.DrawTexturedRect(pos - 10, y_pos, 10, 10)
                        y_pos = y_pos - 7
                    end
                end
                draw.SimpleText(loc_class, "Icon", len + 8, 0, fade_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            draw.SimpleText(loc_rank, "Rank", 0, -54, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        cam.End3D2D()
        ::cont::
    end

    if HORDE.Player_Looking_At_Minion then
        local npc = HORDE.Player_Looking_At_Minion
        if not npc:IsValid() or npc:Health() <= 0 then return end
        local base_pos = Vector()
        base_pos = (npc:LocalToWorld(npc:OBBCenter()) + npc:GetUp() * 24)

        local render_pos = base_pos

        -- Distance fading
        local render_mindist = 800
        local render_maxdist = render_mindist + 80

        local dist = (render_pos - EyePos()):Length()
        local dist_clamped = math.Clamp(dist, render_mindist, render_maxdist)
        local dist_alpha = math.Remap(dist_clamped, render_mindist, render_maxdist, 200, 0)

        if dist_alpha == 0 then return end -- Nothing to render

        -- Render ang
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)

        cam.IgnoreZ(true)
        cam.Start3D2D(render_pos, render_ang, 0.35)
            draw.SimpleTextOutlined(tostring(npc:Health()) .. "/" .. tostring(npc:GetMaxHealth()), "DermaDefault", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
        cam.End3D2D()
        cam.IgnoreZ(false)
    end

    if not table.IsEmpty(hold_zones) then
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)
        
        for id, param in pairs(hold_zones) do
            cam.IgnoreZ(true)
            cam.Start3D2D(param.IndicatorPos, render_ang, 0.35)
                surface.SetMaterial(holdout_mat)
                surface.SetDrawColor(Color(0, 255, 0))
                surface.DrawTexturedRect(-32, 0, 64, 64)

                if hold_zones[id].Progress > 0 then
                    draw.RoundedBox(0, -100, 70, 200, 10, HORDE.color_hollow)
                    draw.RoundedBox(0, -100, 70, hold_zones[id].Progress * 2, 10, Color(0, 255, 0))
                    draw.SimpleText("Hold Progress", "Trebuchet18", 0, 95, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
                end
            cam.End3D2D()
            cam.IgnoreZ(false)

            render.SetMaterial(shldmat)
            render.DrawBox(param.Pos, Angle(0,0,0), param.OBBMins, param.OBBMaxs, Color(0,255,0))
        end
    end

    if not table.IsEmpty(payloads) and not table.IsEmpty(payload_destinations) then
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)

        for id, param in pairs(payloads) do
            cam.IgnoreZ(true)
            cam.Start3D2D(param.Pos, render_ang, 0.35)
                surface.SetMaterial(param.Icon)
                surface.SetDrawColor(Color(255, 255, 255))
                surface.DrawTexturedRect(-32, 0, 64, 64)

                draw.SimpleText("Collect", "Trebuchet18", 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
            cam.End3D2D()
            cam.IgnoreZ(false)
        end

        for id, param in pairs(payload_destinations) do
            cam.IgnoreZ(true)
            cam.Start3D2D(param.IndicatorPos, render_ang, 0.35)
                surface.SetMaterial(obj_mat)
                surface.SetDrawColor(Color(0, 255, 0))
                surface.DrawTexturedRect(-32, 0, 64, 64)

                draw.SimpleText("Deliver", "Trebuchet18", 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
            cam.End3D2D()
            cam.IgnoreZ(false)

            render.SetMaterial(shldmat)
            render.DrawBox(param.Pos, Angle(0,0,0), param.OBBMins, param.OBBMaxs, Color(0,255,0))
        end
    end

    if not table.IsEmpty(escape_zones) then
        local render_ang = EyeAngles()
        render_ang:RotateAroundAxis(render_ang:Right(),90)
        render_ang:RotateAroundAxis(-render_ang:Up(),90)

        for id, param in pairs(escape_zones) do
            cam.IgnoreZ(true)
            cam.Start3D2D(param.IndicatorPos, render_ang, 0.35)
                surface.SetMaterial(escape_mat)
                surface.SetDrawColor(Color(0, 255, 0))
                surface.DrawTexturedRect(-32, 0, 64, 64)

                draw.SimpleText("Escape", "Trebuchet18", 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
            cam.End3D2D()
            cam.IgnoreZ(false)

            render.SetMaterial(shldmat)
            render.DrawBox(param.Pos, Angle(0,0,0), param.OBBMins, param.OBBMaxs, Color(0,255,0))
        end
    end
end


if GetConVar("horde_enable_3d2d_icon"):GetInt() == 1 then
    hook.Add("PostDrawTranslucentRenderables", "Horde_RenderClassIcon", Render)

    --hook.Add("HUDPaint", "Horde_RenderDebuffs", RenderDebuffs)
end