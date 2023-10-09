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
SWEP.NPC_SecondaryFireNext = VJ_Set(15, 18) -- How much time until the secondary fire can be used again?
SWEP.NPC_SecondaryFireSoundLevel = 100
SWEP.NPC_NextPrimaryFire = 3 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire = 0.1 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.1, 0.2, 0.3, 0.4, 0.5} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
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
function SWEP:NPC_SecondaryFire_BeforeTimer(eneEnt, fireTime)
	VJ_EmitSound(self, "weapons/cguard/charging.wav", 100)
	local myPos = self:GetOwner():GetPos()
	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
	effects.BeamRingPoint(myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPC_SecondaryFire()
	local owner = self:GetOwner()
	local pos = self:GetNW2Vector("VJ_CurBulletPos")
	local proj = ents.Create(self.NPC_SecondaryFireEnt)
	proj:SetPos(pos)
	proj:SetAngles(owner:GetAngles())
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()
	local phys = proj:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetVelocity(owner:CalculateProjectile("Line", pos, owner.EnemyData.LastVisiblePos, 1000))
	end

	VJ_CreateSound(self, "weapons/irifle/irifle_fire2.wav", 100)
end


function SWEP:NPCAbleToShoot()
	local owner = self:GetOwner()
	if IsValid(owner) && owner:IsNPC() then
		local ene = owner:GetEnemy()
		if owner:GetActivity() != nil && ((owner.DoingWeaponAttack == true && ((owner.CurrentWeaponAnimation == owner:GetActivity()) or (owner:GetActivity() == owner:TranslateToWeaponAnim(owner.CurrentWeaponAnimation)) or (!owner.DoingWeaponAttack_Standing)))) then
			-- For VJ Humans only, ammo check
			if owner.AllowWeaponReloading == true && self:Clip1() <= 0 then -- No ammo!
				if self.IsMeleeWeapon == false && self.HasDryFireSound == true && CurTime() > self.NextNPCDrySoundT then
					local sdtbl = VJ_PICK(self.DryFireSound)
					if sdtbl != false then owner:EmitSound(sdtbl, 80, math.random(self.DryFireSoundPitch.a, self.DryFireSoundPitch.b)) end
					if self.NPC_NextPrimaryFire != false then
						self.NextNPCDrySoundT = CurTime() + self.NPC_NextPrimaryFire
					end
				end
				return false
			end
			if IsValid(ene) then
				return true
			end
		end
	end
	return false
end

function SWEP:NPCShoot_Primary()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end
	local ene = owner:GetEnemy()
	if !owner.VJ_IsBeingControlled && (!IsValid(ene) or (!owner:Visible(ene))) then return end
	if owner.IsVJBaseSNPC == true then
		owner:DoPoseParameterLooking()
	end
	
	-- Secondary Fire
	if self.NPC_HasSecondaryFire == true && owner.CanUseSecondaryOnWeaponAttack && !self.NPC_SecondaryFirePerforming && CurTime() > self.NPC_SecondaryFireNextT && ene:GetPos():Distance(owner:GetPos()) <= self.NPC_SecondaryFireDistance then
		if math.random(1, self.NPC_SecondaryFireChance) == 1 then
			local secAnim = VJ_PICK(owner.AnimTbl_WeaponAttackSecondary)
			owner:VJ_ACT_PLAYACTIVITY(secAnim, true, false, true)
			self.NPC_SecondaryFirePerforming = true
			self:NPC_SecondaryFire_BeforeTimer(ene, owner.WeaponAttackSecondaryTimeUntilFire)
			timer.Simple(owner.WeaponAttackSecondaryTimeUntilFire, function()
				if IsValid(self) then
					self.NPC_SecondaryFirePerforming = false
					if IsValid(owner) && IsValid(owner:GetEnemy()) && CurTime() > self.NPC_SecondaryFireNextT then
						self:NPC_SecondaryFire()
						if self.NPC_HasSecondaryFireSound == true then VJ_EmitSound(owner, self.NPC_SecondaryFireSound, self.NPC_SecondaryFireSoundLevel) end
						if self.NPC_SecondaryFireNext != false then -- Support for animation events
							self.NPC_SecondaryFireNextT = CurTime() + math.Rand(self.NPC_SecondaryFireNext.a, self.NPC_SecondaryFireNext.b)
						end
					end
				end
			end)
			return
		else
			self.NPC_SecondaryFireNextT = CurTime() + math.Rand(self.NPC_SecondaryFireNext.a, self.NPC_SecondaryFireNext.b)
		end
	end
	
	-- Primary Fire
	timer.Simple(self.NPC_TimeUntilFire, function()
		if IsValid(self) && IsValid(owner) && self:NPCAbleToShoot() == true && CurTime() > self.NPC_NextPrimaryFireT then
			self:PrimaryAttack()
			if self.NPC_NextPrimaryFire != false then -- Support for animation events
				self.NPC_NextPrimaryFireT = CurTime() + self.NPC_NextPrimaryFire
				for _, tv in ipairs(self.NPC_TimeUntilFireExtraTimers) do
					timer.Simple(tv, function() if IsValid(self) && IsValid(owner) && self:NPCAbleToShoot() == true then self:PrimaryAttack() end end)
				end
			end
			if owner.IsVJBaseSNPC == true then owner.Weapon_TimeSinceLastShot = CurTime() end
		end
	end)
end

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end
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