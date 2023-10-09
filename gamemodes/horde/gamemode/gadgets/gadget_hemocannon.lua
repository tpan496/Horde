GADGET.PrintName = "Hemocannon"
GADGET.Description =
[[Shoots a projectile at the cost of 10 health.
The projectile travels for a short distance and explodes.
The explosion deals 100 Slashing damage and inflicts Bleeding buildup.
Has a maximum of 5 charges.
Recharges after 5 seconds.]]
GADGET.Icon = "items/gadgets/hemocannon.png"
GADGET.Duration = 0
GADGET.Cooldown = 0.5
GADGET.Charges = 5
GADGET.Active = true
GADGET.Params = {
}

GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hemocannon" then return end
    if ply:Horde_GetGadgetCharges() <= 0 then
        return
    end

    local remain = ply:Health() - 10
    if remain <= 0 then return end

    ply:SetHealth(remain)
    ply:Horde_SetGadgetCharges(ply:Horde_GetGadgetCharges() - 1)

    timer.Simple(5, function ()
        if !ply:IsValid() or ply:Horde_GetGadget() ~= "gadget_hemocannon" then return end
        ply:Horde_SetGadgetCharges(math.min(5, ply:Horde_GetGadgetCharges() + 1))
    end)

    local tracedata = {}
    tracedata.start = ply:GetShootPos()
    tracedata.endpos = ply:GetShootPos() + (ply:GetAimVector() * 500)
    tracedata.filter = ply
    tracedata.mins = Vector(-25,-25,-25)
    tracedata.maxs = Vector(25,25,25)
    local trace = util.TraceHull(tracedata)
    local Distance = ply:GetPos():Distance(trace.HitPos)
    local Ignite = function()
        if not ply:IsValid() then return end
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_SLASH)
        dmg:SetDamage(100)
        util.BlastDamageInfo(dmg, trace.HitPos, 128)

        for _, ent in pairs(ents.FindInSphere(trace.HitPos, 128)) do
            if ent:IsNPC () and (HORDE:IsPlayerOrMinion(ent) ~= true) then
                ent:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 50, ply)
            end
        end
        
        if (SERVER) then
            local firefx = EffectData()
            firefx:SetOrigin(trace.HitPos)
            util.Effect("horde_hemo_explosion",firefx,true,true)
        end
    end
    timer.Simple(math.min(500, Distance)/2000, Ignite)

    local flamefx = EffectData()
    flamefx:SetOrigin(trace.HitPos)
    flamefx:SetStart(ply:GetShootPos())
    util.Effect("horde_hemo_effect",flamefx,true,true)

    sound.Play("physics/body/body_medium_impact_soft" .. tonumber(math.random(2)) ..".wav", ply:GetPos())
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_hemocannon" then return end
    ply:Horde_SetGadgetCharges(5)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_hemocannon" then return end
    ply:Horde_SetGadgetCharges(0)
end