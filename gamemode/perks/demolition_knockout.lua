PERK.PrintName = "Knockout"
PERK.Description = "Blast damage builds up stun power.\nStuns enemy for {1} seconds when power reaches {2}.\nStun cooldown is {3} seconds."
PERK.Icon = "materials/perks/knockout.png"
PERK.Params = {
    [1] = {value = 300},
    [2] = {value = 2},
    [3] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("demolition_knockout") then
        ent:Horde_AddStun(dmginfo:GetDamage())
    end
end