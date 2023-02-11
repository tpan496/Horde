local PANEL = {}
local players_map_votes = {}
local players_diff_votes = {}
local remaining_time = 60

local font_scale = translate.Get("Default_Font_Scale") or 1
surface.CreateFont("SummaryText", { font = "arial", size = ScreenScale(10) * font_scale, extended = true })
surface.CreateFont("AwardText", { font = "arial bold", size = ScreenScale(10) * font_scale, extended = true })


net.Receive("Horde_VotemapSync", function (len)
    players_map_votes = net.ReadTable()
end)

net.Receive("Horde_VotediffSync", function (len)
    players_diff_votes = net.ReadTable()
end)

net.Receive("Horde_RemainingTime", function (len)
    remaining_time = net.ReadInt(8)
end)

function PANEL:Init()
    local w = math.max(1024, ScrW() * 0.75)
    local h = math.min(800, math.max(600, ScrH() * 0.75))
    self:SetSize(w, h)
    self:SetPos(ScrW()/2 - (self:GetWide() / 2), ScrH()/2 - (self:GetTall() / 2))
    self:SetBackgroundColor(Color(0,0,0,0))

    local summary_panel = vgui.Create("DPanel", self)
    summary_panel:SetSize(w, h)
    summary_panel:SetBackgroundColor(Color(0,0,0,0))
    self.summary_panel = summary_panel

    local summary_btn = vgui.Create("DButton", self)
    local summary_activated = true
    local summary_hovered = false
    local summary_btn_w = 250
    local summary_btn_h = 50
    summary_btn:SetText(translate.Get("Game_Game_Summary"))
    summary_btn:SetTextColor(Color(255,255,255))
    summary_btn:SetFont("Title")
    summary_btn:SetSize(summary_btn_w, summary_btn_h)
    summary_btn:SetPos(0, 0)
    summary_btn.Paint = function ()
        if summary_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if summary_activated then
            draw.RoundedBox(0, 0, 0, summary_btn_w, summary_btn_h, HORDE.color_hollow)
        else
            draw.RoundedBox(0, 0, 0, summary_btn_w, summary_btn_h, HORDE.color_hollow_dim)
        end
    end

    local votemap_panel = vgui.Create("DScrollPanel", self)
    if GetConVar("horde_disable_difficulty_voting"):GetInt() ~= 1 then
        votemap_panel:SetSize(w - 256, h - 50)
    else
        votemap_panel:SetSize(w, h - 50)
    end
    votemap_panel:SetPos(256,50)
    votemap_panel:SetBackgroundColor(Color(0,0,0,0))

    local votediff_panel = vgui.Create("DScrollPanel", self)
    votediff_panel:SetSize(256, 550)
    votediff_panel:SetPos(0,50)
    votediff_panel:SetBackgroundColor(Color(0,0,0,0))
    votediff_panel:SetVisible(false)

    self.diff_btns = {}
    self.create_diff_panel = function (diff)
        local vote_btn = vgui.Create("DButton", votediff_panel)
        local vote_btn_hovered = false
        vote_btn:DockMargin(10, 5, 10, 5)
        vote_btn:SetSize(self:GetParent():GetWide(), 50)
        vote_btn:Dock(TOP)
        vote_btn:SetText("")
        vote_btn.Paint = function ()
            if vote_btn_hovered or (self.diff_btns[vote_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        vote_btn.OnCursorEntered = function ()
            vote_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        vote_btn.OnCursorExited = function ()
            vote_btn_hovered = false
        end
        vote_btn.DoClick = function ()
            votemap_panel:GetParent():Votediff(vote_btn, diff)
            surface.PlaySound("UI/buttonclick.wav")
        end

        players_diff_votes[diff] = 0

        local name_label = vgui.Create("DLabel", vote_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            if (players_diff_votes[diff] <= 0) or vote_btn_hovered or (self.diff_btns[vote_btn] == 1) then
                draw.SimpleText(translate.Get("Game_Difficulty_" .. diff), "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
            else
                draw.SimpleText(translate.Get("Game_Difficulty_" .. diff), "Content", 10, 20, HORDE.color_crimson, TEXT_ALIGN_LEFT)
            end
        end

        local count_label = vgui.Create("DLabel", vote_btn)
        count_label:Dock(RIGHT)
        count_label:SetSize(50, 80)
        count_label:SetColor(Color(255,255,255))
        count_label:SetFont("Content")
        count_label:SetText("")
        count_label.Paint = function ()
            if players_diff_votes[diff] then
                if (players_diff_votes[diff] <= 0) or vote_btn_hovered or (self.diff_btns[vote_btn] == 1) then
                    draw.SimpleText(tostring(players_diff_votes[diff]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, Color(255,255,255))
                else
                    draw.SimpleText(tostring(players_diff_votes[diff]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, HORDE.color_crimson)
                end
            end
        end

        self.diff_btns[vote_btn] = 0
    end

    local maps_panel = vgui.Create("DScrollPanel", votemap_panel)
    maps_panel:Dock(FILL)

    local votemap_btn = vgui.Create("DButton", self)
    local votemap_hovered = false
    votemap_btn:SetText(translate.Get("Game_Vote_Map"))
    votemap_btn:SetTextColor(Color(255,255,255))
    votemap_btn:SetFont("Title")
    votemap_btn:SetSize(250, 50)
    votemap_btn:SetPos(250, 0)
    votemap_btn.Paint = function ()
        if votemap_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if not summary_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow_dim)
        end
    end

    votemap_panel:SetVisible(false)

    summary_btn.DoClick = function ()
        summary_activated = true
        summary_panel:SetVisible(true)
        votemap_panel:SetVisible(false)
        votediff_panel:SetVisible(false)
        surface.PlaySound("UI/buttonclick.wav")
    end

    summary_btn.OnCursorEntered = function ()
        summary_hovered = true
        surface.PlaySound("UI/buttonrollover.wav")
    end

    summary_btn.OnCursorExited = function ()
        summary_hovered = false
    end

    votemap_btn.DoClick = function ()
        summary_activated = false
        summary_panel:SetVisible(false)
        votemap_panel:SetVisible(true)
        if GetConVar("horde_disable_difficulty_voting"):GetInt() ~= 1 then
            votediff_panel:SetVisible(true)
        end
        surface.PlaySound("UI/buttonclick.wav")
    end

    votemap_btn.OnCursorEntered = function ()
        votemap_hovered = true
        surface.PlaySound("UI/buttonrollover.wav")
    end

    votemap_btn.OnCursorExited = function ()
        votemap_hovered = false
    end

    local player_panel_h = (h - 150) / 4 - 2

    self.create_player_panel = function (pos, ply, award, reason)
        local panel = vgui.Create("DPanel", summary_panel)
        -- panel:Dock(TOP)
        panel:DockPadding(10, 10, 10, 10)
        panel:SetSize(w, player_panel_h)
        panel:SetPos(pos.x, pos.y)
        panel:SetBackgroundColor(HORDE.color_hollow)
        panel.Paint = function ()
            if award == "MVP" then
                draw.RoundedBox(10, 0, 0, w / 2, player_panel_h, HORDE.color_crimson)
            else
                --draw.RoundedBox(10, 0, 0, w / 2, player_panel_h, Color(100,100,100))
            end
            draw.RoundedBox(10, 2, 2, w / 2 - 4, player_panel_h - 4, Color(40,40,40))
        end
        local avatar = vgui.Create("AvatarImage", panel)
        avatar:Dock(LEFT)
        avatar:SetSize((player_panel_h - 15),(player_panel_h - 15))
        avatar:SetPlayer(ply, (player_panel_h - 15))

        local award_label = vgui.Create("DLabel", panel)
        award_label:SetPos((player_panel_h - 15) + 20, -(player_panel_h - 60)/2)
        award_label:SetText(award)
        award_label:SetSize(w/2 - player_panel_h - 20, player_panel_h)
        award_label:SetColor(HORDE.color_crimson)
        award_label:SetFont("AwardText")

        local name_label = vgui.Create("DLabel", panel)
        name_label:SetPos((player_panel_h - 15) + 20, 0)
        name_label:SetText(ply:GetName())
        name_label:SetSize(w/2 - player_panel_h - 20, player_panel_h)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("SummaryText")

        local reason_label = vgui.Create("DLabel", panel)
        reason_label:SetPos((player_panel_h - 15) + 20, (player_panel_h - 60)/2)
        reason_label:SetText(reason)
        reason_label:SetSize(w/2 - player_panel_h - 20, player_panel_h)
        reason_label:SetColor(Color(255,255,255))
        reason_label:SetFont("SummaryText")

        local icon_s = ScreenScale(24)
        local class_icon = vgui.Create("DPanel", panel)
        class_icon:SetPos(w/2 - 80 - icon_s/2, player_panel_h/2 - icon_s/2)
        class_icon:SetSize(icon_s, icon_s)
        local subclass = HORDE.subclasses[ply:Horde_GetCurrentSubclass()]
        local mat = Material(subclass.Icon, "mips smooth")
        class_icon.Paint = function ()
            if not ply:Horde_GetClass() then return end
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(0, 0, icon_s, icon_s)
        end

        return panel
    end

    self.map_btns = {}
    self.create_map_panel = function (map)
        local vote_btn = vgui.Create("DButton", votemap_panel)
        local vote_btn_hovered = false
        vote_btn:DockMargin(10, 5, 10, 5)
        vote_btn:SetSize(self:GetParent():GetWide(), 50)
        vote_btn:Dock(TOP)
        vote_btn:SetText("")
        vote_btn.Paint = function ()
            if vote_btn_hovered or (self.map_btns[vote_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        vote_btn.OnCursorEntered = function ()
            vote_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        vote_btn.OnCursorExited = function ()
            vote_btn_hovered = false
        end
        vote_btn.DoClick = function ()
            votemap_panel:GetParent():Votemap(vote_btn, map)
            surface.PlaySound("UI/buttonclick.wav")
        end

        players_map_votes[map] = 0

        local name_label = vgui.Create("DLabel", vote_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            if (players_map_votes[map] <= 0) or vote_btn_hovered or (self.map_btns[vote_btn] == 1) then
                draw.SimpleText(map, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
            else
                draw.SimpleText(map, "Content", 10, 20, HORDE.color_crimson, TEXT_ALIGN_LEFT)
            end
        end

        local count_label = vgui.Create("DLabel", vote_btn)
        count_label:Dock(RIGHT)
        count_label:SetSize(50, 80)
        count_label:SetColor(Color(255,255,255))
        count_label:SetFont("Content")
        count_label:SetText("")
        count_label.Paint = function ()
            if players_map_votes[map] then
                if (players_map_votes[map] <= 0) or vote_btn_hovered or (self.map_btns[vote_btn] == 1) then
                    draw.SimpleText(tostring(players_map_votes[map]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, Color(255,255,255))
                else
                    draw.SimpleText(tostring(players_map_votes[map]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, HORDE.color_crimson)
                end
            end
        end

        self.map_btns[vote_btn] = 0
    end

    local counter_label = vgui.Create("DPanel", self)
    counter_label:SetSize(100, 50)
    counter_label:SetPos(w - 50, 0)
    counter_label.Paint = function ()
        if remaining_time <= 10 then
            draw.SimpleText(tostring(remaining_time), "Title", 0, 10, HORDE.color_crimson)
        else
            draw.SimpleText(tostring(remaining_time), "Title", 0, 10, Color(255,255,255))
        end
    end
end

function PANEL:Votemap(vote_btn, map)
    for btn, _ in pairs(self.map_btns) do
        self.map_btns[btn] = 0
    end
    self.map_btns[vote_btn] = 1
    -- Send vote to server
    net.Start("Horde_Votemap")
    net.WriteString(map)
    net.SendToServer()
end

function PANEL:Votediff(vote_btn, diff)
    for btn, _ in pairs(self.diff_btns) do
        self.diff_btns[btn] = 0
    end
    self.diff_btns[vote_btn] = 1
    -- Send vote to server
    net.Start("Horde_Votediff")
    net.WriteString(diff)
    net.SendToServer()
end

function PANEL:SetData(status, mvp_player, mvp_damage, mvp_kills, damage_player, most_damage, kills_player, most_kills, most_heal_player, most_heal, headshot_player, most_headshots, elite_kill_player, most_elite_kills, damage_taken_player, most_damage_taken, total_damage, maps)
    local w = math.max(1024, ScrW() * 0.75)
    --local h = math.max(600, ScrH() * 0.75)
    local h = math.min(800, math.max(600, ScrH() * 0.75))
    local player_panel_h = (h - 150) / 4  - 2
    local percentage = 0
    if total_damage > 0 then
        percentage = HORDE:Round2(mvp_damage / total_damage, 2) * 100
    end
    self.create_player_panel({x=w/4,y=150}, mvp_player,              "MVP", tostring(mvp_kills) .. " " .. translate.Get("Game_Kills") .. ", " .. tostring(mvp_damage) .. " " .. translate.Get("Game_Damage") .. " (" .. tostring(percentage) .. "%)")
    self.create_player_panel({x=0,  y=160 + player_panel_h}, damage_player,       translate.Get("Game_Most_Damage_Dealt"), tostring(most_damage) .. " " .. translate.Get("Game_Damage"))
    self.create_player_panel({x=w/2,y=160 + player_panel_h}, kills_player,             translate.Get("Game_Most_Kills"), tostring(most_kills) .. " " .. translate.Get("Game_Kills"))
    self.create_player_panel({x=0  ,y=160 + 2*player_panel_h}, damage_taken_player, translate.Get("Game_Most_Damage_Taken"), tostring(most_damage_taken) .. " " .. translate.Get("Game_Damage_Taken"))
    self.create_player_panel({x=w/2,y=160 + 2*player_panel_h}, elite_kill_player,         translate.Get("Game_Elite_Killer"), tostring(most_elite_kills) .. " " .. translate.Get("Game_Elite_Kills"))
    self.create_player_panel({x=0,  y=160 + 3*player_panel_h}, most_heal_player,          translate.Get("Game_Most_Heal"), tostring(most_heal) .. " " .. translate.Get("Game_Healed"))
    self.create_player_panel({x=w/2,y=160 + 3*player_panel_h}, headshot_player,     translate.Get("Game_SharpShooter"), tostring(most_headshots) .. " " .. translate.Get("Game_Headshots"))

    for _, map in pairs(maps) do
        self.create_map_panel(map)
    end

    local summary_label = vgui.Create("DLabel", self.summary_panel)
    summary_label:SetSize(900,100)
    summary_label:SetPos(w/2 - 450, 80)
    summary_label:SetText("")
    summary_label:SetTextColor(Color(255,255,255))
    summary_label.Paint = function ()
        draw.SimpleText(translate.Get("Game_Result_" .. status) .. "! " .. game.GetMap() .. " - " .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]), "LargeTitle", 450, 0, Color(255,255,255), TEXT_ALIGN_CENTER)
    end

    self.create_diff_panel("NORMAL")
    self.create_diff_panel("HARD")
    self.create_diff_panel("REALISM")
    self.create_diff_panel("NIGHTMARE")
    self.create_diff_panel("APOCALYPSE")
end

function PANEL:Paint(w, h)
    -- Entire Panel
    draw.RoundedBox(0, 0, 0, w, h, HORDE.color_hollow)

    -- Cover
    draw.RoundedBox(0, 0, 50, w, h, HORDE.color_hollow)

    gui.EnableScreenClicker(true)
end

vgui.Register("HordeSummaryPanel", PANEL, "DPanel")