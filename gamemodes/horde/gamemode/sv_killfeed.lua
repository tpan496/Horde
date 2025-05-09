util.AddNetworkString( "killfeed_player_killed_npc" )
util.AddNetworkString( "killfeed_player_died" )

-- Disable defaults
function GM:SendDeathNotice() end
function GM:OnNPCKilled( ent, attacker, inflictor )
    if not attacker:IsPlayer() then return end

    local class = ent:GetClass()

    net.Start( "killfeed_player_killed_npc" )
        net.WriteEntity( attacker )
        net.WriteString( inflictor:GetClass() )
        net.WriteString( class )
    net.Broadcast()
end

hook.Add( "PlayerDeath", "Horde_PlayerDeath", function( victim, _, attacker )
    if not IsValid( victim ) or not IsValid( attacker ) then return end

    local attackerName = attacker:IsPlayer() and "suicide" or "#" .. attacker:GetClass()
    net.Start( "killfeed_player_died" )
        net.WriteEntity( victim )
        net.WriteString( attackerName )
    net.Broadcast()
end )
