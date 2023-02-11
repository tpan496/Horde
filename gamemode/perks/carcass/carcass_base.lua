PERK.PrintName = "Carcass Base"
PERK.Description = [[
The Carcass class uses its high health and regeneration for various effects.
Complexity: HIGH

{1} increased maximum health. ({2} per level, up to {3}).

{4} chance to gain Hypertrophy when you hit an enemy ({5} chance on headshot).
100% chance to gain Hypertrophy when you are hit.
Hypertrophy reduces Physical damage taken by {6}.
Hypertrophy provides 2% health regen per second.

Equipped with Carcass Biosystem.
Cannot use any other weapons other than medkits because your hands are fucked.
LMB: Punch
Hold for a charged punch that deals increased damage in an area.]]
PERK.Icon = "materials/subclasses/carcass.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.02, max = 0.5, classname = "Carcass"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {value = 0.5, percent = true},
    [5] = {value = 0.75, percent = true},
    [6] = {value = 0.05, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_base" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 1)
        if ply:HasWeapon("horde_carcass") == true then return end
        ply:StripWeapons()
        timer.Simple(0, function() ply:Give("horde_carcass") end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_base" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 1)
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("carcass_base") then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("carcass_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("carcass_base", math.min(0.5, 0.02 * ply:Horde_GetLevel("Carcass")))
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("carcass_base") then return end
    if ply:Horde_GetMaxHypertrophyStack() <= 0 then return end
    ply:Horde_AddHypertrophyStack()
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("carcass_base") and HORDE:IsPhysicalDamage(dmginfo) then
        local p = math.random()
        if ply:Horde_GetPerk("carcass_anabolic_gland") then
            if hitgroup == HITGROUP_HEAD then
                ply:Horde_AddHypertrophyStack()
            else
                if p <= 0.75 then
                    ply:Horde_AddHypertrophyStack()
                end
            end
        else
            if hitgroup == HITGROUP_HEAD then
                if p <= 0.75 then
                    ply:Horde_AddHypertrophyStack()
                end
            else
                if p <= 0.5 then
                    ply:Horde_AddHypertrophyStack()
                end
            end
        end
    end
end