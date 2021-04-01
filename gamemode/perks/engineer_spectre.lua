PERK.PrintName = "Spectre"
PERK.Description = "Minions leech 10% of damage dealt.\nMinions deal 15% more damage."
PERK.Icon = "materials/perks/spectre.png"

PERK.Hooks = {}

-- idk why manhack damage does not count torwards scalenpcdamage
PERK.Hooks.EntityTakeDamage = function (target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local inflictor = dmginfo:GetInflictor()
    if attacker:IsPlayer() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() and attacker:Horde_GetPerk("engineer_spectre") then
        dmginfo:ScaleDamage(1.15)
    end
end

PERK.Hooks.PostEntityTakeDamage = function (ent, dmg, took)
    local attacker = dmg:GetAttacker()
    local inflictor = dmg:GetInflictor()
    if not attacker:IsValid() or not inflictor:IsValid() then return end
    if took and ent:IsNPC() and attacker:IsPlayer() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() and attacker:Horde_GetPerk("engineer_spectre") then
        local leech = dmg:GetDamage() * 0.1
        inflictor:SetHealth(math.min(inflictor:GetMaxHealth(), leech + inflictor:Health()))
    end
end