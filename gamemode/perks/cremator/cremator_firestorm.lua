PERK.PrintName = "Firestorm"
PERK.Description = "Fire damage increases Burst buildup in enemies.\nCreates an explosion when Burst buildup is full.\nExplosion deals {1} Blast damage."
PERK.Icon = "materials/perks/firestorm.png"
PERK.Params = {
    [1] = {value = 25},
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("cremator_firestorm") and HORDE:IsFireDamage(dmginfo) then
        ent:Horde_AddBurst(dmginfo:GetDamage(), ent, attacker)
    end
end