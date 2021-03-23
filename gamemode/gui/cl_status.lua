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

-- Stack < 0 means disabled
-- Stack = 0 means enabled for non-stacking status
local function DrawStatus(status, stack, displacement)
    if stack <= 0 then return end
    draw.RoundedBox(10, 0 + displacement, 0, 50, 50, Color(40,40,40,200))

    local mat = Material(HORDE.Status_Icon[status], "mips smooth")
    surface.SetMaterial(mat) -- Use our cached material
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(5 + displacement, 5, 40, 40)

    if stack > 0 and HORDE:IsStatusStackable(status) then
        draw.SimpleText(stack, "Trebuchet24", 40 + displacement, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local status_panel = vgui.Create("DPanel")
status_panel:SetSize(350, 50)
status_panel:SetPos(25, 135)
status_panel.Paint = function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end

    if LocalPlayer():IsValid() and LocalPlayer():Alive() and LocalPlayer():GetStatusTable() then
        local pos = 0
        for status, stack in pairs(LocalPlayer():GetStatusTable()) do
            DrawStatus(status, stack, pos)
            pos = pos + 50 + 5
        end
    end
end

net.Receive("Horde_SyncStatus", function()
    local status = net.ReadUInt(8)
    local stack = net.ReadUInt(3)

    LocalPlayer():SetStatus(status, stack)
end)