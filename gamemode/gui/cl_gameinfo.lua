-- Basic user ui
local font = translate.GetFont()
local bold_font = translate.GetBoldFont()
local font_scale = translate.Get("Default_Font_Scale") or 1
surface.CreateFont("Horde_PerkTitle", { font = font, size = 24 * font_scale, bold = true, extended = true })
surface.CreateFont("Horde_PerkButton_Name", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Horde_PerkButton_Text", { font = font, size = 15 * font_scale, extended = true })
surface.CreateFont("Title", { font = font, size = 30 * font_scale, extended = true })
surface.CreateFont("Content", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Warning", { font = font, size = 30 * font_scale, strikeout = true, extended = true })
surface.CreateFont("LargeTitle", { font = bold_font, size = 35 * font_scale, extended = true })
surface.CreateFont("Heading", { font = font, size = 22 * font_scale, extended = true })
surface.CreateFont("Category", { font = bold_font, size = 22 * font_scale, extended = true })
surface.CreateFont("Item", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Info", { font = font, size = ScreenScale(7) * font_scale, extended = true})
surface.CreateFont("SmallInfo", { font = font, size = 20 * font_scale, extended = true})
surface.CreateFont("Horde_Ready", { font = font, size = ScreenScale(5) * font_scale, extended = true })
surface.CreateFont("Horde_Cd", { font = bold_font, size = ScreenScale(8) * font_scale, extended = true })
surface.CreateFont("Horde_Wave_Banner", { font = bold_font, size = ScreenScale(15) * font_scale, extended = true })
surface.CreateFont("Horde_Javeline", { font = "Arial", size = ScreenScale(8), extended = true })

local width = ScreenScale(100)
local height = ScreenScale(15)
local center_panel = vgui.Create("DPanel")
local center_panel_str = ""
center_panel:SetSize(width, height)
center_panel:SetPos(ScreenScale(6), ScreenScale(23))
center_panel.Paint = function (w, h)
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    if center_panel_str == "" then return end
    draw.RoundedBox(10, 0, 0, width, height, Color(40,40,40,200))
    draw.SimpleText(center_panel_str, "Info", ScreenScale(50), ScreenScale(7), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local ammobox_refresh_count = 0
net.Receive("Horde_AmmoboxCountdown", function ()
    ammobox_refresh_count = 60 - net.ReadInt(8)
end)

local wave_str
local corner_panel = vgui.Create("DPanel")
corner_panel:SetSize(width, height)
corner_panel:SetPos(ScreenScale(6), ScreenScale(6))
corner_panel.Paint = function () end
timer.Simple(5, function ()
    corner_panel.Paint = function ()
        if GetConVarNumber("horde_enable_client_gui") == 0 then return end
        draw.RoundedBox(10, 0, 0, width - height - ScreenScale(2), height, Color(40,40,40,200))
        if LocalPlayer():Alive() then
            if (HORDE.current_wave <= 0) or (wave_str == nil) then
                draw.SimpleText(translate.Get("Game_Preparing..."), "Info", ScreenScale(45), ScreenScale(7), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("WAVE " .. wave_str, "Info", ScreenScale(45), ScreenScale(7), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            draw.SimpleText("Spectating", "Info", ScreenScale(45), ScreenScale(7), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        draw.RoundedBox(10, width - height, 0, height, height, Color(40,40,40,200))
        if ammobox_refresh_count > 5 then
            draw.RoundedBox(10, width - height, height * (1 - ammobox_refresh_count / HORDE.ammobox_refresh_interval), height, height * (ammobox_refresh_count / HORDE.ammobox_refresh_interval), HORDE.color_crimson_dark)
        end
        surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        local mat = Material("materials/ammo.png", "mips smooth")
        surface.SetMaterial(mat) -- Use our cached material
        surface.DrawTexturedRect(width - height + ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
end)

local delayed_boss_health = 0
local boss_name = ""
local boss_health = 0
local boss_max_health = 0
local boss_health_bar = vgui.Create("DPanel")
boss_health_bar:SetSize(ScrW() - (width + ScreenScale(10)) * 2, 75)
boss_health_bar:SetPos(ScrW() / 2 - boss_health_bar:GetWide() / 2, 25)
boss_health_bar.Paint = function()
    if boss_health <= 0 or boss_max_health <= 0 then return end
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide(), 35, HORDE.color_hollow)
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * delayed_boss_health / boss_max_health, 35, Color(255,255,255,225))
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * boss_health / boss_max_health, 35, Color(220, 20, 60))
    draw.SimpleText(boss_name, "Info", boss_health_bar:GetWide() / 2, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
end

local holdzone_progress = 0
local holdzone_bar = vgui.Create("DPanel")
holdzone_bar:SetSize(ScrW() - (width + ScreenScale(20)) * 2, 75)
holdzone_bar:SetPos(ScrW() / 2 - holdzone_bar:GetWide() / 2, 25)
holdzone_bar.Paint = function()
    if holdzone_progress <= 0 then return end
    draw.RoundedBox(10, 0, 0, holdzone_bar:GetWide(), 35, HORDE.color_hollow)
    draw.RoundedBox(10, 0, 0, holdzone_bar:GetWide() * holdzone_progress / 100, 35, Color(84, 107, 255))
    draw.SimpleText("Hold Progress", "Info", holdzone_bar:GetWide() / 2, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
end

HORDE.Notifications_Count = 0
local function inQuad(fraction, beginning, change)
	return change * (fraction ^ 2) + beginning
end

local warning_mat = Material("warning.png", "mips smooth")
local ok_mat = Material("ok.png", "mips smooth")
function HORDE:PlayNotification(text, type, icon, col)
    if not type then type = 0 end
    if not text then return end
    local s = string.len(text) * ScreenScale(3) + ScreenScale(20)
    local main = vgui.Create("DPanel")
    local y_start = ScrH() - ScreenScale(40) - HORDE.Notifications_Count * ScreenScale(18)
    main:SetSize(s, ScreenScale(15))
    main:SetPos(ScrW() - s, y_start)
    local mat
    if type == 0 then
        mat = ok_mat
    else
        mat = warning_mat
    end
    if icon then
        mat = Material(icon, "mips smooth")
    end
    local color = color_white
    if col then color = col end
    main.Paint = function ()
        draw.RoundedBox(10, 0, 0, s, ScreenScale(15), Color(40,40,40,150))
        draw.SimpleText(text, "Info", ScreenScale(4) + ScreenScale(10), ScreenScale(4), color_white, TEXT_ALIGN_LEFT)
        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetPos(ScrW() - s - ScreenScale(8), inQuad(delta, y_start, - ScreenScale(30))) -- Change the X coordinate from 200 to 200+600
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
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetAlpha(255 - delta * 255)
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
            main:Remove()
            HORDE.Notifications_Count = math.max(0, HORDE.Notifications_Count - 1)
        end)
    end)
    HORDE.Notifications_Count = HORDE.Notifications_Count + 1
end

function HORDE:PlayWaveNotification(wave)
    local text = (translate.Get("Game_WAVE ") or "WAVE ") .. wave
    local main = vgui.Create("DPanel")
    local y_start = ScrH() / 4
    local h = ScreenScale(40)
    main:SetSize(ScrW(), h)
    main:SetPos(0, y_start)
    main.Paint = function ()
        surface.SetDrawColor(Color(40,40,40,200))
        surface.DrawRect(0, 0, ScrW(), h)
        draw.SimpleText(text, "Horde_Wave_Banner", ScrW()/2, ScreenScale(12), color_white, TEXT_ALIGN_CENTER)
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetTall(delta * h)
        pnl:SetPos(0, y_start - h/2 * delta)
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
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetTall((1 - delta) * h)
            pnl:SetPos(0, y_start - h/2 + h/2 * delta)
            pnl:SetAlpha(255 - delta * 255)
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
            main:Remove()
        end)
    end)
end

function HORDE:DisplayObjective(text, type, icon, col)
    if not type then type = 0 end
    if not text then return end
    local s = string.len(text) * ScreenScale(3) + ScreenScale(20)
    local main = vgui.Create("DPanel")
    local y_start = ScrH() - ScreenScale(40) - HORDE.Notifications_Count * ScreenScale(18)
    main:SetSize(s, ScreenScale(15))
    main:SetPos(ScrW() - s, y_start)
    local mat
    if type == 0 then
        mat = ok_mat
    else
        mat = warning_mat
    end
    if icon then
        mat = Material(icon, "mips smooth")
    end
    local color = color_white
    if col then color = col end
    main.Paint = function ()
        draw.RoundedBox(10, 0, 0, s, ScreenScale(15), Color(40,40,40,150))
        draw.SimpleText(text, "Info", ScreenScale(4) + ScreenScale(10), ScreenScale(4), color_white, TEXT_ALIGN_LEFT)
        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetPos(ScrW() - s - ScreenScale(8), inQuad(delta, y_start, - ScreenScale(30))) -- Change the X coordinate from 200 to 200+600
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
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetAlpha(255 - delta * 255)
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
            main:Remove()
        end)
        HORDE.Notifications_Count = math.max(0, HORDE.Notifications_Count - 1)
    end)
    HORDE.Notifications_Count = HORDE.Notifications_Count + 1
end


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

net.Receive("Horde_SyncHoldProgress", function ()
    holdzone_progress = net.ReadUInt(8)
end)

net.Receive("Horde_RenderPlayersReady", function()
    local str = net.ReadString()
    center_panel_str = translate.Get("Game_Players_Ready") .. ": "  ..str
end)

net.Receive("Horde_RenderBreakCountDown", function()
    local num = net.ReadInt(8)
    local is_end_message = net.ReadBool()
    if is_end_message then
        surface.PlaySound("HL1/fvox/blip.wav")
        center_panel_str = translate.Get("Game_Wave_Completed") .. "!"
        wave_str = nil
        return
    end
    if num then
        if num >= 0 and num <= 10 then
            if HORDE.PlayerReadyPanel then
                HORDE.PlayerReadyPanel:Remove()
                HORDE.HelpPanel:SetVisible(false)
                HORDE.TipPanel:SetVisible(false)
                HORDE.leader_board:SetVisible(false)
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
        elseif num > 0 then
            if not HORDE.HelpPanel:IsVisible() then
                HORDE.HelpPanel:SetVisible(true)
                HORDE.TipPanel:SetVisible(true)
                HORDE:ShowLeaderboardThenFadeOut()
            end
        end
    end
    if num == 0 then
        center_panel_str = translate.Format("Game_Wave_Has_Started", tostring(HORDE.current_wave)) .. "!"
        timer.Simple(1, function() HORDE:PlayWaveNotification(HORDE.current_wave) end)
    else
        center_panel_str = translate.Format("Game_Next_Wave_Starts_In", num)
    end
end)

net.Receive("Horde_RenderEnemiesCount", function()
    local is_boss = net.ReadBool()
    wave_str = net.ReadString()
    local count = net.ReadInt(32)
    if is_boss then
        center_panel_str = "|" .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]) .. "|  " .. "BOSS"
    else
        center_panel_str = "|" .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]) .. "|  " .. translate.Get("Game_Enemies") .. ": " .. tostring(count)
    end
end)

net.Receive("Horde_RenderObjectives", function()
    local count = net.ReadUInt(4)
    local max_count = net.ReadUInt(4)
    center_panel_str = "|" .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]) .. "|  " .. "Objectives: " .. tonumber(count) .. "/" .. tonumber(max_count)
end)

net.Receive("Horde_RenderGameResult", function()
    local status = net.ReadString()
    local wave = net.ReadUInt(32)
    center_panel_str = translate.Get("Game_Result_" .. status) .. "! " .. translate.Get("Game_Wave") .. ": " .. tostring(wave)
end)

net.Receive("Horde_SyncEscapeStart", function ()
    center_panel_str = "|" .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]) .. "|  " .. "Escape!"
end)

local heal_msg_cd = 0
timer.Create("Horde_PreventHealSpam", 1, 0, function()
    if heal_msg_cd > 0 then
        heal_msg_cd = heal_msg_cd - 1
    end
end)

net.Receive("Horde_RenderHealer", function()
    local healer = net.ReadString()
    if heal_msg_cd <= 0 then
        HORDE:PlayNotification(string.sub(healer, 0, 20) .. " " .. translate.Get("Game_Healed_You") .. ".", 0, "status/hp.png", Color(50,205,50))
        heal_msg_cd = 5
    end
end)