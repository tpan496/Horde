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
    [HORDE.Status_Hemorrhage] = HORDE.color_crimson_violet,
    [HORDE.Status_Decay] = HORDE.STATUS_COLOR[HORDE.Status_Decay],
    [HORDE.Status_Necrosis] = HORDE.STATUS_COLOR[HORDE.Status_Necrosis],
    [HORDE.Status_CanHold] = Color(0, 255, 0),
    [HORDE.Status_HasPayload] = Color(0, 255, 0),
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
local status_icon_s = ScreenScale(15)
local function DrawStatus(status, stack, displacement)
    if stack <= 0 then return end
    if not HORDE.Status_Icon[status] then return end
    local mat
    if status < HORDE.Status_Armor_Survivor or status >= HORDE.Status_ExpDisabled then
        if HORDE:IsSkillStatus(status) then
            draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, Color(40,40,40,200))
    
            mat = Material(HORDE.Status_Icon[status], "mips smooth")
    
            surface.SetMaterial(mat)
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(ScreenScale(1 + displacement), ScreenScale(5/4), ScreenScale(13), ScreenScale(13))
    
            local cd = MySelf:Horde_GetPerkInternalCooldown()
            if cd > 0 then
                draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, Color(40,40,40,200))
                surface.SetDrawColor(color_white)
                draw.SimpleText(cd, "Horde_Cd", ScreenScale(displacement + 7.5), ScreenScale(7), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local charge = MySelf:Horde_GetPerkCharges()
            if HORDE:IsStackableSkillStatus(status) and charge >= 0 then
                draw.SimpleText(charge, "Horde_Cd", ScreenScale(displacement + 12), ScreenScale(2.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            return
        end
        local color = color_white
        if status_color[status] then
            color = status_color[status]
        end
        if HORDE.Is_Status_Debuff[status] then
            draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, HORDE.color_crimson_violet)
            draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, Color(40,40,40,200))
        else
            draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, Color(40,40,40,200))
        end

        mat = Material(HORDE.Status_Icon[status], "mips smooth")

        surface.SetMaterial(mat)
        surface.SetDrawColor(color)
        surface.DrawTexturedRect(ScreenScale(displacement + 1), ScreenScale(5/4), ScreenScale(13), ScreenScale(13))
    else
        draw.RoundedBox(10, ScreenScale(displacement), 0, status_icon_s, status_icon_s, Color(40,40,40,200))
        mat = Material(HORDE.Status_Icon[status])
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(ScreenScale(-7 + displacement), ScreenScale(0), ScreenScale(30), ScreenScale(15))
    end

    if stack > 0 and HORDE:IsStatusStackable(status) then
        draw.SimpleText(stack, "Horde_Cd", ScreenScale(12 + displacement), ScreenScale(2.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

local function DrawProgress(status, buildup, x, y)
    if buildup <= 0 then return end
    local mat
    local color = Color(0, 255, 0)

    draw.RoundedBox(5, x + 50, y + 10, 200, 15, Color(40,40,40,200))
    draw.RoundedBox(5, x + 50, y + 10, 200 * buildup / 100, 15, color)
    draw.RoundedBox(10, x, y, 40, 40, Color(40,40,40,200))

    mat = Material(HORDE.Status_Icon[status], "mips smooth")

    surface.SetMaterial(mat)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(5 + x, 5 + y, 30, 30)
end

local status_panel = vgui.Create("DPanel")
status_panel:SetSize(ScreenScale(125), ScreenScale(25))
status_panel:SetPos(ScreenScale(6), ScreenScale(40))
status_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if MySelf:IsValid() and MySelf:Alive() and MySelf:GetStatusTable() then
        local pos = 0
        for status, stack in SortedPairs(MySelf:GetStatusTable()) do
            if HORDE:IsDebuff(status) and stack < 100 then goto cont end
            if not HORDE.Status_Icon[status] then goto cont end
            DrawStatus(status, stack, pos)
            pos = pos + 17
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

    if MySelf:IsValid() and MySelf:Alive() and MySelf:GetStatusTable() then
        local posx = 125
        local posy = 200
        posy = posy - (total_buildup) * 55 / 2
        for status, stack in pairs(MySelf:GetStatusTable()) do
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

    if MySelf.SetStatus then
        MySelf:SetStatus(status, stack)
    end

    total_buildup = 0
    if not MySelf.GetStatusTable then return end
    for s, buildup in pairs(MySelf:GetStatusTable()) do
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

    if MySelf.SetStatus then
        MySelf:SetStatus(armor_table[armor], on)
    end
end)

net.Receive("Horde_SyncActivePerk", function()
    local status = net.ReadUInt(8)
    local on = net.ReadUInt(3)

    if on == 1 then
        MySelf.Horde_ActivePerk = status
    else
        MySelf.Horde_ActivePerk = nil
    end

    if MySelf.SetStatus then
        MySelf:SetStatus(status, on)
    end
end)

net.Receive("Horde_ClearStatus", function()
    MySelf.Horde_StatusTable = {}
end)

local barrier_panel = vgui.Create("DPanel")
barrier_panel:SetSize(500, 200)
barrier_panel:SetPos(ScrW() / 2 - 50, ScrH() / 2 + 50)
barrier_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if MySelf:IsValid() and MySelf:Alive() and MySelf.Horde_BarrierStack and MySelf.Horde_BarrierStack > 0 then
        local mat = Material("status/barrier.png")
        surface.SetDrawColor(255, 255, 255, 150)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(0, 0, 100, 100)

        draw.SimpleText(tostring(MySelf.Horde_BarrierStack), "Trebuchet24", 40, 90, Color(255, 255, 255, 150))
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
local mind = Material("status/mind.png", "mips smooth")
local weight = Material("weight.png")
local vhp = 0
local varmor = 0
local vmind = 0
surface.CreateFont("HealthInfo", { font = "arial", size = ScreenScale(15), extended = true})
surface.CreateFont("HealthInfo2", { font = "arial", size = ScreenScale(12), extended = true})
surface.CreateFont("Horde_WeaponName", { font = "arial", size = ScreenScale(6), extended = true})
surface.CreateFont("Horde_Weight", { font = "arial", size = ScreenScale(8), extended = true})
surface.CreateFont("Horde_SpellButton", { font = "arial", size = ScreenScale(4), extended = true})
surface.CreateFont("Horde_SpellCooldown", { font = "arial", size = ScreenScale(6), extended = true})
surface.CreateFont("Horde_SpellMindCost", { font = "arial", size = ScreenScale(4), extended = true})
local font = "HealthInfo"
local font2 = "HealthInfo2"
local font3 = "Horde_WeaponName"
local fontweight = "Horde_Weight"
local display_money = 0
hook.Add("HUDPaint", "Horde_DrawHud", function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    local colhp = Color(255, 255, 255, 255)
    local airgap = ScreenScale(6)
    
    local icon_x = airgap + ScreenScale(34)
    local icon_y = ScrH() - airgap - ScreenScale(31)
    if GetConVarNumber("horde_enable_health_gui") == 1 then
        draw.RoundedBox(10, airgap, ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(25), ScreenScale(26) + airgap, Color(40,40,40,150))
        draw.RoundedBox(10, airgap, ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(70), ScreenScale(26) + airgap, Color(40,40,40,150))

        -- Draw Class
        local subclass = HORDE.subclasses[MySelf:Horde_GetCurrentSubclass()]
        if not subclass then subclass = HORDE.subclasses[HORDE.Class_Survivor] end
        local display_name = subclass.PrintName
        local class_icon = Material(subclass.Icon, "mips smooth")
        local level = MySelf:Horde_GetLevel(display_name)
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

        if MySelf:Health() <= 30 then
            colhp = Color(150, 0, 0)
        elseif MySelf:Health() < 50 then
            colhp = Color(255, 185, 185)
        end

        local use_mind = MySelf:Horde_GetMaxMind() > 0
        if MySelf:Alive() then
            vhp = MySelf:Health()
            if use_mind then
                vmind = MySelf:Horde_GetMind()
            else
                varmor = MySelf:Armor()
            end
        else
            vhp = 0
            varmor = 0
        end
        

        local icon_s = ScreenScale(15)

        surface.SetMaterial(hp)
        surface.SetDrawColor(colhp)
        surface.DrawTexturedRect(icon_x, icon_y, icon_s, icon_s)
        
        if use_mind then
            surface.SetMaterial(mind)
            draw.SimpleText(tostring(math.Round(vmind)), font, icon_x + icon_s + ScreenScale(1), icon_y + ScreenScale(14), color_white)
        else
            surface.SetMaterial(armor)
            draw.SimpleText(tostring(math.Round(varmor)), font, icon_x + icon_s + ScreenScale(1), icon_y + ScreenScale(14), color_white)
        end
        
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(icon_x, icon_y + ScreenScale(14), icon_s, icon_s)

        draw.SimpleText(tostring(math.Round(vhp)), font, icon_x + icon_s + ScreenScale(1), icon_y - ScreenScale(0.5), colhp)
    end

    if GetConVarNumber("horde_enable_ammo_gui") == 1 then
        -- Draw Ammo
        draw.RoundedBox(10, ScrW() - airgap - ScreenScale(78), ScrH() - ScreenScale(33) - airgap, airgap + ScreenScale(70), ScreenScale(26) + airgap, Color(40,40,40,150))

        local wpn = MySelf:GetActiveWeapon()
        if wpn and wpn:IsValid() then
            if wpn.Base == "horde_spell_weapon_base" then
                draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                
                -- Spell Icons
                surface.SetDrawColor(Color(255,255,255))
                surface.DrawOutlinedRect(ScrW() - ScreenScale(81), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15), 2)
                surface.DrawOutlinedRect(ScrW() - ScreenScale(63), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15), 2)
                surface.DrawOutlinedRect(ScrW() - ScreenScale(44), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15), 2)
                surface.DrawOutlinedRect(ScrW() - ScreenScale(26), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15), 2)

                draw.SimpleText("LMB", "Horde_SpellButton", ScrW() - ScreenScale(74), icon_y + ScreenScale(27), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("RMB", "Horde_SpellButton", ScrW() - ScreenScale(56), icon_y + ScreenScale(27), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("F", "Horde_SpellButton", ScrW() - ScreenScale(37), icon_y + ScreenScale(27), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("R", "Horde_SpellButton", ScrW() - ScreenScale(19), icon_y + ScreenScale(27), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                
                if MySelf:Horde_GetPrimarySpell() then
                    local spell = MySelf:Horde_GetPrimarySpell()
                    surface.SetMaterial(Material(spell.Icon, "mips smooth"))
                    surface.DrawTexturedRect(ScrW() - ScreenScale(81), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                    local t = MySelf:Horde_GetPrimarySpellCooldown()
                    if t > 0 then
                        surface.SetDrawColor(Color(40,40,40, 200))
                        surface.DrawRect(ScrW() - ScreenScale(81), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                        surface.SetDrawColor(color_white)
                        draw.SimpleText(string.format("%.1f", t), "Horde_SpellCooldown", ScrW() - ScreenScale(74), icon_y + ScreenScale(15), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    local c = Color(0,255,0)
                    if MySelf:Horde_GetMind() < spell.Mind[1] then
                        c = Color(200, 0, 0)
                    end
                    draw.SimpleTextOutlined(spell.Mind[1], "Horde_SpellMindCost", ScrW() - ScreenScale(67), icon_y + ScreenScale(20), c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
                else
                    surface.SetMaterial(mind)
                end

                if MySelf:Horde_GetSecondarySpell() then
                    local spell = MySelf:Horde_GetSecondarySpell()
                    surface.SetMaterial(Material(spell.Icon, "mips smooth"))
                    surface.DrawTexturedRect(ScrW() - ScreenScale(63), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                    local t = MySelf:Horde_GetSecondarySpellCooldown()
                    if t > 0 then
                        surface.SetDrawColor(Color(40,40,40, 200))
                        surface.DrawRect(ScrW() - ScreenScale(63), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                        surface.SetDrawColor(color_white)
                        draw.SimpleText(string.format("%.1f", t), "Horde_SpellCooldown", ScrW() - ScreenScale(56), icon_y + ScreenScale(15), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    local c = Color(0,255,0)
                    if MySelf:Horde_GetMind() < spell.Mind[1] then
                        c = Color(200, 0, 0)
                    end
                    draw.SimpleTextOutlined(spell.Mind[1], "Horde_SpellMindCost", ScrW() - ScreenScale(49), icon_y + ScreenScale(20), c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
                else
                    surface.SetMaterial(mind)
                end

                if MySelf:Horde_GetUtilitySpell() then
                    local spell = MySelf:Horde_GetUtilitySpell()
                    surface.SetMaterial(Material(spell.Icon, "mips smooth"))
                    surface.DrawTexturedRect(ScrW() - ScreenScale(44), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                    local t = MySelf:Horde_GetUtilitySpellCooldown()
                    if t > 0 then
                        surface.SetDrawColor(Color(40,40,40, 200))
                        surface.DrawRect(ScrW() - ScreenScale(44), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                        surface.SetDrawColor(color_white)
                        draw.SimpleText(string.format("%.1f", t), "Horde_SpellCooldown", ScrW() - ScreenScale(37), icon_y + ScreenScale(15), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    local c = Color(0,255,0)
                    if MySelf:Horde_GetMind() < spell.Mind[1] then
                        c = Color(200, 0, 0)
                    end
                    draw.SimpleTextOutlined(spell.Mind[1], "Horde_SpellMindCost", ScrW() - ScreenScale(30), icon_y + ScreenScale(20), c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
                else
                    surface.SetMaterial(mind)
                end

                if MySelf:Horde_GetUltimateSpell() then
                    local spell = MySelf:Horde_GetUltimateSpell()
                    surface.SetMaterial(Material(spell.Icon, "mips smooth"))
                    surface.DrawTexturedRect(ScrW() - ScreenScale(26), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                    local t = MySelf:Horde_GetUltimateSpellCooldown()
                    if t > 0 then
                        surface.SetDrawColor(Color(40,40,40, 200))
                        surface.DrawRect(ScrW() - ScreenScale(26), icon_y + ScreenScale(8), ScreenScale(15), ScreenScale(15))
                        surface.SetDrawColor(color_white)
                        draw.SimpleText(string.format("%.1f", t), "Horde_SpellCooldown", ScrW() - ScreenScale(19), icon_y + ScreenScale(15), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    local c = Color(0,255,0)
                    if MySelf:Horde_GetMind() < spell.Mind[1] then
                        c = Color(200, 0, 0)
                    end
                    draw.SimpleTextOutlined(spell.Mind[1], "Horde_SpellMindCost", ScrW() - ScreenScale(12), icon_y + ScreenScale(20), c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
                else
                    surface.SetMaterial(mind)
                end

            else
                if MySelf:Horde_GetInfusion(wpn:GetClass()) ~= HORDE.Infusion_None then
                    local infusion = MySelf:Horde_GetInfusion(wpn:GetClass())
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
                    draw.SimpleText(tostring(wpn:Clip1() .. " / " .. MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType())), font, ScrW() - ScreenScale(20), icon_y + ScreenScale(13), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(tostring(wpn:Clip2() .. " / " .. MySelf:GetAmmoCount(wpn:GetSecondaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(24), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                elseif (wpn:GetMaxClip1() > 0 or wpn:Clip1() > 0) then
                    local c1 = color_white
                    local c2 = color_white
                    if wpn:Clip1() == 0 then c1 = Color(100,0,0) end
                    if MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
                    draw.SimpleText(tostring(wpn:Clip1()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(tostring(MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(17), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                elseif (wpn:GetMaxClip2() > 0 or wpn:Clip2() > 0) then
                    local c1 = color_white
                    local c2 = color_white
                    if wpn:Clip2() == 0 then c1 = Color(100,0,0) end
                    if MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
                    draw.SimpleText(tostring(wpn:Clip2()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(tostring(MySelf:GetAmmoCount(wpn:GetSecondaryAmmoType())), font2, ScrW() - ScreenScale(20), icon_y + ScreenScale(17), c2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                elseif wpn:GetPrimaryAmmoType() > 0 then
                    local c1 = color_white
                    local c2 = color_white
                    if wpn:Clip1() == 0 then c1 = Color(100,0,0) end
                    if MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType()) == 0 then c2 = Color(100,0,0) end
                    --draw.SimpleText(tostring(wpn:Clip1()), font, ScrW() - ScreenScale(55), icon_y + ScreenScale(17), c1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(tostring(MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType())), font2, ScrW() - ScreenScale(45), icon_y + ScreenScale(17), c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(82), icon_y + ScreenScale(3), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(wpn:GetPrintName(), font3, ScrW() - ScreenScale(47), icon_y + ScreenScale(15), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end

        -- Draw Weight
        draw.RoundedBox(10, ScrW() - airgap - ScreenScale(78), ScrH() - ScreenScale(44) - airgap, airgap + ScreenScale(70), ScreenScale(10), Color(40,40,40,150))
        surface.SetMaterial(weight)
        surface.SetDrawColor(color_white)
        local wx = ScrW() - airgap - ScreenScale(80)
        local wy = ScrH() - ScreenScale(46) - airgap
        surface.DrawTexturedRect(wx + ScreenScale(65), wy + ScreenScale(2), ScreenScale(10), ScreenScale(10))
        draw.SimpleText(tostring(MySelf:Horde_GetMaxWeight() - MySelf:Horde_GetWeight()) .. "/" .. tostring(MySelf:Horde_GetMaxWeight()), fontweight, wx + ScreenScale(65), wy + ScreenScale(3), color_white, TEXT_ALIGN_RIGHT)
        draw.SimpleText(tostring(display_money) .. " $", fontweight, wx + ScreenScale(4), wy + ScreenScale(3), color_white)

        -- Draw Gadget
        if MySelf:Horde_GetGadget() ~= nil then
            local gadget = MySelf:Horde_GetGadget()
            local charge = MySelf:Horde_GetGadgetCharges()
            local cd = MySelf:Horde_GetGadgetInternalCooldown()
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
    end
end)

function HORDE:PlayMoneyNotification(diff, money)
    if GetConVarNumber("horde_enable_ammo_gui") == 0 then return end
    if diff == 0 then return end
    local color = HORDE.color_crimson_dark
    local text = diff
    if diff > 0 then
        text = "+" .. diff .. "$"
        color = Color(50,205,50)
    else
        text = diff .. "$"
        color = HORDE.color_crimson_dim
    end
    local main = vgui.Create("DPanel")
    local x = ScrW() - ScreenScale(120)
    local y_start = ScrH() - ScreenScale(46) - ScreenScale(6) + ScreenScale(3)
    local h = ScreenScale(10)
    main:SetSize(ScreenScale(66), h)
    main:SetPos(x, y_start)
    main.Paint = function ()
        draw.SimpleTextOutlined(text, fontweight, ScreenScale(33), 0, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, Color(40, 40, 40, 200))
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetAlpha(delta * 255)
    end)
    main.Think = function(self)
        if anim:Active() then
            anim:Run()
        end
    end
    anim:Start(0.5) -- Animate for two seconds
    if anim:Active() then
        anim:Run()
    end
    timer.Simple(0.75, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetAlpha(255 - delta * 255)
            pnl:SetPos(x + ScreenScale(20) * delta, y_start)
        end)
        anim2:Start(0.5)
        if anim2:Active() then
            anim2:Run()
        end
        main.Think = function(self)
            if anim2:Active() then
                anim2:Run()
            end
        end
        timer.Simple(0.5, function ()
            display_money = money
            main:Remove()
        end)
    end)
end

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
        MySelf:Horde_SetGadgetInternalCooldown(net.ReadUInt(8))
        if MySelf:Horde_GetGadgetInternalCooldown() <= 0 then return end
        timer.Create("Horde_LocalGadgetCooldown", 1, 0, function()
            if MySelf:Horde_GetGadgetInternalCooldown() <= 0 then timer.Remove("Horde_LocalGadgetCooldown") return end
            MySelf:Horde_SetGadgetInternalCooldown(MySelf:Horde_GetGadgetInternalCooldown() - 1)
        end)
    end)

    net.Receive("Horde_PerkStartCooldown", function ()
        MySelf:Horde_SetPerkInternalCooldown(net.ReadUInt(8))
        if MySelf:Horde_GetPerkInternalCooldown() <= 0 then return end
        timer.Create("Horde_LocalPerkCooldown", 1, 0, function()
            if MySelf:Horde_GetPerkInternalCooldown() <= 0 then timer.Remove("Horde_LocalPerkCooldown") return end
            MySelf:Horde_SetPerkInternalCooldown(MySelf:Horde_GetPerkInternalCooldown() - 1)
        end)
    end)

    net.Receive("Horde_GadgetChargesUpdate", function ()
        MySelf:Horde_SetGadgetCharges(net.ReadInt(8))
    end)

    net.Receive("Horde_PerkChargesUpdate", function ()
        MySelf:Horde_SetPerkCharges(net.ReadInt(8))
    end)

    net.Receive("Horde_RenderBarrier", function ()
        MySelf.Horde_BarrierStack = net.ReadUInt(32)
    end)
end