PERK.PrintName = "Disembowel"
PERK.Description = [[
{1} increased Critical Hit damage.
Melee attacks remove Nemesis mutation from enemies.]]
PERK.Icon = "materials/perks/psycho/disembowel.png"
PERK.Params = {
    [1] = {value = 0.4, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_disembowel") then
        bonus.increase = bonus.increase + 0.4
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("psycho_disembowel") and HORDE:IsMeleeDamage(dmginfo) then
        if npc:Horde_HasMutation("nemesis") then
            npc.Horde_Mutation["nemesis"] = nil
            npc.Horde_Mutation_Nemesis = nil
        end
    end
end