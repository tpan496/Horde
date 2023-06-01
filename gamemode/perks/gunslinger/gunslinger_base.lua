PERK.PrintName = "Gunslinger Base"
PERK.Description = [[
{1} increased Pistol damage. ({2} per level, up to {3}).
Your pistols can be upgraded in shop for increased damage.

Press SHIFT+E to apply Hunter's Mark on an enemy.
Hunter's Mark lasts for 5 seconds.
You can apply 1 Hunter's Mark at a time.
Enemies killed under Hunter's Mark has {4} chance to drop extra cash.

Has access to all pistols.]]
PERK.Icon = "materials/subclasses/gunslinger.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.008, max = 0.20, classname = "Gunslinger"},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.2, percent = true},
    [4] = {value = 0.5, percent = true},
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

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not IsValid(victim.Horde_Has_Hunter_Mark) then return end
    if not victim.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_base") then return end
    local p = math.random()
    if p <= 0.5 then
        local money = ents.Create("horde_money")
        local pos = victim:GetPos()
        local drop_pos = pos
        drop_pos.z = pos.z + 15
        money:SetPos(drop_pos)
        money:DropToFloor()
        money:SetMoney(HORDE.kill_reward_base * 0.5)
        money:Spawn()
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
        if ply:Horde_GetPerk("gunslinger_poach") then
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
        sound.Play("horde/player/hunter_mark.ogg", ply:GetPos(), 70, 100)
        timer.Create("Horde_HunterMarkExpire" .. id, delay, 1, function ()
            net.Start("Horde_RemoveHunterMarkHighlight")
                net.WriteEntity(ent)
            net.Broadcast()
            ent.Horde_Has_Hunter_Mark = nil
        end)
        if ply:Horde_GetPerk("gunslinger_exorcism") then
            if ent.Horde_Mutation then
                local mutations_count = table.Count(ent.Horde_Mutation)
                if mutations_count > 0 then
                    local muts = ent.Horde_Mutation
                    ent:Horde_UnsetMutations()
                    timer.Simple(10, function ()
                        if IsValid(ent) then
                            for mut, _ in pairs(muts) do
                                ent:Horde_SetMutation(mut)
                            end
                        end
                    end)
                    local dmg = DamageInfo()
                    dmg:SetAttacker(ply)
                    dmg:SetInflictor(ply)
                    dmg:SetDamagePosition(ent:GetPos())
                    dmg:SetDamage(ent:GetMaxHealth() * 0.075 * mutations_count)
                    dmg:SetDamageType(DMG_DIRECT)
                    ent:TakeDamageInfo(dmg)
                end
            end
            
            if not ent:Horde_IsElite() then
                local p = math.random()
                if p <= 0.3 then
                    local dmg = DamageInfo()
                    dmg:SetAttacker(ply)
                    dmg:SetInflictor(ply)
                    dmg:SetDamagePosition(ent:GetPos())
                    dmg:SetDamage(ent:GetMaxHealth())
                    dmg:SetDamageType(DMG_DIRECT)
                    ent:TakeDamageInfo(dmg)
                end
            end
        end
    else
        return true
    end
end