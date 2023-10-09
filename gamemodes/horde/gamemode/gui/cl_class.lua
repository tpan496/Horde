local PANEL = {}
local mat = {}

function PANEL:Init()
    self.name = ""
    self.bg_color = Color(50,50,50)
    self.bg_color_poor = Color(30,30,30)
    self.text_color = Color(255,255,255)
    self.text_color_poor = Color(100,0,0)
end

function PANEL:DoClick()
    self.description_panel:SetData(self.class)
    surface.PlaySound("UI/buttonclick.wav")
end

function PANEL:OnCursorEntered()
    if self.is_current_class then
        self.bg_color = Color(110, 110, 110)
    else
        self.bg_color = Color(100, 100, 100)
    end
end

function PANEL:OnCursorExited()
    if self.is_current_class then
        self.bg_color = Color(110,110,110)
    else
        self.bg_color = Color(50,50,50)
    end
    surface.PlaySound("UI/buttonrollover.wav")
end

function PANEL:SetData(class, description_panel)
    self.class = class
    self.subclass = HORDE.subclasses[MySelf:Horde_GetSubclass(self.class.name)]
    self.name = class.name
    self.description = class.description
    self.description_panel = description_panel
    self.mat = Material(self.subclass.Icon, "mips smooth")
    if self.subclass.PrintName == MySelf:Horde_GetCurrentSubclass() then
        self.is_current_class = true
    end
    
    if self.is_current_class then
        self.bg_color = Color(110,110,110)
    else
        self.bg_color = Color(50,50,50)
    end
    local btn = vgui.Create("DButton", self)
    btn:Dock(FILL)
    btn:SetText("")
    btn.Paint = function ()
        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    end

    function btn:DoClick()
        self:GetParent():DoClick()
    end

    function btn:OnCursorEntered()
        self:GetParent():OnCursorEntered()
    end

    function btn:OnCursorExited()
        self:GetParent():OnCursorExited()
    end

    self.choose_btn = btn
end

function PANEL:Paint()
    if self.class ~= nil then
        surface.SetDrawColor(self.bg_color)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        surface.SetFont("Item")

        surface.SetTextColor(Color(255,255,255))
        surface.SetTextPos(10, self:GetTall() / 2 - 10)
        surface.DrawText(translate.Get("Class_" .. self.subclass.PrintName) or self.subclass.PrintName)

        surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        local level = MySelf:Horde_GetLevel(self.subclass.PrintName)
        local rank, rank_level = HORDE:LevelToRank(level)
        
        if self.mat then
            surface.SetMaterial(self.mat)
        end
        
        surface.SetDrawColor(HORDE.Rank_Colors[rank])
        local star = Material("star.png", "mips smooth")
        if ScrW() <= 1280 then
            surface.DrawTexturedRect(self:GetWide() / 2 - 135, 0, 40, 40)
            if level <= 0 then return end
            if rank == HORDE.Rank_Master then
                draw.SimpleText(rank_level, "Trebuchet18", self:GetWide() / 2 - 145, 12, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                surface.SetMaterial(star)
                local pos = 28
                for i = 0, rank_level - 1 do
                    surface.DrawTexturedRect(self:GetWide() / 2 - 145, pos, 10, 10)
                    pos = pos - 7
                end
            end
        else
            surface.DrawTexturedRect(self:GetWide() / 2 - 50, 0, 40, 40)
            if level <= 0 then return end
            if rank == HORDE.Rank_Master then
                draw.SimpleText(rank_level, "Trebuchet18", self:GetWide() / 2 - 60, 12, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                surface.SetMaterial(star)
                local pos = 28
                for i = 0, rank_level - 1 do
                    surface.DrawTexturedRect(self:GetWide() / 2 - 60, pos, 10, 10)
                    pos = pos - 7
                end
            end
        end
    end
end

vgui.Register("HordeClass", PANEL, "DPanel")