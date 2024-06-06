PERK.PrintName = "Overlord Base"
PERK.Description = [[
The Overlord class focuses on oppressing enemies and special defense.

Staying near the enemies adds the Fear effect on them.
Adds 1 Fear stack per second near the enemy.
Each Fear stack make enemies take {1} increased damage and deal {2} less damage.
Fear can stack up to 2 times.

{3} increased Fear radius. ({4} per level, up to {5}).
{6} increased less debuff buildup received. ({7} per level, up to {8}).

Your watchtower has no effects.]]
PERK.Params = {
    [1] = { percent = true, value = 0.04 },
    [2] = { percent = true, value = 0.02 },
    [3] = { percent = true, level = 0.01, max = 0.25, classname = HORDE.Class_Overlord },
    [4] = { value = 0.01, percent = true },
    [5] = { value = 0.25, percent = true },
    [6] = { percent = true, level = 0.008, max = 0.2, classname = HORDE.Class_Overlord },
    [7] = { value = 0.008, percent = true },
    [8] = { value = 0.20, percent = true },
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_base" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 2)
        local id = ply:SteamID()
        timer.Create("Horde_FearRegen" .. id, 1, 0, function()
            if not ply:IsValid() then
                timer.Remove("Horde_FearRegen" .. id)
                return
            end
            local radius_bonus = ply:Horde_GetPerkLevelBonus("overlord_base")
            if ply:Horde_GetPerk("overlord_doomed_prescence") then
                radius_bonus = radius_bonus * 1.5
            end
            for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 125 * radius_bonus)) do
                if ent:IsNPC() and HORDE:IsPlayerOrMinion(ent) ~= true then
                    ent:Horde_AddFearStack(ply)
                    if ply:Horde_GetPerk("overlord_authority") then
                        for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
                            ply:Horde_ReduceDebuffBuildup(debuff, 20)
                        end
                    end
                    if ply:Horde_GetPerk("overlord_doomed_prescence") then
                        if ent:Horde_IsElite() then
                            if not ent.Horde_Overlord_Doomed_Prescence_Instance then
                                ent.Horde_Overlord_Doomed_Prescence_Instance = 1
                            end
                            if ent.Horde_Overlord_Doomed_Prescence_Instance >= 8 then
                            else
                                ent:SetMaxHealth(ent:GetMaxHealth() * 0.99)
                                ent:SetHealth(ent:GetMaxHealth())
                                ent.Horde_Overlord_Doomed_Prescence_Instance = ent
                                    .Horde_Overlord_Doomed_Prescence_Instance + 1
                            end
                        else
                            ent:SetMaxHealth(ent:GetMaxHealth() * 0.9)
                            ent:SetHealth(ent:GetMaxHealth())
                        end
                    end
                end
            end
            if ply.Horde_overlord_juxtapose and ply.Horde_overlord_juxtapose:IsValid() then
                local pos = ply.Horde_overlord_juxtapose:GetPos()
                for _, ent in pairs(ents.FindInSphere(pos, 175 * radius_bonus)) do
                    if ent:IsNPC() and HORDE:IsPlayerOrMinion(ent) ~= true then
                        ent:Horde_AddFearStack(ply)
                        if ply:Horde_GetPerk("overlord_authority") then
                            for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
                                ply:Horde_ReduceDebuffBuildup(debuff, 20)
                            end
                        end
                        if ply:Horde_GetPerk("overlord_doomed_prescence") then
                            if ent:Horde_IsElite() then
                                if not ent.Horde_Overlord_Doomed_Prescence_Instance then
                                    ent.Horde_Overlord_Doomed_Prescence_Instance = 1
                                end
                                if ent.Horde_Overlord_Doomed_Prescence_Instance >= 8 then
                                else
                                    ent:SetMaxHealth(ent:GetMaxHealth() * 0.99)
                                    ent:SetHealth(ent:GetMaxHealth())
                                    ent.Horde_Overlord_Doomed_Prescence_Instance = ent
                                        .Horde_Overlord_Doomed_Prescence_Instance + 1
                                end
                            else
                                ent:SetMaxHealth(ent:GetMaxHealth() * 0.9)
                                ent:SetHealth(ent:GetMaxHealth())
                            end
                        end
                    end
                end
            end
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_base" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 2)
        local id = ply:SteamID()
        timer.Remove("Horde_FearRegen" .. id)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function(ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("overlord_base", 1 + math.min(0.25, 0.01 * ply:Horde_GetLevel(HORDE.Class_Overlord)))
        ply:Horde_SetPerkLevelBonus("overlord_base2", math.min(0.2, 0.008 * ply:Horde_GetLevel(HORDE.Class_Overlord)))
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_base") then return end
    bonus.less = bonus.less * (1 - ply:Horde_GetPerkLevelBonus("overlord_base2"))
end
