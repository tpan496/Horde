PERK.PrintName = "Warlock Base"
PERK.Description = [[
COMPLEXITY: HIGH

{1} increased maximum energy. ({2} per level, up to {3}).

Equipped with Astral Relic. Upgradable through shop.
LMB: Astral Pulsar (10 Energy)
Releases a homing object that attaches to enemies and deals Physical damage over time.
You can have at most 2 active Astral Pulsars.
HOLD LMB to detonate all active Astral Pulsars.

RMB: Astral Remnant (5 Energy)
Plants energy bodies that explode when enemies are nearby, dealing Physical damage.
You can plant at most 5 active Astral Remnants.
HOLD RMB to charge and refresh duration of all active Astral Remnants.]]
PERK.Icon = "materials/subclasses/warlock.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Warlock"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_base" then
        if ply:HasWeapon("horde_astral_relic") == true then return end
        ply:StripWeapons()
        timer.Simple(0, function() ply:Give("horde_astral_relic") end)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("warlock_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Warlock")))
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_base" then
        if ply:HasWeapon("horde_astral_relic") == true then return end
        ply:StripWeapons()
        timer.Simple(0,
            function()
                local wpn = ply:Give("horde_astral_relic")
                if (not wpn) or (not wpn:IsValid()) then return end
                wpn.Primary.MaxAmmo = 100 + 100 * ply:Horde_GetPerkLevelBonus("warlock_base")
                if ply:Horde_GetPerk("warlock_nucleosynthesis") then
                    wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 50
                end
                if ply:Horde_GetPerk("warlock_dirac_sea") then
                    wpn.Primary.MaxAmmo = wpn.Primary.MaxAmmo + 25
                end
            end
        )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warlock_base" then
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
