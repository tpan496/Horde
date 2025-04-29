PERK.PrintName = "Psycho Base"
PERK.Description = [[
The Psycho class focuses on dealing critical damage with both melee and ranged weapons.

Adds {1} Base Critical Hit chance. ({2} + {3} per level, up to {4}).
You deal {5} more damage on Critical Hit.

Gain Brutality by hitting enemies with melee attacks, up to {6} stacks.
Each Brutality stack adds {7} Base Critical Hit chance.

Press Shift + E to toggle Frenzy Mode.
Lose {8} health every {9} seconds in Frenzy Mode, down to {10} health.
{11} increased Critical Hit chance in Frenzy Mode.
{12} increased health recovery in Frenzy Mode.

(Recommended to bind, “horde_use_perk_skill” to a key or mouse button)
]]
PERK.Icon = "materials/subclasses/psycho.png"
PERK.Params = {
    [1] = {percent = true, level = 0.006, base = 0.05, max = 0.20, classname = "Psycho"},
    [2] = {value = 0.05, percent = true},
    [3] = {value = 0.006, percent = true},
    [4] = {value = 0.20, percent = true},
    [5] = {value = 0.5, percent = true},
    [6] = {value = 5},
    [7] = {value = 0.05, percent = true},
    [8] = {value = 1},
    [9] = {value = 0.2},
    [10] = {value = 1},
    [11] = {value = 0.5, percent = true},
    [12] = {value = 1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function (ply, perk)
    if SERVER and perk == "psycho_base" then
        ply:Horde_SetMaxBrutalityStack(5)
        ply:Horde_SetPerkCooldown(0)
        ply:Horde_SetPerkInternalCooldown(0)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function (ply, perk)
    if SERVER and perk == "psycho_base" then
        ply:Horde_SetMaxBrutalityStack(0)
        ply:Horde_SetPerkCooldown(0)
        ply:Horde_SetPerkInternalCooldown(0)
        
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        ply.Horde_In_Frenzy_Mode = nil  
        HORDE.SendBorderEffect(ply, {
            id = "Frenzy_Mode_SE",
            time = 0,
        })
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("psycho_base") then
        local crit_rate = ply:Horde_GetPerkLevelBonus("psycho_base")
        local crit_bonus = { increase = 0, more = 1, add = 0 }
        hook.Run("Horde_OnPlayerCriticalCheck", ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
        crit_rate = (crit_rate + crit_bonus.add) * (1 + crit_bonus.increase) * crit_bonus.more
        local p = math.random()
        if p <= crit_rate then
            bonus.more = bonus.more * 1.5
            hook.Run("Horde_OnPlayerCritical", ply, npc, bonus, hitgroup, dmginfo)
            sound.Play("horde/player/crit.ogg", ply:GetPos())
        end
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("psycho_base", math.min(0.20, 0.05 + 0.006 * ply:Horde_GetLevel("Psycho")))
    end
end

PERK.Hooks.PlayerTick = function (ply, mv)
    if ply.Horde_In_Frenzy_Mode and CurTime() >= ply.Horde_HealthDegenCurTime then
        ply:SetHealth(math.max(1, ply:Health() - 1))
        if ply:Horde_GetPerk("psycho_bestial_wrath") then
            ply.Horde_HealthDegenCurTime = CurTime() + 0.3
        else
            ply.Horde_HealthDegenCurTime = CurTime() + 0.2
        end
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("psycho_base") then return end
    if ply.Horde_In_Frenzy_Mode == nil then
        -- Enable Frenzy mode
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        ply.Horde_In_Frenzy_Mode = true
        ply.Horde_HealthDegenCurTime = CurTime()
        --ply:ScreenFade(SCREENFADE.STAYOUT, Color(200, 112, 121, 50), 0.2, 5)
        HORDE.SendBorderEffect(ply, {
            id = "Frenzy_Mode_SE",
            color = Color(200, 112, 121),
            time = 9999,
            alpha = 50,
        })
    else
        -- Disable Frenzy mode
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        ply.Horde_In_Frenzy_Mode = nil 
        --ply:ScreenFade(SCREENFADE.PURGE, Color(200, 112, 121, 0), 0.1, 0.1)
        HORDE.SendBorderEffect(ply, {
            id = "Frenzy_Mode_SE",
            time = 0,
        })
    end
    ply:EmitSound("items/flashlight1.wav", 100, 100, 1, CHAN_AUTO)
end

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply.Horde_In_Frenzy_Mode and ply:Horde_GetPerk("psycho_base") then
        crit_bonus.increase = crit_bonus.increase + 0.5
    end
end

PERK.Hooks.Horde_OnPlayerHeal = function (ply, healinfo)
    if ply.Horde_In_Frenzy_Mode and ply:Horde_GetPerk("psycho_base") then
        healinfo.amount = healinfo.amount * 2
    end
end