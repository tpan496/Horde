PERK.PrintName = "Spectre"
PERK.Description = "Minions leech 10% of damage dealt.\nMinions deal 15% more damage on full health."
PERK.Icon = "materials/perks/spectre.png"

PERK.Hooks = {}

PERK.Hooks.ScaleNPCDamage = function (npc, hitgroup, dmg)
    if not npc:IsValid() then return end
    local attacker = dmg:GetAttacker()
    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        if attacker:GetNWEntity("HordeOwner"):Horde_GetPerk("engineer_spectre") then
            dmg:ScaleDamage(1.15)
        end
    end
end

PERK.Hooks.PostEntityTakeDamage = function (ent, dmg, took)
    local attacker = dmg:GetAttacker()
    local inflictor = dmg:GetInflictor()
    if not attacker:IsValid() or not inflictor:IsValid() then return end
    if took and ent:IsNPC() and attacker:IsPlayer() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() and attacker:Horde_GetPerk("engineer_spectre") then
        local leech = dmg:GetDamage() * 0.1
        inflictor:SetHealth(math.max(inflictor:GetMaxHealth(), leech + inflictor:Health()))
    end
end