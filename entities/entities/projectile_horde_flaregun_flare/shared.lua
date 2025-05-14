ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/crossbow_bolt.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PLAYER
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER
ENT.Removing = nil

ENT.FlareDamage = 50
ENT.FlareUpgrade = 1

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:DrawShadow( true )
        self:PhysicsInitSphere(5)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetMass(1)
            phys:SetBuoyancyRatio(0)
            phys:EnableDrag(false)
            phys:EnableGravity(false)
        end

        self.SpawnTime = CurTime()

        self.ENVFlare = ents.Create("env_flare")
        self.ENVFlare:SetPos(self:GetPos())
        self.ENVFlare:SetAngles(self:GetAngles())
        self.ENVFlare:SetParent(self)
        self.ENVFlare:SetKeyValue("Scale","1")
        self.ENVFlare:SetKeyValue("spawnflags","4")
        self.ENVFlare:Spawn()

        --self:EmitSound(self.IdleSound1, 75)

        timer.Simple(2,function()
            if IsValid(self) then
                phys:SetMass(5)
                phys:EnableGravity(true)
            end
        end)
    else
        self:SetColor(Color(255, 0, 0))
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end

        self:Detonate(data)
    end
end

function ENT:Detonate(data)
    if !SERVER then return end
    if !self:IsValid() or self.Removing then return end
    local ply = self.Owner
            if ply:Horde_GetCurrentSubclass() == "Gunslinger" then
                local level = ply:Horde_GetUpgrade("arccw_horde_flaregun")
                self.FlareUpgrade = 1 + (level * 0.03)
            end
	if IsValid(data.HitEntity) && (data.HitEntity:IsNPC() or data.HitEntity:IsPlayer()) && !self.Removing then
		self:FireBullets({
			Attacker = self.Owner,
			Damage = self.FlareDamage * self.FlareUpgrade,
			Tracer = 0,
			Distance = 200,
			Dir = (data.HitPos - self:GetPos()),
			Src = self:GetPos(),
			Callback = function(att, tr, dmg)
				dmg:SetDamageType(DMG_BURN)
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)

                if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) then
                    if data.HitEntity:IsNPC() then
                        data.HitEntity:TakeDamageInfo(dmg)
                    end
                end
                
                if data.HitEntity:IsNPC() and HORDE:IsEnemy(data.HitEntity) then
                    data.HitEntity:Horde_SetIgniteDamage(math.max(2, (self.FlareDamage * self.FlareUpgrade) * 0.03))
                end
            end
		})
	end

    util.Decal("FadingScorch", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
    self:Remove()
end