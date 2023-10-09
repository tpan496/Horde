
local P_meta = FindMetaTable("Panel")
local P_Player = FindMetaTable("Player")
local P_IsValid = P_meta.IsValid

local PANEL = {}

PANEL.m_Player = NULL
PANEL.NextRefresh = 0
PANEL.RefreshTime = 1

local draw_RoundedBox = draw.RoundedBox

local function MuteDoClick(self)
	local pl = self:GetParent():GetPlayer()
	if pl:IsValid() then
		pl:SetMuted(not pl:IsMuted())
		self:GetParent().NextRefresh = RealTime()
	end
end

function P_Player:LongName()
	local name = self:Name()
	if #name > 25 then
		name = string.sub(name, 1, 25)..".."
	end

	return name
end

function PANEL:Init()

    self.m_AvatarPanel = vgui.Create("DPanel", self)
    self.m_AvatarPanel:SetText(" ")
	self.m_AvatarPanel:SetSize(32, 32 )
	self.m_AvatarPanel:Center()
	self.m_AvatarPanel:SetPaintBackground(false)

    self.m_Avatar = vgui.Create("AvatarImage", self.m_AvatarPanel)
	self.m_Avatar:SetSize(32, 32)
	self.m_Avatar:SetVisible(false)
	self.m_Avatar:SetMouseInputEnabled(false)

	self.m_PlayerLabel = HORDE:EasyLabel(self, " ", "Content", COLOR_WHITE)
	self.m_KillsLabel = HORDE:EasyLabel(self, " ", "Content", COLOR_WHITE)
	self.m_DeathsLabel = HORDE:EasyLabel(self, " ", "Content", COLOR_WHITE)

	self.m_RankLabel = HORDE:EasyLabel(self, " ", "Content", COLOR_WHITE)

	self.m_MoneyLabel = HORDE:EasyLabel(self, " ", "Content", COLOR_WHITE)

	self.m_PingMeter = vgui.Create("DPingMeter", self)

	self.m_Mute = vgui.Create("DImageButton", self)
	self.m_Mute.DoClick = MuteDoClick

    self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:RefreshPlayer()
	end
end

function PANEL:PerformLayout()

	self:SetSize(self:GetWide(), 40)

    local w = self:GetWide()
	local h = self:GetTall()

    self.m_AvatarPanel:AlignLeft(w * 0.015)
	self.m_AvatarPanel:CenterVertical()

	self.m_PlayerLabel:SizeToContents()
	self.m_PlayerLabel:AlignLeft(w * 0.05)
	self.m_PlayerLabel:CenterVertical()

	self.m_RankLabel:AlignLeft(w * 0.25)
	self.m_RankLabel:SizeToContents()
	self.m_RankLabel:CenterVertical()

	self.m_MoneyLabel:SizeToContents()
	self.m_MoneyLabel:AlignRight(w * 0.26)
	self.m_MoneyLabel:CenterVertical()

	self.m_KillsLabel:SizeToContents()
	self.m_KillsLabel:AlignRight(w * 0.18, 0)
	self.m_KillsLabel:CenterVertical()

	self.m_DeathsLabel:SizeToContents()
	self.m_DeathsLabel:AlignRight(w * 0.1, 0)
	self.m_DeathsLabel:CenterVertical()

	local pingsize = self:GetTall() - 8

	self.m_PingMeter:SizeToContents()
	self.m_PingMeter:SetSize(self:GetTall() - 2, pingsize)
	self.m_PingMeter:AlignRight(w * 0.02)
	self.m_PingMeter:CenterVertical()

	self.m_Mute:SizeToContents()
	self.m_Mute:SetSize(16, 16)
	self.m_Mute:MoveLeftOf(self.m_PingMeter, 15)
	self.m_Mute:CenterVertical()

end

function PANEL:RefreshPlayer()

	local pl = self:GetPlayer()


	local subclass_name = HORDE.Class_Survivor
    if pl:Horde_GetCurrentSubclass() then 
		subclass_name = pl:Horde_GetCurrentSubclass()
	end

    local subclass = HORDE.subclasses[subclass_name]

	local class = translate.Get("Class_" .. subclass.PrintName) or subclass.PrintName

	local name = pl:LongName()
	local color = color_white

	self.m_AvatarPanel:CenterVertical()

	self.m_PlayerLabel:SetText( name )
	self.m_PlayerLabel:SetColor( color )
	self.m_PlayerLabel:SizeToContents()

	self.m_RankLabel:SetText( class )
	self.m_RankLabel:SizeToContents()
	self.m_RankLabel:SetColor( color )

	self.m_MoneyLabel:SizeToContents()
	self.m_MoneyLabel:SetText(pl:Horde_GetMoney().."$")
	self.m_MoneyLabel:SetColor( color )
	
	self.m_KillsLabel:SizeToContents()
	self.m_KillsLabel:SetText(pl:Frags())
	self.m_KillsLabel:SetColor( color )

	self.m_DeathsLabel:SizeToContents()
	self.m_DeathsLabel:SetText(pl:Deaths())
	self.m_DeathsLabel:SetColor( color )

	self.m_PingMeter:CenterVertical()

	if pl == MySelf then
		self.m_Mute:SetVisible(false)
	else
		if pl:IsMuted() then
			self.m_Mute:SetImage("icon16/sound_mute.png")
		else
			self.m_Mute:SetImage("icon16/sound.png")
		end

	end
	self.m_Mute:SizeToContents()

	self:InvalidateLayout()
end

local colTemp = Color(255, 255, 255, 200)
function PANEL:Paint()

	local wide = self:GetWide()
	local tall = self:GetTall()

	local col = Color(40,40,40,200)
	local mul = 0.5
	local pl = self:GetPlayer()

	if P_IsValid then
		col = Color(40,40,40,200)
		if not pl:Alive() then
			col = Color(100, 0, 0, 200)
		end

		if self.Hovered then
			mul = 2
		end
	
		colTemp.r = col.r * mul
		colTemp.g = col.g * mul
		colTemp.b = col.b * mul
		
		draw_RoundedBox(0, 0, 0, wide , tall , colTemp)
    end

    local subclass_name = HORDE.Class_Survivor
    if pl:Horde_GetCurrentSubclass() then subclass_name = pl:Horde_GetCurrentSubclass() end

    local perks
    if HORDE.classes[subclass_name] then
        perks = HORDE.classes[subclass_name].perks
    else
        perks = HORDE.subclasses[subclass_name].Perks
    end

    local gadget = pl:Horde_GetGadget()

    local subclass = HORDE.subclasses[subclass_name]
    if subclass then
        local mat = Material(subclass.Icon, "mips smooth")
        local rank = pl:Horde_GetRank(subclass.PrintName)
        local rank_level = pl:Horde_GetRankLevel(subclass.PrintName)
        surface.SetMaterial(mat) -- Use our cached material
        surface.SetDrawColor(HORDE.Rank_Colors[rank])
        surface.DrawTexturedRect(wide * 0.215, 2, 38, 38)
        if rank == HORDE.Rank_Master then
            draw.SimpleText(rank_level, "Trebuchet18", wide * 0.2075, 12, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
        else
            if rank_level > 0 then
                local star = Material("star.png", "mips smooth")
                surface.SetMaterial(star)
                local y_pos = 26
                for i = 0, rank_level - 1 do
                    surface.DrawTexturedRect(wide * 0.2075, y_pos, 10, 10)
                    y_pos = y_pos - 7
            	end
        	end
        end
		
    end

	local x = wide * 0.36
	for perk_level, v in SortedPairs(perks) do
		local color = color_white
		if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(perk_level) then 
			color = Color(150,150,150)
		end

		if not pl.Horde_PerkChoices then
			break
		end
		if (not subclass_name) or (not perk_level) or (not v.choices) then 
			break
		end

		if (not pl.Horde_PerkChoices[subclass_name]) then break end

		local choice = v.choices[pl.Horde_PerkChoices[subclass_name][perk_level] or 1]
		local perk = HORDE.perks[choice]
		local icon = perk.Icon
		if icon then
			local mat = Material(icon, "mips smooth")
			surface.SetMaterial(mat)
			surface.SetDrawColor(color)
			surface.DrawTexturedRect(x, 2, 35, 35)
		else
			local mat = Material(HORDE.subclasses[subclass_name].Icon, "mips smooth")
			surface.SetMaterial(mat)
			surface.SetDrawColor(color)
			surface.DrawTexturedRect(x, 2, 35, 35)
		end
		x = x + 40
		
	end

    if gadget then
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
        surface.DrawTexturedRect(wide * 0.526, -2, 90, 45)
    end

	return true
end

function PANEL:SetPlayer(pl)
	self.m_Player = pl or NULL

	self.m_Avatar:SetPlayer(pl)
	self.m_Avatar:SetVisible(true)


	self.m_PingMeter:SetPlayer(pl)

	self:RefreshPlayer()
end

function PANEL:GetPlayer()
	return self.m_Player
end

vgui.Register("DPlayerLine", PANEL, "Panel")