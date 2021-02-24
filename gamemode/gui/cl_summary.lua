if SERVER then return end

surface.CreateFont('Title', { font = 'arial bold', size = 25 })
surface.CreateFont('Content', { font = 'arial bold', size = 20 })

local PANEL = {}
local players_votes = {}
local remaining_time = 60

net.Receive("Horde_VotemapSync", function (len)
    players_votes = net.ReadTable()
end)

net.Receive("Horde_RemainingTime", function (len)
    remaining_time = net.ReadInt(8)
end)

function PANEL:Init()
    self:SetSize(1024, 600)
	self:SetPos(ScrW()/2 - (self:GetWide() / 2), ScrH()/2 - (self:GetTall() / 2))
    self:SetBackgroundColor(Color(0,0,0,0))

    local summary_panel = vgui.Create('DPanel', self)
    summary_panel:SetSize(1024, 600)
    summary_panel:SetBackgroundColor(Color(0,0,0,0))

    local summary_btn = vgui.Create('DButton', self)
    local summary_activated = true
    local summary_hovered = false
    summary_btn:SetText("Game Summary")
    summary_btn:SetTextColor(Color(255,255,255))
    summary_btn:SetFont('Title')
    summary_btn:SetSize(250, 50)
    summary_btn:SetPos(0, 0)
    summary_btn.Paint = function ()
        if summary_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if summary_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow_dim)
        end
    end

    local votemap_panel = vgui.Create('DScrollPanel', self)
    votemap_panel:SetSize(1024, 550)
    votemap_panel:SetPos(0,50)
    votemap_panel:SetBackgroundColor(Color(0,0,0,0))

    local maps_panel = vgui.Create('DScrollPanel', votemap_panel)
    maps_panel:Dock(FILL)

    local votemap_btn = vgui.Create('DButton', self)
    local votemap_hovered = false
    votemap_btn:SetText("Vote Map")
    votemap_btn:SetTextColor(Color(255,255,255))
    votemap_btn:SetFont('Title')
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
        surface.PlaySound("UI/buttonclick.wav")
    end

    votemap_btn.OnCursorEntered = function ()
        votemap_hovered = true
        surface.PlaySound("UI/buttonrollover.wav")
    end

    votemap_btn.OnCursorExited = function ()
        votemap_hovered = false
    end

    self.create_player_panel = function (pos, ply, award, reason)
        local panel = vgui.Create('DPanel', summary_panel)
        -- panel:Dock(TOP)
        panel:DockPadding(10, 10, 10, 10)
        panel:SetSize(480, 80)
        panel:SetPos(pos.x, pos.y)
        panel:SetBackgroundColor(HORDE.color_hollow)
        local avatar = vgui.Create('AvatarImage', panel)
        avatar:Dock(LEFT)
        avatar:SetSize(64,64)
        avatar:SetPlayer(ply, 64)
        
        local name_label = vgui.Create('DLabel', panel)
        name_label:SetPos(90,-20)
        name_label:SetText(ply:GetName())
        name_label:SetSize(100, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont('Title')

        local award_label = vgui.Create('DLabel', panel)
        award_label:SetPos(200, -20)
        award_label:SetText(award)
        award_label:SetSize(250, 80)
        award_label:SetColor(HORDE.color_crimson)
        award_label:SetFont('Title')

        local reason_label = vgui.Create('DLabel', panel)
        reason_label:SetPos(90,20)
        reason_label:SetText(reason)
        reason_label:SetSize(400, 80)
        reason_label:SetColor(Color(255,255,255))
        reason_label:SetFont('Title')

        return panel
    end

    self.map_btns = {}
    self.create_map_panel = function (map)
        local vote_btn = vgui.Create('DButton', votemap_panel)
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
        
        players_votes[map] = 0

        local name_label = vgui.Create('DLabel', vote_btn)
        name_label:Dock(LEFT)
        name_label:SetText('')
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont('Content')
        name_label.Paint = function ()
            if (players_votes[map] <= 0) or vote_btn_hovered or (self.map_btns[vote_btn] == 1) then
                draw.SimpleText(map, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
            else
                draw.SimpleText(map, "Content", 10, 20, HORDE.color_crimson, TEXT_ALIGN_LEFT)
            end
        end

        local count_label = vgui.Create('DLabel', vote_btn)
        count_label:Dock(RIGHT)
        count_label:SetSize(50, 80)
        count_label:SetColor(Color(255,255,255))
        count_label:SetFont('Content')
        count_label:SetText('')
        count_label.Paint = function ()
            if players_votes[map] then
                if (players_votes[map] <= 0) or vote_btn_hovered or (self.map_btns[vote_btn] == 1) then
                    draw.SimpleText(tostring(players_votes[map]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, Color(255,255,255))
                else
                    draw.SimpleText(tostring(players_votes[map]) .. "/" .. tostring(table.Count(player.GetAll())), "Content", 0, 20, HORDE.color_crimson)
                end
            end
        end

        self.map_btns[vote_btn] = 0
    end

    local counter_label = vgui.Create('DLabel', self)
    counter_label:SetText("")
    counter_label:SetSize(1024, 50)
    counter_label:SetTextColor(Color(255,255,255))
    counter_label.Paint = function ()
        draw.SimpleText("Remaining time: " .. tostring(remaining_time), "Title", self:GetWide() - 240, 12.5, Color(255,255,255))
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

function round2(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function PANEL:SetData(mvp_player, mvp_damage, mvp_kills, damage_player, most_damage, kills_player, most_kills, money_player, most_money, headshot_player, most_headshots, elite_kill_player, most_elite_kills, damage_taken_player, most_damage_taken, total_damage, maps)
    local percentage = 0
    if total_damage > 0 then
        percentage = round2(mvp_damage / total_damage, 2) * 100
    end
    self.create_player_panel({x=512 - 240,y=100}, mvp_player, "MVP", tostring(mvp_kills) .. " Kills, " .. tostring(mvp_damage) .. " Damage (" .. tostring(percentage) .. "%)")
    self.create_player_panel({x=512 - 480 - 5,y=220}, damage_player, "Most Damage Dealt", tostring(most_damage) .. " Damage")
    self.create_player_panel({x=512 + 5, y=220}, kills_player, "Most Kills", tostring(most_kills) .. " Kills")
    self.create_player_panel({x=512 - 480 - 5,y=340}, damage_taken_player, "Most Damage Taken", tostring(most_damage_taken) .. " Damage Taken")
    self.create_player_panel({x=512 + 5,y=340}, elite_kill_player, "Elite Killer", tostring(most_elite_kills) .. " Elite Kills")
    self.create_player_panel({x=512 + 5,y=460}, money_player, "Money Bag", tostring(most_money) .. "$ Earned")
    self.create_player_panel({x=512 - 480 - 5,y=460}, headshot_player, "SharpShooter", tostring(most_headshots) .. " Headshots")
    
    for _, map in pairs(maps) do
        self.create_map_panel(map)
    end

    gui.EnableScreenClicker(true)
end

function PANEL:Paint(w, h)
    -- Entire Panel
	draw.RoundedBox(0, 0, 0, w, h, HORDE.color_hollow)

    -- Cover
    draw.RoundedBox(0, 0, 50, w, h, HORDE.color_hollow)
end

vgui.Register('HordeSummaryPanel', PANEL, 'DPanel')