PERK.PrintName = "Swarm"
PERK.Description =
[[+1 to maximum Antlions.]]
PERK.Icon = "materials/perks/hatcher/swarm.png"
PERK.Params = {
    [1] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "hatcher_swarm" then
        local count = 0
        if not HORDE.player_drop_entities[ply:SteamID()] then return 0 end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" then
                count = count + 1
                if count > 1 then
                    ent:Remove()
                end
            end
        end
    end
end
