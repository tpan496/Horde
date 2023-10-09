PERK.PrintName = "Eldritch Protection"
PERK.Description =
[[{1} increased mind regeneration.
You take {2} less damage from enemies affected by Frostbite.]]
PERK.Icon = "materials/perks/necromancer/eldritch_protection.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_MindRegeneration = function (ply, bonus)
    if ply:Horde_GetPerk("necromancer_eldritch_protection") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_eldritch_protection") then return end
    local attacker = dmginfo:GetAttacker()
    if attacker and attacker:Horde_HasDebuff(HORDE.Status_Frostbite) then
        bonus.less = bonus.less * 0.75
    end
end