PERK.PrintName = "Metabolism"
PERK.Description = [[
Minions leech {1} of damage dealt, up to {2} hp per hit.
{3} increased minion damage while leeching.]]
PERK.Icon = "materials/perks/metabolism.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 20},
    [3] = {value = 0.15, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.PostEntityTakeDamage = function (ent, dmg, took)
    local attacker = dmg:GetAttacker()
    local inflictor = dmg:GetInflictor()
    if not attacker:IsValid() or not inflictor:IsValid() then return end
    if took and ent:IsNPC() and attacker:IsPlayer() and (inflictor:GetNWEntity("HordeOwner"):IsPlayer() or (ent.Horde_Has_Parasite and ent.Horde_Has_Parasite:IsPlayer())) and attacker:Horde_GetPerk("engineer_metabolism") then
        if inflictor.Horde_Debuff_Active and inflictor.Horde_Debuff_Active[HORDE.Status_Decay] then return end
        local leech = math.min(20, dmg:GetDamage() * 0.1)
        inflictor:SetHealth(math.min(inflictor:GetMaxHealth(), leech + inflictor:Health()))
    end
end

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_metabolism") and dmginfo:GetInflictor():Health() < dmginfo:GetInflictor():GetMaxHealth() then
        bonus.increase = bonus.increase + 0.15
    end
end