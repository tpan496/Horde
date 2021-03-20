PERK.PrintName = "Cardiac Overload"
PERK.Description = "25% chance to add 1 Adrenaline stack on headshot.\nAdds 2 maximum Adrenaline stacks."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if perk == "assault_cardiac_overload" and ply:GetClass().name == HORDE.Class_Assault then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if perk == "assault_cardiac_overload" and ply:GetClass().name == HORDE.Class_Assault then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 2)
    end
end

hook.Add("ScaleNPCDamage", "Horde_CardiacOverloadDamage", function(npc, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if not attacker:IsValid() or not attacker:IsPlayer() then return end
    if not attacker:Horde_GetPerk("assault_cardiac_overload")  then return end
    if hitgroup == HITGROUP_HEAD then
        local p = math.random()
        if p <= 0.25 then
            attacker:Horde_AddAdrenalineStack()
        end
    end
end)