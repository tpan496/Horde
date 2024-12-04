AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel( "models/weapons/w_slam.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WORLD )
    self:SetBodygroup( 0, 1 )

    timer.Simple( 2, function ()
        if self:IsValid() then
            self:SetTrigger( true )
            self:UseTriggerBounds( true, 150 )

            local expLight = ents.Create( "light_dynamic" )
            expLight:SetKeyValue( "brightness", "1" )
            expLight:SetKeyValue( "distance", "200" )
            expLight:SetLocalPos( self:GetPos() )
            expLight:SetLocalAngles( self:GetAngles() )
            expLight:Fire( "Color", "255 0 0" )
            expLight:SetParent( self )
            expLight:Spawn()
            expLight:Activate()
            expLight:Fire( "TurnOn", "", 0 )
            self:DeleteOnRemove( expLight )

            self:EmitSound( "weapons/slam/mine_mode.wav", 100 )
        end
    end )

    self.Removing = false
    self:PhysWake()
end

local snd = Sound( "npc/roller/mine/rmine_predetonate.wav" )
function ENT:StartTouch( ent )
    if self.Removing then return end
    if ent:IsNPC() and ( not ent:GetNWEntity( "HordeOwner" ):IsValid() ) then
        self.Removing = true
        self:EmitSound( snd, 100 )

        timer.Simple( 1, function ()
            if not self:IsValid() then return end
            self:Detonate()
        end )
    end
end

function ENT:Detonate()
    self.Removing = true
    local pos = self:GetPos()
    local eff = EffectData()
    eff:SetStart( pos )
    eff:SetOrigin( pos )
    util.Effect( "Explosion", eff )
    util.BlastDamage( self, self.Horde_Owner, pos, 100, 200 )

    for _, e in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
        if e:IsNPC() and ( not e:GetNWEntity( "HordeOwner" ):IsValid() ) then
            local dmg = DamageInfo()
            dmg:SetDamage( 100 )
            dmg:SetDamageType( DMG_BLAST )
            dmg:SetAttacker( self.Horde_Owner )
            dmg:SetInflictor( self )
            dmg:SetDamagePosition( e:GetPos() )
            e:TakeDamageInfo( dmg )
        elseif e:GetClass() == "horde_ied" and e ~= self then
            if not e.Removing and e.Horde_Owner == self.Horde_Owner then
                e:Detonate()
            end
        end
    end

    local ply = self.Horde_Owner
    timer.Simple( 2, function ()
        if not ply:IsValid() then return end
        if ply:Horde_GetGadget() ~= "gadget_ied" then return end
        if ply:Horde_GetGadgetCharges() >= 5 then
            ply:Horde_SetGadgetCharges( 5 )
        else
            ply:Horde_SetGadgetCharges( ply:Horde_GetGadgetCharges() + 1 )
        end
    end )
    self:Remove()
end