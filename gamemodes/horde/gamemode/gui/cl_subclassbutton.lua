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

    self.desc = vgui.Create("DLabel", self)
    self.desc:Dock(FILL)
    self.desc:DockMargin(5, 3, 5, 0)
    self.desc:SetText("Subclass Description")
    self.desc:SetColor(color_white)

    local p = self

    self.locked_panel = vgui.Create("DPanel", self)
    self.locked_panel:SetMouseInputEnabled(false)
    self.locked_panel.Paint = function ()
        if self.locked then
            draw.SimpleText(self.info.subclass.UnlockCost, "Info", p:GetWide() - 65, 28, color_white, TEXT_ALIGN_CENTER)
            local mat = Material("skull.png", "mips smooth")
            surface.SetDrawColor(color_white)
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(p:GetWide() - 42, 22, 32, 32)
        end
    end
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.info then return end
    if self.locked then
        if MySelf:Horde_GetSkullTokens() < self.info.subclass.UnlockCost then return end
        Derma_Query("Unlock?", "Unlock Subclass",
                "Yes",
                function()
                    net.Start("Horde_UnlockSubclass")
                        net.WriteString(self.info.subclass.PrintName)
                    net.SendToServer()
                    HORDE:ToggleShop()
                end,
                "No", function() end
            )
    else
        Derma_Query("Change Subclass?", "Change Subclass",
                "Yes",
                function()
                    HORDE:SendSavedPerkChoices(self.info.subclass.PrintName)
                    MySelf:Horde_SetSubclass(self.info.class, self.info.subclass.PrintName)
                    HORDE:ToggleShop()
                    MySelf.Horde_subclass_choices[self.info.class] = self.info.subclass.PrintName
                    local subclass = HORDE.subclasses[self.info.subclass.PrintName]
                    local current_subclass = HORDE.subclasses[MySelf:Horde_GetCurrentSubclass()]
                    local parent_class = subclass.ParnetClass or subclass
                    local current_parent_class = current_subclass.ParnetClass or current_subclass
                    if parent_class == current_parent_class then
                        file.Write("horde/class_choices.txt", self.info.subclass.PrintName)
                    end
                    HORDE:SaveSubclassChoices()
                end,
                "No", function() end
            )
    end
    
    --[[MySelf.Horde_PerkChoices = MySelf.Horde_PerkChoices or {}
    MySelf.Horde_PerkChoices[self.info.class] = MySelf.Horde_PerkChoices[self.info.class] or {}
    MySelf.Horde_PerkChoices[self.info.class][self.info.perk_level] = self.info.choice
    file.Write("horde/perk_choices.txt", util.TableToJSON(MySelf.Horde_PerkChoices))
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
    local subclass = HORDE.subclasses[subclass_name]
    if not subclass then error("Could not find subclass! class: " .. classname .. ", subclass: " .. subclass.PrintName) return end
    self.info = {class = classname, subclass = subclass}

    local icon = subclass.Icon
    self.icon:SetMaterial(Material(icon, "mips smooth"))

    self.locked = MySelf:Horde_GetSubclassUnlocked(subclass.PrintName) == false
    if self.locked == true then
        self.icon:SetImageColor(Color(150,150,150,255))
        self.title:SetColor(Color(150,150,150,255))
        self.desc:SetColor(Color(150,150,150,255))
        self.title:SetText("???")
        self.desc:SetText("??????\n??????")
        self.desc:SetFont("Horde_PerkButton_Text")
    else
        self.icon:SetImageColor(color_white)
        self.title:SetColor(color_white)
        self.desc:SetColor(color_white)
        local text = subclass.Description .. "\n"
        local loc_desc = translate.Get("Subclass_" .. subclass.Description) or text
        self.desc:SetText(loc_desc)
        self.desc:SetFont("Horde_PerkButton_Text")
        local title = subclass.PrintName or "Unnamed Subclass"
        local loc_title = translate.Get("Subclass_Title_" .. title) or subclass.PrintName
        self.title:SetText(loc_title)
    end

    self.info.active = MySelf:Horde_GetSubclass(classname) == subclass.PrintName
    self.locked_panel:SetSize(self:GetWide(), self:GetTall())
end

function PANEL:GetLocked()
    return self.locked
end

function PANEL:SetLocked(locked)
    self.locked = locked
end

function PANEL:Think()
    if not self.info then return end
    self.info.active = MySelf:Horde_GetSubclass(self.info.class) == self.info.subclass.PrintName
    if self.locked then
        self.bg_color = Color(50, 50, 50)
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
