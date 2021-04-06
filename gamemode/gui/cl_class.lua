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
    self.bg_color = Color(100, 100, 100)
end

function PANEL:OnCursorExited()
    self.bg_color = Color(50,50,50)
    surface.PlaySound("UI/buttonrollover.wav")
end

function PANEL:SetData(class, description_panel)
    self.class = class
    self.name = class.name
    self.description = class.description
    self.description_panel = description_panel
    mat = {self.class, Material(self.class.icon, "mips smooth")}

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
        surface.DrawText(translate.Get("Class_" .. self.name) or self.name)

        surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        if mat[1] ~= self.class then mat = {self.class, Material(self.class.icon, "mips smooth")} end
        if mat then surface.SetMaterial(mat[2]) end
        local level = LocalPlayer():Horde_GetLevel(LocalPlayer():Horde_GetClass().name)
        if level <= 0 then return end
        local rank, rank_level, color = HORDE:LevelToRank(level)
        surface.SetDrawColor(color)
        local star = Material("star.png", "mips smooth")
        if ScrW() <= 1280 then
            surface.DrawTexturedRect(self:GetWide() / 2 - 135, 0, 40, 40)
            surface.SetMaterial(star)
            local pos = 28
            for i = 0, rank_level do
                surface.DrawTexturedRect(self:GetWide() / 2 - 145, pos, 10, 10)
                pos = pos - 7
            end
        else
            surface.DrawTexturedRect(self:GetWide() / 2 - 50, 0, 40, 40)
            surface.SetMaterial(star)
            local pos = 28
            for i = 0, rank_level do
                surface.DrawTexturedRect(self:GetWide() / 2 - 60, pos, 10, 10)
                pos = pos - 7
            end
        end
    end
end

vgui.Register("HordeClass", PANEL, "DPanel")