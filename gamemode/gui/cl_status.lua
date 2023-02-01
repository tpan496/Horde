local plymeta = FindMetaTable("Player")

function plymeta:SetStatus(status, stack)
    if not self.Horde_StatusTable then self.Horde_StatusTable = {} end
    if stack <= 0 then
        self.Horde_StatusTable[status] = nil
    else
        self.Horde_StatusTable[status] = stack
    end
end

function plymeta:GetStatusTable()
    return self.Horde_StatusTable
end

local status_color = {
    [HORDE.Status_Ignite] = HORDE.DMG_COLOR[HORDE.DMG_FIRE],
    [HORDE.Status_Frostbite] = HORDE.DMG_COLOR[HORDE.DMG_COLD],
    [HORDE.Status_Shock] = HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING],
    [HORDE.Status_Break] = HORDE.DMG_COLOR[HORDE.DMG_POISON],
    [HORDE.Status_Bleeding] = HORDE.color_crimson_violet,
    [HORDE.Status_Decay] = HORDE.STATUS_COLOR[HORDE.Status_Decay],
    [HORDE.Status_Necrosis] = HORDE.STATUS_COLOR[HORDE.Status_Necrosis]
}

local function DrawTextWithShadow(text, font, x, y, col, align_x, align_y)
    if not col then col = color_white end
    if not align_x then align_x = TEXT_ALIGN_LEFT end
    if not align_y then align_y = TEXT_ALIGN_TOP end
    draw.SimpleText(text, font, x, y, col, align_x, align_y)
    draw.TextShadow({text=text, font=font, pos = {x,y}, xalign = align_x, yalign = align_y, color=col}, ScreenScale(1), 100)
end

-- Stack < 0 means disabled
-- Stack = 0 means enabled for non-stacking status
local function DrawStatus(status, stack, displacement)
    if stack <= 0 then return end
    if not HORDE.Status_Icon[status] then return end
    local mat
    if status < HORDE.Status_Armor_Survivor or status >= HORDE.Status_ExpDisabled then
        if HORDE:IsSkillStatus(status) then
            draw.RoundedBox(10, ScreenScale(displacement)/4, 0, ScreenScale(12.5), ScreenScale(12.5), Color(40,40,40,200))
    
            mat = Material(HORDE.Status_Icon[status], "mips smooth")
    
            surface.SetMaterial(mat)
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(ScreenScale(5 + displacement)/4, ScreenScale(5/4), ScreenScale(10), ScreenScale(10))
    
            local cd = LocalPlayer():Horde_GetPerkInternalCooldown()
            if cd > 0 then
                draw.RoundedBox(10, ScreenScale(displacement)/4, 0, ScreenScale(12.5), ScreenScale(12.5), Color(40,40,40,200))
                surface.SetDrawColor(color_white)
                draw.SimpleText(cd, "Trebuchet24", ScreenScale(displacement + 25)/4, ScreenScale(25/4), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local charge = LocalPlayer():Horde_GetPerkCharges()
            if HORDE:IsStackableSkillStatus(status) and charge >= 0 then
                draw.SimpleText(charge, "Trebuchet24", ScreenScale(displacement + 39)/4, ScreenScale(10/4), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            return
        end
        local color = color_white
        if status_color[status] then
            color = status_color[status]
        end
        if color ~= color_white then
            if stack < 100 then
                draw.RoundedBox(5, 0 + ScreenScale(displacement/4), ScreenScale(55/4), ScreenScale(50/4), ScreenScale(10/4), Color(40,40,40,200))
                draw.RoundedBox(5, 0 + ScreenScale(displacement/4), ScreenScale(55/4), ScreenScale(50 * stack / 400), ScreenScale(10/4), HORDE.color_crimson_violet)
            else
                draw.RoundedBox(10, 0 + ScreenScale(displacement/4), 0, ScreenScale(50/4), ScreenScale(50/4), HORDE.color_crimson_violet)
            end
            draw.RoundedBox(10, 0 + ScreenScale(displacement/4), 0, ScreenScale(50/4), ScreenScale(50/4), Color(40,40,40,200))
        else
            draw.RoundedBox(10, 0 + ScreenScale(displacement/4), 0, ScreenScale(50/4), ScreenScale(50/4), Color(40,40,40,200))
        end

        mat = Material(HORDE.Status_Icon[status], "mips smooth")

        surface.SetMaterial(mat)
        surface.SetDrawColor(color)
        surface.DrawTexturedRect(ScreenScale(5 + displacement)/4, ScreenScale(5/4), ScreenScale(10), ScreenScale(10))
    else
        draw.RoundedBox(10, ScreenScale(displacement/4), 0, ScreenScale(50/4), ScreenScale(50/4), Color(40,40,40,200))
        mat = Material(HORDE.Status_Icon[status])
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(ScreenScale(-15 + displacement)/4, ScreenScale(5/4), ScreenScale(20), ScreenScale(10))
    end

    if stack > 0 and HORDE:IsStatusStackable(status) then
        draw.SimpleText(stack, "Trebuchet24", ScreenScale(40 + displacement)/4, ScreenScale(2.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function DrawBuildup(status, buildup, x, y)
    if buildup <= 0 or not HORDE:IsDebuff(status) then return end
    local mat
    local color = color_white
    if status_color[status] then
        color = status_color[status]
    end

    draw.RoundedBox(5, x + 50, y + 10, 200, 15, Color(40,40,40,200))
    if buildup < 100 then
        draw.RoundedBox(5, x + 50, y + 10, 200 * buildup / 100, 15, HORDE.color_crimson_dark)
    else
        draw.RoundedBox(5, x + 50, y + 10, 200 * buildup / 100, 15, HORDE.color_crimson)
    end
    draw.RoundedBox(10, x, y, 40, 40, Color(40,40,40,200))

    mat = Material(HORDE.Status_Icon[status], "mips smooth")

    surface.SetMaterial(mat)
    surface.SetDrawColor(color)
    surface.DrawTexturedRect(5 + x, 5 + y, 30, 30)
end

local status_panel = vgui.Create("DPanel")
status_panel:SetSize(ScreenScale(125), ScreenScale(25))
status_panel:SetPos(ScreenScale(6), ScreenScale(135/4))
status_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer():GetStatusTable() then
        local pos = 0
        for status, stack in SortedPairs(LocalPlayer():GetStatusTable()) do
            if HORDE:IsDebuff(status) and stack < 100 then goto cont end
            if not HORDE.Status_Icon[status] then goto cont end
            DrawStatus(status, stack, pos)
            pos = pos + 55
            ::cont::
        end
    end
end

local function DrawActivePerk(perk, cd, pos)
    draw.RoundedBox(10, pos, 0, 50, 50, Color(40,40,40,200))

    local mat = Material(HORDE.Status_Icon[perk], "mips smooth")
    surface.SetMaterial(mat) -- Use our cached material
    --surface.SetDrawColor(HORDE.color_gadget_active)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(5 + pos, 5, 40, 40)

    if cd > 0 then
        draw.RoundedBox(10, pos, 0, 50, 50, Color(40,40,40,200))
        surface.SetDrawColor(color_white)
        draw.SimpleText(cd, "Trebuchet24", pos + 25, 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local total_buildup = 0
local buildup_panel = vgui.Create("DPanel")
buildup_panel:SetSize(500, 400)
buildup_panel:SetPos(ScrW() / 2 - 250, ScrH() - 400)
buildup_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer():GetStatusTable() then
        local posx = 125
        local posy = 200
        posy = posy - (total_buildup) * 55 / 2
        for status, stack in pairs(LocalPlayer():GetStatusTable()) do
            if HORDE:IsDebuff(status) then
                if stack <= 0 then goto cont end
                DrawBuildup(status, stack, posx, posy)
                posy = posy + 45
                ::cont::
            end
        end
    end
end

net.Receive("Horde_SyncStatus", function()
    local status = net.ReadUInt(8)
    local stack = net.ReadUInt(8)

    if LocalPlayer().SetStatus then
        LocalPlayer():SetStatus(status, stack)
    end

    total_buildup = 0
    if not LocalPlayer().GetStatusTable then return end
    for s, buildup in pairs(LocalPlayer():GetStatusTable()) do
        if HORDE:IsDebuff(s) then
            if buildup <= 0 then goto cont end
            total_buildup = total_buildup + 1
        end
        ::cont::
    end
end)

local armor_table = {
    armor_survivor = HORDE.Status_Armor_Survivor,
    armor_assault = HORDE.Status_Armor_Assault,
    armor_heavy = HORDE.Status_Armor_Heavy,
    armor_demolition = HORDE.Status_Armor_Demolition,
    armor_ghost = HORDE.Status_Armor_Ghost,
    armor_medic = HORDE.Status_Armor_Medic,
    armor_engineer = HORDE.Status_Armor_Engineer,
    armor_warden = HORDE.Status_Armor_Warden,
    armor_cremator = HORDE.Status_Armor_Cremator,
    armor_berserker = HORDE.Status_Armor_Berserker,
}

net.Receive("Horde_SyncSpecialArmor", function()
    local armor = net.ReadString()
    local on = net.ReadUInt(3)

    if LocalPlayer().SetStatus then
        LocalPlayer():SetStatus(armor_table[armor], on)
    end
end)

net.Receive("Horde_SyncActivePerk", function()
    local status = net.ReadUInt(8)
    local on = net.ReadUInt(3)

    if on == 1 then
        LocalPlayer().Horde_ActivePerk = status
    else
        LocalPlayer().Horde_ActivePerk = nil
    end

    if LocalPlayer().SetStatus then
        LocalPlayer():SetStatus(status, on)
    end
end)

net.Receive("Horde_ClearStatus", function()
    LocalPlayer().Horde_StatusTable = {}
end)

local barrier_panel = vgui.Create("DPanel")
barrier_panel:SetSize(500, 200)
barrier_panel:SetPos(ScrW() / 2 - 50, ScrH() / 2 + 50)
barrier_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer().Horde_BarrierStack and LocalPlayer().Horde_BarrierStack > 0 then
        local mat = Material("status/barrier.png")
        surface.SetDrawColor(255, 255, 255, 150)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(0, 0, 100, 100)

        draw.SimpleText(tostring(LocalPlayer().Horde_BarrierStack), "Trebuchet24", 40, 90, Color(255, 255, 255, 150))
    end
end

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudAmmo"] = true
}

hook.Add("HUDShouldDraw", "Horde_HideHUD", function(name)
	if ( hide[ name ] ) then
		return false
	end
end)

local hp = Material("status/hp.png", "smooth")
local armor = Material("status/armor.png", "mips smooth")
local weight = Material("weight.png")
local vhp = 0
local varmor = 0
surface.CreateFont("HealthInfo", { font = "arial", size = ScreenScale(15), extended = true})
surface.CreateFont("HealthInfo2", { font = "arial", size = ScreenScale(12), extended = true})
surface.CreateFont("Horde_WeaponName", { font = "arial", size = ScreenScale(6), extended = true})
surface.CreateFont("Horde_Weight", { font = "arial", size = ScreenScale(8), extended = true})
local font = "HealthInfo"
local font2 = "HealthInfo2"
local font3 = "Horde_WeaponName"
local fontweight = "Horde_Weight"
hook.Add("HUDPaint", "Horde_DrawHud", function ()
    local colhp = Color(255, 255, 255, 255)
    local gotarmor = false
    local airgap = ScreenScale(6)
    
    draw.RoundedBox(10, airgap, ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(25), ScreenScale(26) + airgap, Color(40,40,40,150))
    draw.RoundedBox(10, airgap, ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(70), ScreenScale(26) + airgap, Color(40,40,40,150))

    -- Draw Class
    local subclass = HORDE.subclasses[LocalPlayer():Horde_GetCurrentSubclass()]
    if not subclass then subclass = HORDE.subclasses[HORDE.Class_Survivor] end
    local display_name = subclass.PrintName
    local class_icon = Material(subclass.Icon, "mips smooth")
    local level = LocalPlayer():Horde_GetLevel(display_name)
    local rank, rank_level = HORDE:LevelToRank(level)
    local class_icon_s = ScreenScale(24)
    surface.SetMaterial(class_icon)
    surface.SetDrawColor(HORDE.Rank_Colors[rank])
    local class_icon_x = airgap + ScreenScale(4)
    local class_icon_y = ScrH() - airgap - ScreenScale(28)
    surface.DrawTexturedRect(class_icon_x, class_icon_y, class_icon_s, class_icon_s)
    if rank == HORDE.Rank_Master then
        draw.SimpleText(rank_level, "Trebuchet18", class_icon_x, class_icon_y, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        if rank_level > 0 then
            local star = Material("star.png", "mips smooth")
            surface.SetMaterial(star)
            local x_pos = class_icon_x
            local y_pos = class_icon_y + ScreenScale(12)
            for i = 0, rank_level - 1 do
                surface.DrawTexturedRect(x_pos - ScreenScale(3), y_pos, ScreenScale(4), ScreenScale(4))
                y_pos = y_pos - ScreenScale(3)
            end
        end
    end

    if LocalPlayer():Health() <= 30 then
        colhp = Color(150, 0, 0)
    end

    vhp = LocalPlayer():Health()
    varmor = LocalPlayer():Armor()

    local icon_s = ScreenScale(15)
    local icon_x = airgap + ScreenScale(34)
    local icon_y = ScrH() - airgap - ScreenScale(32)

    surface.SetMaterial(hp)
    surface.SetDrawColor(colhp)
    surface.DrawTexturedRect(icon_x, icon_y, icon_s, icon_s)
    surface.SetMaterial(armor)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(icon_x, icon_y + ScreenScale(15), icon_s, icon_s)

    --DrawTextWithShadow(tostring(math.Round(vhp)), font, icon_x + icon_s + ScreenScale(1), icon_y, colhp)
    draw.SimpleText(tostring(math.Round(vhp)), font, icon_x + icon_s + ScreenScale(1), icon_y, colhp)
    draw.SimpleText(tostring(math.Round(varmor)), font, icon_x + icon_s + ScreenScale(1), icon_y + ScreenScale(15), color_white)

    --draw.RoundedBox(10, airgap, ScrH() - ScreenScale(45) - airgap, airgap + ScreenScale(70), ScreenScale(1) + airgap, Color(40,40,40,150))
    -- Draw Ammo
    draw.RoundedBox(10, ScrW() - airgap - ScreenScale(78), ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(70), ScreenScale(26) + airgap, Color(40,40,40,150))

    local wpn = LocalPlayer():GetActiveWeapon()
    if not wpn or not wpn:IsValid() then return end
    local col_ammo = color_white
    local col_ammo2 = color_white
    
    if LocalPlayer():Horde_GetInfusion(wpn:GetClass()) ~= HORDE.Infusion_None then
        local infusion = LocalPlayer():Horde_GetInfusio_n(wpn:GetClass())
        local infusion_mat = Material(HORDE.Infusion_Icons[infusion], "mips smooth")
        surface.SetMaterial(infusion_mat)
        surface.SetDrawColor(HORDE.Infusion_Colors[infusion])
        surface.DrawTexturedRect(ScrW() - ScreenScale(16), icon_y, ScreenScale(6), ScreenScale(6))
    end
    if (wpn:GetMaxClip1() > 0 or wpn:Clip1() > 0) and (wpn:GetMaxClip2() > 0 or wpn:Clip2() > 0) then
        local c1 = color_white
        local c2 = color_white
        if wpn:Clip1() == 0 then c1 = Color(100,0,0) end
        if wpn:Clip2() == 0 then c2 = Color(100,0,0) end
        draw.SimpleText(tostring(wpn:Clip1() .. " / " .. LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType())), font, ScrW() - ScreenScale(20), icon_y + ScreenScale(13), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(wpn:Clip2() .. " / " .. LocalPlayer():GetAmmoCount(wpn:GetSecondaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(24), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    elseif (wpn:GetMaxClip1() > 0 or wpn:Clip1() > 0) then
        local c1 = color_white
        local c2 = color_white
        if wpn:Clip1() == 0 then c1 = Color(100,0,0) end
        if LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
        draw.SimpleText(tostring(wpn:Clip1()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(17), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    elseif (wpn:GetMaxClip2() > 0 or wpn:Clip2() > 0) then
        local c1 = color_white
        local c2 = color_white
        if wpn:Clip2() == 0 then c1 = Color(100,0,0) end
        if LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
        draw.SimpleText(tostring(wpn:Clip2()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(LocalPlayer():GetAmmoCount(wpn:GetSecondaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(17), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    elseif wpn:GetPrimaryAmmoType() > 0 then
        local c1 = color_white
        local c2 = color_white
        if wpn:Clip1() == 0 then c1 = Color(100,0,0) end
        if LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
        --draw.SimpleText(tostring(wpn:Clip1()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(17), c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(47), icon_y + ScreenScale(15), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    -- Draw Weight
    draw.RoundedBox(10, ScrW() - airgap - ScreenScale(78), ScrH() - ScreenScale(44) - airgap, airgap + ScreenScale(70), ScreenScale(10), Color(40,40,40,150))
    surface.SetMaterial(weight)
    surface.SetDrawColor(color_white)
    local wx = ScrW() - airgap - ScreenScale(80)
    local wy = ScrH() - ScreenScale(46) - airgap
    surface.DrawTexturedRect(wx + ScreenScale(65), wy + ScreenScale(2), ScreenScale(10), ScreenScale(10))
    draw.SimpleText(tostring(LocalPlayer():Horde_GetMaxWeight() - LocalPlayer():Horde_GetWeight()) .. "/" .. tostring(LocalPlayer():Horde_GetMaxWeight()), fontweight, wx + ScreenScale(65), wy + ScreenScale(3), color_white, TEXT_ALIGN_RIGHT)
    draw.SimpleText(tostring(LocalPlayer():Horde_GetMoney()) .. " $", fontweight, wx + ScreenScale(4), wy + ScreenScale(3), color_white)

    -- Draw Gadget
    if LocalPlayer():Horde_GetGadget() ~= nil then
        local gadget = LocalPlayer():Horde_GetGadget()
        local charge = LocalPlayer():Horde_GetGadgetCharges()
        local cd = LocalPlayer():Horde_GetGadgetInternalCooldown()
        local x = ScrW() - airgap - ScreenScale(78) - ScreenScale(33)
        local y = ScrH() - ScreenScale(33) - airgap
        local s = ScreenScale(26) + airgap
        draw.RoundedBox(10, x, y, s, s, Color(40,40,40,150))

        local mat = Material(HORDE.gadgets[gadget].Icon, "mips smooth")
        surface.SetMaterial(mat) -- Use our cached material
        if HORDE.gadgets[gadget].Active then
            if HORDE.gadgets[gadget].Once then
                surface.SetDrawColor(HORDE.color_gadget_once)
            else
                surface.SetDrawColor(HORDE.color_gadget_active)
            end
        else
            surface.SetDrawColor(color_white)
        end
        surface.DrawTexturedRect(x - ScreenScale(14), y + ScreenScale(1), ScreenScale(60), ScreenScale(30))

        if cd > 0 then
            draw.RoundedBox(10, x, y, s, s, Color(40,40,40,225))
            surface.SetDrawColor(color_white)
            draw.SimpleText(cd, font, x + s/2, y + s/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if charge >= 0 then
            draw.SimpleText(charge, fontweight, x + s - ScreenScale(5), y + ScreenScale(5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)

-- Override health, armor and ammo
function ArcCW:ShouldDrawHUDElement(ele)
    if ele == "CHudHealth" then return false end
    if ele == "CHudBattery" then return false end
    if ele == "CHudAmmo" then return false end
    return true
end

if CLIENT then
    if ArcCWInstalled then
        -- Use our own health display
        timer.Simple(0, function ()
            ArcCW.HUDElementConVars["CHudHealth"] = false
            ArcCW.HUDElementConVars["CHudBattery"] = false
        end)
    end
    net.Receive("Horde_GadgetStartCooldown", function()
        LocalPlayer():Horde_SetGadgetInternalCooldown(net.ReadUInt(8))
        if LocalPlayer():Horde_GetGadgetInternalCooldown() <= 0 then return end
        timer.Create("Horde_LocalGadgetCooldown", 1, 0, function()
            if LocalPlayer():Horde_GetGadgetInternalCooldown() <= 0 then timer.Remove("Horde_LocalGadgetCooldown") return end
            LocalPlayer():Horde_SetGadgetInternalCooldown(LocalPlayer():Horde_GetGadgetInternalCooldown() - 1)
        end)
    end)

    net.Receive("Horde_PerkStartCooldown", function ()
        LocalPlayer():Horde_SetPerkInternalCooldown(net.ReadUInt(8))
        if LocalPlayer():Horde_GetPerkInternalCooldown() <= 0 then return end
        timer.Create("Horde_LocalPerkCooldown", 1, 0, function()
            if LocalPlayer():Horde_GetPerkInternalCooldown() <= 0 then timer.Remove("Horde_LocalPerkCooldown") return end
            LocalPlayer():Horde_SetPerkInternalCooldown(LocalPlayer():Horde_GetPerkInternalCooldown() - 1)
        end)
    end)

    net.Receive("Horde_GadgetChargesUpdate", function ()
        LocalPlayer():Horde_SetGadgetCharges(net.ReadInt(8))
    end)

    net.Receive("Horde_PerkChargesUpdate", function ()
        LocalPlayer():Horde_SetPerkCharges(net.ReadInt(8))
    end)

    net.Receive("Horde_RenderBarrier", function ()
        LocalPlayer().Horde_BarrierStack = net.ReadUInt(32)
    end)
end