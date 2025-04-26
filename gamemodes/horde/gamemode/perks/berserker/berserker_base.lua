PERK.PrintName = "Berserker Base"
PERK.Description = [[
The Berserker class is a melee-centered class that can be played both offensively and defensively.
Complexity: HIGH

{1} increased Slashing and Blunt damage. ({2} per level, up to {3}).
{1} increased Global damage resistance. ({2} per level, up to {3}).
{4} increased Movement Speed and Jump height
+{5} damage block.

Aerial Parry: Jump to reduce Physical damage taken by {6}.]]
PERK.Params = {
    [1] = { percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Berserker },
    [2] = { value = 0.008, percent = true },
    [3] = { value = 0.20, percent = true },
    [4] = { value = 0.2, percent = true },
    [5] = { value = 2 },
    [6] = { value = 0.65, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "berserker_base" then
        ply:Horde_SetAerialGuardEnabled(1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "berserker_base" then
        ply:Horde_SetAerialGuardEnabled(0)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "berserker_base" )  then return end
    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus( "berserker_base" )
    bonus.block = bonus.block + 2
end

PERK.Hooks.Horde_OnPlayerDamage = function ( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "berserker_base" ) then return end
    if HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo) then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus( "berserker_base" )
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function ( ply )
    if SERVER then
        ply:Horde_SetPerkLevelBonus( "berserker_base", math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Berserker)) )
    end
end

hook.Add("Horde_PlayerMoveBonus", "Horde_BerserkerSpeed", function (ply, bonus_walk, bonus_run, bonus_jump)
    if not ply:Horde_GetPerk("berserker_base") then return end
    bonus_walk.increase = bonus_walk.increase + 0.2
    bonus_run.increase = bonus_run.increase + 0.2
    bonus_jump.increase = bonus_jump.increase + 0.2
end)