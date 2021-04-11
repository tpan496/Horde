PERK.PrintName = "Engineer Base"
PERK.Description = "The Engineer class is a minion-centered class that deals damage through minions.\nComplexity: MEDIUM\n\n{1} increased minion health and damage.\nTurrets have {2} base health and deals {3} base damage."
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 500},
    [3] = {value = 18},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
    end
end

PERK.Hooks.EntityTakeDamage = function (target, dmginfo)
end

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_base") and dmginfo:GetInflictor():GetClass() == "npc_turret_floor" then
        bonus.more = bonus.more * 6
    end
    bonus.increase = bonus.increase + 0.25
end

PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    if CLIENT then return end
    timer.Simple(0.1, function()
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsPlayer() and ply:Horde_GetPerk("engineer_base") and ent:IsNPC() then
            if ent:GetClass() == "npc_turret_floor" then
                if ent:GetMaxHealth() < 500 then
                    ent:SetMaxHealth(500)
                end
            end
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.25)
            ent:SetHealth(ent:GetMaxHealth())
        end
    end)
end