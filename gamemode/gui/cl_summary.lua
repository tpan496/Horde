if SERVER then return end

surface.CreateFont('Title', { font = 'arial bold', size = 25 })
surface.CreateFont('Content', { font = 'arial bold', size = 20 })

local PANEL = {}

function PANEL:Init()
    self:SetSize(1024, 600)
	self:SetPos(ScrW()/2 - (self:GetWide() / 2), ScrH()/2 - (self:GetTall() / 2))
    self:SetBackgroundColor(Color(0,0,0,0))

    self.create_player_panel = function (pos, ply, award, reason)
        local panel = vgui.Create('DPanel', self)
        -- panel:Dock(TOP)
        panel:DockPadding(10, 10, 10, 10)
        panel:SetSize(480, 80)
        panel:SetPos(pos.x, pos.y)
        panel:SetBackgroundColor(Color(50,50,50,255))
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
end

function PANEL:SetData(mvp_player, mvp_damage, mvp_kills, damage_player, most_damage, kills_player, most_kills, money_player, most_money, headshot_player, most_headshots, elite_kill_player, most_elite_kills, damage_taken_player, most_damage_taken)
    self.create_player_panel({x=512 - 240,y=80}, mvp_player, "MVP", tostring(mvp_kills) .. " Kills, " .. tostring(mvp_damage) .. " Damage")
    self.create_player_panel({x=512 - 480 - 5,y=200}, damage_player, "Most Damage Dealt", tostring(most_damage) .. " Damage")
    self.create_player_panel({x=512 + 5, y=200}, kills_player, "Most Kills", tostring(most_kills) .. " Kills")
    self.create_player_panel({x=512 - 480 - 5,y=320}, damage_taken_player, "Most Damage Taken", tostring(most_damage_taken) .. " Damage Taken")
    self.create_player_panel({x=512 + 5,y=320}, elite_kill_player, "Elite Killer", tostring(most_elite_kills) .. " Elite Kills")
    self.create_player_panel({x=512 + 5,y=440}, money_player, "Money Bag", tostring(most_money) .. "$ Earned")
    self.create_player_panel({x=512 - 480 - 5,y=440}, headshot_player, "SharpShooter", tostring(most_headshots) .. " Headshots")
end

function PANEL:Paint(w, h)
	--Derma_DrawBackgroundBlur(self)

    -- Entire Panel
	draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40, 255))
	draw.SimpleText("Game Summary", 'Heading', self:GetWide()/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register('HordeSummary', PANEL, 'DPanel')