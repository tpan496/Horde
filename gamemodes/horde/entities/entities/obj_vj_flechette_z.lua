AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Flechette"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/weapons/hunter_flechette.mdl"}

ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 8 -- How much damage should it do when it hits something
ENT.DirectDamageType = bit.bor(DMG_NEVERGIB, DMG_SHOCK) -- Damage type

ENT.CollideCodeWithoutRemoving = true
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 75 255" )
	light:SetPos( self:GetAttachment(1).Pos )
	light:SetParent( self, 1 )
	light:SetKeyValue( "scale","0.12" )
	light:SetKeyValue( "rendermode","9" )
	light:Spawn()
	self:DeleteOnRemove(light)

	self:DrawShadow(false)

	ParticleEffectAttach("hunter_flechette_trail_striderbuster",PATTACH_ABSORIGIN_FOLLOW,self,0)


end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:SetMass(0.1)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

	local parent = self:GetParent()
	if parent:IsPlayer() && !parent:Alive() then
		self:Remove()
	end

	if self:WaterLevel() > 0 then
		self:GetPhysicsObject():EnableGravity(true)
		self:Explode()
	end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Explode()

	local time_until_explode = 3
	local blastradius = 100

	sound.EmitHint(SOUND_DANGER,self:GetPos(),blastradius*1.5,time_until_explode,self)

	timer.Simple(time_until_explode*0.5, function() if IsValid(self) then
		self:EmitSound("npc/ministrider/hunter_flechette_preexplode" .. math.random(1, 2) .. ".wav" , 70, math.random(70, 90))
	end end)

	timer.Simple(time_until_explode, function() if IsValid(self) then

		local realisticRadius = false

		self:EmitSound("npc/ministrider/flechette_explode" .. math.random(1, 3) .. ".wav" , 100, math.random(110, 130), 0.66,  CHAN_WEAPON)

		ParticleEffect("hunter_projectile_explosion_1", self:GetPos(), Angle(0,0,0))
		self:DeathEffects()

		local expLight = ents.Create("light_dynamic")
		expLight:SetKeyValue("brightness", "3")
		expLight:SetKeyValue("distance", "250")
		expLight:Fire("Color", "0 75 255")
		expLight:SetPos(self:GetPos())
		expLight:Spawn()
		expLight:Fire("TurnOn", "", 0)
		timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)

		local attacker = self:GetOwner()
		if !IsValid(attacker) then attacker = self end

    	util.VJ_SphereDamage(attacker, self, self:GetPos(), blastradius, self.DirectDamage, bit.bor(DMG_DISSOLVE, DMG_SHOCK), true, realisticRadius)

		self:Remove()

	end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsAlly(ent)

    if !ent.VJ_NPC_Class then return end

    for _,npcclass in pairs(ent.VJ_NPC_Class) do
        for _,mynpcclass in pairs(self.VJ_NPC_Class) do
            if npcclass == mynpcclass then
                return true
            end
        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCollideWithoutRemove(data, phys)

	local hitent = data.HitEntity

	if self:IsAlly(hitent) then
		self:Remove()
		return
	end

	if hitent:IsWorld() then

		self:EmitSound("npc/ministrider/flechette_impact_stick" .. math.random(1, 5) .. ".wav" , 85, math.random(90, 110))

		self:SetPos(data.HitPos)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)

		self:Explode()

		self:FireBullets({
			Src = self:GetPos(),
			Dir = self:GetForward(),
			Tracer = 0,
			Damage = 0,
			Distance = 25,
		})

	else

		self:EmitSound("npc/ministrider/flechette_flesh_impact" .. math.random(1, 4) .. ".wav" , 85, math.random(90, 110))


			if hitent:GetClass() == "func_breakable_surf" then
				hitent:Fire("Shatter")
			end

			self:DeathEffects()
			self:Remove()
		end

	end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects()
	ParticleEffect("Weapon_Combine_Ion_Cannon_i",self:GetPos(),Angle(0,0,0))
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------