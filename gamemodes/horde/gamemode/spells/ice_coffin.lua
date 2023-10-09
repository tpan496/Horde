SPELL.PrintName      = "Ice Coffin"
SPELL.Weapon         = {"horde_void_projector"}
SPELL.Mind           = {20}
SPELL.Price          = 1500
SPELL.ChargeTime     = {0}
SPELL.ChargeRelease  = true
SPELL.Cooldown       = 20
SPELL.Slot           = HORDE.Spell_Slot_Utility
SPELL.Icon           = "spells/ice_coffin.png"
SPELL.Type           = {HORDE.Spell_Type_Utility}
SPELL.Description    = [[Wraps the user in an ice that provides damage immunity and health regeneration. However, user becomes immobile.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    ply:SetLocalVelocity(Vector(0,0,0))
    ply:EmitSound("horde/weapons/void_projector/ice_cocoon.ogg")
    local p = ents.Create("prop_dynamic")
    p:SetModel("models/props_wasteland/rockgranite02b.mdl")
    p:SetMaterial("spells/effects/frozen")
    p:SetPos(ply:GetPos() + Vector(0,0,1) * 24)
    p:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    p:SetAngles(Angle(0, 180, 0))
    p:SetKeyValue("modelscale", "1.5")
    local ply_pos = ply:GetPos()
    local ply_angles = ply:GetAngles()

    ply:Spectate(OBS_MODE_CHASE)
    ply:SpectateEntity(p)
    ply:SetMoveType(MOVETYPE_NONE)
    ply:DrawViewModel(false)
    ply.Horde_Fake_Respawn = true
    ply.Horde_Invincible = true

    for i = 1, 6 do
        timer.Simple((i-1) * 0.5, function ()
            HORDE:SelfHeal(ply, 5)
        end)
    end

    timer.Simple(3, function ()
        local health = ply:Health()
        local mind = ply:Horde_GetMind()
        ply:UnSpectate()
        ply:DrawViewModel(true)
        p:Remove()
        ply:Spawn()
        ply.Horde_Fake_Respawn = nil
        ply:SetPos(ply_pos)
        ply:SetAngles(ply_angles)
        ply.Horde_Invincible = nil
        timer.Simple(0, function ()
            ply:SetHealth(health)
            ply:Horde_SetMind(mind)
        end)
    end)
end
SPELL.Price = 750