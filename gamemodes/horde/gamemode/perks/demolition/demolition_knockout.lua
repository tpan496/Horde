PERK.PrintName = "Knockout"
PERK.Description = "Blast damage increases Stun buildup.\nEnemies affected by Stun is paralyzed for {1} seconds.\nStun cooldown is {2} seconds."
PERK.Icon = "materials/perks/knockout.png"
PERK.Params = {
    [1] = {value = 3},
    [2] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("demolition_knockout") and HORDE:IsBlastDamage(dmginfo) then
        ent:Horde_AddStun(dmginfo:GetDamage())
    end
end