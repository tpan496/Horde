PERK.PrintName = "Sigil Mastery"
PERK.Description =
[[+1 level to your Sigil spells.
Activating spells create a weaker version of your Sigil spell.]]
PERK.Icon = "materials/perks/warlock/sigil_mastery.png"
PERK.Params = {}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSpellLevel = function (ply, bonus, spell)
    if ply:Horde_GetPerk("warlock_sigil_mastery") and (spell.Is_Sigil) then
        bonus.add = bonus.add + 1
    end
end

PERK.Hooks.Horde_OnSpellFire = function (ply, wpn, stage, spell)
    if ply:Horde_GetPerk("warlock_sigil_mastery") then
        local s = ply:Horde_GetSecondarySpell()
        if s.Sigil then
            s.Fire(ply, wpn, stage, {sigil_mastery = true})
        end
    end
end