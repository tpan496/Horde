PERK.PrintName = "Demolition Base"
PERK.Description = "The Demolition is a crowd-control class that can also provide high single target damage.\nComplexity: MEDIUM\n\n{1} increased Blast damage resistance.\nRegenerate {2} frag grenade every {3} seconds, if you do not have one."
PERK.Params = {
    [1] = {value = 0.85, percent = true},
    [2] = {value = 1},
    [3] = {value = 30},
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
        bonus.resistance = bonus.resistance + 0.85
    end
end