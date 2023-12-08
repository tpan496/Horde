
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

local physMin = Vector( -2, -2, -2 )
local physMax = Vector( 2, 2, 2 )

function ENT:Initialize()	
	self:SetModel("models/crossbow_bolt.mdl")
	self:PhysicsInitBox( physMin, physMax )
	
	self:SetMoveCollide(3)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_CUSTOM)
	self:SetHealth(1)	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
		phys:EnableGravity(false)
		phys:Wake()
	end

	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(255,255,0,255))

	self.delayRemove = CurTime() + 60
	if self:GetScale() > 1 then self.deploy = CurTime() + 0.2 end

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
    self:StopSound("ambient/energy/whiteflash.wav")
    self.NextSound = nil
    self:Remove()
end

function ENT:Think()
    if SERVER and not IsValid(self.entOwner) then 
	    self:Remove()
        return
    end
	
    if SERVER and self.NextSound <= CurTime() and self:IsValid() then
        self:EmitSound("ambient/energy/whiteflash.wav")
        self.NextSound = self.NextSound + 3
    end
	
    if self.NextScale < CurTime() and self:GetScale() < 6 then
        self:SetScale(self:GetScale() + 1)
        self.NextScale = CurTime() + 3
        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos() + self:OBBCenter())
        effectdata:SetScale(10)
        effectdata:SetMagnitude(10)
        local data = EffectData();
        data:SetOrigin(self:GetPos() + self:OBBCenter())
        util.Effect("StunstickImpact", data);
        util.Effect( "horde_status_shock", data, true, true )
        return
    end
	
    local phys = self:GetPhysicsObject()
    if self.Target and self.Target:IsValid() and phys:IsValid() then
        local ang = self:GetAngles()
        local desired = ((self.Target:GetPos() + self.Target:OBBCenter()) - self:GetPos()):Angle()
        ang = LerpAngle(0.8, ang, desired)
        self:SetAngles(desired)
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
    dmg:SetDamage(self:GetScale() * 3)
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
    if not ent:IsValid() then return end
    if HORDE:IsPlayerOrMinion(ent) then
        self.Removing = true
        self:GetPhysicsObject():EnableMotion(false)
        self:EmitSound("npc/stalker/laser_burn.wav")
    end

    timer.Simple(0.0001, function ()
        if !IsValid(self) or !IsValid(self.entOwner) then return end
        if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC()) then
            local dmg = DamageInfo()
            dmg:SetDamage(self:GetScale() * 3)
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
