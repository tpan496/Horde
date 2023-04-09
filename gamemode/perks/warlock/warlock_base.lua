PERK.PrintName = "Warlock Base"
PERK.Description = [[
COMPLEXITY: HIGH

{1} increased maximum Mind. ({2} per level, up to {3}).

Uses Mind instead of Armor.
Has access to spells for Astral Relic.]]
PERK.Icon = "materials/subclasses/warlock.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Warlock"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("warlock_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Warlock")))
    end
end

PERK.Hooks.Horde_OnSetMaxMind = function(ply, bonus)
    if ply:Horde_GetPerk("warlock_base") then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("warlock_base")
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_base" then
        ply:Horde_SetMindRegenTick(0.25)
        ply:SetMaxArmor(0)
        if ply:HasWeapon("horde_astral_relic") == true then return end
        ply:Horde_UnsetSpellWeapon()
        ply:StripWeapons()
        timer.Simple(0, function()
            if !ply:Alive() then return end
            if !ply:Horde_GetPerk("warlock_base") then return end
            ply:Give("horde_astral_relic")
            if (!ply:Horde_GetPrimarySpell() or ( ply:Horde_GetPrimarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetPrimarySpell().Weapon, "horde_astral_relic"))) then
                ply:Horde_SetSpell("meteor")
            end
            if (!ply:Horde_GetSecondarySpell() or ( ply:Horde_GetSecondarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetSecondarySpell().Weapon, "horde_astral_relic"))) then
                ply:Horde_SetSpell("sigil_of_arcana")
            end
            if (!ply:Horde_GetUtilitySpell() or ( ply:Horde_GetUtilitySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUtilitySpell().Weapon, "horde_astral_relic") )) then
                ply:Horde_SetSpell("illuminate")
            end
            if (ply:Horde_GetUltimateSpell() and ( ply:Horde_GetUltimateSpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUltimateSpell().Weapon, "horde_astral_relic"))) then
                ply:Horde_UnsetSpell(ply:Horde_GetUltimateSpell().ClassName)
            end
            ply:Horde_RecalcAndSetMaxMind()
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warlock_base" then
        ply:Horde_SetMaxMind(0)
        ply:Horde_SetMind(0)
        ply:Horde_SetMindRegenTick(0)
        ply:SetMaxArmor(100)
    end
end
