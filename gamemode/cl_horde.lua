if SERVER then return end
-- Horde Client

net.Receive("HighlightEnemies", function (len, ply)
    local render = net.ReadInt(2)
    if render == 1 then
        hook.Add("PreDrawHalos", "Horde_AddPropHalos", function()
            halo.Add( ents.FindByClass( "npc*" ), Color(255, 0, 0), 1, 1, 2, true, true )
        end)
    else
        hook.Remove("PreDrawHalos", "Horde_AddPropHalos")
    end
end)