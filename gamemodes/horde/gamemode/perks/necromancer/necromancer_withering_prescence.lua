PERK.PrintName = "Withering Presence"
PERK.Description =
[[{1} increased Frostbite buildup.
{2} increased Frostbite duration.]]
PERK.Icon = "materials/perks/necromancer/withering_prescence.png"

PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.5, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyDebuffApply = function ( _, debuff, bonus, inflictor )
    if debuff == HORDE.Status_Frostbite and inflictor:Horde_GetPerk( "necromancer_withering_prescence" ) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnEnemyFrostbiteApply = function ( inflictor, _, duration_bonus )
    if inflictor and inflictor:IsPlayer() and inflictor:Horde_GetPerk( "necromancer_withering_prescence" ) then
        duration_bonus.increase = duration_bonus.increase + 0.5
    end
end