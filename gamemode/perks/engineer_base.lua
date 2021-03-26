PERK.PrintName = "Engineer Base"
PERK.Description = "25% more minion health and damage.\nTurrets you build have 500 base health and deals 20 base damage."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
    end
end

PERK.Hooks.ScaleNPCDamage = function (npc, hitgroup, dmg)
    if not npc:IsValid() then return end
    local attacker = dmg:GetAttacker()
    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        if attacker:GetNWEntity("HordeOwner"):Horde_GetPerk("engineer_base") then
            if dmg:GetAttacker():GetClass() == "npc_turret_floor" then
                if dmg:GetDamage() < 20 then
                    dmg:SetDamage(20)
                end
            end
            dmg:ScaleDamage(1.25)
        end
    end
end

PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    timer.Simple(0.1, function()
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsValid() and ply:Horde_GetPerk("engineer_base") and ent:IsNPC() then
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