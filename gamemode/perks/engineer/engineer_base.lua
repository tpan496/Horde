PERK.PrintName = "Engineer Base"
PERK.Description = [[
The Engineer class is a minion-centered class that deals damage through minions.
Complexity: MEDIUM

{1} increased minion damage. ({2} per level, up to {3}).

Turrets have {4} base health and deals {5} base damage.]]
PERK.Params = {
    [1] = { percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Engineer },
    [2] = { value = 0.008, percent = true },
    [3] = { value = 0.20, percent = true },
    [4] = { value = 400 },
    [5] = { value = 15 },
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_base" then
        -- Removes and sells turrets (for subclass swapping)
        --ply:Horde_RemoveMinionsAndDrops()
    end
end

PERK.Hooks.Horde_OnPlayerMinionDamage = function(ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_base") then
        local class = dmginfo:GetInflictor():GetClass()
        if class == "npc_turret_floor" then
            bonus.more = bonus.more * 5
        end
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("engineer_base")
    end
end

PERK.Hooks.OnEntityCreated = function(ent)
    if CLIENT then return end
    timer.Simple(0.1, function()
        if not ent:IsValid() then return end
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsPlayer() and ply:Horde_GetPerk("engineer_base") and ent:IsNPC() then
            if ent:GetClass() == "npc_turret_floor" then
                if ent:GetMaxHealth() < 400 then
                    if ent.Horde_Is_Mini_Sentry then
                        ent:SetMaxHealth(200)
                    else
                        ent:SetMaxHealth(400)
                    end
                end
            end
        end
    end)
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function(ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("engineer_base", math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Engineer)))
    end
end
