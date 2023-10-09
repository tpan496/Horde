PERK.PrintName = "Rejection Pulse"
PERK.Description = "Watchtowers generate a shockwave every {1} seconds.\nShockwave deals {2} Lightning damage."
PERK.Icon = "materials/perks/rejection_pulse.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 50},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_rejection_pulse" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if HORDE:IsWatchTower(ent) then
                ent.Horde_EnableShockwave = true
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower.Horde_EnableShockwave = true
        end
   end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_rejection_pulse" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if HORDE:IsWatchTower(ent) then
                ent.Horde_EnableShockwave = nil
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower.Horde_EnableShockwave = nil
        end
   end
end