if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Annabelle"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel					= "models/weapons/w_annabelle.mdl"
SWEP.HoldType 					= "shotgun"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_HasSecondaryFire = false -- Can the weapon have a secondary fire?
SWEP.NPC_SecondaryFireSound = {"weapons/ar2/ar2_altfire.wav"} -- The sound it plays when the secondary fire is used
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0 -- Damage
SWEP.Primary.ClipSize			= 2 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 2  -- Time until it can shoot again
SWEP.NPC_NextPrimaryFire 		= 2 -- Next time it can use primary fire
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"Weapon_Shotgun.Single"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"Weapon_Shotgun.NPC_Single"}
SWEP.Primary.DistantSoundVolume	= 0.55 -- Distant sound volumeSWEP.Primary.DistantSoundVolume	= 0.7 -- Distant sound volume
SWEP.NPC_TimeUntilFireExtraTimers = {1} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_SpawnShells = true
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_ShotgunShell1"
	-- ====== Secondary Fire Variables ====== --
SWEP.Secondary.Automatic = false -- Is it automatic?
SWEP.Secondary.Ammo = nil -- Ammo type
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
	SWEP.ReloadSound				= {"weapons/shotgun/shotgun_reload1.wav","weapons/shotgun/shotgun_reload2.wav","weapons/shotgun/shotgun_reload3.wav"}
	SWEP.Reload_TimeUntilAmmoIsSet	= 0.5 -- Time until ammo is set to the weapon
	SWEP.Reload_TimeUntilFinished	= 0.5 -- How much time until the player can play idle animation, shoot, etc.	
SWEP.Primary.Tracer = 0
SWEP.Primary.DisableBulletCode = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnSecondaryAttack()
	local owner = self:GetOwner()
	owner:ViewPunch(Angle(-self.Primary.Recoil *3, 0, 0))
	VJ_EmitSound(self, "weapons/ar2/ar2_altfire.wav", 85)

	local proj = ents.Create(self.NPC_SecondaryFireEnt)
	proj:SetPos(owner:GetShootPos())
	proj:SetAngles(owner:GetAimVector():Angle())
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()
	local phys = proj:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetVelocity(owner:GetAimVector() * 2000)
	end
	return true
end

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end
	local bullet = ents.Create("obj_vj_horde_bullet")
	bullet:SetPos(self:GetAttachment(self:LookupAttachment("0")).Pos)
	bullet:SetAngles(self:GetOwner():GetAngles())
	bullet:SetOwner(self:GetOwner())
	bullet.TracerColor = Color(250, 191, 0)
	bullet.TracerWidth = 20
	bullet:Activate()
	bullet:Spawn()
	bullet.DirectDamage = 40

	local phy = bullet:GetPhysicsObject()
	if phy:IsValid() then
		local dir = (self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos())
		dir:Normalize()
		dir = dir + VectorRand() * 0.01
		dir:Normalize()
		phy:ApplyForceCenter(dir * 2500)
	end
end

function SWEP:CustomOnPrimaryAttack_AfterShoot()
	timer.Simple(0.2,function()
		if IsValid(self) && IsValid(self.Owner) && self.Owner:IsPlayer() then
			self.Weapon:EmitSound(Sound("weapons/shotgun/shotgun_empty.wav"),80,100)
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		end
	end)
end
function SWEP:CustomOnThink()

	local owner = self:GetOwner()

	if IsValid(owner) then
		if owner:IsPlayer() then
			self:SetNWVector("EnemyDir", self:EyeAngles():Forward())
		else
			local enemy = self:GetOwner():GetEnemy()

			if IsValid(enemy) && owner:Visible(enemy) && self:Clip1() > 0 then
				self:SetNWVector("EnemyDir", ( (enemy:GetPos() + enemy:OBBCenter()) - (self:GetPos() + self:OBBCenter()) ):GetNormalized() )
			elseif self:Clip1() < 1 then
				self:SetNWVector("EnemyDir", Vector(0,0,0))
			else
				self:SetNWVector("EnemyDir", self:GetAngles():Forward()*-100)
			end
		end
	end
end
if SERVER then return end

SWEP.DefaultRenderBoundsSet = true

local laser2mat = Material("effects/blueblacklargebeam")
local laserdotmat = Material("vj_base/sprites/vj_glow1.vmt")
local laserwidth = 2
local laserMaxDist = 10000

function SWEP:CustomOnDrawWorldModel()
	local laserstartpos = self:GetAttachment(self:LookupAttachment("0")).Pos
	local IdealPos = laserstartpos + self:GetNWVector("EnemyDir") * laserMaxDist

	--if !self.DefaultRenderBoxMins && !self.DefaultRenderBoxMaxs then
		--self.DefaultRenderBoxMins,self.DefaultRenderBoxMaxs = self:GetRenderBounds()
	--end

	if IdealPos != laserstartpos then

		--local sin1 = math.sin(CurTime()*2)*self.SinRandMult1
	--	local sin2 = math.sin(CurTime()*2)*self.SinRandMult2

		if !self.trEndPos then
			self.trEndPos = IdealPos
		end

		self.trEndPos = LerpVector(0.15, self.trEndPos, IdealPos)

		local lasertracer = util.TraceLine({
			start = laserstartpos,
			endpos = self.trEndPos + Vector(sin1,sin2,sin1) * 1,
			mask = MASK_SHOT,
			filter = {self,self:GetOwner()},
		})

		-- render.SetMaterial(laser1mat)
		-- render.SetShadowsDisabled(true)
		-- render.DrawBeam(laserstartpos, lasertracer.HitPos, laserwidth, 0, 20)
	
		render.SetMaterial(laser2mat)
		render.SetShadowsDisabled(true)
		render.DrawBeam(laserstartpos, lasertracer.HitPos, laserwidth, 0, 1, Color(0,100,255))

		render.SetMaterial(laserdotmat)

--		render.DrawSprite(lasertracer.HitPos, laserwidth*3, laserwidth*3, Color(0,200,255))

		--self:SetRenderBoundsWS(laserstartpos, lasertracer.HitPos)
		--self.DefaultRenderBoundsSet = false

	elseif !self.DefaultRenderBoundsSet then

		--self:SetRenderBounds(self.DefaultRenderBoxMins,self.DefaultRenderBoxMaxs)
		--self.DefaultRenderBoundsSet = true
		--print("default render bounds set: " .. tostring(self.DefaultRenderBoxMins) .. ", " .. tostring(self.DefaultRenderBoxMaxs))
	
	end

	return true

end