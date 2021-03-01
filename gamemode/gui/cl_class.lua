if SERVER then return end

surface.CreateFont("Item", { font = "arial", size = 20 })

local PANEL = {}

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
        surface.DrawText(self.name)

        surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        local mat = Material("materials/" .. self.name .. ".png", "mips smooth")
        surface.SetMaterial(mat) -- Use our cached material
        surface.DrawTexturedRect(self:GetWide() - 50, 0, 40, 40)
    end
end

vgui.Register("HordeClass", PANEL, "DPanel")