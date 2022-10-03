PERK.PrintName = "Maverick"
PERK.Description = [[
While holding a Pistol weapon:
  {1} increased movement speed.
  Adds {2} evasion.]]
PERK.Icon = "materials/perks/gunslinger/maverick.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 0.2, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("gunslinger_maverick") then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE.items[wpn_class] and HORDE.items[wpn_class].category == "Pistol" then
        bonus_walk.increase = bonus_walk.increase + 0.2
        bonus_run.increase = bonus_run.increase + 0.2
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("gunslinger_maverick")  then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE.items[wpn_class] and HORDE.items[wpn_class].category == "Pistol" then
        bonus.evasion = bonus.evasion + 0.2
    end
end