-- Difficulty settings
-- Rule: scale as difficulty/endless.
-- 0 - normal, 1 - hard, 2 - realism

HORDE.difficulty = GetConVar("horde_difficulty"):GetInt() + 1
HORDE.endless = GetConVar("horde_endless"):GetInt()
HORDE.additional_pack = 0

-- Difficulty Stuff

local difficulty_normal = 0
local difficulty_hard = 1
local difficulty_realism = 2
local difficulty_nightmare = 3

-- Multipliers
local difficulty_damage_multiplier = {1, 1.25, 1.5, 1.65}
local difficulty_enemy_count_multiplier = {1, 1.3, 1.5, 1.5}
local difficulty_reward_base_multiplier = {1, 0.8, 0.6, 0.5}
HORDE.difficulty_health_multiplier = {1, 1.25, 1.5, 1.5}
local difficulty_start_money_multiplier = {1, 0.9, 0.8, 0.75}
local difficulty_spawn_radiuis_multiplier = {1, 0.75, 0.5, 0.5}
local difficulty_max_enemies_alive_scale_factor = {1, 1.15, 1.25, 1.25}
local difficulty_poison_headcrab_damage = {70, 80, 90, 90}

-- Flat modifiers
HORDE.difficulty_elite_health_scale_add = {0, 0.05, 0.075, 0.010}
HORDE.difficulty_additional_pack = {0, 1, 2, 2}
HORDE.difficulty_additional_ammoboxes = {2, 1, 0, 0}

-- Endless stuff
HORDE.endless_health_multiplier = 1
HORDE.endless_damage_multiplier = 1

-- Mutation
HORDE.difficulty_mutation_probability = {0, 0.05, 0.10, 0.15}
HORDE.difficulty_elite_mutation_probability = {0, 0, 0.05, 0.25}

-- Hook settings
-- Damage scaling/handling
-- Turrets should not be one-shot
function VJ_DestroyCombineTurret() end

hook.Add("EntityTakeDamage", "Horde_EntityTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsPlayer() then
        if dmg:GetAttacker():IsNPC() then
            if dmg:GetAttacker():GetNWEntity("HordeOwner"):IsPlayer() then
                -- Prevent minions from hurting players
                return true
            end
            if dmg:GetDamageType() == DAMAGE_CRUSH then
                -- Cap bullshit physics damage that can sometimes occur
                dmg:SetDamage(math.min(dmg:GetDamage(),20))
            end
            if dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_NERVEGAS then
                -- Otherwise poison headcrabs can oneshot you
                dmg:SetDamage(math.min(dmg:GetDamage(), difficulty_poison_headcrab_damage[HORDE.difficulty]))
                return
            end
            
            if HORDE.endless == 1 then
                dmg:ScaleDamage(difficulty_damage_multiplier[HORDE.difficulty] * HORDE.endless_damage_multiplier)
            else
                dmg:ScaleDamage(difficulty_damage_multiplier[HORDE.difficulty])
            end

            if dmg:GetAttacker():GetVar("damage_scale") then
                dmg:ScaleDamage(dmg:GetAttacker():GetVar("damage_scale"))
            end
        elseif dmg:GetAttacker():IsPlayer() and dmg:GetAttacker() ~= target then
            -- Prevent PVP
            return true
        elseif dmg:GetDamageType() == DAMAGE_CRUSH then
            dmg:SetDamage(math.min(dmg:GetDamage(), 20))
        end
    elseif target:GetNWEntity("HordeOwner"):IsPlayer() then
        if (dmg:GetAttacker():IsPlayer() or dmg:GetAttacker():GetNWEntity("HordeOwner"):IsPlayer()) then
            -- Prevent player / player minions from damaging minions
            return true
        else
            if dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_NERVEGAS then
                dmg:SetDamage(math.min(dmg:GetDamage(), difficulty_poison_headcrab_damage[HORDE.difficulty]))
            end
            
            if target:GetClass() == "npc_turret_floor" then
                dmg:SetDamageForce(Vector(0,0,0))
                target:SetHealth(target:Health() - dmg:GetDamage())
                if target:Health() <= 0 then
                    target:Fire("selfdestruct")
                end
            end
        end
    end
end)
--[[
hook.Add("EntityTakeDamage", "Horde_VJRPGBuff", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and dmg:GetAttacker():IsPlayer() and dmg:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_rpg" then
        dmg:ScaleDamage(5)
    end
end)]]--
-- Fall damage handling
hook.Add("GetFallDamage", "RealisticDamage", function(ply, speed)
    if HORDE.difficulty == difficulty_normal then
        return 10
    elseif HORDE.difficulty == difficulty_hard then
        return math.max(0, math.ceil(0.2418 * speed - 141.75)) / 2
    else
        -- css fall damage
        return math.max(0, math.ceil(0.2418 * speed - 141.75))
    end
end)

-- Non-hook settings
-- Wave count scaling
for i, enemies_count in ipairs(HORDE.total_enemies_per_wave) do
    HORDE.total_enemies_per_wave[i] = math.floor(enemies_count * difficulty_enemy_count_multiplier[HORDE.difficulty])
end

-- Kill reward scaling
HORDE.kill_reward_base = math.floor(HORDE.kill_reward_base * difficulty_reward_base_multiplier[HORDE.difficulty])
HORDE.round_bonus_base = math.floor(HORDE.round_bonus_base * difficulty_reward_base_multiplier[HORDE.difficulty])

-- Start money scaling
HORDE.start_money = math.floor(HORDE.start_money * difficulty_start_money_multiplier[HORDE.difficulty])

-- Spawn density scaling
HORDE.spawn_radius = math.floor(HORDE.spawn_radius * difficulty_spawn_radiuis_multiplier[HORDE.difficulty])

-- Maximum enemies alive scaling
HORDE.difficulty_max_enemies_alive_scale_factor = difficulty_max_enemies_alive_scale_factor[HORDE.difficulty]