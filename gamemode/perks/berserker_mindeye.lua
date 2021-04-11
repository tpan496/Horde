PERK.PrintName = "Mind's Eye"
PERK.Description = "While holding a melee weapon:\n  {1} chance to evade damage.\n  Counter with {2} of evaded melee damage."
PERK.Icon = "materials/perks/mindeye.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_mindeye")  then return end
    if ply:GetActiveWeapon():IsValid() and HORDE.items[ply:GetActiveWeapon():GetClass()] and HORDE.items[ply:GetActiveWeapon():GetClass()].category == "Melee" then
        bonus.evasion = bonus.evasion + PERK.Params[1].value
    end
end

PERK.Hooks.Horde_OnPlayerEvade = function(ply, dmg)
    local attacker = dmg:GetAttacker()
    if ply:Horde_GetPerk("berserker_mindeye") and attacker:IsNPC() then
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(ply)
        dmginfo:SetInflictor(ply:GetActiveWeapon())
        dmginfo:SetDamage(dmg:GetDamage() * PERK.Params[2].value)
        dmginfo:SetDamageType(DMG_DIRECT)
        attacker:TakeDamageInfo(dmginfo)
    end
end