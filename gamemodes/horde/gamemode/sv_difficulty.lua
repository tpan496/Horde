-- Difficulty settings
-- Rule: scale as difficulty/endless.
-- 1 - normal, 2 - hard, 3 - realism

HORDE.CurrentDifficulty = GetConVar( "horde_difficulty" ):GetInt()
if HORDE.Difficulty[HORDE.CurrentDifficulty] == nil then
    HORDE.CurrentDifficulty = 2
end

HORDE.endless = GetConVar( "horde_endless" ):GetInt()
HORDE.additional_pack = 0

-- Difficulty Stuff

local difficulty_normal = 0
local difficulty_hard = 1

-- Endless stuff
HORDE.endless_health_multiplier = 1
HORDE.endless_damage_multiplier = 1

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
            if dmg:IsDamageType(DMG_CRUSH) then
                -- Cap bullshit physics damage that can sometimes occur
                dmg:SetDamage(math.min(dmg:GetDamage(),20))
            end

            local dmgMult = HORDE.Difficulty[HORDE.CurrentDifficulty].damageMultiplier
            if HORDE.endless == 1 then
                dmg:ScaleDamage(dmgMult * HORDE.endless_damage_multiplier)
            else
                dmg:ScaleDamage(dmgMult)
            end

            if dmg:GetAttacker():GetVar("damage_scale") then
                dmg:ScaleDamage(dmg:GetAttacker():GetVar("damage_scale"))
            end
        elseif dmg:GetAttacker():IsPlayer() and dmg:GetAttacker() ~= target then
            -- Prevent PVP
            return true
        elseif dmg:GetAttacker():GetClass() == "mortarshell" then
                return true -- Prevent PVP on certain maps with combine supression devices.
        elseif dmg:IsDamageType(DMG_CRUSH) then
            dmg:SetDamage(math.min(dmg:GetDamage(), 20))
        end
    elseif HORDE:IsPlayerMinion(target) then
        if dmg:GetAttacker():IsPlayer() or HORDE:IsPlayerMinion(dmg:GetAttacker()) then
            -- Prevent player / player minions from damaging minions
            return true
        else
            if dmg:GetAttacker():GetClass() == "npc_headcrab_poison" then
                dmg:SetDamage( math.min( dmg:GetDamage(), HORDE.Difficulty[HORDE.CurrentDifficulty].poisonHeadcrabDamage ) )
            end

            if target:GetClass() == "npc_turret_floor" then
                dmg:SetDamageForce(Vector(0,0,0))
                target:SetHealth(target:Health() - dmg:GetDamage())
                if target:Health() <= 0 then
                    target:Fire("selfdestruct")
                end
            end

            local dmgMult = HORDE.Difficulty[HORDE.CurrentDifficulty].damageMultiplier
            if HORDE.endless == 1 then
                dmg:ScaleDamage(dmgMult * HORDE.endless_damage_multiplier)
            else
                dmg:ScaleDamage(dmgMult)
            end

            if dmg:GetAttacker():GetVar("damage_scale") then
                dmg:ScaleDamage(dmg:GetAttacker():GetVar("damage_scale"))
            end
        end
    elseif target:IsNPC() then
        if not dmg:GetAttacker():IsNPC() then return end
        if target:GetClass() == dmg:GetAttacker() and dmg:GetAttacker() == dmg:GetInflictor() then return true end
        if dmg:IsDamageType(DMG_POISON) and dmg:GetAttacker():GetClass() == "npc_headcrab_poison" then
            dmg:SetDamage(0)
        elseif dmg:IsDamageType(DMG_SHOCK) or dmg:IsDamageType(DMG_REMOVENORAGDOLL) then
            local c = dmg:GetAttacker():GetClass()
            if c == "npc_vj_horde_screecher" or c == "npc_vj_horde_weeper" then
                dmg:SetDamage(0)
            end
        end
    end
end)

-- Fall damage handling
hook.Add("GetFallDamage", "RealisticDamage", function(ply, speed)
    local bonus = {less = 1}
    local dmg = 0
    if HORDE.CurrentDifficulty == difficulty_normal then
        dmg = 10
    elseif HORDE.CurrentDifficulty == difficulty_hard then
        dmg = math.max(0, math.ceil(0.2418 * speed - 141.75)) / 2
    else
        -- css fall damage
        dmg = math.max(0, math.ceil(0.2418 * speed - 141.75))
    end

    hook.Run("Horde_GetFallDamage", ply, speed, bonus)
    return dmg * bonus.less
end)

-- Non-hook settings
-- Wave count scaling
for i, enemies_count in ipairs(HORDE.total_enemies_per_wave) do
    HORDE.total_enemies_per_wave[i] = math.floor(enemies_count * HORDE.Difficulty[HORDE.CurrentDifficulty].enemyCountMultiplier)
end

-- Kill reward scaling
HORDE.kill_reward_base = math.floor(HORDE.kill_reward_base * HORDE.Difficulty[HORDE.CurrentDifficulty].rewardMultiplier)
HORDE.round_bonus_base = math.floor(HORDE.round_bonus_base * HORDE.Difficulty[HORDE.CurrentDifficulty].rewardMultiplier)

-- Start money scaling
HORDE.start_money = math.floor(HORDE.start_money * HORDE.Difficulty[HORDE.CurrentDifficulty].startMoneyMultiplier)

-- Spawn density scaling
HORDE.spawn_radius = math.floor(HORDE.spawn_radius * HORDE.Difficulty[HORDE.CurrentDifficulty].spawnRadiusMultiplier)
