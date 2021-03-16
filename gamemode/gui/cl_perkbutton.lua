local PANEL = {}

surface.CreateFont("Horde_PerkButton_Name", { font = "arial bold", size = 16, bold = true })

local function getweaponname(class)
    if language.GetPhrase(class) ~= class then return language.GetPhrase(class) end
    if weapons.Get(class) then return weapons.Get(class).PrintName end
    return class
end

function PANEL:Init()
    local w, h = ScrW() * 0.1, ScrH() * 0.05
    self:SetSize(w, h)
    self:SetText("")

    self.icon = vgui.Create("DImage", self)
    self.icon:SetSize(h, h)
    self.icon:Dock(LEFT)

    self.title = vgui.Create("DLabel", self)
    self.title:SetSize(w, 16)
    self.title:Dock(TOP)
    self.title:DockMargin(5, 5, 0, 0)
    self.title:SetFont("Horde_PerkButton_Name")
    self.title:SetText("Perk Name")

    self.desc = vgui.Create("DLabel", self)
    self.desc:Dock(FILL)
    self.desc:DockMargin(5, 5, 5, 5)
    self.desc:SetText("Perk Description")

    --[[]
    self.button = vgui.Create("DButton", self)
    self.button:SetSize(w, h)
    self.button:SetText("")
    self.button.Paint = function() end
    self.button.DoClick = function()
        if not self.info or self.info.class ~= LocalPlayer():Horde_GetClass().name then return end
        net.Start("Horde_PerkChoice")
            net.WriteUInt(self.info.perk_level, 4)
            net.WriteUInt(self.info.choice, 4)
        net.SendToServer()
        LocalPlayer().Horde_PerkChoices = LocalPlayer().Horde_PerkChoices or {}
        LocalPlayer().Horde_PerkChoices[self.info.class][self.info.perk_level] = self.info.choice
    end
    ]]
end

function PANEL:DoClick()
    if not self.info then return end
    LocalPlayer().Horde_PerkChoices = LocalPlayer().Horde_PerkChoices or {}
    LocalPlayer().Horde_PerkChoices[self.info.class] = LocalPlayer().Horde_PerkChoices[self.info.class] or {}
    LocalPlayer().Horde_PerkChoices[self.info.class][self.info.perk_level] = self.info.choice
    file.Write("horde_perkchoices.txt", util.TableToJSON(LocalPlayer().Horde_PerkChoices))
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

function PANEL:SetData(classname, perk_level, choice)
    local tbl = HORDE.classes[classname].perks[perk_level].choices[choice]
    if not tbl then error("Could not find choice! class: " .. classname .. ", level: " .. perk_level .. ", choice: " .. choice) return end
    self.info = {class = classname, perk_level = perk_level, choice = choice}

    if tbl.icon then
        self.icon:SetMaterial(Material(tbl.icon, "mips smooth"))
    else
        self.icon:SetMaterial(Material("materials/" .. classname .. ".png", "mips smooth"))
    end

    LocalPlayer().Horde_PerkChoices = LocalPlayer().Horde_PerkChoices or {}
    LocalPlayer().Horde_PerkChoices[classname] = LocalPlayer().Horde_PerkChoices[classname] or {}
    local tbl_choices = LocalPlayer().Horde_PerkChoices[classname]

    self.info.active = (tbl_choices[perk_level] or 1) == choice

    self.title:SetText(tbl.name or "Unnamed Perk")

    self.desctext = ""

    for perk, params in pairs(tbl.perks) do
        local perk_tbl = HORDE.perks[perk]
        if not perk_tbl then error("Could not find perk '" .. perk .. "'!") continue end
        local text = perk_tbl.Description
        for i, v in pairs(perk_tbl.Parameters) do
            local replaced = "{" .. i .. "}"
            if not string.find(text, replaced) then continue end
            local formatted = params[i] or v.default
            if v.percent then
                formatted = math.Round(formatted * 100) .. "%"
            elseif v.weapon then
                formatted = getweaponname(formatted)
            elseif v.ammo then
                formatted = language.GetPhrase("ammo_" .. formatted) or formatted
            elseif v.entity then
                formatted = scripted_ents.Get(formatted) and scripted_ents.Get(formatted).PrintName or formatted
            end
            text = string.Replace(text, replaced, formatted)
        end
        self.desctext = self.desctext .. text .. "\n"
    end

    self.desc:SetText(self.desctext)

    if self.info and self.info.active then
        self.bg_color = Color(50, 80, 50)
    else
        self.bg_color = Color(50, 50, 50)
    end
end

function PANEL:Think()
    if not self.info then return end
    self.info.active = (LocalPlayer().Horde_PerkChoices[self.info.class][self.info.perk_level] or 1) == self.info.choice
    self.bg_color = self.info.active and Color(50, 80, 50) or Color(50, 50, 50)
end

function PANEL:Paint(w,h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, self.bg_color)
end

vgui.Register("HordePerkButton", PANEL, "DButton")