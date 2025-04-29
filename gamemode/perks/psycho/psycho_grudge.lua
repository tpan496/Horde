PERK.PrintName = "Grudge"
PERK.Description = [[
{1} increased movement speed per {2} health missing, up to {3}.
{4} increased Critical Hit damage per {5} health missing. Tripled with melee crits.
You are considered at {6} health while above {7} health.]]
PERK.Icon = "materials/perks/psycho/grudge.png"
PERK.Params = {
    [1] = {value = 0.01, percent = true},
    [2] = {value = 1},
    [3] = {value = 0.3, percent = true},
    [4] = {value = 0.01, percent = true},
    [5] = {value = 1},
    [6] = {value = 0.7, percent = true},
    [7] = {value = 0.9, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function (ply, bonus_walk, bonus_run)
    if ply:Horde_GetPerk("psycho_grudge") then
        if ply:Health() > ply:GetMaxHealth() * 0.9 then
            bonus_walk.increase = bonus_walk.increase + math.min(0.3, ply:GetMaxHealth() * 0.3 / 100)
            bonus_run.increase = bonus_run.increase + math.min(0.3, ply:GetMaxHealth() * 0.3 / 100)
        else
        local increase = math.min(0.3, math.max(0, 1 - ply:Health() / ply:GetMaxHealth()))
            bonus_walk.increase = bonus_walk.increase + increase
            bonus_run.increase = bonus_run.increase + increase
        end
    end
end

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_grudge") then
        if ply:Health() > ply:GetMaxHealth() * 0.9 and (HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true) then
            bonus.increase = bonus.increase + ply:GetMaxHealth() * 0.3 / 100 * 3
        elseif HORDE:IsMeleeDamage(dmginfo) then
            bonus.increase = bonus.increase + (math.max(0, 1 - ply:Health() / ply:GetMaxHealth())) * 3
        elseif ply:Health() > ply:GetMaxHealth() * 0.9 then
            bonus.increase = bonus.increase + ply:GetMaxHealth() * 0.3 / 100
        else
            bonus.increase = bonus.increase + (math.max(0, 1 - ply:Health() / ply:GetMaxHealth()))
        end
    end
end