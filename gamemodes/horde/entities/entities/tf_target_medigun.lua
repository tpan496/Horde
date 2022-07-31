AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
end

function ENT:Initialize()
if SERVER then
self.Entity:SetModel( "models/hunter/plates/plate.mdl" )
self.Entity:SetMoveType( MOVETYPE_NONE )
self.Entity:SetSolid( SOLID_NONE )
self.Entity:PhysicsInit( SOLID_NONE )
self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
self.Entity:DrawShadow( false )
self.Entity:SetName( self.Entity:GetName().."_"..self.Entity:EntIndex() )
end
end