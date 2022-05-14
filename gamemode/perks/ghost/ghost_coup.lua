PERK.PrintName = "Coup De Grace"
PERK.Description = "Instantly kills enemies with less than {1} health."
PERK.Icon = "materials/perks/coup.png"
PERK.Params = {
     [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmg)
    local attacker = dmg:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("ghost_coup") then return end
    if not target:IsNPC() then return end

    if not target:GetNWEntity("HordeOwner"):IsPlayer() and (target:Health() <= 0.15 * target:GetMaxHealth()) then
        dmg:SetDamage(0.15 * target:GetMaxHealth() + 1)
        dmg:SetDamageType(DMG_DIRECT)
    end
end