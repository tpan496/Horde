AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetColor(Color(0,255,0))
    self:SetModel("models/items/flare.mdl")
	
    self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysicsInitBox(Vector(-1,-1,-1), Vector(1,1,1))
	self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
    self.Removing = false

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Touch(entity)
    if not self.Removing and entity:IsPlayer() and entity:Alive() then
        entity:AddMoney(50)
        entity:SyncEconomy()
        entity:EmitSound("items/ammo_pickup.wav")
		self:Remove()
        self.Removing = true
    end
end