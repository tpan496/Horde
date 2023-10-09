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
    if self.infusion_panel then
        self.infusion_panel:SetData(self.item)
        self.infusion_panel:SetVisible(false)
    end
    self.description_panel:SetVisible(true)
    if self.infusion_btn then
        self.infusion_btn:SetActive(false)
    end
end

function PANEL:OnCursorEntered()
    self.bg_color = Color(100, 100, 100, 200)
end

function PANEL:OnCursorExited()
    self.bg_color = Color(50,50,50, 200)
end

function PANEL:IsUpgraded()
    return MySelf:HasWeapon(self.item.class) and
    ((MySelf:Horde_GetCurrentSubclass() == "Gunslinger" and self.item.category == "Pistol")
    or (self.item.class == "horde_void_projector" or self.item.class == "horde_solar_seal" or self.item.class == "horde_astral_relic" or self.item.class == "horde_carcass" or self.item.class == "horde_pheropod"))
end

function PANEL:SetData(item, description_panel, infusion_panel)
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

    if self:IsUpgraded() then
        self.loc_name = self.loc_name .. " +" .. tostring(MySelf:Horde_GetUpgrade(self.item.class))
    end

    self.description = item.description
    self.weight = item.weight
    self.price = item.price
    self.skull_tokens = item.skull_tokens or 0
    self.description_panel = description_panel
    self.infusion_panel = infusion_panel
    self.player_class = MySelf:Horde_GetClass().name

    self.level_satisfy = true
    if self.item.levels then
        for class, level in pairs(self.item.levels) do
            if MySelf:Horde_GetLevel(class) < level then
                self.level_satisfy = false
                break
            end
        end
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

    local weight_panel = vgui.Create("DPanel", self)
    weight_panel:Dock(RIGHT)
    weight_panel:SetSize(50, weight_panel:GetTall())
    weight_panel:DockMargin(10,0,10,0)
    weight_panel.Paint = function () end

    local weight_panel_text = vgui.Create("DLabel", weight_panel)
    weight_panel_text:Dock(LEFT)
    weight_panel_text:SetSize(20, weight_panel:GetTall())
    weight_panel_text:SetFont("Item")
    weight_panel_text:SetText(tostring(self.weight))
    weight_panel_text:SetContentAlignment(6)
    local weight_panel_icon = vgui.Create("DImage", weight_panel)
    weight_panel_icon:SetSize(25, 25)
    weight_panel_icon:SetPos(18, 6)
    weight_panel_icon:SetMaterial(Material("weight.png", "mips smooth"))
    --weight_panel_icon:SetPos(10,5)
    self.weight_panel = weight_panel
    self.weight_panel_text = weight_panel_text
    self.weight_panel_icon = weight_panel_icon

    local price_panel = vgui.Create("DLabel", self)
    price_panel:Dock(RIGHT)
    price_panel:SetSize(80, price_panel:GetTall())
    price_panel:SetFont("Item")
    price_panel:SetContentAlignment(6)
    self.price_panel = price_panel

    local infusion_btn
    infusion_btn = vgui.Create("DButton", self)
    infusion_btn:SetPos(self:GetWide() - 256 - 96 - 150, 8)
    infusion_btn:SetTall(48)
    infusion_btn.PerformLayout = function(pnl)
        pnl:SizeToContents() pnl:SetWide(pnl:GetWide() + 12) DLabel.PerformLayout(pnl)
        pnl:SetContentAlignment(4)
        pnl:SetTextInset(15, 0)
    end

    if MySelf:Horde_GetInfusion(self.item.class) == HORDE.Infusion_None then
        infusion_btn:SetText(translate.Get("Game_Infusion") .. ": " .. translate.Get("Infusion_None"))
    else
        infusion_btn:SetText(translate.Get("Game_Infusion") .. ": " .. translate.Get("Infusion_" .. HORDE.Infusion_Names[MySelf:Horde_GetInfusion(self.item.class)]))
    end
    infusion_btn:SetFont("Category")

    infusion_btn.Paint = function(pnl, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(40,40,40,230))
    end

    infusion_btn.UpdateColours = function(pnl)
        if pnl:GetActive() then
            pnl:SetTextColor(HORDE.color_crimson)
            return
        end
        if pnl.Hovered then
            pnl:SetTextColor(HORDE.color_crimson)
        return end
        pnl:SetTextColor(Color(255, 255, 255))
    end

    infusion_btn.GetActive = function(pnl) return pnl.Active or false end
    infusion_btn.SetActive = function(pnl, state) pnl.Active = state end

    local p = self
    infusion_btn.DoClick = function(pnl)
        --pnl:SetActive(true)
        surface.PlaySound("UI/buttonclick.wav")
        pnl:SetActive(true)
        p.infusion_panel:SetVisible(true)
        p.infusion_panel:SetData(p.item)
        p.description_panel:SetVisible(false)
    end

    infusion_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end
    self.infusion_btn = infusion_btn

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
        local is_rich = MySelf:Horde_GetMoney() >= self.item.price and MySelf:Horde_GetSkullTokens() >= (self.item.skull_tokens or 0) and MySelf:Horde_GetWeight() >= self.item.weight
        surface.SetDrawColor(self.bg_color)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        surface.SetFont("Item")

        if MySelf:HasWeapon(self.item.class) or MySelf:Horde_GetGadget() == self.item.class or (MySelf.Horde_drop_entities and MySelf.Horde_drop_entities[self.item.class]) then
            self.price_panel:SetTextColor(HORDE.color_crimson)
            self.price_panel:SetText("Owned")
            self.weight_panel_text:SetTextColor(HORDE.color_crimson)
            self.weight_panel_icon:SetImageColor(HORDE.color_crimson)
            if self.item.infusions and !table.IsEmpty(self.item.infusions) then
                self.infusion_btn:SetVisible(true)
            else
                self.infusion_btn:SetVisible(false)
            end

            local infusion = MySelf:Horde_GetInfusion(self.item.class)
            if infusion == HORDE.Infusion_None then
                self.infusion_btn:SetText(translate.Get("Game_Infusion") .. ": " .. translate.Get("Infusion_None"))
            else
                self.infusion_btn:SetText(translate.Get("Game_Infusion") .. ": " .. translate.Get("Infusion_" .. HORDE.Infusion_Names[infusion]))
            end
        else
            self.infusion_btn:SetVisible(false)
            if is_rich then
                surface.SetTextColor(self.text_color)
                self.weight_panel_text:SetTextColor(self.text_color)
                self.weight_panel_icon:SetImageColor(self.text_color)
                self.price_panel:SetTextColor(self.text_color)
            else
                surface.SetTextColor(self.text_color_poor)
                self.weight_panel_text:SetTextColor(self.text_color_poor)
                self.weight_panel_icon:SetImageColor(self.text_color_poor)
                self.price_panel:SetTextColor(self.text_color_poor)
            end
            if self.skull_tokens and self.skull_tokens > 0 then
                if self.price <= 0 then
                    self.price_panel:SetText(tostring(self.skull_tokens) .. "    ")
                else
                    self.price_panel:SetText(tostring(self.price) .. "$ " .. tostring(self.skull_tokens) .. "    ")
                end
                local mat = Material("skull.png", "mips smooth")
                surface.SetMaterial(mat)
                if is_rich then
                    surface.SetDrawColor(self.text_color)
                else
                    surface.SetDrawColor(self.text_color_poor)
                end
                local x,y = self.price_panel:GetPos()
                surface.DrawTexturedRect(x + self.price_panel:GetWide() - 20, y + 12, 14, 15)
            else
                self.price_panel:SetText(tostring(self.price) .. "$ ")
            end
        end

        if (not MySelf:HasWeapon(self.item.class)) and (not self.level_satisfy) then
            surface.SetTextColor(Color(80,80,80))
        else
            surface.SetTextColor(Color(255,255,255))
        end
        surface.SetTextPos(10, self:GetTall() / 2 - 10)
        surface.DrawText(self.loc_name)

        if self.item.entity_properties and self.item.entity_properties.is_arccw_attachment and ArcCW.AttachmentTable[self.item.class] then
            local icon = ArcCW.AttachmentTable[self.item.class].Icon
            if icon then
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(icon)
                surface.DrawTexturedRect(self:GetWide() - 128, -10, 60, 60)
                self.price_panel:SetText(tostring(self.price) .. "$   ")
            end
            self.weight_panel:SetVisible(false)
        else
            self.weight_panel:SetVisible(true)
            if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                if HORDE.gadgets[self.item.class].Active then
                    surface.SetMaterial(Material(HORDE.gadgets[self.item.class].Icon, "mips smooth"))
                    if HORDE.gadgets[self.item.class].Once then
                        surface.SetDrawColor(HORDE.color_gadget_once)
                    else
                        surface.SetDrawColor(HORDE.color_gadget_active)
                    end
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