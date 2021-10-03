PERK.PrintName = "Deus Ex Machina"
PERK.Description = "Watchtowers have Warden Aura.\nWatchtowers generate a shockwave every {1} seconds.\nShockwave deals {2} Shock damage."
PERK.Icon = "materials/perks/ex_machina.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 100},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_ex_machina" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if ent:GetClass() == "horde_watchtower" then
                ent:Horde_AddWardenAura()
                ent.Horde_EnableShockwave = true
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower:Horde_AddWardenAura()
            ply.Horde_Extra_Watchtower.Horde_EnableShockwave = true
        end
   end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_ex_machina" then
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
            if ent:GetClass() == "horde_watchtower" then
                ent:Horde_RemoveWardenAura()
                ent.Horde_EnableShockwave = nil
            end
        end

        if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
            ply.Horde_Extra_Watchtower:Horde_RemoveWardenAura()
            ply.Horde_Extra_Watchtower.Horde_EnableShockwave = nil
        end
   end
end