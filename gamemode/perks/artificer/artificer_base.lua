PERK.PrintName = "Artificer Base"
PERK.Description = [[
{1} increased Fire damage. ({2} per level, up to {3}).
{1} increased Lightning damage. ({2} per level, up to {3}).

Equipped with Solar Seal. Upgradable through shop.
LMB: Solar Orb (5/10/20 Energy)
Releases a projectile that deals Fire damage.
HOLD LMB for different effects.

RMB: Solar Storm (10/20/40 Energy)
Releases a powerful lightning strike at the target.
HOLD RMB for different effects.

HOLD SPACE: Hover (3 Energy/s)]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Artificer"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_base" then
        if ply:HasWeapon("horde_solar_seal") == true then return end
        ply:StripWeapons()
        timer.Simple(0, function() ply:Give("horde_solar_seal") end)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("artificer_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Artificer")))
    end
end