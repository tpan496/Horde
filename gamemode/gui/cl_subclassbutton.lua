local PANEL = {}

local function getweaponname(class)
    if language.GetPhrase(class) ~= class then return language.GetPhrase(class) end
    if weapons.Get(class) then return weapons.Get(class).PrintName end
    return class
end

function PANEL:Init()
    local w, h = 200, 82
    self:SetSize(w, h)
    self:SetText("")

    self.icon = vgui.Create("DImage", self)
    self.icon:SetSize(h, h)
    self.icon:Dock(LEFT)

    self.title = vgui.Create("DLabel", self)
    self.title:SetSize(w, 20)
    self.title:Dock(TOP)
    self.title:DockMargin(5, 5, 0, 0)
    self.title:SetFont("Horde_PerkButton_Name")
    self.title:SetText("Subclass Name")
    self.title:SetColor(color_white)

    self.locked_icon = vgui.Create("DImage", self)
    self.locked_icon:SetSize(15,15)
    self.locked_icon:SetMaterial(Material("locked.png", "mips smooth"))

    self.desc = vgui.Create("DLabel", self)
    self.desc:Dock(FILL)
    self.desc:DockMargin(5, 3, 5, 0)
    self.desc:SetText("Subclass Description")
    self.desc:SetColor(color_white)
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.info then return end
    Derma_Query("Change Subclass?", "Change",
                "Yes",
                function()
                    LocalPlayer():Horde_SetSubclass(self.info.class, self.info.subclass.ClassName)
                    HORDE:ToggleShop()
                end,
                "No", function() end
            )
    --[[LocalPlayer().Horde_PerkChoices = LocalPlayer().Horde_PerkChoices or {}
    LocalPlayer().Horde_PerkChoices[self.info.class] = LocalPlayer().Horde_PerkChoices[self.info.class] or {}
    LocalPlayer().Horde_PerkChoices[self.info.class][self.info.perk_level] = self.info.choice
    file.Write("horde/perk_choices.txt", util.TableToJSON(LocalPlayer().Horde_PerkChoices))
    net.Start("Horde_PerkChoice")
        net.WriteString(self.info.class)
        net.WriteUInt(self.info.perk_level, 4)
        net.WriteUInt(self.info.choice, 4)
    net.SendToServer()]]--
end

function PANEL:OnCursorEntered()
    if self.info and self.info.active then
        self.bg_color = Color(100, 150, 100)
    else
        self.bg_color = Color(100, 100, 100)
    end
end

function PANEL:OnCursorExited()
    if self.info and self.info.active then
        self.bg_color = Color(50, 80, 50)
    else
        self.bg_color = Color(50, 50, 50)
    end
    surface.PlaySound("UI/buttonrollover.wav")
end

function PANEL:SetData(classname, subclass_name)
    self.locked_icon:SetPos(self:GetWide() - 20, 5)
    local subclass = HORDE.subclasses[subclass_name]
    if not subclass then error("Could not find subclass! class: " .. classname .. ", subclass: " .. subclass.PrintName) return end
    self.info = {class = classname, subclass = subclass}

    local icon = subclass.Icon
    if icon then
        self.icon:SetMaterial(Material(icon, "mips smooth"))
    else
        self.icon:SetMaterial(Material(HORDE.classes[classname].icon, "mips smooth"))
    end

    self.locked = LocalPlayer():Horde_GetSubclassUnlocked(subclass.ClassName)
    if self.locked then
        self.icon:SetImageColor(Color(150,150,150,255))
        self.title:SetColor(color_gray)
        self.desc:SetColor(color_gray)
        self.locked_icon:SetVisible(true)
    else
        self.icon:SetImageColor(color_white)
        self.title:SetColor(color_white)
        self.desc:SetColor(color_white)
        self.locked_icon:SetVisible(false)
    end

    self.info.active = string.lower(LocalPlayer():Horde_GetSubclass(classname)) == subclass.ClassName

    local title = subclass.PrintName or "Unnamed Subclass"
    local loc_title = translate.Get("Subclass_Title_" .. title) or subclass.PrintName
    self.title:SetText(loc_title)
    
    local text = subclass.Description .. "\n"
    local loc_desc = translate.Get("Subclass_" .. subclass.Description) or text

    self.desc:SetText(loc_desc)
    self.desc:SetFont("Horde_PerkButton_Text")
end

function PANEL:GetLocked()
    return self.locked
end

function PANEL:SetLocked(locked)
    self.locked = locked
end

function PANEL:Think()
    if not self.info then return end
    self.info.active = string.lower(LocalPlayer():Horde_GetSubclass(self.info.class)) == self.info.subclass.ClassName
    if self.locked then
        if self.info and self.info.active then
            self.bg_color = Color(80, 00, 80, 150)
        else
            self.bg_color = Color(30, 30, 30)
        end
    else
        if self.info and self.info.active then
            self.bg_color = Color(150, 20, 150, 150)
        else
            self.bg_color = Color(50, 50, 50)
        end
    end
end

function PANEL:Paint(w,h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, self.bg_color)
end

vgui.Register("HordeSubclassButton", PANEL, "DButton")