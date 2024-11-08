SPELL.PrintName             = "Raise Hulk Spectre"
SPELL.Weapon                = { "horde_void_projector" }

SPELL.Mind                  = { 60, 0 }
SPELL.ChargeTime            = { 0, 0.5 }
SPELL.ChargeRelease         = nil
SPELL.Cooldown              = 11

SPELL.Slot                  = HORDE.Spell_Slot_Reload
SPELL.DamageType            = { HORDE.DMG_PHYSICAL }
SPELL.Type                  = { HORDE.Spell_Type_Minion }

SPELL.Icon                  = "spells/raise_shadow_hulk.png"
SPELL.Description           = [[Raises a hulk spectre created using dark matter. You can create at most 1 Hulk Spectre.]]

SPELL.Fire = function( ply, _, charge_stage )

    if charge_stage == 2 then

        if not HORDE.player_drop_entities[ply:SteamID()] then return end

        for _, ent in pairs( HORDE.player_drop_entities[ply:SteamID()] ) do

            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_shadow_hulk" then

                local rand = VectorRand() * 50
                rand.z = 0
                ent:SetPos( ply:GetPos() + rand )

            end

        end
        return

    end

    return HORDE:RaiseSpectre( ply, {
        hulk_spectre = true
    } )

end

SPELL.Price                 = 1500
SPELL.Upgrades              = 3
SPELL.Upgrade_Description   = "Increases minion health and damage."
SPELL.Upgrade_Prices        = function( upgrade_level )
    return 800 + 100 * upgrade_level
end