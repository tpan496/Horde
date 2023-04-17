GADGET.PrintName = "Healing Beam"
GADGET.Description =
[[Connects a healing beam between the user and target.
If the target is an enemy, leeches health from the target.
If the target is an ally, restores health to the ally.]]
GADGET.Icon = "items/gadgets/healing_beam.png"
GADGET.Duration = 0
GADGET.Cooldown = 2
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if ply:Horde_GetGadget() ~= "gadget_healing_beam" then return end
    local tr = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 400,
        filter = ply,
        mask = MASK_SHOT_HULL,
    })
    if !IsValid(tr.Entity) then
        tr = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 400,
            filter = ply,
            mins = Vector( -16, -16, 0 ),
            maxs = Vector( 16, 16, 0 ),
            mask = MASK_SHOT_HULL,
        })
    end

    if tr.Hit and IsValid(tr.Entity) and (tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:GetClass() == "npc_vj_horde_antlion") and tr.Entity:Health() > 0 then
        if SERVER then
            if ply.Horde_Healing_Beam  and ply.Horde_Healing_Beam:IsValid() then
                ply.Horde_Healing_Beam:Remove()
            end

            if ply.Horde_Healing_BeamTarget and ply.Horde_Healing_BeamTarget:IsValid() then
                ply.Horde_Healing_BeamTarget:Remove()
            end
            local beam = ents.Create("info_particle_system")
            beam:SetOwner(ply)
            local Forward = ply:EyeAngles():Forward()
            local Right = ply:EyeAngles():Right()
            local Up = ply:EyeAngles():Up()
            beam:SetPos(ply:GetShootPos() + Forward * 24 + Right * 8 + Up * -6)
            beam:SetAngles(ply:EyeAngles())
            local beamtarget = ents.Create("tf_target_medigun")
            beamtarget:SetOwner(ply)
            beamtarget:SetPos(tr.Entity:GetPos() + Vector(0, 0, 50))
            beamtarget:Spawn()
            beam:SetKeyValue("cpoint1", beamtarget:GetName())
            ply.Horde_Healing_Beam = beam
            ply.Horde_Healing_BeamTarget = beamtarget
            ply.Horde_Healing_Target = tr.Entity
            if ply.Horde_Healing_Target:IsNPC() and not ply.Horde_Healing_Target:GetNWEntity("HordeOwner"):IsValid() then
                ply.Horde_Healing_Target_Hostile = true
                beam:SetKeyValue("effect_name", "medicgun_beam_red")
            else
                ply.Horde_Healing_Target_Hostile = nil
                beam:SetKeyValue("effect_name", "medicgun_beam_blue")
            end
            beam:Spawn()
            beam:Activate()
            beam:Fire("start", "", 0)
        end
        ply:EmitSound("horde/gadgets/heal_beam.ogg", 125, 100, 0.8, CHAN_AUTO)
    else
        return true
    end
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_healing_beam" then return end
    local id = ply:SteamID()
    timer.Create("Horde_Healing_Beam_Effect" .. id, 0.01, 0, function ()
        if ply.Horde_Healing_Beam and ply.Horde_Healing_BeamTarget and ply.Horde_Healing_Target
        and IsValid(ply.Horde_Healing_Beam) and IsValid(ply.Horde_Healing_BeamTarget) and IsValid(ply.Horde_Healing_Target) then
            local Forward = ply:EyeAngles():Forward()
            local Right = ply:EyeAngles():Right()
            local Up = ply:EyeAngles():Up()
            ply.Horde_Healing_Beam:SetPos(ply:GetShootPos() + Forward * 24 + Right * 8 + Up * -6)
            ply.Horde_Healing_Beam:SetAngles( ply:EyeAngles() )
            ply.Horde_Healing_BeamTarget:SetPos(ply.Horde_Healing_Target:GetPos() + ply.Horde_Healing_Target:OBBCenter())
        else
            if ply.Horde_Healing_Beam and IsValid(ply.Horde_Healing_Beam) then
                ply.Horde_Healing_Beam:Remove()
            end

            if ply.Horde_Healing_BeamTarget and IsValid(ply.Horde_Healing_BeamTarget) then
                ply.Horde_Healing_BeamTarget:Remove()
            end
        end
    end)

    timer.Create("Horde_Healing_Beam_Damage" .. id, 0.5, 0, function ()
        if not ply.Horde_Healing_Target or not ply.Horde_Healing_Target:IsValid() then return end
        if ply.Horde_Healing_Target_Hostile then
            local dmg = DamageInfo()
            dmg:SetDamage(5)
            dmg:SetDamageType(DMG_NERVEGAS)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply.Horde_Healing_Beam)
            dmg:SetDamagePosition(ply.Horde_Healing_Target:GetPos())
            ply.Horde_Healing_Target:TakeDamageInfo(dmg)
            local healinfo = HealInfo:New({amount=1, healer=ply})
            HORDE:OnPlayerHeal(ply, healinfo)
        else
            local healinfo = HealInfo:New({amount=2, healer=ply})
            if ply.Horde_Healing_Target:GetClass() == "npc_vj_horde_antlion" then
                HORDE:OnAntlionHeal(ply.Horde_Healing_Target, healinfo)
            else
                HORDE:OnPlayerHeal(ply.Horde_Healing_Target, healinfo)
            end
        end
        if ply:GetPos():DistToSqr(ply.Horde_Healing_Target:GetPos()) > 250000 then
            ply.Horde_Healing_Target = nil
        end
    end)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_healing_beam" then return end
    local id = ply:SteamID()
    if ply.Horde_Healing_Beam and ply.Horde_Healing_Beam:IsValid() then
        ply.Horde_Healing_Beam:Remove()
    end
    if ply.Horde_Healing_BeamTarget and ply.Horde_Healing_BeamTarget:IsValid() then
        ply.Horde_Healing_BeamTarget:Remove()
    end
    timer.Remove("Horde_Healing_Beam_Effect" .. id)
    timer.Remove("Horde_Healing_Beam_Damage" .. id)
end