PERK.PrintName = "Artificer Base"
PERK.Description = [[
COMPLEXITY: MEDIUM

Inflicts Lightning buildup by {1} of base Lightning damage. ({2} + {3} per level, up to {4}).
{5} increased Fire and Lightning damage. ({6} per level, up to {7}).

Uses Mind instead of Armor.
Has access to spells for Solar Seal.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {percent = true, base = 0.15, level = 0.01, max = 0.4, classname = "Artificer"},
    [2] = {value = 0.15, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.4, percent = true},
    [5] = {percent = true, base = 0, level = 0.004, max = 0.1, classname = "Artificer"},
    [6] = {value = 0.004, percent = true},
    [7] = {value = 0.1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_base" then
        ply:Horde_SetMindRegenTick(0.25)
        ply:SetMaxArmor(0)
        if ply:HasWeapon("horde_solar_seal") == true then return end
        ply:Horde_UnsetSpellWeapon()
        ply:StripWeapons()
        timer.Simple(0, function()
            if !ply:Alive() then return end
            if !ply:Horde_GetPerk("artificer_base") then return end
            ply:Give("horde_solar_seal")
            if (!ply:Horde_GetPrimarySpell() or ( ply:Horde_GetPrimarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetPrimarySpell().Weapon, "horde_solar_seal") )) then
                ply:Horde_SetSpell("solar_orb")
            end
            if (!ply:Horde_GetSecondarySpell() or ( ply:Horde_GetSecondarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetSecondarySpell().Weapon, "horde_solar_seal") )) then
                ply:Horde_SetSpell("solar_bolt")
            end
            if (!ply:Horde_GetUtilitySpell() or ( ply:Horde_GetUtilitySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUtilitySpell().Weapon, "horde_solar_seal") )) then
                ply:Horde_SetSpell("illuminate")
            end
            if (ply:Horde_GetUltimateSpell() and ( ply:Horde_GetUltimateSpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUltimateSpell().Weapon, "horde_solar_seal") )) then
                ply:Horde_UnsetSpell(ply:Horde_GetUltimateSpell().ClassName)
            end
            ply:Horde_RecalcAndSetMaxMind()
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "artificer_base" then
        ply:Horde_SetMaxMind(0)
        ply:Horde_SetMind(0)
        ply:Horde_SetMindRegenTick(0)
        ply:SetMaxArmor(100)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_base") then return end
    if HORDE:IsLightningDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmginfo:GetDamage() * (0.15 + ply:Horde_GetPerkLevelBonus("artificer_base")), ply, dmginfo:GetDamagePosition())
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("artificer_base")
    elseif HORDE:IsFireDamage(dmginfo) then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("artificer_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("artificer_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Artificer")))
    end
end