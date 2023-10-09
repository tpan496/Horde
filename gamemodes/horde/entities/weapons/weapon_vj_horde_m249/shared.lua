if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "SMG1"
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
SWEP.ViewModel					= "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.WorldModel					= "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-8, -15, 13)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand" -- The bone it will use as the main point (Owner's bone)
SWEP.WorldModel_Invisible = false -- Should the world model be invisible?
SWEP.WorldModel_NoShadow = false -- Should the world model have a shadow?
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_HasSecondaryFire = false -- Can the weapon have a secondary fire?
SWEP.NPC_SecondaryFireSound = {"weapons/ar2/ar2_altfire.wav"} -- The sound it plays when the secondary fire is used
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0 -- Damage
SWEP.Primary.ClipSize			= 100 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.09 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"arccw_go/m249/m249-1.wav"}
SWEP.Primary.DistantSound		= {"arccw_go/m249/m249-1-distant.wav"}
SWEP.NPC_TimeUntilFireExtraTimers = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_PistolShell1"
SWEP.NPC_NextPrimaryFire = 5 -- Next time it can use primary fire
	-- ====== Secondary Fire Variables ====== --
SWEP.Secondary.Automatic = true -- Is it automatic?
SWEP.Secondary.Ammo = nil -- Ammo type
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound = false -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound = {"weapons/smg1/smg1_reload.wav"}
SWEP.Primary.Tracer = 0
SWEP.Primary.DisableBulletCode = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end
	local bullet = ents.Create("obj_vj_horde_bullet")
	local src = self:GetAttachment(1).Pos
	local dir = (self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos())
	bullet:SetPos(src)
	bullet:SetAngles(self:GetOwner():GetAngles())
	bullet:SetOwner(self:GetOwner())
	bullet:Activate()
	bullet:Spawn()
	bullet.DirectDamage = 6
	if self.Owner.Weaken then
		bullet.Weaken = true
	elseif self.Owner.Hinder then
		bullet.Hinder = true
	end
	
	
	local phy = bullet:GetPhysicsObject()
	if phy:IsValid() then
		dir:Normalize()
		dir = dir + VectorRand() * 0.03
		dir:Normalize()
		phy:ApplyForceCenter(dir * 4000)
	end
end

function SWEP:CustomOnThink()
	if not self.Critical and self:GetOwner() and IsValid(self:GetOwner()) then
		if self:GetOwner().Critical then
			self.NPC_NextPrimaryFire = 3
		end
	end
end