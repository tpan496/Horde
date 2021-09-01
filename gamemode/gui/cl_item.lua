local PANEL = {}

function PANEL:Init()
    self.name = ""
    self.bg_color = Color(50,50,50, 200)
    self.bg_color_poor = Color(30,30,30, 200)
    self.text_color = Color(255,255,255)
    self.text_color_poor = Color(100,0,0)
end

function PANEL:DoClick()
    self.description_panel:SetData(self.item)
end

function PANEL:OnCursorEntered()
    self.bg_color = Color(100, 100, 100, 200)
end

function PANEL:OnCursorExited()
    self.bg_color = Color(50,50,50, 200)
end

function PANEL:SetData(item, description_panel)
    self.item = item
    self.name = item.name
    if GetConVar("horde_default_item_config"):GetInt() == 1 then
        if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
            self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
        else
            self.loc_name = translate.Get("Item_" .. self.name) or self.name
        end
    else
        if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
            self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
        else
            self.loc_name = self.name
        end
    end

    self.description = item.description
    self.weight = item.weight
    self.price = item.price
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
        surface.PlaySound("UI/buttonclick.wav")
    end

    function btn:OnCursorEntered()
        self:GetParent():OnCursorEntered()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    function btn:OnCursorExited()
        self:GetParent():OnCursorExited()
    end

    self.buy_btn = btn

    local weight_panel = vgui.Create("DLabel", self)
    weight_panel:Dock(RIGHT)
    weight_panel:SetSize(50, weight_panel:GetTall())
    weight_panel:SetFont("Item")
    weight_panel:SetText("[" .. tostring(self.weight) .."]")
    self.weight_panel = weight_panel

    local price_panel = vgui.Create("DLabel", self)
    price_panel:Dock(RIGHT)
    price_panel:SetSize(80, price_panel:GetTall())
    price_panel:SetFont("Item")
    self.price_panel = price_panel

    if self.item.shop_icon and self.item.shop_icon ~= "" then
        self.icon = self.item.shop_icon
        return
    end
    local icon
    local wpn = weapons.Get(self.item.class)
    if not wpn then
        if self.item.class == "weapon_crowbar" or
        self.item.class == "weapon_stunstick" or
        self.item.class == "weapon_pistol" or
        self.item.class == "weapon_357" or
        self.item.class == "weapon_rpg" or
        self.item.class == "weapon_frag" or
        self.item.class == "weapon_slam" or
        self.item.class == "weapon_smg1" or
        self.item.class == "weapon_shotgun" or
        self.item.class == "weapon_ar2" or
        self.item.class == "weapon_physcannon" or
        self.item.class == "weapon_crossbow" or
        self.item.class == "weapon_bugbait" then
            self.is_hl2 = true
        end
        self.icon = surface.GetTextureID("vgui/hud/item")
        return
    end
    icon = wpn.WepSelectIcon
    if not icon or icon == surface.GetTextureID("weapons/swep") then
        if wpn.ArcCW then
            local path = "arccw/weaponicons/" .. self.item.class
            local mat = Material(path)
            local tex = mat:GetTexture("$basetexture")
            if tex then
                if tex:GetName() == "error" then
                    self.icon = surface.GetTextureID("vgui/hud/item")
                    return
                end
                local texpath = tex:GetName()
                icon = surface.GetTextureID(texpath)
            else
                icon = surface.GetTextureID("vgui/hud/item")
            end
        else
            icon = surface.GetTextureID("vgui/hud/item")
        end
    end
    self.icon = icon
end

function PANEL:Paint()
    if self.item ~= nil then
        local is_rich = LocalPlayer():Horde_GetMoney() >= self.item.price and LocalPlayer():Horde_GetWeight() >= self.item.weight
        surface.SetDrawColor(self.bg_color)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        surface.SetFont("Item")

        if LocalPlayer():HasWeapon(self.item.class) or LocalPlayer():Horde_GetGadget() == self.item.class then
            self.price_panel:SetTextColor(HORDE.color_crimson)
            self.price_panel:SetText("Owned")
        else
            if is_rich then
                surface.SetTextColor(self.text_color)
                self.weight_panel:SetTextColor(self.text_color)
                self.price_panel:SetTextColor(self.text_color)
            else
                surface.SetTextColor(self.text_color_poor)
                self.weight_panel:SetTextColor(self.text_color_poor)
                self.price_panel:SetTextColor(self.text_color_poor)
            end
            self.price_panel:SetText(tostring(self.price) .. "$")
        end

        surface.SetTextColor(Color(255,255,255))
        surface.SetTextPos(10, self:GetTall() / 2 - 10)
        surface.DrawText(self.loc_name)

        if self.item.entity_properties and self.item.entity_properties.is_arccw_attachment and ArcCW.AttachmentTable[self.item.class] then
            local icon = ArcCW.AttachmentTable[self.item.class].Icon
            if icon then
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(icon)
                surface.DrawTexturedRect(self:GetWide() - 64, -10, 60, 60)
            end
            self.weight_panel:SetVisible(false)
        else
            self.weight_panel:SetVisible(true)
            if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                if HORDE.gadgets[self.item.class].Active then
                    surface.SetMaterial(Material(HORDE.gadgets[self.item.class].Icon, "mips smooth"))
                    surface.SetDrawColor(HORDE.color_crimson)
                    surface.DrawTexturedRect(self:GetWide() - 256, -5, 96, 48)
                else
                    surface.SetMaterial(Material(HORDE.gadgets[self.item.class].Icon, "mips smooth"))
                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(self:GetWide() - 256, -5, 96, 48)
                end
                return
            end
            if GetConVar("horde_enable_shop_icons"):GetInt() == 0 then return end
            if self.item.shop_icon then
                surface.SetMaterial(Material(self.item.shop_icon, "mips smooth"))
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(self:GetWide() - 256, -5, 96, 48)
                return
            end
            if not self.icon or self.icon < 0 or self.icon == surface.GetTextureID( "weapons/swep" ) then return end
            if self.is_hl2 then
                surface.SetMaterial(Material("items/hl2/" .. self.item.class .. ".png", "mips smooth"))
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(self:GetWide() - 256, -5, 96, 48)
            else
                surface.SetTexture(self.icon)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(self:GetWide() - 256, -5, 96, 48)
            end
        end
    end
end

vgui.Register("HordeShopItem", PANEL, "DPanel")