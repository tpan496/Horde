ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/weapons/w_bugbait.mdl"
ENT.Ticks = 0
ENT.FuseTime = 10
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil

if SERVER then

function ENT:Initialize()
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.SpawnTime = CurTime()

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

else

function ENT:Think()
    if self.Ticks % 5 == 0 then
        local emitter = ParticleEmitter(self:GetPos())
	    emitter:SetNearClip(16, 48)
        local particle = emitter:Add("particles/smokey", self:GetPos())
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(128, 350))
		particle:SetAirResistance(100)
		particle:SetDieTime(0.3)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(10, 30))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-30, 30))
		particle:SetColor(255, 30, 30)
		particle:SetLighting(true)
        emitter:Finish()
    end

    self.Ticks = self.Ticks + 1
end

end

function ENT:Detonate()
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = 0,
        Tracer = 0,
        Distance = 20000,
        Dir = self:GetVelocity(),
        Src = self:GetPos(),
        Callback = function(att, tr, dmg)
            util.Decal("YellowBlood", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
        end
    })
    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    if colData.HitEntity:IsNPC() and not colData.HitEntity:GetNWEntity("HordeOwner"):IsValid() then
        local ent = colData.HitEntity
        local id = self.Owner:SteamID()
        local owner = self.Owner
        local counter = 0
        ent.Horde_Has_Parasite = owner
        if owner:IsValid() then
            owner:Horde_SetMinionCount(owner:Horde_GetMinionCount() + 1)
        end
        timer.Create("Horde_Parasite" .. id, 0.5, 0, function()
            if not owner:IsValid() or counter >= 20 or not ent:IsValid() then
                timer.Remove("Horde_Parasite" .. id)
                ent.Horde_Has_Parasite = nil
                if owner:IsValid() then
                    owner:Horde_SetMinionCount(owner:Horde_GetMinionCount() - 1)
                end
                return
            end
            local dmg = DamageInfo()
            dmg:SetAttacker(owner)
            dmg:SetInflictor(Entity(0))
            dmg:SetDamageType(DMG_NERVEGAS)
            dmg:SetDamage(15)
            dmg:SetDamagePosition(ent:GetPos())
            ent:TakeDamageInfo(dmg)

            local healinfo = HealInfo:New({amount=2, healer=owner})
            HORDE:OnPlayerHeal(owner, healinfo)
            counter = counter + 1
        end)
        sound.Play("weapons/bugbait/bugbait_impact1.wav", ent:GetPos())
    end
    self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
end