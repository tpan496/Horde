local PANEL = {}
HORDE_PlayerNames = {}
HORDE_QueuedAvatarDownload = {}

if(file.Exists("horde/playernames.txt", "DATA")) then
    local data = util.JSONToTable(file.Read("horde/playernames.txt"), false, true)
    if(data && istable(data)) then
        HORDE_PlayerNames = data
    end
end

function HORDE_WriteName(steamid64, nick)
    file.Write("horde/playernames.txt", util.TableToJSON(HORDE_PlayerNames))
end

function HORDE_GetNick(steamid64)
    if(HORDE_PlayerNames[steamid64]) then
        return HORDE_PlayerNames[steamid64]
    else
        HORDE_PlayerNames[steamid64] = "Fetching.."
        steamworks.RequestPlayerInfo(steamid64, function(nick)
            local ret = nick
            if(!ret || ret == "" || ret == "anonymous") then
                ret = "<INVALID PLAYER>"
            end
            HORDE_PlayerNames[steamid64] = ret
            HORDE_WriteName(steamid64, nick)
        end)
    end
end

function HORDE_WriteAvatar(steamid, ctx)
    file.Write("horde/avatars/"..steamid..".png", ctx)
end

function HORDE_GetFixedValue(input)
    local target = 0.016666
    return input / (target / RealFrameTime())
end

local emptyAvatar = file.Read("materials/horde/emptyframe.png", "GAME")

function HORDE_DownloadAvatar(steamid64)
    HTTP({
        failed = function(reason)
        end,
        success = function(code, body, headers)
            local st, ed = string.find(body, "<avatarFull>"), string.find(body, "</avatarFull>")
            if(st && ed) then
                st = st + 12
                ed = ed - 1
                local ctx = string.sub(body, st, ed)
                local avatar_link = string.Replace(ctx, "<![CDATA[", "")
                avatar_link = string.Replace(avatar_link, "]]>", "")
                HTTP({
                    failed = function(reason)
                    end,
                    success = function(code, body, headers)
                        HORDE_WriteAvatar(steamid64, body)
                    end,
                    method = "GET",
                    url = avatar_link
                })
            else
                HORDE_WriteAvatar(steamid64, emptyAvatar)
            end
        end,
        method = "GET",
        url = "https://steamcommunity.com/profiles/"..steamid64.."?xml=1"
    })
end

function HORDE_GetTextSize(font, text)
    surface.SetFont(font)
    return surface.GetTextSize(text)
end

function HORDE_CreatePanel(parent, x, y, w, h, color, r)
    r = r || 0
    local panel = vgui.Create("DPanel", parent)
        panel:SetPos(x, y)
        panel:SetSize(w, h)
        panel.Paint2x = function() end
        panel.Paint = function()
            draw.RoundedBox(r, 0, 0, w, h, color)
            panel.Paint2x()
        end
        panel:SetZPos(0)
    return panel
end

function HORDE_CreateLabel(parent, x, y, text, font, color, bg, bgcolor)
    local label = vgui.Create("DLabel", parent)
        label.oPos = Vector(x, y)
        label:SetPos(x, y)
        label:SetFont(font)
        label:SetText(text)
        label:SetColor(color)
        local w, h = HORDE_GetTextSize(font, label:GetText())
        label:SetSize(w, h)

        label.CentHor = function()
            local w, h = HORDE_GetTextSize(font, label:GetText())
            label:SetPos(label.oPos.x - w / 2, label.oPos.y)
            label:SetSize(w, h)
        end

        label.CentVer = function()
            local w, h = HORDE_GetTextSize(font, label:GetText())
            label:SetPos(label.oPos.x, label.oPos.y - h / 2)
            label:SetSize(w, h)
        end

        label.CentPos = function()
            local w, h = HORDE_GetTextSize(font, label:GetText())
            label:SetPos(label.oPos.x - w / 2, label.oPos.y - h / 2)
            label:SetSize(w, h)
        end

        label.UpdateText = function(text)
            label:SetText(text)
            local w, h = HORDE_GetTextSize(font, label:GetText())
            label:SetSize(w, h)
        end

        if(bg) then
            label.oPaint = label.Paint
            label.Paint = function()
                draw.RoundedBox(0, 0, 0, label:GetWide(), label:GetTall(), bgcolor)
                label.oPaint(label)
            end
        end

    local tw, th = HORDE_GetTextSize(font, label:GetText())
    return tw, th, label
end

function HORDE_CreateScroll(parent, x, y, w, h, color)
    local frame = vgui.Create("DScrollPanel", parent)
    frame:SetPos(x, y)
    frame:SetSize(w, h)
    frame.Paint = function() draw.RoundedBox(0, 0, 0, w, h, color) end

    frame.ScrollAmount = ScreenScaleH(64) -- You can change it with returned panel object
    frame.Smoothing = 0.2

    frame.CurrrentScroll = 0
    frame.MaximumScroll = 0 -- Don't touch this value
    frame.Panels = {}

    frame.FiltePanels = function(searchString)
        for k,v in ipairs(frame.Panels) do
            if(!IsValid(v)) then
                table.remove(frame.Panels, k)
                continue
            end
            if(!v.SortString) then continue end
            if(string.find(v.SortString, searchString)) then
                if(!frame.HideAnimation) then
                    v:SetVisible(true)
                else
                    v.Display = true
                end
            else
                if(!frame.HideAnimation) then
                    v:SetVisible(false)
                    v.Display = false
                end
            end
            local t = v:GetTall() -- So it recalculate the dock position
            v:SetTall(t - 1)
            v:SetTall(t)
        end
    end

    frame.AddPanel = function(ui)
        table.insert(frame.Panels, ui)
    end

    local DVBar = frame:GetVBar()
    local down = false
    local clr = 0

    DVBar:SetWide(ScreenScaleH(4))
    DVBar:SetX(DVBar:GetX() - DVBar:GetWide())

    DVBar.Think = function()
        frame.MaximumScroll = DVBar.CanvasSize
        if(down) then return end
        local dvscroll = DVBar:GetScroll()
        local step = frame.CurrrentScroll - dvscroll
        if(math.abs(step) > 1) then
            clr = 125
        end
        DVBar:SetScroll(dvscroll + HORDE_GetFixedValue(step * frame.Smoothing))
    end

    function frame:OnMouseWheeled(delta)
        frame.CurrrentScroll = math.Clamp(frame.CurrrentScroll + frame.ScrollAmount * -delta, 0, frame.MaximumScroll)
    end

    function DVBar:Paint(drawW, drawH)
        draw.RoundedBox(0, 0, 0, drawW, drawH, Color(0, 0, 0, 150))
    end

    function DVBar.btnUp:Paint() return end
    function DVBar.btnDown:Paint() return end

    DVBar.btnGrip.oOnMousePressed = DVBar.btnGrip.OnMousePressed
    function DVBar.btnGrip.OnMousePressed(self, code)
        down = true
        DVBar.btnGrip.oOnMousePressed(self, code)
        frame.CurrrentScroll = DVBar:GetScroll()
    end
    DVBar.oOnMousePressed = DVBar.OnMousePressed
    function DVBar.OnMousePressed(self, code)
        down = true
        DVBar.oOnMousePressed(self, code)
    end

    function DVBar.btnGrip:Paint(drawW, drawH)
        local roundWide = drawW * 0.5
        if(DVBar.btnGrip:IsHovered()) then
            clr = math.Clamp(clr + HORDE_GetFixedValue(8), 0, 80)
            if(input.IsMouseDown(107) && !down) then
                down = true
            end
        else
            clr = math.Clamp(clr - HORDE_GetFixedValue(8), 0, 80)
        end

        if(down && !input.IsMouseDown(107)) then
            down = false
        end

        if(down) then
            frame.CurrrentScroll = DVBar:GetScroll()
            clr = 125
        end

        local _color = 130 + clr
        draw.RoundedBox(roundWide, 0, 0, drawW, drawH, Color(_color, _color, _color, 255))
    end
    return frame
end

function HORDE_InvisButton(parent, x, y, w, h, func)
    local btn = vgui.Create("DButton", parent)
        btn:SetPos(x, y)
        btn:SetSize(w, h)
        btn:SetText("")
        btn.Paint = function() end
        btn.DoClick = func
        
        return btn
end

local function HTTPUpdateStatus(addr)
    http.Post("https://meiryiservice.xyz/horde/horde_status.php",{
        steamid = LocalPlayer():SteamID64(),
        host = GetHostName(),
        map = game.GetMap(),
        addr = addr,
        wave = tostring(HORDE.current_wave || 0),
        difficulty = tostring(HORDE.difficulty || 1),
        playercount = tostring(player.GetCount()),
        maxplayer = tostring(game.MaxPlayers()),
    },
    function(body, length, headers, code)
    end,
    function(message)
    end)
end

local function GetImmune(status)
    if HORDE:GetStat(status) == 0 then
        return "NO"
    else
        return "YES"
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
    stats_panel:SetVisible(false)
    self.stats_panel = stats_panel

    local achievements_panel = vgui.Create("DPanel", self)
    achievements_panel:SetPos(0, 50)
    achievements_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    achievements_panel:SetBackgroundColor(HORDE.color_hollow)
    achievements_panel:SetVisible(false)
    self.achievements_panel = achievements_panel

    -- Man I hate coding UI without UI library
    local looking2play_panel = vgui.Create("DPanel", self)
    looking2play_panel:SetPos(0, 50)
    looking2play_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    looking2play_panel:SetBackgroundColor(HORDE.color_hollow)
    looking2play_panel:SetVisible(true)

    local gap = 12
    local _, _, text = HORDE_CreateLabel(looking2play_panel, gap, gap, "Find other players to play with!", "LargeTitle", color_white, false)
    local _, _, playercount = HORDE_CreateLabel(looking2play_panel, gap, text:GetY() + text:GetTall() + gap, "Online players : Fetching..", "Title", color_white, false)
    local _, _, note = HORDE_CreateLabel(looking2play_panel, gap, playercount:GetY(), "Connection might take a while, please be patient", "Title", color_white, false)
    note:SetX(looking2play_panel:GetWide() - note:GetWide() - gap)

    local upperGap = playercount:GetY() + playercount:GetTall() + gap
    local playerlist = HORDE_CreateScroll(looking2play_panel, gap, upperGap, looking2play_panel:GetWide() - gap * 2, looking2play_panel:GetTall() - upperGap - gap, Color(30, 30, 30, 255))

    local serverlist = {
        {
            ServerName = "Horde Gamemode Official Server (1.2.1)",
            Address = "131.153.172.122:27055",
            MaxPlayers = 10,
        },
    }
    local players = {}

    playerlist.Update = function()
        playerlist:Clear()
        local plycount = 0
        local count = {}
        local labels = {}
        local tall = playerlist:GetTall() * 0.135
        local gap_str = 6

        for _, server in pairs(serverlist) do
            count[server.Address] = 0
        end

        for _, data in ipairs(serverlist) do
            local base = HORDE_CreatePanel(playerlist, 0, 0, playerlist:GetWide(), tall, Color(20, 20, 20, 255))
                base:Dock(TOP)
                base:DockMargin(0, 0, 0, 5)
             local image = vgui.Create("DImage", base)
                image:SetSize(tall, tall)
                image:SetImage("server.png")
            local _, _, nick = HORDE_CreateLabel(base, tall + gap_str, gap_str, data.ServerName, "LargeTitle", color_white)
            local _, _, addr = HORDE_CreateLabel(base, tall + gap_str, nick:GetY() + nick:GetTall() + gap_str, data.Address, "Heading", Color(150, 150, 150, 255))
            addr:SetY(base:GetTall() - addr:GetTall() - gap_str)
            local _, _, count = HORDE_CreateLabel(base, 0, base:GetTall() * 0.5, "0 / "..data.MaxPlayers, "Title", Color(150, 150, 150, 255))
            count:SetPos(base:GetWide() - count:GetWide() - gap_str, (base:GetTall() - count:GetTall()) * 0.5)
            local btn = HORDE_InvisButton(base, 0, 0, base:GetWide(), base:GetTall(), function()
                if(steamid64 == LocalPlayer():SteamID64()) then return end
                LocalPlayer():ConCommand("connect "..data.Address)
            end)
            btn.Alpha = 0
            btn.Paint = function()
                if(btn:IsHovered()) then
                    btn.Alpha = math.Clamp(btn.Alpha + 100 * RealFrameTime(), 0, 20)
                else
                    btn.Alpha = math.Clamp(btn.Alpha - 100 * RealFrameTime(), 0, 20)
                end
                draw.RoundedBox(0, 0, 0, base:GetWide(), base:GetTall(), Color(255, 255, 255, btn.Alpha))
            end

            labels[data.Address] = count
        end

        for steamid64, data in pairs(players) do
            steamid64 = tostring(steamid64)
            local base = HORDE_CreatePanel(playerlist, 0, 0, playerlist:GetWide(), tall, Color(20, 20, 20, 255))
                base:Dock(TOP)
                base:DockMargin(0, 0, 0, 5)
            local avatar = vgui.Create("DImage", base)
                avatar:SetSize(tall, tall)
                avatar.NamePath = "horde/avatars/"..steamid64..".png"
                avatar.NextUpdate = 0
                avatar.AvatarMaterial = nil
                avatar.Think = function()
                    if(avatar.NextUpdate > SysTime()) then return end
                        if(file.Exists(avatar.NamePath, "DATA")) then
                            avatar.AvatarMaterial = Material("data/"..avatar.NamePath)
                            avatar.Think = nil
                            return
                        else
                            if(!HORDE_QueuedAvatarDownload[steamid64]) then
                                HORDE_QueuedAvatarDownload[steamid64] = true
                            end
                        end
                    avatar.NextUpdate = SysTime() + 0.2
                end
                avatar.Paint = function()
                    if(avatar.AvatarMaterial) then
                        surface.SetDrawColor(255, 255, 255, 255)
                        surface.SetMaterial(avatar.AvatarMaterial)
                        surface.DrawTexturedRect(0, 0, tall, tall)
                    end
                end
                local _, _, nick = HORDE_CreateLabel(base, tall + gap_str, gap_str, "Fetching..", "LargeTitle", color_white)
                nick.NextUpdate = 0
                nick.Think = function()
                    if(nick.NextUpdate > SysTime()) then return end
                    local name = HORDE_GetNick(steamid64)
                    nick.UpdateText(HORDE_PlayerNames[steamid64])
                    if(name != "Fetching..") then
                        nick.Think = nil
                    end
                    nick.NextUpdate = SysTime() + 0.2
                end
                local _, _, addr = HORDE_CreateLabel(base, tall + gap_str, nick:GetY() + nick:GetTall() + gap_str, data.host.." ["..data.address.."]".." ["..data.playercount.." / "..data.maxplayer.."]", "Heading", Color(150, 150, 150, 255))
                addr:SetY(base:GetTall() - addr:GetTall() - gap_str)
                local wavestr = "Wave : " .. data.wave
                if(tonumber(data.wave) <= 0) then
                    wavestr = "Preparing phase"
                end
                local diff = HORDE.difficulty_text[tonumber(data.difficulty)]
                if(diff) then
                    diff = translate.Get("Game_Difficulty_"..diff) || "Unknown Difficulty"
                else
                    diff = "Unknown Difficulty"
                end
                local _, _, info = HORDE_CreateLabel(base, tall + gap_str, 0, data.map.." | "..wavestr.." | "..diff, "Heading", Color(150, 150, 150, 255))
                info:SetPos(base:GetWide() - (info:GetWide() + gap_str), base:GetTall() - addr:GetTall() - gap_str)
                local btn = HORDE_InvisButton(base, 0, 0, base:GetWide(), base:GetTall(), function()
                    if(steamid64 == LocalPlayer():SteamID64()) then return end
                    LocalPlayer():ConCommand("connect "..data.address)
                end)
                btn.Alpha = 0
                btn.Paint = function()
                    if(btn:IsHovered()) then
                        btn.Alpha = math.Clamp(btn.Alpha + 100 * RealFrameTime(), 0, 20)
                    else
                        btn.Alpha = math.Clamp(btn.Alpha - 100 * RealFrameTime(), 0, 20)
                    end
                    draw.RoundedBox(0, 0, 0, base:GetWide(), base:GetTall(), Color(255, 255, 255, btn.Alpha))
                end
            plycount = plycount + 1
        end

        for addr, _count in pairs(count) do
            local label = labels[addr]
            if(label) then
                label.UpdateText(_count.." / 10")
                label:SetX(playerlist:GetWide() - label:GetWide() - gap_str)
            end
        end

        playercount.UpdateText("Online players : " .. plycount)
    end

    local FetchPlayers = function()
        players = {}
        http.Fetch("https://meiryiservice.xyz/horde/players.txt",
        function(body, length, headers, code)
            local t = util.JSONToTable(body, false, true)
            if(istable(t) && IsValid(playerlist)) then
                players = t
                playerlist.Update()
            end
        end,
        function(message)
         end)
    end

    FetchPlayers()

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
        draw.SimpleText('Complete maps on 10 waves to earn achievements!', 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.DrawText([[
        *Notes: Achievements are disabled in sandbox mode.
        
        To achieve the special Horde Completion achievement, you need:
          - Default Config Enabled
          - Default Settings:
            - Base Start Money <= 1000
            - Base Round bonus <= 500
            - Base Walk Speed <= 180
            - Base Run Speed <= 220]], 'Content', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
                draw.SimpleText(map .. ": " .. title, 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                surface.SetMaterial(Material("trophy.png", "mips smooth"))
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(map_achievements_panel:GetWide() - 125, 25, 50, 50)
            else
                draw.RoundedBox(10, 0, 0, map_achievements_panel:GetWide() - 25, 100, HORDE.color_hollow_dim)
                draw.SimpleText(map .. ": " .. title, 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
    update_text_panel:SetSize(self:GetParent():GetWide(), 2000)
    update_text_panel:SetVisible(true)
    local update_text = translate.Get("Game_Dank_Patch_Notes_Info")

    local mt = multlinetext(update_text, update_text_panel:GetWide() - 550, 'Content')
    update_text_panel.Paint = function ()
        draw.SimpleText(translate.Get("Game_Dank_Patch_Notes"), 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
        surface.SetDrawColor(Color(50, 50, 50))
        surface.DrawTexturedRect(50, 730, 40, 40)

        draw.SimpleText("Debuff Status", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Bleed:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from certain enemies and mutations. When inflicted, removes health over time.", 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ignite:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Fire damage. When inflicted, deals Fire damage over time.", 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Frostbite:", 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Cold damage. When inflicted, reduces movement speed by 40/45/50/50/55%.", 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Shock:", 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Lightning damage. When inflicted, causes player to receive 15/20/25/25/30% more damage.", 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Break:", 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Poison damage. When inflicted, removes 80/85/90/90/95% of player health that is recovered slowly.", 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Decay:", 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Decay mutation. When inflicted, prevents healing.", 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Necrosis:", 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Blight enemies. When inflicted, causes instant death.", 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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

        draw.SimpleText("Damage Types", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ballistic:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT.", 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slash:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_SLASH.", 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blunt:", 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_CLUB.", 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Other Physical Damage:", 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_GENERIC, DMG_CRUSH, DMG_SONIC.", 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Fire:", 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Ignite buildup. DMG_BURN, DMG_SLOWBURN, DMG_PLASMA.", 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Cold:", 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Frostbite buildup. DMG_REMOVENORAGDOLL.", 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Lightning:", 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Shock buildup. DMG_SHOCK, DMG_ENERGYBEAM.", 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Poison:", 'Heading', 100, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Break buildup. DMG_NERVEGAS, DMG_ACID, DMG_POISON, DMG_PARALYZE", 'Content', 100, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blast:", 'Heading', 100, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
    enemies_text_panel:SetSize(self:GetParent():GetWide(), 5000)
    enemies_text_panel:SetVisible(false)
    enemies_text_panel.Paint = function ()
        draw.SimpleText("Regular Enemies", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Walker", 'Heading', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slow moving zombies that come in hordes.", 'Content', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Sprinter", 'Heading', 50, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Zombies with moderate speed that come in hordes.", 'Content', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Crawler", 'Heading', 50, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Zombies with fast speed that come in hordes that are easy to dispose of.", 'Content', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Fast Zombie/Poison Zombie/Zombine", 'Heading', 50, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Zombies that roam around City-17.", 'Content', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Charred Zombine", 'Heading', 50, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Zombine convered in flames that are more suicidal.", 'Content', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(500, {[HORDE.DMG_FIRE] = 0.5, [HORDE.DMG_COLD] = 1.25})

        draw.SimpleText("Elite Enemies", 'LargeTitle', 50, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Exploder", 'Heading', 50, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Explodes on death, dealing Poison damage. Does not explode when decapitated. Weak to headshots.", 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(750, {[HORDE.DMG_POISON] = 0.5, [HORDE.DMG_FIRE] = 1.5, [HORDE.DMG_BLAST] = 1.5})
        
        draw.SimpleText("Vomitter", 'Heading', 50, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ranged attackers that spits flesh at enemies. Inflicts Bleeding.", 'Content', 100, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Scorcher", 'Heading', 50, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Vomitters covered in flames. Spits burning flesh that deal Fire damage. Has a flamethrower attack.", 'Content', 100, 1000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(950, {[HORDE.DMG_FIRE] = 0.5, [HORDE.DMG_COLD] = 1.25})

        draw.SimpleText("Screecher", 'Heading', 50, 1050, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Emits screaming shockwaves when approached. Deals Lightning damage.", 'Content', 100, 1100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1050, {[HORDE.DMG_LIGHTNING] = 0.5, [HORDE.DMG_BLAST] = 1.25})
        
        draw.SimpleText("Blight", 'Heading', 50, 1150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Necrosis buildup to nearby players when shot in the torso. Weak to headshots.", 'Content', 100, 1200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1150, {[HORDE.DMG_LIGHTNING] = 1.5})
        
        draw.SimpleText("Weeper", 'Heading', 50, 1250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Emits growling shockwaves when approached. Deals Cold damage.", 'Content', 100, 1300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1250, {[HORDE.DMG_FIRE] = 1.25, [HORDE.DMG_COLD] = 0.5, [HORDE.DMG_LIGHTNING] = 0.75, [HORDE.DMG_BLAST] = 1.25})
        
        draw.SimpleText("Hulk", 'Heading', 50, 1350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Dangerous enemy with high health. Rages when health drops below 50%.", 'Content', 100, 1400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Yeti", 'Heading', 50, 1450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Hulks that are experimented with dangerous mutations.", 'Content', 100, 1500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1450, {[HORDE.DMG_FIRE] = 1.25, [HORDE.DMG_COLD] = 0.5})

        draw.SimpleText("Lesion", 'Heading', 50, 1550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Dangerous enemy with high health and agility. Rages periodically or when provoked.", 'Content', 100, 1600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Plague Elite", 'Heading', 50, 1650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Dangerous enemy with high health. Can fire devastating energy balls and summon minions.", 'Content', 100, 1700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Bosses", 'LargeTitle', 50, 1750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Alpha Gonome", 'Heading', 50, 1800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local next_pos = write_paragraph({
            "An aged gonome that gained increased endurance and power.",
            "Corruption Aura: Inflicts Bleeding to players nearby.",
            "Claw Attack: Deals Slashing damage. Inflicts Bleeding.",
            "Acid Throw: Ranged attack that deals Poison damage.",
            "Frenzy (Phase 2): Passively increases movement speed and action speed.",
        }, 1850)

        draw.SimpleText("Gamma Gonome", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "A gonome infused with cryo-engine that provides minor camouflage.",
            "Claw Attack: Deals Slashing damage. Inflicts Frostbite.",
            "Icicle Throw: Ranged attack that deals Cold damage.",
            "Icestorm (Phase 2): Creates a large icestorm near itself, dealing massive Cold damage to nearby units.",
        }, next_pos + 100)

        draw.SimpleText("Subject: Wallace Breen", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "A gonome infused with a human subject to increase cognitive capabilities.",
            "Claw Attack: Deals Slashing damage. Inflicts Haemorrhage.",
            "Particle Cannon: An accurate ranged cannon that deals massive Physical and Blast damage. Inflicts Decay.",
            "Particle Cannon (Phase 2): Generates continuous explosions post detonation.",
            "Shockwave: Generates a shockwave when it received certain amount of damage. Inflicts Haemorrhage.",
            "Haemorrhage: A strong Bleeding debuff that builds up slowly on its own. Removes health one the bar is full."
        }, next_pos + 100)

        draw.SimpleText("Xen Host Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Experimental unit made from Gonarch.",
            "Claw Attack: Deals Slash damage.",
            "Acid Mortar: Spits acid from above acting like a mortar.",
            "Spawn Baby Headcrab: Spawns a swarm of baby headcrabs.",
        }, next_pos + 100)

        draw.SimpleText("Xen Destroyer Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Experimental unit made from Xen Gargantua. Dropping heavy armor and focuses on offense capabilities.",
            "Slam Attack: Deals Blunt damage.",
            "Fumethrower: Creates streams of dark flame that deals Fire damage and inflicts Necrosis.",
            "Earthshatter: Stomps the ground and generates a tracing shockwave torwards the target. Deals Physical damage.",
            "Sonic Blast (Phase 2): Accumulates energy over time, indicated by its red light. When full, blinds players and blasts the area with Physical damage.",
        }, next_pos + 100)

        draw.SimpleText("Xen Psychic Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Experimental unit made from Xen Kingpin. Has enhanced psychic and physical capabilities.",
            "Claw Attack: Deals Slashing damage.",
            "Lightning Beam: Projects a lightning beam, dealing heavy Lightning damage in an area.",
            "Lightning Beam (Phase 2): Lightning Beam leaves behind ground flames that last for a long time.",
            "Lightning Orb: Creates homing lightning orbs that follow players. Explodes after delay on contact, dealing Lightning damage.",
            "Melee Mode (Phase 2): Greatly increases speed and focuses on Melee attacks.",
            "Psionic Shield (Phase 2): Melee Mode only. When the shield is active, reduces damage taken by 50%.",
        }, next_pos + 100)

        draw.SimpleText("Plague Platoon", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Combine commanders that have been converted into biological weapons using parasites.",
            "While their brains are fully infested, they retain a low level of setience.",
            "Plague Heavy: Armed with an M249 machine gun. Can throw shrapnel grenades",
            "Plague Demolition: Armed with an RPG-7. Can throw M67 grenade with mini-cluster nades.",
            "Plauge Berserker: Armed with a katana and inflicts Bleeding buildup on you.",
        }, next_pos + 100)
    end

    local donate_text_panel = vgui.Create("DPanel", description_panel)
    donate_text_panel:SetSize(self:GetParent():GetWide(), 800)
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

    self.create_mechanic_btn("Latest Update", update_text_panel)
    self.create_mechanic_btn("Damage Types", damage_text_panel)
    self.create_mechanic_btn("Debuff Status Effects", debuff_text_panel)
    if GetConVarNumber("horde_default_enemy_config") == 1 then
        self.create_mechanic_btn("Enemies", enemies_text_panel)
    end
    self.create_mechanic_btn("Donate $", donate_text_panel)

    local basic_stats_panel = vgui.Create("DPanel", stats_panel)
    basic_stats_panel:Dock(LEFT)
    basic_stats_panel:SetWide(self:GetWide() / 3)
    basic_stats_panel:SetTall(self:GetTall())
    basic_stats_panel.Paint = function ()
        draw.SimpleText("Basic", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

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

        draw.SimpleText("Speed:", 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Health:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Armor:", 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Evasion:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Block:", 'Heading', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        

        draw.SimpleText(tostring(HORDE:GetStat("speed") * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(MySelf:Health()) .. " / " .. tostring(MySelf:GetMaxHealth()), 'Heading', self:GetWide() / 3 - 10, 150, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(MySelf:Armor()) .. " / " .. tostring(MySelf:GetMaxArmor()), 'Heading', self:GetWide() / 3 - 10, 200, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(tostring(HORDE:GetStat("evasion") * 100) .. "%", 'Heading', self:GetWide() / 3 - 10, 250, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(HORDE:GetStat("block"), 'Heading', self:GetWide() / 3 - 10, 300, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Perks", 'Heading', 50, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local y = 50
        local class = MySelf:Horde_GetCurrentSubclass()
        mat = Material(HORDE.subclasses[class].Icon, "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(50, 375 + y, 40, 40)
        draw.SimpleText(HORDE.perks[MySelf:Horde_GetClass().base_perk].PrintName, 'Heading', 100, 400 + y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        y = y + 50

        local perks
        if HORDE.classes[class] then
            perks = HORDE.classes[class].perks
        else
            perks = HORDE.subclasses[class].Perks
        end

        for perk_level, v in SortedPairs(perks) do
            if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(perk_level) then goto cont end
            if not MySelf.Horde_PerkChoices then break end
            local choice = v.choices[MySelf.Horde_PerkChoices[class][perk_level] or 1]
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
            draw.SimpleText(perk.PrintName, 'Heading', 100, 400 + y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            
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

        draw.SimpleText("Physical Resistances", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ballistic Resistance:", 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slash Resistance:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blunt Resistance:", 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Other:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

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
        draw.SimpleText("Special Resistances", 'Heading', 50, 330, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Fire Resistance:", 'Heading', 100, 380, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Cold Resistance:", 'Heading', 100, 430, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Lightning Resistance:", 'Heading', 100, 480, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Poison Resistance:", 'Heading', 100, 530, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blast Resistance:", 'Heading', 100, 580, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
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
        draw.SimpleText("Status Effects", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

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

        mat = Material("materials/status/necrosis.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.STATUS_COLOR[HORDE.Status_Necrosis])
        surface.DrawTexturedRect(50, 330, 40, 40)

        draw.SimpleText("Bleeding Immunity:", 'Heading', 100, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ignite Immunity:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Frostbite Immunity:", 'Heading', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Shock Immunity:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Break Immunity:", 'Heading', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Necrosis Immunity:", 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText(GetImmune(HORDE.Status_Bleeding), 'Heading', self:GetWide() / 3 - 50, 100, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Ignite), 'Heading', self:GetWide() / 3 - 50, 150, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Frostbite), 'Heading', self:GetWide() / 3 - 50, 200, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Shock), 'Heading', self:GetWide() / 3 - 50, 250, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Break), 'Heading', self:GetWide() / 3 - 50, 300, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText(GetImmune(HORDE.Status_Necrosis), 'Heading', self:GetWide() / 3 - 50, 350, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    local stats_btn = vgui.Create("DButton", self)
    local stats_activated = false
    local stats_hovered = false
    stats_btn:SetText("Stats")
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
    achievements_btn:SetText("Achievements")
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
    learn_btn:SetText("Mechanics")
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

    local looking2play_btn = vgui.Create("DButton", self)
    local looking2play_activated = true
    local looking2play_hovered = false
    looking2play_btn:SetText("Looking to play")
    looking2play_btn:SetTextColor(Color(255,255,255))
    looking2play_btn:SetFont("Title")
    looking2play_btn:SetSize(250, 50)
    looking2play_btn:SetPos(750, 0)
    looking2play_btn.Paint = function ()
        if looking2play_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if looking2play_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    stats_btn.DoClick = function ()
        stats_activated = true
        achievements_activated = nil
        looking2play_activated = nil
        learn_activated = nil
        looking2play_panel:SetVisible(false)
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
        looking2play_activated = nil
        learn_activated = nil
        looking2play_panel:SetVisible(false)
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
        looking2play_activated = nil
        learn_activated = true
        looking2play_panel:SetVisible(false)
        achievements_panel:SetVisible(false)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(true)
        surface.PlaySound("UI/buttonclick.wav")
    end

    looking2play_btn.DoClick = function()
        achievements_activated = nil
        stats_activated = nil
        looking2play_activated = nil
        learn_activated = nil
        looking2play_activated = true
        looking2play_panel:SetVisible(true)
        achievements_panel:SetVisible(false)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(false)
        FetchPlayers()
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
    discord_btn:SetPos(1000, 0)
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

    local offset = 8
    local button_size = 20
    local gap = 6
    local auto_btn = HORDE_CreatePanel(self, 0, 0, 256, 36, Color(0, 0, 0, 255))
    auto_btn:SetZPos(32767)
    auto_btn:SetPos(8, self:GetTall() - auto_btn:GetTall() - 8)
    auto_btn.Paint = function()
        draw.RoundedBox(0, 0, 0, auto_btn:GetWide(), auto_btn:GetTall(), Color(30, 30, 30, 255))
        local toggled = true -- man this is really bad, but it's just one button so I think it might be fine
        if(file.Exists("horde/hidemenu.txt", "DATA")) then
            if(file.Read("horde/hidemenu.txt", "DATA") == "false") then
                toggled = false
            end
        end

        if(toggled) then
            draw.RoundedBox(0, offset, offset, button_size, button_size, Color(255, 255, 255, 255))
        else
            --draw.RoundedBox(0, offset, offset, button_size, button_size, Color(255, 255, 255, 255))
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawOutlinedRect(offset, offset, button_size, button_size, 2)
        end
    end

    -- For anyone who is reading this, I do this because it's only for one button and I'm lazy
    function auto_btn:OnMousePressed()
        if(file.Exists("horde/hidemenu.txt", "DATA")) then
            if(file.Read("horde/hidemenu.txt", "DATA") == "false") then
                file.Write("horde/hidemenu.txt", "true")
            else
                file.Write("horde/hidemenu.txt", "false")
            end
        else
            file.Write("horde/hidemenu.txt", "false")
        end
        surface.PlaySound("UI/buttonclick.wav")
    end

    local _, _, label = HORDE_CreateLabel(auto_btn, gap * 3 + button_size, auto_btn:GetTall() * 0.5, "Automatically open this menu", "Content", Color(255, 255, 255, 255))
    label.CentVer()

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

local nextUpdate = SysTime()
local nextQueue = 0
local connectAddress = "NULL"
hook.Add("Think", "HORDE_UpdateStatus", function()
    if(nextQueue < SysTime()) then
        for k,v in pairs(HORDE_QueuedAvatarDownload) do
            HORDE_DownloadAvatar(k)
            HORDE_QueuedAvatarDownload[k] = nil
            break
        end
        nextQueue = SysTime() + 0.33
    end
    if(nextUpdate > SysTime() || !IsValid(LocalPlayer())) then return end
    if(connectAddress == "NULL") then
        for _, ply in ipairs(player.GetAll()) do
            if(ply:IsListenServerHost()) then
                connectAddress = "p2p:"..ply:SteamID64()
                break
            end
        end

        if(connectAddress == "NULL") then
            connectAddress = game.GetIPAddress()
        end
    end
    HTTPUpdateStatus(connectAddress)
    nextUpdate = SysTime() + 10
end)

file.CreateDir("horde/avatars")

HORDE_OpenMenu = HORDE_OpenMenu || true
hook.Add("HUDPaint", "HORDE_AutoMenu", function()
    if(HORDE_OpenMenu == true) then
        HORDE_OpenMenu = false
        local open = true
        if(file.Exists("horde/hidemenu.txt", "DATA")) then
            if(file.Read("horde/hidemenu.txt", "DATA") == "false") then
                return
            end
        end
        HORDE:ToggleStats()
    end
end)