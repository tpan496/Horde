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
    self.title:SetText("Perk Name")
    self.title:SetColor(color_white)

    self.locked_icon = vgui.Create("DImage", self)
    self.locked_icon:SetSize(15,15)
    self.locked_icon:SetMaterial(Material("locked.png", "mips smooth"))

    self.desc = vgui.Create("DLabel", self)
    self.desc:Dock(FILL)
    self.desc:DockMargin(5, 3, 5, 0)
    self.desc:SetText("Perk Description")
    self.desc:SetColor(color_white)
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.info then return end
    MySelf.Horde_PerkChoices = MySelf.Horde_PerkChoices or {}
    MySelf.Horde_PerkChoices[self.info.class] = MySelf.Horde_PerkChoices[self.info.class] or {}
    MySelf.Horde_PerkChoices[self.info.class][self.info.perk_level] = self.info.choice
    file.Write("horde/perk_choices.txt", util.TableToJSON(MySelf.Horde_PerkChoices))
    net.Start("Horde_PerkChoice")
        net.WriteString(self.info.class)
        net.WriteUInt(self.info.perk_level, 4)
        net.WriteUInt(self.info.choice, 4)
    net.SendToServer()
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

function PANEL:SetData(classname, perk_level, choice, subclass)
    self.locked_icon:SetPos(self:GetWide() - 20, 5)
    local perk_choice
    if subclass and subclass.ParentClass then
        perk_choice = subclass.Perks[perk_level].choices[choice]
    else
        perk_choice = HORDE.classes[classname].perks[perk_level].choices[choice]
    end
    
    if not perk_choice then error("Could not find choice! class: " .. classname .. ", level: " .. perk_level .. ", choice: " .. choice) return end
    self.info = {class = classname, perk_level = perk_level, choice = choice}

    local perk = HORDE.perks[perk_choice]
    if not perk then error("Could not find perk '" .. perk .. "'!") return end

    local icon = perk.Icon
    if icon then
        self.icon:SetMaterial(Material(icon, "mips smooth"))
    else
        self.icon:SetMaterial(Material(HORDE.classes[classname].icon, "mips smooth"))
    end
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

    MySelf.Horde_PerkChoices = MySelf.Horde_PerkChoices or {}
    MySelf.Horde_PerkChoices[classname] = MySelf.Horde_PerkChoices[classname] or {}
    local tbl_choices = MySelf.Horde_PerkChoices[classname]

    self.info.active = (tbl_choices[perk_level] or 1) == choice

    local title = perk.PrintName or "Unnamed Perk"
    local loc_title = translate.Get("Perk_Title_" .. perk_choice) or title
    self.title:SetText(loc_title)
    
    local text = perk.Description .. "\n"
    local loc_desc = translate.Get("Perk_" .. perk_choice) or text
    if perk.Params then
        for i, v in pairs(perk.Params) do
            local replaced = "{" .. i .. "}"
            if not string.find(loc_desc, replaced) then goto cont end
            if v.level then
                v.value = math.min(v.max, MySelf:Horde_GetLevel(classname) * v.level)
            end
            local formatted = v.value
            if v.percent then
                formatted = math.Round(formatted * 100) .. "%"
            end
            loc_desc = string.Replace(loc_desc, replaced, formatted)
            ::cont::
        end
    end

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
    self.info.active = (MySelf.Horde_PerkChoices[self.info.class][self.info.perk_level] or 1) == self.info.choice
    if self.locked then
        if self.info and self.info.active then
            self.bg_color = Color(100, 00, 00, 150)
        else
            self.bg_color = Color(30, 30, 30)
        end
    else
        if self.info and self.info.active then
            self.bg_color = Color(220, 20, 60, 150)
        else
            self.bg_color = Color(50, 50, 50)
        end
    end
end

function PANEL:Paint(w,h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, self.bg_color)
end

vgui.Register("HordePerkButton", PANEL, "DButton")