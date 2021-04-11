PERK.PrintName = "Crude Casing"
PERK.Description = "Enemies you hit with Ballistic damage are Weakened.\nWeakened enemies deal {1} reduced damage.\nWeakened enemies receive {2} increased damage."
PERK.Icon = "materials/perks/crude_casing.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 0.10, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_crude_casing") then return end
    if not target:IsNPC() or target:GetNWEntity("HordeOwner") then return end
    local dmgtype = dmg:GetDamageType()
    if dmgtype == DMG_BULLET or dmgtype == DMG_BUCKSHOT then
        target:Horde_AddWeaken(attacker:Horde_GetApplyDebuffDuration())
    end
end