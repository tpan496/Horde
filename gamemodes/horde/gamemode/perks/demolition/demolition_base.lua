PERK.PrintName = "Demolition Base"
PERK.Description = [[
The Demolition class is a crowd-control class that can also provide high single target damage.
Complexity: MEDIUM

{1} increased Blast damage resistance. ({2} + {3} per level, up to {4}).

Regenerate {5} frag grenade every {6} seconds, if you do not have one.]]
PERK.Params = {
    [1] = {percent = true, base = 0.5, level = 0.01, max = 0.75, classname = HORDE.Class_Demolition},
    [2] = {value = 0.5, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.75, percent = true},
    [5] = {value = 1},
    [6] = {value = 30},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "demolition_base" then
        timer.Create("Horde_DemolitionBase" .. ply:SteamID(), 30, 0, function ()
            if not ply:IsValid() or not ply:Alive() then return end
            if not ply:HasWeapon("weapon_frag") then
                ply:Give("weapon_frag", ply:GetAmmoCount("Grenade") > 0)
            end
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "demolition_base" then
        timer.Remove("Horde_DemolitionBase" .. ply:SteamID())
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("demolition_base")  then return end
    if HORDE:IsBlastDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("demolition_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("demolition_base", math.min(0.75, 0.5 + 0.01 * ply:Horde_GetLevel(HORDE.Class_Demolition)))
    end
end