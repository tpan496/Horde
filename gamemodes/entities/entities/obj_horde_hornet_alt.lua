AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    if SERVER then
        self:SetMaxHealth(30)
        self:SetHealth(30)
    end
    self:SetModel( "models/horde/hornet/hornet.mdl" )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
    self:DrawShadow( false )
    self.SoundTimer = CurTime()
    self.RemoveTimer = CurTime() + 3
    if SERVER then
    util.SpriteTrail( self, 0, Color( 255, 200, 0 ), false, 5, 0, 2.5, 0.04, "trails/smoke.vmt" )
    end
end

function ENT:Think()
    if self.Removing then return end
    if self.SoundTimer <= CurTime() then
    self:EmitSound( "Weapon_HL_Hivehand.Buzz" )
    self.SoundTimer = CurTime() + 1
    end
    if SERVER and self.RemoveTimer <= CurTime() then
        self:Remove()
    end
end

function ENT:PhysicsCollide( data )
    if self.Removing then return end
    local dmg = DamageInfo()
    local owner = self:GetOwner()
    if !IsValid( self ) then
        owner = self
    end
    dmg:SetAttacker( owner )
    dmg:SetInflictor( self )
    dmg:SetDamage( 40 )
    dmg:SetDamageType( DMG_BULLET )
    data.HitEntity:TakeDamageInfo( dmg )
    if SERVER then
        self:Remove()
        self.Removing = true
    end
end

function ENT:OnRemove()
    if SERVER then
        self.Owner:Horde_SetMinionCount(self.Owner:Horde_GetMinionCount() - 1)
    end
    self:EmitSound( "Weapon_HL_Hivehand.Hit" )
end