SPELL.PrintName       = "Sigil of Arcana"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {10}
SPELL.Price           = 0
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 15
SPELL.Upgrades        = 3
SPELL.Slot            = HORDE.Spell_Slot_RMB
SPELL.Icon            = "spells/sigil_of_arcana.png"
SPELL.Type            = {HORDE.Spell_Type_Utility}
SPELL.Description     = [[Generates a sigil that enhances spells damage. Standing in the field increases your spell damage by 15%.]]
SPELL.Sigil           = true
SPELL.Fire            = function (ply, wpn, charge_stage, param)
    local level = ply:Horde_GetSpellUpgrade("sigil_of_arcana")
	local pos = ply:GetPos()
    local duration = 6
    local s = 1
    if param and param.sigil_mastery then
        s = 0.5
    end
	local r = (150 + 30 * level) * s
    duration = (duration + math.floor(0.5 + 0.5 * level)) * s
    local ed = EffectData()
    ed:SetOrigin(pos)
    ed:SetScale(r)
    ed:SetMagnitude(duration)
    util.Effect("horde_sigil_arcana", ed, true, true)
    local bonus = {}
    hook.Run("Horde_OnSigilCreated", ply, bonus, pos, r, duration, level)

    for i = 1, duration do
        timer.Simple((i-1) * 1, function ()
            sound.Play("horde/spells/mystic_field.ogg", pos, 100, 100)
            for _, ent in pairs(ents.FindInSphere(pos, r)) do
                if ent:IsPlayer() then
                    ent:Horde_AddSigil(HORDE.Status_SigilArcana, 1, bonus, level)
                end
            end
        end)
    end
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases area of effect and spell amplification (+10% per level)."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end