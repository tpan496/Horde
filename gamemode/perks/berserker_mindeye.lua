PERK.PrintName = "Mind's Eye"
PERK.Description = "While holding a melee weapon:\n  25% chance to evade damage.\n  Counter with 50% of evaded melee damage."
PERK.Icon = "materials/perks/mindeye.png"

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if not ply:Horde_GetPerk("berserker_mindeye")  then return end
    if ply:GetActiveWeapon():IsValid() and HORDE.items[ply:GetActiveWeapon():GetClass()] and HORDE.items[ply:GetActiveWeapon():GetClass()].category == "Melee" then
        bonus.evasion = bonus.evasion + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerEvade = function(ply, dmg)
    local attacker = dmg:GetAttacker()
    if ply:Horde_GetPerk("berserker_mindeye") and attacker:IsNPC() then
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(ply)
        dmginfo:SetInflictor(ply:GetActiveWeapon())
        dmginfo:SetDamage(dmg:GetDamage()/2)
        dmginfo:SetDamageType(DMG_DIRECT)
        attacker:TakeDamageInfo(dmginfo)
    end
end