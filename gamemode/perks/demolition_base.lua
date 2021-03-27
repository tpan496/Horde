PERK.PrintName = "Demolition Base"
PERK.Description = "75% increased Blast damage resistance.\nRegenerate 1 frag grenade every 30 seconds, if you do not have one."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "demolition_base" then
        timer.Create("Horde_DemolitionBase" .. ply:SteamID(), 30, 0, function ()
            if not ply:IsValid() then return end
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

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if not ply:Horde_GetPerk("demolition_base")  then return end
    if dmg:GetDamageType() == DMG_BLAST then
        bonus.resistance = bonus.resistance + 0.75
    end
end