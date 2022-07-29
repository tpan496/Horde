PERK.PrintName = "Nucleosynthesis"
PERK.Description =
[[{1} increased maximum energy.
Recover {2} energy you used as health.]]
PERK.Icon = "materials/perks/warlock/nucleosynthesis.png"
PERK.Params = {
    [1] = {value = 0.50, percent = true},
    [2] = {value = 0.2, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherRelicPostCast = function(ply, wpn, energy)
    if ply:Horde_GetPerk("warlock_nucleosynthesis") then
        HORDE:SelfHeal(ply, energy * 0.2)
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_nucleosynthesis" then
        local wpn = ply:GetWeapon("horde_astral_relic")
        if (not wpn) or (not wpn:IsValid()) then return end
        wpn.Primary.MaxAmmo = 100 + 100 * ply:Horde_GetPerkLevelBonus("warlock_base")
        if ply:Horde_GetPerk("warlock_nucleosynthesis") then
            wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 50
        end
        if ply:Horde_GetPerk("warlock_dirac_sea") then
            wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 25
        end
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warlock_nucleosynthesis" then
        local wpn = ply:GetWeapon("horde_astral_relic")
        if (not wpn) or (not wpn:IsValid()) then return end
        wpn.Primary.MaxAmmo = 100 + 100 * ply:Horde_GetPerkLevelBonus("warlock_base")
        if ply:Horde_GetPerk("warlock_nucleosynthesis") then
            wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 50
        end
        if ply:Horde_GetPerk("warlock_dirac_sea") then
            wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 25
        end
    end
end
