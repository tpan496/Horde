PERK.PrintName = "Energy Siphon"
PERK.Description =
[[Leeches {1} Cold damage dealt as Mind, up to {2} per hit.
Increase Cold damage based on your current Mind, up to {3}.]]
PERK.Icon = "materials/perks/necromancer/energy_siphon.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 15},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {
}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("necromancer_energy_siphon") and HORDE:IsColdDamage(dmginfo) then
        ply:Horde_SetMind(math.min(ply:Horde_GetMaxMind(), math.min(15, dmginfo:GetDamage() / 5) + ply:Horde_GetMind()))
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_energy_siphon")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.25 * (ply:Horde_GetMind() / ply:Horde_GetMaxMind())
    end
end
