if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "AR2"
SWEP.Author = "DrVrej"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
SWEP.Slot = 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos = 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands = true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_HasSecondaryFire = true -- Can the weapon have a secondary fire?
SWEP.NPC_SecondaryFireEnt = "obj_vj_horde_cball"
SWEP.NPC_SecondaryFireDistance = 3000 -- How close does the owner's enemy have to be for it to fire?
SWEP.NPC_SecondaryFireChance = 1 -- Chance that the secondary fire is used | 1 = always
SWEP.NPC_SecondaryFireNext = VJ_Set(1, 3) -- How much time until the secondary fire can be used again?
SWEP.NPC_SecondaryFireSoundLevel = 100
SWEP.NPC_NextPrimaryFire = 3 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire = 0.1 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.HoldType = "ar2"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 0 -- Damage
SWEP.Primary.Force = 0 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize = 30 -- Max amount of bullets per clip
SWEP.Primary.Delay = 0.1 -- Time until it can shoot again
SWEP.Primary.TracerType = "None" -- Tracer type (Examples: AR2, laster, 9mm)
SWEP.Primary.Automatic = true -- Is it automatic?
SWEP.Primary.Ammo = "AR2" -- Ammo type
SWEP.Primary.Sound = {"vj_weapons/hl2_ar2/ar2_single1.wav","vj_weapons/hl2_ar2/ar2_single2.wav","vj_weapons/hl2_ar2/ar2_single3.wav"}
SWEP.Primary.DistantSound = {"^weapons/ar1/ar1_dist1.wav","^weapons/ar1/ar1_dist2.wav"}
SWEP.PrimaryEffects_MuzzleParticles = {"vj_rifle_full_blue"}
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color(0, 31, 225)
	-- ====== Secondary Fire Variables ====== --
--SWEP.Secondary.Ammo = "AR2AltFire" -- Ammo type

SWEP.DryFireSound = {"weapons/ar2/ar2_empty.wav"}
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound				= "weapons/ar2/ar2_reload.wav"
SWEP.Reload_TimeUntilAmmoIsSet	= 0.8 -- Time until ammo is set to the weapon
SWEP.Primary.Tracer = 0
SWEP.Primary.DisableBulletCode = true
SWEP.Secondary.Ammo = "AR2AltFire" -- Ammo type
---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:NPC_SecondaryFire_BeforeTimer(eneEnt, fireTime)
-- 	VJ_EmitSound(self, "weapons/cguard/charging.wav", 100)
-- 	local myPos = self:GetOwner():GetPos()
-- 	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
-- 	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
-- end
-- ---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:NPC_SecondaryFire()
-- 	local owner = self:GetOwner()
-- 	local pos = self:GetNW2Vector("VJ_CurBulletPos")
-- 	local proj = ents.Create(self.NPC_SecondaryFireEnt)
-- 	print("spawn proj")
-- 	proj:SetPos(pos)
-- 	proj:SetAngles(owner:GetAngles())
-- 	proj:SetOwner(owner)
-- 	proj:Spawn()
-- 	proj:Activate()
-- 	local phys = proj:GetPhysicsObject()
-- 	if IsValid(phys) then
-- 		phys:Wake()
-- 		phys:SetVelocity(owner:CalculateProjectile("Line", pos, owner.EnemyData.LastVisiblePos, 1000))
-- 	end

-- 	VJ_CreateSound(self, "weapons/irifle/irifle_fire2.wav", 100)
-- end

function SWEP:NPC_SecondaryFire_BeforeTimer(eneEnt, fireTime)
	VJ.EmitSound(self, "weapons/cguard/charging.wav", 100)
	local myPos = self:GetOwner():GetPos()
	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
end

function SWEP:NPC_SecondaryFire()
	local owner = self:GetOwner()
	local proj = ents.Create(self.NPC_SecondaryFireEnt)
	print("spawn proj")
	proj:SetPos(owner:GetShootPos())
	proj:SetAngles(owner:GetAngles())
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()
	local phys = proj:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetVelocity(owner:GetAimVector() * 1000)
	end
end

function SWEP:NPCShoot_Primary()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end
	local ene = owner:GetEnemy()
	if !owner.VJ_IsBeingControlled && (!IsValid(ene) or (!owner:Visible(ene))) then return end
	if owner.IsVJBaseSNPC then
		owner:UpdatePoseParamTracking()
	end
	
	-- Secondary Fire
	if self.NPC_HasSecondaryFire && owner.Weapon_CanSecondaryFire && CurTime() > self.NPC_SecondaryFireNextT && ene:GetPos():Distance(owner:GetPos()) <= self.NPC_SecondaryFireDistance then
		local anim, animDur, animType = owner:PlayAnim(owner.AnimTbl_WeaponAttackSecondary, true, false, true)
		if animType != VJ.ANIM_TYPE_GESTURE then
			animDur = animDur - 0.5
		end
		local fireTime = (anim == ACT_INVALID and 0) or owner.Weapon_SecondaryFireTime or animDur
		self.NPC_SecondaryFireNextT = CurTime() + fireTime + 0.5 -- Prevent attempting to fire again
		self:NPC_SecondaryFire_BeforeTimer(ene, fireTime)
		timer.Simple(fireTime, function()
			if IsValid(self) && IsValid(owner) && IsValid(owner:GetEnemy()) then -- ONLY check for cur anim IF it even had one!
				self:NPC_SecondaryFire()
				if self.NPC_HasSecondaryFireSound then
					local fireSd = VJ.PICK(self.NPC_SecondaryFireSound)
					if fireSd != false then
						self:EmitSound(fireSd, self.NPC_SecondaryFireSoundLevel, math.random(90, 110), 1, CHAN_WEAPON, 0, 0, VJ_RecipientFilter)
					end
				end
				self.NPC_SecondaryFireNextT = CurTime() + math.Rand(self.NPC_SecondaryFireNext.a, self.NPC_SecondaryFireNext.b)
			end
		end)
		return
	end
	
	-- Primary Fire
	timer.Simple(self.NPC_TimeUntilFire, function()
		if !IsValid(self) then return end
		local curTime = CurTime()
		owner = self:GetOwner()
		if IsValid(owner) && owner:IsNPC() && self:NPC_CanFire() && curTime > self.NPC_NextPrimaryFireT then
			self:PrimaryAttack()
			owner.WeaponLastShotTime = curTime
			if self.NPC_NextPrimaryFire != false then -- Support for animation events
				self.NPC_NextPrimaryFireT = curTime + self.NPC_NextPrimaryFire
				for _, tv in ipairs(self.NPC_TimeUntilFireExtraTimers) do
					timer.Simple(tv, function()
						if !IsValid(self) then return end
						owner = self:GetOwner()
						if IsValid(owner) && owner:IsNPC() && self:NPC_CanFire() then
							self:PrimaryAttack()
						end
					end)
				end
			end
		end
	end)
end

function SWEP:OnPrimaryAttack(status, statusData)
	if CLIENT then return end
	if status == "Init" then
		if SERVER then
			local fireSd = VJ.PICK(self.Primary.Sound)
			if fireSd != false then
				self:EmitSound(fireSd, self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume, CHAN_WEAPON, 0, 0, VJ_RecipientFilter)
				//EmitSound(fireSd, owner:GetPos(), owner:EntIndex(), CHAN_WEAPON, 1, 140, 0, 100, 0, filter)
				//sound.Play(fireSd, owner:GetPos(), self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume)
			end
			if self.Primary.HasDistantSound then
				local fireFarSd = VJ.PICK(self.Primary.DistantSound)
				if fireFarSd != false then
					-- Use "CHAN_AUTO" instead of "CHAN_WEAPON" otherwise it will override primary firing sound because it's also "CHAN_WEAPON"
					self:EmitSound(fireFarSd, self.Primary.DistantSoundLevel, math.random(self.Primary.DistantSoundPitch.a, self.Primary.DistantSoundPitch.b), self.Primary.DistantSoundVolume, CHAN_AUTO, 0, 0, VJ_RecipientFilter)
				end
			end
		end
		local bullet = ents.Create("obj_vj_horde_bullet")
		bullet:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos)
		bullet:SetAngles(self:GetOwner():GetAngles())
		bullet:SetOwner(self:GetOwner())
		bullet:Activate()
		bullet.TracerColor = Color(0, 191, 255)
		bullet.TracerWidth = 20
		bullet:Spawn()
		bullet.DirectDamage = 8
		
		local phy = bullet:GetPhysicsObject()
		if phy:IsValid() then
			local dir = (self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos())
			dir:Normalize()
			dir = dir + VectorRand() * 0.02
			dir:Normalize()
			phy:ApplyForceCenter(dir * 4250)
		end
	end
end