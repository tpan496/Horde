if CLIENT then return end

-- Difficulty settings
local difficulty = GetConVarNumber("horde_difficulty")
local difficulty_normal = 0
local difficulty_hard = 1
local difficulty_realism = 2

hook.Add("EntityTakeDamage", "Horde_EntityTakeDamage", function (target, dmg)
    if target:IsValid() and target:IsPlayer() and dmg:GetAttacker():IsNPC() then
        dmg:ScaleDamage(1.25)
        if dmg:GetAttacker():GetVar("damage_scale") then
            dmg:ScaleDamage(dmg:GetAttacker():GetVar("damage_scale"))
        end
    end
end)

if difficulty >= difficulty_hard then

    for i, enemies_count in ipairs(HORDE.total_enemies_per_wave) do
        if difficulty == difficulty_hard then
            HORDE.total_enemies_per_wave[i] = enemies_count * 1.3
        else
            HORDE.total_enemies_per_wave[i] = enemies_count * 1.7
        end
    end
end

if difficulty == difficulty_hard then
    HORDE.kill_reward_base = HORDE.kill_reward_base * 0.8
end

if difficulty == difficulty_realism then
    hook.Add("OnEntityCreated", "Horde_OnEntityCreated", function (entity)
        timer.Simple(0.01, function ()
            if entity:IsValid() and entity:IsNPC() then
                entity:SetMaxHealth(entity:GetMaxHealth() * 1.25)
                entity:SetHealth(entity:GetMaxHealth() * 1.25)
            end
        end)
    end)

    HORDE.kill_reward_base = HORDE.kill_reward_base * 0.6
end