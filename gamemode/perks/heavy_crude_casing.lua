PERK.PrintName = "Crude Casing"
PERK.Description = "Enemies you hit are Weakened.\nWeakened enemies deal 10% reduced damage.\nWeakened enemies receive 10% increased damage."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("heavy_crude_casing") then return end
    if not target:IsNPC() then return end
    if not target:GetNWEntity("HordeOwner") then
        target:Horde_AddWeaken(5, target:Horde_GetApplyDebuffMore())
    end
end