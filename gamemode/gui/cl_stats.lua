local PANEL = {}

local function GetImmune(status)
    if HORDE:GetStat(status) == 0 then
        return translate.Get("Stats_Menu_Status_Effect_Immunity_NO")
    else
        return translate.Get("Stats_Menu_Status_Effect_Immunity_YES")
    end
end

local function multlinetext(text, maxw, font)
    local content = ""
    local tline = ""
    local x = 0
    surface.SetFont(font)

    local newlined = string.Split(text, "\n")

    for _, line in pairs(newlined) do
        local words = string.Split(line, " ")

        for _, word in pairs(words) do
            local tx = surface.GetTextSize(word)

            if x + tx >= maxw then
                content = content .. "\n" .. tline
                tline = ""
                x = surface.GetTextSize(word)
            end

            tline = tline .. word .. " "

            x = x + surface.GetTextSize(word .. " ")
        end

        content = content .. "\n" .. tline
        tline = ""
        x = 0
    end
    return content
end

function PANEL:Init()
    if ScrH() < 1080 then
        self:SetSize(ScrW(), ScrH())
    else
        self:SetSize(ScrW() / 1.25, ScrH() / 1.5)
    end
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))

    local stats_panel = vgui.Create("DPanel", self)
    stats_panel:SetPos(0, 50)
    stats_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    stats_panel:SetBackgroundColor(HORDE.color_hollow)
    self.stats_panel = stats_panel

    local achievements_panel = vgui.Create("DPanel", self)
    achievements_panel:SetPos(0, 50)
    achievements_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    achievements_panel:SetBackgroundColor(HORDE.color_hollow)
    achievements_panel:SetVisible(false)
    self.achievements_panel = achievements_panel

    local maps_panel = vgui.Create("DScrollPanel", achievements_panel)
    maps_panel:Dock(LEFT)
    maps_panel:SetSize(300, self:GetParent():GetTall())
    maps_panel:SetBackgroundColor(Color(0,0,0,0))

    local map_achievement_btns = {}
    local map_achievements_panel = vgui.Create("DScrollPanel", achievements_panel)
    local map_clicked = nil
    map_achievements_panel:Dock(FILL)
    map_achievements_panel:DockMargin(10, 5, 10, 5)
    map_achievements_panel:SetSize(self:GetParent():GetWide() - 300, self:GetParent():GetTall())
    map_achievements_panel.Paint = function ()
        if map_clicked then return end
        draw.SimpleText(translate.Get("Achievements_Menu_Info"), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.DrawText(translate.Get("Achievements_Menu_Info_Text"), 'Content', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    
    local function firstToUpper(str)
        return (str:gsub("^%l", string.upper))
    end
    self.create_map_achievement_btn = function (map, title, unlocked)
        local achievement = vgui.Create("DPanel", map_achievements_panel)
        achievement:DockMargin(10, 5, 10, 5)
        achievement:SetSize(self:GetParent():GetWide() - 50, 100)
        achievement:Dock(TOP)
        local content = HORDE.MapAchievement_Descriptions[title]
        local ss = string.Split(map, "_")
        if ss[1] == "zs" or ss[1] == "de" or ss[1] == "hr" or ss[1] == "cs" or ss[1] == "gm" or ss[1] == "ow" or ss[1] == "zm" or ss[1] == "kf2" then
            local i = 1
            for _, sb in pairs(ss) do
                if i > 1 then
                    if i == 2 then
                        map = firstToUpper(ss[2])
                    else
                        map = map .. " " .. firstToUpper(ss[i])
                    end
                end
                i = i + 1
            end
        else
            map = string.upper(map)
        end
        achievement.Paint = function ()
            if unlocked then
                draw.RoundedBox(10, 0, 0, map_achievements_panel:GetWide() - 25, 100, HORDE.color_crimson)
                draw.SimpleText(translate.Format("Achievement_X_Map_X_Completion_Title", map, translate.Get("Achievement_Completion_Title_" .. title) or title), 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(translate.Get("Achievement_Completion_" .. content) or content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                surface.SetMaterial(Material("trophy.png", "mips smooth"))
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(map_achievements_panel:GetWide() - 125, 25, 50, 50)
            else
                draw.RoundedBox(10, 0, 0, map_achievements_panel:GetWide() - 25, 100, HORDE.color_hollow_dim)
                draw.SimpleText(translate.Format("Achievement_X_Map_X_Completion_Title", map, translate.Get("Achievement_Completion_Title_" .. title) or title), 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(translate.Get("Achievement_Completion_" .. content) or content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                surface.SetMaterial(Material("locked.png", "mips smooth"))
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(map_achievements_panel:GetWide() - 125, 25, 50, 50)
            end
        end
        table.insert(map_achievement_btns, achievement)
    end

    HORDE:LoadMapAchievements()
    local achievements = {}
    for map, stats in pairs(HORDE.achievements_map) do
        achievements[map] = HORDE:GetMapAchievements(map)
    end
    
    self.map_btns = {}
    self.create_map_btn = function (map)
        local map_btn = vgui.Create("DButton", maps_panel)
        local map_btn_hovered = false
        map_btn:DockMargin(10, 5, 10, 5)
        map_btn:SetSize(self:GetParent():GetWide(), 50)
        map_btn:Dock(TOP)
        map_btn:SetText("")
        map_btn.Paint = function ()
            if map_btn_hovered or (self.map_btns[map_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        map_btn.OnCursorEntered = function ()
            map_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        map_btn.OnCursorExited = function ()
            map_btn_hovered = false
        end
        map_btn.DoClick = function ()
            for btn, _ in pairs(self.map_btns) do
                self.map_btns[btn] = 0
            end
            self.map_btns[map_btn] = 1
            surface.PlaySound("UI/buttonclick.wav")
            map_clicked = true

            for _, btns in pairs(map_achievement_btns) do
                btns:Remove()
            end

            if not achievements[map] then
                achievements[map] = {}
                achievements[map]["completion_count"] = 0
            end

            self.create_map_achievement_btn(map, HORDE.MapAchievements.normal, achievements[map][HORDE.MapAchievements.normal])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hard, achievements[map][HORDE.MapAchievements.hard])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.realism, achievements[map][HORDE.MapAchievements.realism])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.nightmare, achievements[map][HORDE.MapAchievements.nightmare])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.apocalypse, achievements[map][HORDE.MapAchievements.apocalypse])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.coop, achievements[map][HORDE.MapAchievements.coop])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.horde, achievements[map][HORDE.MapAchievements.horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hardcore_horde, achievements[map][HORDE.MapAchievements.hardcore_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.coop_horde, achievements[map][HORDE.MapAchievements.coop_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hardcore_coop_horde, achievements[map][HORDE.MapAchievements.hardcore_coop_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.endless_20, achievements[map][HORDE.MapAchievements.endless_20])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.endless_30, achievements[map][HORDE.MapAchievements.endless_30])
        end

        local name_label = vgui.Create("DLabel", map_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            draw.SimpleText(map, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
        end

        local num_label = vgui.Create("DLabel", map_btn)
        num_label:Dock(RIGHT)
        num_label:SetText("")
        num_label:SetSize(35, 80)
        num_label:SetColor(Color(255,255,255))
        num_label:SetFont("Content")
        local count = achievements[map]["completion_count"]
        local completion = nil
        if count then
            if count >= 4 then
                completion = "bronze"
            elseif count >= 7 then
                completion = "silver"
            elseif count >= 9 then
                completion = "gold"
            end
        end
        num_label.Paint = function ()
            surface.SetMaterial(Material("trophy.png", "mips smooth"))
            if completion == "bronze" then
                surface.SetDrawColor(Color(205,127,50))
            elseif completion == "silver" then
                surface.SetDrawColor(Color(192,192,192))
            elseif completion == "gold" then
                surface.SetDrawColor(Color(255,215,0))
            else
                return
            end
            surface.DrawTexturedRect(0, 18, 25, 25)
        end

        self.map_btns[map_btn] = 0
    end

    for map, _ in SortedPairs(HORDE.achievements_map) do
        if not achievements[map] then
            achievements[map] = {}
        end
        self.create_map_btn(map)
    end
    
    local learn_panel = vgui.Create("DPanel", self)
    learn_panel:SetPos(0, 50)
    learn_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    learn_panel:SetBackgroundColor(HORDE.color_hollow)
    learn_panel:SetVisible(false)
    self.learn_panel = learn_panel

    local mechanics_panel = vgui.Create("DScrollPanel", learn_panel)
    mechanics_panel:Dock(LEFT)
    mechanics_panel:SetSize(256, self:GetParent():GetTall())
    mechanics_panel:SetBackgroundColor(Color(0,0,0,0))

    local description_panel = vgui.Create("DScrollPanel", learn_panel)
    description_panel:Dock(FILL)
    description_panel:SetSize(self:GetParent():GetWide() - 266, self:GetParent():GetTall())

    local update_text_panel = vgui.Create("DPanel", description_panel)
    update_text_panel:SetSize(self:GetParent():GetWide(), 1000)
    update_text_panel:SetVisible(true)
    local update_text = [[
        Major Update 1.1.7
        -- Starter Weapons Customization
            - You can now set starter weapons in item config.
            - Starter weapons follow rules in Killing Floor.

        -- Added two new buttons for custom configs:
            - Add Default Items (Item Config)
                - It adds default items but does not reset the config.
            - Add Default Enemies (Enemy Config)
                - It adds default enemies but does not reset the config.

        -- New Subclasses:
            - Warlock (Demolition subclass)
            - Psycho (Survivor subclass)

        -- New Items:
            - Half life weapons rework.
              - arccw_horde_9mm
              - arccw_horde_medic_9mm
              - arccw_horde_smg1
              - arccw_horde_heat_crossbow (greatly buffed, has 2 fire modes)
              - arccw_horde_shotgun
              - arccw_horde_357
            - Welder: horde_welder (Engineer)
            - Rocket Turret: npc_vj_horde_rocket_turret (Engineer)
            - Machete: arccw_horde_machete (All)
            - Katana/Bat rework
            - TMP rework: arccw_horde_tmp
        
        -- New Enemies:
            - Xen Destroyer Unit: npc_vj_horde_xen_destroyer_unit (Boss)
            - Xen Psychic Unit: npc_vj_horde_xen_psychic_unit (Boss)
            - Xen Host Unit: npc_vj_horde_xen_host_unit (Boss)
            - Vomitter/Scorcher models reworked
            
        -- Bug Fixes:
            - Nemesis mutation display should be more consistent.
            - Gadget fixes.]]
    local mt = multlinetext(update_text, update_text_panel:GetWide() - 50, 'Content')
    update_text_panel.Paint = function ()
	    local update_version_number = "1.1.7"
        draw.SimpleText(translate.Format("Mechanics_Latest_X_Update", update_version_number), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.DrawText(mt, 'Content', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local debuff_text_panel = vgui.Create("DPanel", description_panel)
    debuff_text_panel:SetSize(self:GetParent():GetWide(), 900)
    debuff_text_panel:SetVisible(false)
    debuff_text_panel.Paint = function ()
        local mat = Material("materials/status/bleeding.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.color_crimson_violet)
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material("materials/status/ignite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material("materials/status/frostbite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 330, 40, 40)

        mat = Material("materials/status/shock.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 430, 40, 40)

        mat = Material("materials/status/break.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 530, 40, 40)

        mat = Material("materials/status/decay.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(Color(50, 150, 50))
        surface.DrawTexturedRect(50, 630, 40, 40)

        mat = Material("materials/status/necrosis.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(Color(50, 150, 50))
        surface.DrawTexturedRect(50, 730, 40, 40)

        draw.SimpleText(translate.Get("Mechanics_Debuff_Status"), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Bleed"), 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Bleed_Description"), 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Fire"), 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Fire_Description"), 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Frost"), 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Frost_Description"), 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Shock"), 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Shock_Description"), 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Armor_Break"), 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Armor_Break_Description"), 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Decay"), 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Decay_Description"), 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Necrosis"), 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Debuff_Status_Necrosis_Description"), 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local damage_text_panel = vgui.Create("DPanel", description_panel)
    damage_text_panel:SetSize(self:GetParent():GetWide(), 1200)
    damage_text_panel:SetVisible(false)
    damage_text_panel.Paint = function ()
        local mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BALLISTIC], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_SLASH], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BLUNT], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 330, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_PHYSICAL], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 430, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_FIRE], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 530, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_COLD], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 630, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_LIGHTNING], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 730, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_POISON], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 830, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BLAST], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_BLAST])
        surface.DrawTexturedRect(50, 930, 40, 40)

        draw.SimpleText(translate.Get("Mechanics_Damage_Types"), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Bullet"), 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT.", 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Knife"), 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_SLASH.", 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Crowbar"), 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_CLUB.", 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Environment"), 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_GENERIC, DMG_CRUSH, DMG_SONIC.", 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Fire"), 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Fire_Description"), 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Cold"), 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Cold_Description"), 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Lightning"), 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Lightning_Description"), 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Poison"), 'Heading', 100, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Poison_Description"), 'Content', 100, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Damage_Type_Blast"), 'Heading', 100, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_BLAST, DMG_MISSILEDEFENSE.", 'Content', 100, 1000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local function draw_resistances(pos, res)
        local start_pos = 250
        for type, value in SortedPairs(res) do
            local mat = Material(HORDE.DMG_TYPE_ICON[type], "mips smooth")
            surface.SetMaterial(mat)
            surface.SetDrawColor(HORDE.DMG_COLOR[type])
            surface.DrawTexturedRect(start_pos, pos - 15, 30, 30)

            surface.SetDrawColor(color_white)
            if value < 1 then
                draw.SimpleText("x" .. tostring(value), 'Content', start_pos + 40, pos, Color(255,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            elseif value > 1 then
                draw.SimpleText("x" .. tostring(value), 'Content', start_pos + 40, pos, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
            
            start_pos = start_pos + 90
        end
    end
    local function write_paragraph(strs, start_pos)
        for _, str in pairs(strs) do
            draw.SimpleText(str, 'Content', 100, start_pos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            start_pos = start_pos + 50
        end
        return start_pos
    end
    local enemies_text_panel = vgui.Create("DPanel", description_panel)
    enemies_text_panel:SetSize(self:GetParent():GetWide(), 4000)
    enemies_text_panel:SetVisible(false)
    enemies_text_panel.Paint = function ()
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemies"), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Walker"), 'Heading', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Walker_Description"), 'Content', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Sprinter"), 'Heading', 50, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Sprinter_Description"), 'Content', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Clawler"), 'Heading', 50, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Clawler_Description"), 'Content', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Fast_Poison_Zombie_Zombine"), 'Heading', 50, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Fast_Poison_Zombie_Zombine_Description"), 'Content', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Charred_Zombine"), 'Heading', 50, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Regular_Enemy_Charred_Zombine_Description"), 'Content', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(500, {[HORDE.DMG_FIRE] = 0.5, [HORDE.DMG_COLD] = 1.25})

        draw.SimpleText(translate.Get("Mechanics_Elite_Enemies"), 'LargeTitle', 50, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Exploder"), 'Heading', 50, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Exploder_Description"), 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(750, {[HORDE.DMG_POISON] = 0.5, [HORDE.DMG_FIRE] = 1.5, [HORDE.DMG_BLAST] = 1.5})
        
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Vomitter"), 'Heading', 50, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Vomitter_Description"), 'Content', 100, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Scorcher"), 'Heading', 50, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Scorcher_Description"), 'Content', 100, 1000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(950, {[HORDE.DMG_FIRE] = 0.5, [HORDE.DMG_COLD] = 1.25})

        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Screecher"), 'Heading', 50, 1050, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Screecher_Description"), 'Content', 100, 1100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1050, {[HORDE.DMG_LIGHTNING] = 0.5, [HORDE.DMG_BLAST] = 1.25})
        
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Blight"), 'Heading', 50, 1150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Blight_Description"), 'Content', 100, 1200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1150, {[HORDE.DMG_LIGHTNING] = 1.5})
        
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Weeper"), 'Heading', 50, 1258, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Weeper_Description"), 'Content', 100, 1300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1250, {[HORDE.DMG_FIRE] = 1.25, [HORDE.DMG_COLD] = 0.5, [HORDE.DMG_LIGHTNING] = 0.75, [HORDE.DMG_BLAST] = 1.25})
        
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Hulk"), 'Heading', 50, 1350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Hulk_Description"), 'Content', 100, 1400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Yeti"), 'Heading', 50, 1450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Yeti_Description"), 'Content', 100, 1500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1450, {[HORDE.DMG_FIRE] = 1.25, [HORDE.DMG_COLD] = 0.5})

        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Lesion"), 'Heading', 50, 1550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Mechanics_Elite_Enemy_Lesion_Description"), 'Content', 100, 1600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText(translate.Get("Mechanics_Bosses"), 'LargeTitle', 50, 1700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText(translate.Get("Mechanics_Boss_Alpha_Gonome"), 'Heading', 50, 1750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local next_pos = write_paragraph({
            translate.Get("Mechanics_Boss_Alpha_Gonome_Description1"),
            translate.Get("Mechanics_Boss_Alpha_Gonome_Description2"),
            translate.Get("Mechanics_Boss_Alpha_Gonome_Description3"),
            translate.Get("Mechanics_Boss_Alpha_Gonome_Description4"),
            translate.Get("Mechanics_Boss_Alpha_Gonome_Description5"),
        }, 1800)

        draw.SimpleText(translate.Get("Mechanics_Boss_Gamma_Gonome"), 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            translate.Get("Mechanics_Boss_Gamma_Gonome_Description1"),
            translate.Get("Mechanics_Boss_Gamma_Gonome_Description2"),
            translate.Get("Mechanics_Boss_Gamma_Gonome_Description3"),
            translate.Get("Mechanics_Boss_Gamma_Gonome_Description4"),
        }, next_pos + 100)

        draw.SimpleText(translate.Get("Mechanics_Boss_Wallace_Breen"), 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            translate.Get("Mechanics_Boss_Wallace_Breen_Description1"),
            translate.Get("Mechanics_Boss_Wallace_Breen_Description2"),
            translate.Get("Mechanics_Boss_Wallace_Breen_Description3"),
            translate.Get("Mechanics_Boss_Wallace_Breen_Description4"),
            translate.Get("Mechanics_Boss_Wallace_Breen_Description5"),
        }, next_pos + 100)

        draw.SimpleText(translate.Get("Mechanics_Boss_Xen_Destroyer"), 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            translate.Get("Mechanics_Boss_Xen_Destroyer_Description1"),
            translate.Get("Mechanics_Boss_Xen_Destroyer_Description2"),
            translate.Get("Mechanics_Boss_Xen_Destroyer_Description3"),
            translate.Get("Mechanics_Boss_Xen_Destroyer_Description4"),
            translate.Get("Mechanics_Boss_Xen_Destroyer_Description5"),
        }, next_pos + 100)

        draw.SimpleText(translate.Get("Mechanics_Boss_Xen_Psychic"), 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            translate.Get("Mechanics_Boss_Xen_Psychic_Description1"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description2"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description3"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description4"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description5"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description6"),
            translate.Get("Mechanics_Boss_Xen_Psychic_Description7"),
        }, next_pos + 100)
    end

    local donate_text_panel = vgui.Create("DPanel", description_panel)
    donate_text_panel:SetSize(self:GetParent():GetWide(), 400)
    donate_text_panel:SetVisible(false)
    donate_text_panel.Paint = function () end

    local paypal_btn = vgui.Create("DButton", donate_text_panel)
    paypal_btn:SetSize(250, 80)
    paypal_btn:Dock(TOP)
    paypal_btn:SetText("")
    paypal_btn.Paint = function ()
        draw.SimpleText("Paypal", "Content", 50, 25, Color(51,102,187), TEXT_ALIGN_LEFT)
    end
    paypal_btn.DoClick = function ()
        gui.OpenURL("https://steamcommunity.com/linkfilter/?url=https://www.paypal.com/donate?business=XSZEUMTKKC8ZU&no_recurring=0&item_name=Author+of+Horde+Gamemode&currency_code=USD")
    end

    local patreon_btn = vgui.Create("DButton", donate_text_panel)
    patreon_btn:SetSize(250, 80)
    patreon_btn:Dock(TOP)
    patreon_btn:SetText("")
    patreon_btn.Paint = function ()
        draw.SimpleText("Patreon", "Content", 50, 25, Color(51,102,187), TEXT_ALIGN_LEFT)
    end
    patreon_btn.DoClick = function ()
        gui.OpenURL("https://www.patreon.com/user?u=67559435")
    end

    self.mechanic_btns = {}
    self.create_mechanic_btn = function (text, panel)
        local mechanic_btn = vgui.Create("DButton", mechanics_panel)
        local mechanic_btn_hovered = false
        mechanic_btn:DockMargin(10, 5, 10, 5)
        mechanic_btn:SetSize(self:GetParent():GetWide(), 50)
        mechanic_btn:Dock(TOP)
        mechanic_btn:SetText("")
        mechanic_btn.Paint = function ()
            if mechanic_btn_hovered or (self.mechanic_btns[mechanic_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        mechanic_btn.OnCursorEntered = function ()
            mechanic_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        mechanic_btn.OnCursorExited = function ()
            mechanic_btn_hovered = false
        end
        mechanic_btn.DoClick = function ()
            --votemap_panel:GetParent():Votediff(vote_btn, diff)
            for btn, _ in pairs(self.mechanic_btns) do
                self.mechanic_btns[btn] = 0
            end
            self.mechanic_btns[mechanic_btn] = 1
            update_text_panel:SetVisible(false)
            damage_text_panel:SetVisible(false)
            debuff_text_panel:SetVisible(false)
            enemies_text_panel:SetVisible(false)
            donate_text_panel:SetVisible(false)
            panel:SetVisible(true)
            surface.PlaySound("UI/buttonclick.wav")
        end

        local name_label = vgui.Create("DLabel", mechanic_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            draw.SimpleText(text, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
        end

        self.mechanic_btns[mechanic_btn] = 0

        return mechanic_btn
    end

    self.create_mechanic_btn(translate.Get("Mechanics_Subcategory_Latest_Update"), update_text_panel)
    self.create_mechanic_btn(translate.Get("Mechanics_Subcategory_Damage_Types"), damage_text_panel)
    self.create_mechanic_btn(translate.Get("Mechanics_Subcategory_Debuff_Status_Effects"), debuff_text_panel)
    if GetConVarNumber("horde_default_enemy_config") == 1 then
        self.create_mechanic_btn(translate.Get("Mechanics_Subcategory_Enemies"), enemies_text_panel)
    end
    self.create_mechanic_btn(translate.Get("Mechanics_Subcategory_Donate_Money"), donate_text_panel)

    local basic_stats_panel = vgui.Create("DPanel", stats_panel)
    basic_stats_panel:Dock(LEFT)
    basic_stats_panel:SetWide(self:GetWide() / 3)
    basic_stats_panel:SetTall(self:GetTall())
    basic_stats_panel.Paint = function ()
        draw.SimpleText(translate.Get("Stats_Menu_Basic"), 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        local mat = Material("materials/status/speed.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 80, 40, 40)

        mat = Material("materials/status/health.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material("materials/status/armor.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 180, 40, 40)

        mat = Material("materials/status/evasion.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material("materials/status/block.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 280, 40, 40)

        draw.SimpleText(translate.Get("Stats_Menu_Speed"), 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Health"), 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Armor"), 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Evasion"), 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Block"), 'Heading', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        

        draw.SimpleText(tostring(HORDE:GetStat("speed") * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(LocalPlayer():Health()) .. " / " .. tostring(LocalPlayer():GetMaxHealth()), 'Heading', self:GetWide() / 3 - 10, 150, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(LocalPlayer():Armor()) .. " / " .. tostring(LocalPlayer():GetMaxArmor()), 'Heading', self:GetWide() / 3 - 10, 200, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat("evasion") * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 250, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(HORDE:GetStat("block"), 'Heading', self:GetWide() / 3 - 10, 300, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        draw.SimpleText(translate.Get("Stats_Menu_Perks"), 'Heading', 50, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local y = 50
        local class = LocalPlayer():Horde_GetCurrentSubclass()
        mat = Material(HORDE.subclasses[class].Icon, "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 375 + y, 40, 40)
        draw.SimpleText(HORDE.perks[LocalPlayer():Horde_GetClass().base_perk].PrintName, 'Heading', 100, 400 + y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        y = y + 50

        local perks
        if HORDE.classes[class] then
            perks = HORDE.classes[class].perks
        else
            perks = HORDE.subclasses[class].Perks
        end

        for perk_level, v in SortedPairs(perks) do
            if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(perk_level) then goto cont end
            if not LocalPlayer().Horde_PerkChoices then break end
            local choice = v.choices[LocalPlayer().Horde_PerkChoices[class][perk_level] or 1]
            if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end
            local perk = HORDE.perks[choice]
            local icon = perk.Icon
            if icon then
                mat = Material(icon, "mips smooth")
                surface.SetMaterial(mat)
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(50, 380 + y, 40, 40)
            else
                mat = Material(HORDE.subclasses[class].Icon, "mips smooth")
                surface.SetMaterial(mat)
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(50, 375 + y, 40, 40)
            end
            draw.SimpleText(translate.Get("Perk_Title_" .. perk.PrintName), 'Heading', 100, 400 + y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            
            y = y + 50
            ::cont::
        end
    end

    local res_stats_panel = vgui.Create("DPanel", stats_panel)
    res_stats_panel:Dock(LEFT)
    res_stats_panel:SetWide(self:GetWide() / 3)
    res_stats_panel:SetTall(self:GetTall())

    res_stats_panel.Paint = function ()
        --local mat = Material("materials/damagetype/physical.png", "mips smooth")
        --surface.SetMaterial(mat)
        --surface.SetDrawColor(color_white)
        --surface.DrawTexturedRect(50, 50, 40, 40)

        local mat = Material("materials/damagetype/ballistic.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 80, 40, 40)

        mat = Material("materials/damagetype/slash.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material("materials/damagetype/blunt.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 180, 40, 40)

        mat = Material("materials/damagetype/physical.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 230, 40, 40)

        draw.SimpleText(translate.Get("Stats_Menu_Physical_Resistances"), 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Bullet_Resistance"), 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Knife_Resistance"), 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Crowbar_Resistance"), 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Environment_Resistance"), 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_BALLISTIC) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_SLASH) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 150, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_BLUNT) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 200, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_PHYSICAL) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 250, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        mat = Material("materials/damagetype/fire.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 360, 40, 40)

        mat = Material("materials/damagetype/cold.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 410, 40, 40)

        mat = Material("materials/damagetype/lightning.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 460, 40, 40)

        mat = Material("materials/damagetype/poison.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 510, 40, 40)

        mat = Material("materials/damagetype/blast.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_BLAST])
        surface.DrawTexturedRect(50, 560, 40, 40)
        draw.SimpleText(translate.Get("Stats_Menu_Special_Resistances"), 'Heading', 50, 330, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Fire_Resistance"), 'Heading', 100, 380, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Cold_Resistance"), 'Heading', 100, 430, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Lightning_Resistance"), 'Heading', 100, 480, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Poison_Resistance"), 'Heading', 100, 530, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Explode_Resistance"), 'Heading', 100, 580, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_FIRE) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 380, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_COLD) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 430, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_LIGHTNING) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 480, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_POISON) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 530, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat(HORDE.DMG_BLAST) * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 580, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    local immunity_stats_panel = vgui.Create("DPanel", stats_panel)
    immunity_stats_panel:Dock(LEFT)
    immunity_stats_panel:SetWide(self:GetWide() / 3)
    immunity_stats_panel:SetTall(self:GetTall())
    immunity_stats_panel.Paint = function ()
        draw.SimpleText(translate.Get("Stats_Menu_Status_Effects"), 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        local mat = Material("materials/status/bleeding.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.color_crimson_violet)
        surface.DrawTexturedRect(50, 80, 40, 40)

        mat = Material("materials/status/ignite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material("materials/status/frostbite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 180, 40, 40)

        mat = Material("materials/status/shock.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material("materials/status/break.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 280, 40, 40)

        --[[mat = Material("materials/status/psychosis.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(Color(255,192,203))
        surface.DrawTexturedRect(50, 330, 40, 40)]]--

        draw.SimpleText(translate.Get("Stats_Menu_Bleeding_Immunity"), 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Fire_Immunity"), 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Frost_Immunity"), 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Shock_Immunity"), 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(translate.Get("Stats_Menu_Armor_Break_Immunity"), 'Heading', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        --draw.SimpleText(translate.Get("Stats_Menu_Sanity_Immunity"), 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText(GetImmune(HORDE.Status_Bleeding), 'Heading', self:GetWide() / 3 - 50, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Ignite), 'Heading', self:GetWide() / 3 - 50, 150, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Frostbite), 'Heading', self:GetWide() / 3 - 50, 200, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Shock), 'Heading', self:GetWide() / 3 - 50, 250, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Break), 'Heading', self:GetWide() / 3 - 50, 300, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    local stats_btn = vgui.Create("DButton", self)
    local stats_activated = true
    local stats_hovered = false
    stats_btn:SetText(translate.Get("Main_Menu_Category_Stats"))
    stats_btn:SetTextColor(Color(255,255,255))
    stats_btn:SetFont("Title")
    stats_btn:SetSize(250, 50)
    stats_btn:SetPos(0, 0)
    stats_btn.Paint = function ()
        if stats_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if stats_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    local achievements_btn = vgui.Create("DButton", self)
    local achievements_activated = false
    local achievements_hovered = false
    achievements_btn:SetText(translate.Get("Main_Menu_Category_Achievements"))
    achievements_btn:SetTextColor(Color(255,255,255))
    achievements_btn:SetFont("Title")
    achievements_btn:SetSize(250, 50)
    achievements_btn:SetPos(250, 0)
    achievements_btn.Paint = function ()
        if achievements_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if achievements_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    local learn_btn = vgui.Create("DButton", self)
    local learn_activated = false
    local learn_hovered = false
    learn_btn:SetText(translate.Get("Main_Menu_Category_Mechanics"))
    learn_btn:SetTextColor(Color(255,255,255))
    learn_btn:SetFont("Title")
    learn_btn:SetSize(250, 50)
    learn_btn:SetPos(500, 0)
    learn_btn.Paint = function ()
        if learn_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if learn_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    stats_btn.DoClick = function ()
        stats_activated = true
        achievements_activated = nil
        learn_activated = nil
        stats_panel:SetVisible(true)
        achievements_panel:SetVisible(false)
        learn_panel:SetVisible(false)
        surface.PlaySound("UI/buttonclick.wav")
    end

    stats_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        stats_hovered = true
    end

    stats_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        stats_hovered = false
    end

    achievements_btn.DoClick = function ()
        achievements_activated = true
        stats_activated = nil
        learn_activated = nil
        achievements_panel:SetVisible(true)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(false)
        surface.PlaySound("UI/buttonclick.wav")
    end

    achievements_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        achievements_hovered = true
    end

    achievements_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        achievements_hovered = false
    end

    learn_btn.DoClick = function ()
        achievements_activated = nil
        stats_activated = nil
        learn_activated = true
        achievements_panel:SetVisible(false)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(true)
        surface.PlaySound("UI/buttonclick.wav")
    end

    learn_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        learn_hovered = true
    end

    learn_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        learn_hovered = false
    end

    local discord_btn = vgui.Create("DButton", self)
    local discord_activated = false
    local discord_hovered = false
    discord_btn:SetText("Discord")
    discord_btn:SetTextColor(Color(255,255,255))
    discord_btn:SetFont("Title")
    discord_btn:SetSize(250, 50)
    discord_btn:SetPos(750, 0)
    discord_btn.Paint = function ()
        if discord_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if discord_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end
    discord_btn.DoClick = function ()
        gui.OpenURL("https://discord.gg/NevEgfAPSN")
    end

    local close_btn = vgui.Create("DButton", self)
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 8)
    close_btn.DoClick = function() HORDE:ToggleStats() end

    if HORDE.has_new_update then
        learn_btn:DoClick() 
    end
end

function PANEL:Paint(w, h)
    --Derma_DrawBackgroundBlur(self)
    -- Entire 
    if ScrW() < 1400 then
        draw.RoundedBox(0, 0, 0, w, h, Color(40,40,40))
    else
        draw.RoundedBox(0, 0, 0, w, h, HORDE.color_hollow)
    end
end

vgui.Register("HordeStats", PANEL)