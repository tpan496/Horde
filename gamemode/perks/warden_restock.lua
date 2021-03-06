PERK.PrintName = "Quick Restock"
PERK.Description = "Watchtowers restock cooldown decreased by {1}."
PERK.Icon = "materials/perks/restock.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_restock" then
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if ent:GetClass() == "horde_watchtower" then
                ent.Horde_ThinkInterval = 15
            end
        end
   end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_restock" then
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if ent:GetClass() == "horde_watchtower" then
                ent.Horde_ThinkInterval = 30
            end
        end
   end
end