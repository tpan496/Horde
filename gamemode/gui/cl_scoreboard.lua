if SERVER then return end

if GetConVarNumber("horde_enable_scoreboard") == 0 then return end

local scoreboard = {}

surface.CreateFont('Title', { font = 'arial bold', size = 30 })
surface.CreateFont('Content', { font = 'arial bold', size = 20 })

function scoreboard:show()
    local title = vgui.Create('DPanel')
    title:SetSize(1000, 100)
    title:SetPos(ScrW()/2 - 1000 / 2, ScrH()/5 - 50)
    function title:Paint(w, h)
        draw.SimpleText("Horde - " .. game.GetMap(), "Title", 0, 12, HORDE.color_crimson_dim, TEXT_ALIGN_LEFT)
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
        draw.DrawText("Name", "Content", 51, 9, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
        draw.DrawText("Class", "Content", 200, 9, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
        draw.DrawText("Kill", "Content", 871, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
        draw.DrawText("Death", "Content", 921, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
        draw.DrawText("Ping", "Content", 971, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
    end

    for _, v in ipairs( player.GetAll() ) do
        local class = ""
        if v:GetClass() then class = v:GetClass().name end

        local list = lists:Add("DPanel")
        list:SetSize(lists:GetWide(), 45)
        list:Dock(TOP)
        function list:Paint(w,h)
            if v:Alive() then
                draw.RoundedBox(5, 0, 0, w, 40, Color(40,40,40,200), true, true, false, false)
            else
                draw.RoundedBox(5, 0, 0, w, 40, Color(100,0,0,200), true, true, false, false)
            end
            draw.DrawText(v:Name():sub(1,20), "Content", 51, 9, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
            draw.DrawText(class, "Content", 200, 9, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT )
            draw.DrawText(tostring(v:Frags()), "Content", 871, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
            draw.DrawText(tostring(v:Deaths()), "Content", 921, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER )
            draw.DrawText(tostring(v:Ping()), "Content", 971, 9, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
        end

        local avatar = lists:Add("AvatarImage")
        avatar:SetParent(list)
        avatar:Dock(NODOCK)
	    avatar:SetPos(2, 2)
		avatar:SetSize(36, 36)
        avatar:SetPlayer(v)
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