PERK.PrintName = "Crude Casing"
PERK.Description = "Enemies you hit with Ballistic damage are Weakened.\nWeakened enemies deal 10% reduced damage.\nWeakened enemies receive 10% increased damage."
PERK.Icon = "materials/perks/crude_casing.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_crude_casing") then return end
    if not target:IsNPC() or not dmg:GetDamageType() == DMG_BULLET then return end
    if not target:GetNWEntity("HordeOwner") then
        target:Horde_AddWeaken(attacker:Horde_GetApplyDebuffDuration(), attacker:Horde_GetApplyDebuffMore())
    end
end