PERK.PrintName = "Elusive"
PERK.Description = [[
While holding a Pistol weapon:
  {1} increased movement speed.
  Adds {2} evasion.]]
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 0.2, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("gunslinger_elusive") then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE:IsPistolItem(wpn_class) then
        bonus_walk.increase = bonus_walk.increase + 0.2
        bonus_run.increase = bonus_run.increase + 0.2
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("gunslinger_elusive")  then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE:IsPistolItem(wpn_class) then
        bonus.evasion = bonus.evasion + 0.2
    end
end