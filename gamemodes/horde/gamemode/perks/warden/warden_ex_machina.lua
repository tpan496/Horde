PERK.PrintName = "Deus Ex Machina"
PERK.Description = "Watchtowers have Warden Aura."
PERK.Icon = "materials/perks/ex_machina.png"
PERK.Params = {
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_ex_machina" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if HORDE:IsWatchTower(ent) then
                ent:Horde_AddWardenAura()
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower:Horde_AddWardenAura()
        end
   end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_ex_machina" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if HORDE:IsWatchTower(ent) then
                ent:Horde_RemoveWardenAura()
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower:Horde_RemoveWardenAura()
        end
   end
end