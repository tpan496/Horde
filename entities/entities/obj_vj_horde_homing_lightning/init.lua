
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
	self:SetMaterial("invis")
	self:SetMoveCollide(3)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_CUSTOM)
	self:SetHealth(1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(1)
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
	
	self.delayRemove = CurTime() + 60
	if self:GetScale() > 1 then self.deploy = CurTime() +0.2 end

    self.Target = nil
    self.NextScale = CurTime()
    self.NextSound = CurTime()
end

function ENT:SetScale(nScale)
	self:SetNetworkedInt("scale", nScale)
end

function ENT:GetScale()
	return self:GetNetworkedInt("scale")
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:OnRemove()
end

function ENT:Think()
    if SERVER and self.NextSound <= CurTime() then
        self:EmitSound("ambient/energy/whiteflash.wav")
        self.NextSound = self.NextSound + 3
    end
    if self.Removing and self.NextScale < CurTime() then
        self:SetScale(self:GetScale() + 3)
        self.NextScale = CurTime() + 0.1
        return
    end
    if self.Target and self.Target:IsValid() then
        local ang = self:GetAngles()
        local desired = ((self.Target:GetPos() + self.Target:OBBCenter()) - self:GetPos()):Angle()
        ang = LerpAngle(0.8, ang, desired)
        self:SetAngles(desired)
        local phys = self:GetPhysicsObject()
        phys:ApplyForceCenter(self:GetForward() * 225)
    end
	if self.deploy && CurTime() >= self.deploy then
		if IsValid(self.entOwner) then
			local pos = self:GetPos()
			for _, ent in pairs(ents.FindInSphere(pos, 600)) do
				if ent:IsPlayer() then
                    self.Target = ent
                    break
				end
			end
		end
	end
	if CurTime() < self.delayRemove then return end

    local dmg = DamageInfo()
    dmg:SetDamage(self:GetScale() * 2)
    dmg:SetDamageType(DMG_SHOCK)
    dmg:SetAttacker(self.entOwner)
    dmg:SetInflictor(self)
    dmg:SetDamagePosition(self:GetPos())
    util.BlastDamageInfo(dmg, self:GetPos(), 150)
    ParticleEffect("vj_explosionspark1", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect("vj_explosionspark2", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect("vj_explosionspark3", self:GetPos(), Angle(0,0,0), nil)

	self:Remove()
end

function ENT:PhysicsCollide(data, physobj)
    if self.Removing then return end
	local ent = data.HitEntity
    if HORDE:IsPlayerOrMinion(ent) then
        self.Removing = true
        self:GetPhysicsObject():EnableMotion(false)
        self:EmitSound("npc/stalker/laser_burn.wav")
    end
    
    timer.Simple(1, function ()
        if !IsValid(self) or !IsValid(self.entOwner) then return end
        if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC()) then
            local dmg = DamageInfo()
            dmg:SetDamage(self:GetScale() * 2)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetAttacker(self.entOwner)
            dmg:SetInflictor(self)
            dmg:SetDamagePosition(data.HitPos)
            util.BlastDamageInfo(dmg, self:GetPos(), 150)
            ParticleEffect("vj_explosionspark1", self:GetPos(), Angle(0,0,0), nil)
            ParticleEffect("vj_explosionspark2", self:GetPos(), Angle(0,0,0), nil)
            ParticleEffect("vj_explosionspark3", self:GetPos(), Angle(0,0,0), nil)

            HORDE:ApplyDebuffInRadius(HORDE.Status_Shock, self:GetPos(), 150, 20, self)
        end
        self:EmitSound("horde/kingpin/electro4.wav", 75, 100)
        self:Remove()
    end)
end

