SPELL.PrintName       = "Raise Greater Spectre"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {45, 0}
SPELL.Price           = 0
SPELL.ChargeTime      = {0, 0.5}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 4
SPELL.Upgrades        = 5
SPELL.Slot            = HORDE.Spell_Slot_RMB
SPELL.DamageType      = {HORDE.DMG_PHYSICAL}
SPELL.Type            = {HORDE.Spell_Type_Minion}
SPELL.Icon            = "spells/raise_greater_spectre.png"
SPELL.Description    = [[Raises a greater spectre created using dark matter. Greater spectre has larger health and damage, but cannot leap and attack less often.
Charge to recall spectres.
Maximum number of Spectres can be increased by perks]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    if charge_stage == 2 then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_spectre" then
                local rand = VectorRand() * 50
                rand.z = 0
                ent:SetPos(ply:GetPos() + rand)
            end
        end
        return
    end
    return HORDE:RaiseSpectre(ply, {greater_spectre=true})
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases minion health and damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end