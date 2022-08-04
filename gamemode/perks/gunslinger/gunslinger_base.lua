PERK.PrintName = "Gunslinger Base"
PERK.Description = [[
{1} increased Pistol damage. ({2} per level, up to {3}).

Press SHIFT+E to apply Hunter's Mark on an enemy.
Hunter's Mark lasts for 5 seconds.
You can apply 1 Hunter's Mark at a time.

Gains access to all Pistols.]]
PERK.Icon = "materials/subclasses/gunslinger.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.008, max = 0.20, classname = "Gunslinger"},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.2, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("gunslinger_base") then return end
    if HORDE:IsCurrentWeapon(dmginfo, "Pistol") == true then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("gunslinger_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("gunslinger_base", math.min(0.20, 0.008 * ply:Horde_GetLevel("Gunslinger")))
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_base" then
        ply:Horde_SetPerkCooldown(1)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Hunter_Mark, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_base" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Hunter_Mark, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)

        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and ent.Horde_Has_Antimatter_Shield then
                net.Start("Horde_Antimatter_Shield_Remove")
                    net.WriteEntity(ent)
                net.Broadcast()
                ent.Horde_Has_Antimatter_Shield = nil
            end
        end
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if CLIENT then return end
    if not ply:Horde_GetPerk("gunslinger_base") then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() and ent:IsNPC() and (not ent:GetNWEntity("HordeOwner"):IsValid()) then
        local range = 640000
        local delay = 5
        if ply:Horde_GetPerk("gunslinger_puncture") then
            range = 2560000
        end
        if ply:Horde_GetPerk("gunslinger_bladerunner") then
            delay = 10
        end
        if ent:GetPos():DistToSqr(ply:GetPos()) > range then
            return true
        end
        if ent.Horde_Has_Hunter_Mark and ent.Horde_Has_Hunter_Mark ~= ply then return true end
        local id = ent:GetCreationID()
        timer.Remove("Horde_HunterMarkExpire" .. id)
        if ply.Horde_Hunter_Mark_Target and ply.Horde_Hunter_Mark_Target:IsValid() and ply.Horde_Hunter_Mark_Target ~= ent then
            timer.Remove("Horde_HunterMarkExpire" .. ply.Horde_Hunter_Mark_Target:GetCreationID())
            net.Start("Horde_RemoveHunterMarkHighlight")
                net.WriteEntity(ply.Horde_Hunter_Mark_Target)
            net.Broadcast()
            ent.Horde_Hunter_Mark_Target = nil
        end
        ent.Horde_Has_Hunter_Mark = ply
        net.Start("Horde_HunterMarkHighlight")
            net.WriteEntity(ent)
        net.Broadcast()
        ply.Horde_Hunter_Mark_Target = ent
        sound.Play("buttons/combine_button1.wav", ply:GetPos(), 70, 100)
        timer.Create("Horde_HunterMarkExpire" .. id, delay, 1, function ()
            net.Start("Horde_RemoveHunterMarkHighlight")
                net.WriteEntity(ent)
            net.Broadcast()
            ent.Horde_Has_Hunter_Mark = nil
        end)
    else
        return true
    end
end