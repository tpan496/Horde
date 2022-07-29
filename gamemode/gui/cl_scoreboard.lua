if GetConVarNumber("horde_enable_scoreboard") == 0 then return end

local scoreboard = {}

function scoreboard:show()
    local title = vgui.Create("DPanel")
    title:SetSize(1000, 100)
    title:SetPos(ScrW()/2 - 1000 / 2, ScrH()/5 - 50)
    function title:Paint(w, h)
        draw.SimpleText("Horde - " .. game.GetMap() .. " - " .. translate.Get("Game_Difficulty_" .. HORDE.difficulty_text[HORDE.difficulty]), "Title", 0, 12, HORDE.color_crimson_dim, TEXT_ALIGN_LEFT)
        draw.SimpleText(GetHostName(), "Title", 1000, 12, HORDE.color_crimson_dim, TEXT_ALIGN_RIGHT)
    end

    local board = vgui.Create("DPanel")
    board:SetSize(1000, ScrH()/2)
    board:SetPos(ScrW()/2-(1000/2), ScrH()/5)

    local scroll = vgui.Create("DScrollPanel", board)
    scroll:Dock(FILL)

    local lists = vgui.Create("DListLayout", scroll)
    lists:Dock(FILL)

    function board:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,0))
    end

    local header = lists:Add("DPanel")
    header:SetSize(lists:GetWide(), 45)
    header:Dock(TOP)
    header:DockMargin(0,0,0,10)
    function header:Paint(w,h)
        draw.RoundedBox(5, 0, 0, w, 40, Color(40,40,40,200), true, true, false, false )
        draw.DrawText(translate.Get("Scoreboard Info Name"), "Content", 51, 11, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
        draw.DrawText(translate.Get("Scoreboard Info Class"), "Content", 225, 11, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
        draw.DrawText(translate.Get("Scoreboard Info Gadget"), "Content", 375, 11, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
        draw.DrawText(translate.Get("Scoreboard Info Money"), "Content", 771, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
        draw.DrawText(translate.Get("Scoreboard Info Kill"), "Content", 871, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
        draw.DrawText(translate.Get("Scoreboard Info Death"), "Content", 921, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
        draw.DrawText(translate.Get("Scoreboard Info Ping"), "Content", 971, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
    end

    local player_score = {}
    for _, ply in pairs(player.GetAll()) do
        player_score[ply] = ply:Frags()
    end

    for ply, _ in SortedPairsByValue(player_score, true) do
        if not ply:IsValid() then goto cont end
        local subclass_name = HORDE.Class_Survivor
        if ply:Horde_GetCurrentSubclass() then subclass_name = ply:Horde_GetCurrentSubclass() end

        local gadget = ply:Horde_GetGadget()

        local list = lists:Add("DPanel")
        list:SetSize(lists:GetWide(), 45)
        list:Dock(TOP)
        function list:Paint(w,h)
            if not ply:IsValid() then return end
            if ply:Alive() then
                draw.RoundedBox(5, 0, 0, w, 40, Color(40,40,40,200), true, true, false, false)
            else
                draw.RoundedBox(5, 0, 0, w, 40, Color(100,0,0,200), true, true, false, false)
            end
            draw.DrawText(ply:Name():sub(1,20), "Content", 51, 11, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
            local subclass = HORDE.subclasses[subclass_name]
            if subclass then
                local mat = Material(subclass.Icon, "mips smooth")
                local rank = ply:Horde_GetRank(subclass.PrintName)
                local rank_level = ply:Horde_GetRankLevel(subclass.PrintName)
                surface.SetMaterial(mat) -- Use our cached material
                surface.SetDrawColor(HORDE.Rank_Colors[rank])
                surface.DrawTexturedRect(200, 2, 38, 38)
                if rank == HORDE.Rank_Master then
                    draw.SimpleText(rank_level, "Trebuchet18", 200 - 5, 15, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.DrawText(translate.Get("Class_" .. subclass.PrintName) or subclass.PrintName, "Content", 250, 11, HORDE.Rank_Colors[rank], TEXT_ALIGN_LEFT )
                else
                    if rank_level > 0 then
                        local star = Material("star.png", "mips smooth")
                        surface.SetMaterial(star)
                        local y_pos = 27
                        for i = 0, rank_level - 1 do
                            surface.DrawTexturedRect(200 - 10, y_pos, 10, 10)
                            y_pos = y_pos - 7
                        end
                    end
                    draw.DrawText(translate.Get("Class_" .. subclass.PrintName) or subclass.PrintName, "Content", 250, 11, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
                end
            end
            
            if gadget then
                local mat = Material(HORDE.gadgets[gadget].Icon, "mips smooth")
                surface.SetMaterial(mat) -- Use our cached material
                if HORDE.gadgets[gadget].Active then
                    surface.SetDrawColor(HORDE.color_gadget_active)
                else
                    surface.SetDrawColor(color_white)
                end
                surface.DrawTexturedRect(350, -2, 90, 45)
            end
            surface.SetDrawColor(255, 255, 255, 255)
            draw.DrawText(tostring(ply:Horde_GetMoney()) .. "$", "Content", 771, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
            draw.DrawText(tostring(ply:Frags()), "Content", 871, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
            draw.DrawText(tostring(ply:Deaths()), "Content", 921, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
            draw.DrawText(tostring(ply:Ping()), "Content", 971, 11, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
        end

        local avatar = lists:Add("AvatarImage")
        avatar:SetParent(list)
        avatar:Dock(NODOCK)
	    avatar:SetPos(2, 2)
		avatar:SetSize(36, 36)
        avatar:SetPlayer(ply)

        ::cont::
    end

    function scoreboard:hide()
		-- This is where you hide the scoreboard, such as with Base:Remove()
        gui.EnableScreenClicker(false)
        board:Remove()
        title:Remove()
        hook.Remove("KeyPress", "Horde_Scoreboard_Mouse")
	end

    hook.Add("KeyPress", "Horde_Scoreboard_Mouse", function(ply, key)
        if board and title and (key == IN_ATTACK or key == IN_ATTACK2 or key == IN_USE) then
            gui.EnableScreenClicker(true)
        end
    end)
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end