PERK.PrintName = "Anti-Matter Shield"
PERK.Description = [[Press Shift+E to deploy a shield on a targeted minion.
The shield absorbs damage up to {1} of the minion's health.
Shield explodes on depletion and has a cooldown of {2} seconds.]]
PERK.Icon = "materials/perks/antimatter_shield.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 3}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_antimatter_shield" then
        ply:Horde_SetPerkCooldown(3)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_AntimatterShield, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_antimatter_shield" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_AntimatterShield, 8)
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
    if not ply:Horde_GetPerk("engineer_antimatter_shield") then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity
    
    if ent:IsValid() then
        if ent:GetPos():DistToSqr(ply:GetPos()) > 250000 then
            return true
        end
        local owner = ent:GetNWEntity("HordeOwner")
        if owner:IsValid() and owner == ply then
            local item = HORDE.items[ent:GetClass()]
            if not item then return end
            ent.Horde_Has_Antimatter_Shield = ent:Health() * 0.05
            util.ParticleTracerEx("vortigaunt_beam", ply:GetPos(), ent:GetPos() + ent:OBBCenter(), true, ply:EntIndex(), -1)
            ent:Horde_SetMaxShieldHealth(ent:Health() * 0.05)
            ent:Horde_SetShieldHealth(ent:Horde_GetMaxShieldHealth())
            net.Start("Horde_Antimatter_Shield_Deploy")
                net.WriteEntity(ent)
            net.Broadcast()
            sound.Play("weapons/physcannon/physcannon_pickup.wav", ply:GetPos())
        else
            return true
        end
    else
        return true
    end
end

PERK.Hooks.Horde_OnMinionDamageTaken = function(target, dmg)
    if CLIENT then return end
    if target:IsNPC() and target.Horde_Has_Antimatter_Shield then
        local health = target:Horde_GetShieldHealth()
        if health > 0 then
            target:Horde_SetShieldHealth(health - dmg:GetDamage())
            if target:Horde_GetShieldHealth() <= 0 then
                net.Start("Horde_Antimatter_Shield_Remove")
                    net.WriteEntity(target)
                net.Broadcast()

                local effectdata = EffectData()
                effectdata:SetOrigin(target:GetPos())
                util.Effect("antimatter_explosion", effectdata)
                if target:GetNWEntity("HordeOwner"):IsValid() then
                    local dd = DamageInfo()
                        dd:SetAttacker(target)
                        dd:SetInflictor(target)
                        dd:SetDamageType(DMG_CRUSH)
                        dd:SetDamage(target.Horde_Has_Antimatter_Shield)
                    if target:GetNWEntity("HordeOwner"):Horde_GetGadget() == "gadget_voidout" then
                        dd:SetDamage(target.Horde_Has_Antimatter_Shield * 2)
                    end
                    util.BlastDamageInfo(dd, target:GetPos(), 200)
                end

                target.Horde_Has_Antimatter_Shield = nil
            end
            return true
        end
    end
end