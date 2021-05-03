PERK.PrintName = "Firestorm"
PERK.Description = "Fire damage builds up Burst power in enemies.\nCreates an explosion when Burst power reaches {1}.\nExplosion deals {2} Blast damage."
PERK.Icon = "materials/perks/firestorm.png"
PERK.Params = {
    [1] = {value = 100},
    [2] = {value = 25},
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("cremator_firestorm") and (dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SLOWBURN) then
        ent:Horde_AddBurst(dmginfo:GetDamage(), ent, attacker)
    end
end