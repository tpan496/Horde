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
    [HORDE.Status_Decay] = Color(50, 150, 50)
}

-- Stack < 0 means disabled
-- Stack = 0 means enabled for non-stacking status
local function DrawStatus(status, stack, displacement)
    if stack <= 0 then return end
    if not HORDE.Status_Icon[status] then return end
    local mat
    if status <= HORDE.Status_CanBuy or status >= HORDE.Status_ExpDisabled then
        local color = color_white
        if status_color[status] then
            color = status_color[status]
        end
        if color ~= color_white then
            if stack < 100 then
                draw.RoundedBox(5, 0 + displacement, 55, 50, 10, Color(40,40,40,200))
                draw.RoundedBox(5, 0 + displacement, 55, 50 * stack / 100, 10, HORDE.color_crimson_violet)
            else
                draw.RoundedBox(10, 0 + displacement, 0, 50, 50, HORDE.color_crimson_violet)
            end
            draw.RoundedBox(10, 0 + displacement, 0, 50, 50, Color(40,40,40,200))
        else
            draw.RoundedBox(10, 0 + displacement, 0, 50, 50, Color(40,40,40,200))
        end

        mat = Material(HORDE.Status_Icon[status], "mips smooth")

        surface.SetMaterial(mat)
        surface.SetDrawColor(color)
        surface.DrawTexturedRect(5 + displacement, 5, 40, 40)
    else
        draw.RoundedBox(10, 0 + displacement, 0, 50, 50, Color(40,40,40,200))
        mat = Material(HORDE.Status_Icon[status])
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(-15 + displacement, 5, 80, 40)
    end

    if stack > 0 and HORDE:IsStatusStackable(status) then
        draw.SimpleText(stack, "Trebuchet24", 40 + displacement, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function DrawBuildup(status, buildup, displacement)
    if buildup <= 0 or not HORDE:IsDebuff(status) then return end
    local mat
    local color = color_white
    if status_color[status] then
        color = status_color[status]
    end

    draw.RoundedBox(5, displacement, 55, 50, 10, Color(40,40,40,200))
    if buildup < 100 then
        draw.RoundedBox(5, displacement, 55, 50 * buildup / 100, 10, HORDE.color_crimson_violet)
    else
        draw.RoundedBox(5, displacement, 55, 50 * buildup / 100, 10, HORDE.color_crimson)
    end
    draw.RoundedBox(10, displacement, 0, 50, 50, Color(40,40,40,200))

    mat = Material(HORDE.Status_Icon[status], "mips smooth")

    surface.SetMaterial(mat)
    surface.SetDrawColor(color)
    surface.DrawTexturedRect(5 + displacement, 5, 40, 40)
end

local function DrawGadget(gadget, cd, charge)
    draw.RoundedBox(10, 0, 0, 50, 50, Color(40,40,40,200))

    local mat = Material(HORDE.gadgets[gadget].Icon, "mips smooth")
    surface.SetMaterial(mat) -- Use our cached material
    if HORDE.gadgets[gadget].Active then
        surface.SetDrawColor(HORDE.color_gadget_active)
    else
        surface.SetDrawColor(color_white)
    end
    surface.DrawTexturedRect(-35, -5, 120, 60)

    if cd > 0 then
        draw.RoundedBox(10, 0, 0, 50, 50, Color(40,40,40,200))
        surface.SetDrawColor(color_white)
        draw.SimpleText(cd, "Trebuchet24", 25, 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if charge >= 0 then
        draw.SimpleText(charge, "Trebuchet24", 40, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local status_panel = vgui.Create("DPanel")
status_panel:SetSize(500, 100)
status_panel:SetPos(25, 135)
status_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer():GetStatusTable() then
        local pos = 0
        if LocalPlayer():Horde_GetGadget() ~= nil then
            DrawGadget(LocalPlayer():Horde_GetGadget(), LocalPlayer():Horde_GetGadgetInternalCooldown(), LocalPlayer():Horde_GetGadgetCharges())
            pos = 55
        end
        for status, stack in SortedPairs(LocalPlayer():GetStatusTable()) do
            if HORDE:IsDebuff(status) and stack < 100 then goto cont end
            if not HORDE.Status_Icon[status] then goto cont end
            DrawStatus(status, stack, pos)
            pos = pos + 55
            ::cont::
        end
    end
end

local total_buildup = 0
local buildup_panel = vgui.Create("DPanel")
buildup_panel:SetSize(500, 100)
buildup_panel:SetPos(ScrW() / 2 - 250, ScrH() - 200)
buildup_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer():GetStatusTable() then
        local pos = 250
        pos = pos - (total_buildup) * 55 / 2
        for status, stack in pairs(LocalPlayer():GetStatusTable()) do
            if HORDE:IsDebuff(status) then
                if stack <= 0 then goto cont end
                DrawBuildup(status, stack, pos)
                pos = pos + 55
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

net.Receive("Horde_ClearStatus", function()
    LocalPlayer().Horde_StatusTable = {}
end)

if CLIENT then
    net.Receive("Horde_GadgetStartCooldown", function()
        LocalPlayer():Horde_SetGadgetInternalCooldown(net.ReadUInt(8))
        if LocalPlayer():Horde_GetGadgetInternalCooldown() <= 0 then return end
        timer.Create("Horde_LocalGadgetCooldown", 1, 0, function()
            if LocalPlayer():Horde_GetGadgetInternalCooldown() <= 0 then timer.Remove("Horde_LocalGadgetCooldown") return end
            LocalPlayer():Horde_SetGadgetInternalCooldown(LocalPlayer():Horde_GetGadgetInternalCooldown() - 1)
        end)
    end)

    net.Receive("Horde_GadgetChargesUpdate", function ()
        LocalPlayer():Horde_SetGadgetCharges(net.ReadInt(8))
    end)
end