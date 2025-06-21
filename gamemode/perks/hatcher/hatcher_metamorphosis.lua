PERK.PrintName = "Metamorphosis"
PERK.Description =
[[Adds Stage IV evolution, turning Antlion into Antlion Guardian.
Antlion Guardian has increased health and damage.]]
PERK.Icon = "materials/perks/hatcher/metamorphosis.png"
PERK.Params = {
    [1] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "hatcher_metamorphosis" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsValid() and ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" and ent.Evolve_Stage == 4 then
                ent:Remove()
            end
        end
    end
end