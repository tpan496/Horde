PERK.PrintName = "Bloodlust"
PERK.Description = "Leech {1} of melee damage done.\nLeech is capped at {2} hp per hit."
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("berserker_bloodlust") and (dmginfo:GetDamageType() == DMG_SLASH or dmginfo:GetDamageType() == DMG_CLUB) then
        local leech = math.min(10, dmginfo:GetDamage() * 0.10)
        local ply = dmginfo:GetAttacker()
        local healinfo = HealInfo:New({amount=leech, healer=ply})
        HORDE:OnPlayerHeal(ply, healinfo)
    end
end