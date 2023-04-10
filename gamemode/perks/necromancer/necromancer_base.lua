PERK.PrintName = "Necromancer Base"
PERK.Description = [[
COMPLEXITY: MEDIUM

Inflicts Frostbite buildup by {1} of base Cold damage. ({2} + {3} per level, up to {4}).
{5} increased Cold damage resistance. ({6} per level, up to {7}).

Uses Mind instead of Armor.
Has access to spells for Void Projector.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
    [1] = {percent = true, base = 0.15, level = 0.01, max = 0.4, classname = "Necromancer"},
    [2] = {value = 0.15, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.4, percent = true},
    [5] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Necromancer"},
    [6] = {value = 0.01, percent = true},
    [7] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_base")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("necromancer_base")
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_base") then return end
    if HORDE:IsColdDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmginfo:GetDamage() * (0.15 + ply:Horde_GetPerkLevelBonus("necromancer_base")), ply, dmginfo:GetDamagePosition())
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_base" then
        ply:Horde_SetMindRegenTick(0.25)
        ply:SetMaxArmor(0)
        if ply:HasWeapon("horde_void_projector") == true then return end
        ply:Horde_UnsetSpellWeapon()
        ply:StripWeapons()
        timer.Simple(0, function()
            if !ply:Alive() then return end
            if !ply:Horde_GetPerk("necromancer_base") then return end
            ply:Give("horde_void_projector")
            if (!ply:Horde_GetPrimarySpell() or ( ply:Horde_GetPrimarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetPrimarySpell().Weapon, "horde_void_projector"))) then
                ply:Horde_SetSpell("void_sphere")
            end
            if (!ply:Horde_GetSecondarySpell() or ( ply:Horde_GetSecondarySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetSecondarySpell().Weapon, "horde_void_projector"))) then
                ply:Horde_SetSpell("raise_spectre")
            end
            if (!ply:Horde_GetUtilitySpell() or ( ply:Horde_GetUtilitySpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUtilitySpell().Weapon, "horde_void_projector") )) then
                ply:Horde_SetSpell("illuminate")
            end
            if (ply:Horde_GetUltimateSpell() and ( ply:Horde_GetUltimateSpell().Weapon ~= nil and !table.HasValue(ply:Horde_GetUltimateSpell().Weapon, "horde_void_projector"))) then
                ply:Horde_UnsetSpell(ply:Horde_GetUltimateSpell().ClassName)
            end
            ply:Horde_RecalcAndSetMaxMind()
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_base" then
        ply:Horde_SetMaxMind(0)
        ply:Horde_SetMind(0)
        ply:Horde_SetMindRegenTick(0)
        ply:SetMaxArmor(100)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("necromancer_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Necromancer")))
    end
end