PERK.PrintName = "Artificer Base"
PERK.Description = [[
COMPLEXITY: MEDIUM

Inflicts Shock buildup by {1} of base Lightning damage. ({2} per level, up to {3}).
{1} increased Fire and Lightning damage. ({2} per level, up to {3}).

Equipped with Solar Seal. Upgradable through shop.
LMB: Solar Orb (5/10/20 Energy)
Releases a projectile that deals splashing Fire damage.
HOLD LMB for different effects.

RMB: Solar Storm (5/10/20 Energy)
Strikes at the target, dealing Lightning damage and applies Shock buildup.
HOLD RMB for different effects.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.008, max = 0.2, classname = "Artificer"},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.2, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_base" then
        if ply:HasWeapon("horde_solar_seal") == true then return end
        ply:StripWeapons()
        timer.Simple(0, function() ply:Give("horde_solar_seal") end)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_base") then return end
    if HORDE:IsLightningDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmginfo:GetDamage() * (ply:Horde_GetPerkLevelBonus("artificer_base")), ply, dmginfo:GetDamagePosition())
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("artificer_base")
    elseif HORDE:IsFireDamage(dmginfo) then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("artificer_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("artificer_base", math.min(0.2, 0.008 * ply:Horde_GetLevel("Artificer")))
    end
end