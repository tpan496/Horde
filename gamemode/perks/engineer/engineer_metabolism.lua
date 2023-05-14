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

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("engineer_metabolism") then
        local inflictor = dmginfo:GetInflictor()
        if inflictor.Horde_Debuff_Active and inflictor.Horde_Debuff_Active[HORDE.Status_Decay] then return end
        if (inflictor:IsNPC() and inflictor:GetNWEntity("HordeOwner"):IsPlayer()) or (npc.Horde_Has_Parasite and npc.Horde_Has_Parasite:IsPlayer()) then
            local leech = math.min(20, dmginfo:GetDamage() * 0.1)
            inflictor:SetHealth(math.min(inflictor:GetMaxHealth(), leech + inflictor:Health()))
        end
    end
end

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_metabolism") and dmginfo:GetInflictor():Health() < dmginfo:GetInflictor():GetMaxHealth() then
        bonus.increase = bonus.increase + 0.15
    end
end