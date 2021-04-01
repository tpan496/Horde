-- Basic user ui
local center_panel = vgui.Create("DPanel")
center_panel:SetSize(350, 50)
center_panel:SetPos(25, 80)
center_panel.Paint = function () end

local ammobox_refresh_count = 0
net.Receive("Horde_AmmoboxCountdown", function ()
    ammobox_refresh_count = 60 - net.ReadInt(8)
end)

local corner_panel = vgui.Create("DPanel")
corner_panel:SetSize(350, 50)
corner_panel:SetPos(25, 25)
corner_panel.Paint = function () end
timer.Simple(5, function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    corner_panel.Paint = function ()
        draw.RoundedBox(10, 0, 0, 280, 50, Color(40,40,40,200))
        if LocalPlayer():Alive() then
            local class = HORDE.classes[HORDE.Class_Survivor]
            if not class then return end
            local name = class.name
            local display_name = class.display_name
            if LocalPlayer():Horde_GetClass() then
                display_name = LocalPlayer():Horde_GetClass().display_name
                name = LocalPlayer():Horde_GetClass().name
            end
            draw.SimpleText(display_name .. " | " .. math.min(99999,LocalPlayer():Horde_GetMoney()) .. "$", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
            local mat = Material(HORDE.classes[name].icon, "mips smooth")
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(140 - 40 - string.len(display_name) * 7 - 25, 5, 40, 40)
        else
            draw.SimpleText("Spectating", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        draw.RoundedBox(10, 285, 0, 50, 50, Color(40,40,40,200))
        if ammobox_refresh_count > 5 then
            draw.RoundedBox(10, 285, 50 - ammobox_refresh_count / HORDE.ammobox_refresh_interval * 50, 50, ammobox_refresh_count / HORDE.ammobox_refresh_interval * 50, HORDE.color_crimson_dark)
        end
        surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        local mat = Material("materials/ammo.png", "mips smooth")
        surface.SetMaterial(mat) -- Use our cached material
        surface.DrawTexturedRect(290, 5, 40, 40)
    end
end)

local delayed_boss_health = 0
local boss_name = ""
local boss_health = 0
local boss_max_health = 0
local boss_health_bar = vgui.Create("DPanel")
boss_health_bar:SetSize(ScrW() - 400 * 2, 60)
boss_health_bar:SetPos(ScrW() / 2 - boss_health_bar:GetWide() / 2, 25)
boss_health_bar.Paint = function()
    if boss_health <= 0 or boss_max_health <= 0 then return end
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide(), 35, HORDE.color_hollow)
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * delayed_boss_health / boss_max_health, 35, Color(255,255,255,225))
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * boss_health / boss_max_health, 35, Color(220, 20, 60))
    draw.SimpleTextOutlined(boss_name, "Trebuchet24", boss_health_bar:GetWide() / 2, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, color_black)
end

net.Receive("Horde_RenderCenterText", function ()
    local str = net.ReadString()
    local num = net.ReadInt(8)
    if num then
        if num >= 0 and num <= 10 then
            if HORDE.PlayerReadyPanel then
                HORDE.PlayerReadyPanel:Remove()
                HORDE.HelpPanel:SetVisible(false)
            end
            if num == 10 then
                surface.PlaySound("HL1/fvox/ten.wav")
            elseif num == 5 then
                surface.PlaySound("HL1/fvox/five.wav")
            elseif num == 0 then
                surface.PlaySound("ambient/alarms/manhack_alert_pass1.wav")
            else
                surface.PlaySound("horde/cd/" .. tostring(num) ..".mp3")
            end
        elseif num == -2 then
            surface.PlaySound("HL1/fvox/blip.wav")
        elseif num > 0 then
            if not HORDE.HelpPanel:IsVisible() then
                HORDE.HelpPanel:SetVisible(true)
            end
        end
    end
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    center_panel.Paint = function (w, h)
        draw.RoundedBox(10, 0, 0, 280 + 5 + 50, 50, Color(40,40,40,200))
        draw.SimpleText(str, "Trebuchet24", (280 + 5 + 50) / 2, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

net.Receive("Horde_SyncGameInfo", function()
    HORDE.current_wave = net.ReadUInt(16)
end)

net.Receive("Horde_SyncBossSpawned", function ()
    boss_name = net.ReadString()
    boss_max_health = net.ReadInt(32)
    boss_health = net.ReadInt(32)
    delayed_boss_health = boss_health
    timer.Create("Horde_BossHealthDelayedDisplay", 0.1, 0, function ()
        if delayed_boss_health ~= boss_health then
            delayed_boss_health = delayed_boss_health - (delayed_boss_health - boss_health) / 2.5
        end
    end)
end)

net.Receive("Horde_SyncBossHealth", function ()
    boss_health = net.ReadInt(32)
    if boss_health <= 0 then
        timer.Remove("Horde_BossHealthDelayedDisplay")
    end
end)