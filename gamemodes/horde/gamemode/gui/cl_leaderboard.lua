local PANEL = {}
local top_tens = player.GetAll()

local font = translate.GetFont()
surface.CreateFont("Horde_LeaderRank", { font = font, size = ScreenScale(4), extended = true})

function PANEL:Init()
    local w = math.max(300, ScrW() * 0.2)
    local h = ScreenScale(15) * 11
    self:SetSize(w, h)
    self:SetPos(ScrW() - w - ScreenScale(6), ScreenScale(6))
    self:SetBackgroundColor(Color(0,0,0,0))

    local leader_panel = vgui.Create("DPanel", self)
    leader_panel:SetSize(w, 0)
    leader_panel:SetBackgroundColor(Color(40,40,40,200))
    leader_panel:DockMargin(0, 0, 0, 0)
    self.leader_panel = leader_panel
end

local function AddPlayer(ply)
    
end

function PANEL:SetData()
    local i = 1
    local w = self:GetWide()
    self.leader_panel:Clear()

    self.leader_panel:SetSize(w, ScreenScale(15) * (1 + table.Count(top_tens)))

    local llabel = vgui.Create("DLabel", self.leader_panel)
    llabel:SetText("  Leaderboard:")
    llabel:SetFont("Info")
    llabel:SetTextColor(color_white)
    llabel:SetSize(100, ScreenScale(15))
    llabel:SetPos(10, 0)
    llabel:Dock(TOP)

    for level, ply in SortedPairs(top_tens, true) do
        local panel = vgui.Create("DPanel", self.leader_panel)
        panel:DockPadding(ScreenScale(5), 0, 0, 0)
        panel:SetSize(w, ScreenScale(15))
        panel:Dock(TOP)
        panel:SetBackgroundColor(Color(0,0,0,0))

        local rlabel = vgui.Create("DLabel", panel)
        rlabel:SetText(i .. ".")
        rlabel:SetFont("Info")
        rlabel:SetTextColor(color_white)
        rlabel:SetSize(ScreenScale(15), ScreenScale(15))
        rlabel:Dock(LEFT)

        local class_panel = vgui.Create("DPanel", panel)
        class_panel:Dock(LEFT)
        class_panel:SetSize(ScreenScale(17), ScreenScale(15))
        class_panel:SetBackgroundColor(Color(0,0,0,0))
        local subclass_name = ply.class
        if not subclass_name then return end
        local subclass = HORDE.subclasses[subclass_name]
        if not subclass then subclass = HORDE.subclasses["Survivor"] end
        local mat = Material(subclass.Icon, "mips smooth")
        local rank, rank_level = HORDE:LevelToRank(level)
        class_panel.Paint = function ()
            surface.SetMaterial(mat)
            surface.SetDrawColor(HORDE.Rank_Colors[rank])
            surface.DrawTexturedRect(ScreenScale(2), ScreenScale(1.5), ScreenScale(12), ScreenScale(12))
            
            if rank == HORDE.Rank_Master then
                draw.SimpleText(rank_level, "Horde_LeaderRank", 0, ScreenScale(3), HORDE.Rank_Colors[rank], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            else
                if rank_level > 0 then
                    local star = Material("star.png", "mips smooth")
                    surface.SetMaterial(star)
                    local y_pos = ScreenScale(8.5)
                    for j = 0, rank_level - 1 do
                        surface.DrawTexturedRect(0, y_pos, ScreenScale(3), ScreenScale(3))
                        y_pos = y_pos - ScreenScale(2)
                    end
                end
            end
        end
        
        
        local label = vgui.Create("DLabel", panel)
        label:SetText(ply.name)
        label:SetFont("Info")
        label:SetTextColor(color_white)
        label:SetSize(w - ScreenScale(32), ScreenScale(15))
        label:Dock(LEFT)

        i = i + 1
    end
end

function PANEL:Paint()
    
end

function HORDE:ShowLeaderboardThenFadeOut()
    HORDE.leader_board:SetVisible(true)
    timer.Simple(10, function ()
        HORDE.leader_board:SetVisible(false)
    end)
end

vgui.Register("HordeLeaderBoard", PANEL, "DPanel")
HORDE.leader_board = vgui.Create("HordeLeaderBoard")
HORDE:ShowLeaderboardThenFadeOut()

net.Receive("Horde_SyncTopTen", function ()
    local s = net.ReadString()
    local temp_table = util.JSONToTable(s)
    top_tens = {}
    for level, ply in pairs(temp_table) do
        steamworks.RequestPlayerInfo(ply.steamid, function(steamName)
            top_tens[level] = {name=steamName, steamid=ply.steamid, class=ply.class}
            HORDE.leader_board:SetData()
        end)
    end
end)