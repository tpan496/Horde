PERK.PrintName = "Berserker Base"
PERK.Description = [[
The Berserker class is a melee-centered class that can be played both offensively and defensively.
Complexity: HIGH

{1} increased melee damage. ({2} per level, up to {3}).
{4} increased global damage resistance. ({5} per level, up to {6}).

While on the ground, jump to gain Aerial Parry.
{7} less physical damage taken while Aerial Parry or Active Parry is active.
Lose Aerial Parry when you land on the ground.

Modifiers to Aerial Parry also apply to Active Parry.
Modifiers to melee damage also apply to slashing and blunt damage.

Shift + E to perform Active Parry while airborne or grounded.
Active Parry lasts for {8} second.
Duration is refreshed on successful Active Parry.
Active Parry initially has no cooldown.
Cooldown is increased by {9} second every unsuccessful Active Parry after the first attempt.
Cooldown is reset after successful Active Parry.
Cooldown is reset if you haven’t used Active Parry in the past {10} seconds.

(Recommended to bind, “horde_use_perk_skill” to a key or mouse button)
]]

PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Berserker},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Berserker},
    [5] = {value = 0.008, percent = true},
    [6] = {value = 0.20, percent = true},
    [7] = {value = 0.65, percent = true},
    [8] = {value = 0.5},
    [9] = {value = 1},
    [10] = {value = 5},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
        ply:Horde_SetAerialGuardEnabled(1)
        ply.Horde_Steadfast_Parry_Penalty = 0

        ply:Horde_SetPerkCooldown(0)

        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Steadfast_Parry, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
        ply:Horde_SetAerialGuardEnabled(0)
        ply.Horde_Steadfast_Parry_Penalty = 0
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Steadfast_Parry, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)

        HORDE.SendBorderEffect(ply, {
            time = 0,
        })
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_base") then return end
    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("berserker_base")
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_base") then return end
    if HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("berserker_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("berserker_base", math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Berserker)))
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("berserker_base") then return end
    if ply:Horde_GetSpamPerkCooldown() > CurTime() then return true end
    ply:Horde_SetSpamPerkCooldown(CurTime() + 0.35)

    local r = math.random(90,120)
    ply:EmitSound("npc/roller/blade_out.wav", 40, r, 1, CHAN_AUTO)

    ply:Horde_SetPerkCooldown(0 + ply.Horde_Steadfast_Parry_Penalty)

    ply.Horde_In_Steadfast_Parry = true
    if ply.Horde_Steadfast_Parry_Penalty < 5 then
        ply.Horde_Steadfast_Parry_Penalty = ply.Horde_Steadfast_Parry_Penalty + 1
    end

    local id = ply:SteamID()
    timer.Create("Horde_Steadfast_Parry_Effect" .. id, 0.5, 1, function()
        timer.Remove("Horde_Steadfast_Parry_Effect" .. id)
        if ply:IsValid() then
            ply.Horde_In_Steadfast_Parry = nil
        end
    end)

    timer.Create("Horde_Steadfast_Parry_Penalty_Effect" .. id, 4.75, 1, function()
        timer.Remove("Horde_Steadfast_Parry_Penalty_Effect" .. id)
        if ply:IsValid() then
            ply.Horde_Steadfast_Parry_Penalty = 0
        end
    end)
end