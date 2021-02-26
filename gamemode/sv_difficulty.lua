if CLIENT then return end

-- Difficulty settings
-- 0 - normal, 1 - hard, 2 - realism

HORDE.difficulty = GetConVar("horde_difficulty"):GetInt() + 1
HORDE.additional_pack = 0

local difficulty_normal = 0
local difficulty_hard = 1
local difficulty_realism = 2

-- Multipliers
local difficulty_damage_multiplier = {1, 1.25, 1.75}
local difficulty_enemy_count_multiplier = {1, 1.3, 1.5}
local difficulty_reward_base_multiplier = {1, 0.8, 0.6}
local difficulty_health_multiplier = {1, 1.1, 1.25}
local difficulty_start_money_multiplier = {1, 0.9, 0.8}
local difficulty_spawn_radiuis_multiplier = {1, 0.75, 0.5}

local difficulty_ammo_box_spawn_chance_multiplier = {1, 0.75, 0.5}

-- Flat modifiers
local difficulty_additional_pack = {0, 1, 2}

-- Hook settings
-- Damage scaling/handling
hook.Add("EntityTakeDamage", "Horde_EntityTakeDamage", function (target, dmg)
    if target:IsValid() and target:IsPlayer() then
        if dmg:GetAttacker():IsNPC() then
            if dmg:GetDamageType() == DAMAGE_CRUSH then
                -- Cap bullshit physics damage that can sometimes occur
                dmg:SetDamage(math.min(dmg:GetDamage(),20))
            end
            if dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_NERVEGAS then
                -- Otherwise poison headcrabs can oneshot you
                return
            end
            
            dmg:ScaleDamage(difficulty_damage_multiplier[HORDE.difficulty])

            if dmg:GetAttacker():GetVar("damage_scale") then
                dmg:ScaleDamage(dmg:GetAttacker():GetVar("damage_scale"))
            end
        elseif dmg:GetAttacker():IsPlayer() and dmg:GetAttacker() ~= target then
            dmg:SetDamage(0)
        elseif dmg:GetDamageType() == DAMAGE_CRUSH then
            dmg:SetDamage(math.min(dmg:GetDamage(),20 * difficulty_damage_multiplier[HORDE.difficulty]))
        end
    end
end)

-- Fall damage handling
hook.Add("GetFallDamage", "RealisticDamage", function(ply, speed)
    if HORDE.difficulty == difficulty_normal then
        return 10
    elseif HORDE.difficulty == difficulty_hard then
        return 0.5 * (speed / 8)
    else
        return (speed / 8)
    end
end)

-- Health scaling
hook.Add("OnEntityCreated", "Horde_OnEntityCreated", function (entity)
    timer.Simple(0.01, function ()
        if entity:IsValid() and entity:IsNPC() then
            entity:SetMaxHealth(entity:GetMaxHealth() * difficulty_health_multiplier[HORDE.difficulty])
            entity:SetHealth(entity:GetMaxHealth() * difficulty_health_multiplier[HORDE.difficulty])
        end
    end)
end)

-- Non-hook settings
-- Wave count scaling
for i, enemies_count in ipairs(HORDE.total_enemies_per_wave) do
    HORDE.total_enemies_per_wave[i] = enemies_count * difficulty_enemy_count_multiplier[HORDE.difficulty]
end

-- Kill reward scaling
HORDE.kill_reward_base = HORDE.kill_reward_base * difficulty_reward_base_multiplier[HORDE.difficulty]

-- Start money scaling
HORDE.start_money = HORDE.start_money * difficulty_start_money_multiplier[HORDE.difficulty]

-- Spawn density scaling
HORDE.spawn_radius = HORDE.spawn_radius * difficulty_spawn_radiuis_multiplier[HORDE.difficulty]

-- Additional spawns
HORDE.additional_pack = difficulty_additional_pack[HORDE.difficulty]