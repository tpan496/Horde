GADGET.PrintName = "Void Shield"
GADGET.Description = [[Allows you to place a shield on minions that negates damage taken.
The shield explodes on hit, dealing Cold damage equal to 10% of the minion's health.]]
GADGET.Icon = "items/gadgets/voidout.png"
GADGET.Duration = 0
GADGET.Cooldown = 5
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_voidout" then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity
    
    if ent:IsValid() then
        if ent:GetPos():DistToSqr(ply:GetPos()) > 640000 then
            return true
        end
        local owner = ent:GetNWEntity("HordeOwner")
        if owner:IsValid() and owner == ply then
            local item = HORDE.items[ent:GetClass()]
            if not item then return end
            ent.Horde_Has_Void_Shield = ent:Health() * 0.1
            util.ParticleTracerEx("vortigaunt_beam", ply:GetPos(), ent:GetPos() + ent:OBBCenter(), true, ply:EntIndex(), -1)
            net.Start("Horde_Void_Shield_Deploy")
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

GADGET.Hooks.Horde_OnMinionDamageTaken = function(target, dmg)
    if CLIENT then return end
    if target:IsNPC() and target.Horde_Has_Void_Shield then
        net.Start("Horde_Void_Shield_Remove")
            net.WriteEntity(target)
        net.Broadcast()

        local effectdata = EffectData()
        effectdata:SetOrigin(target:GetPos())
        util.Effect("antimatter_explosion", effectdata)
        if target:GetNWEntity("HordeOwner"):IsValid() then
            local dd = DamageInfo()
                dd:SetAttacker(target)
                dd:SetInflictor(target)
                dd:SetDamageType(DMG_REMOVENORAGDOLL)
                dd:SetDamage(target.Horde_Has_Void_Shield)
            util.BlastDamageInfo(dd, target:GetPos(), 200)
        end

        target.Horde_Has_Void_Shield = nil
        return true
    end
end