if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= ".357"
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
SWEP.ViewModel					= "models/weapons/c_357.mdl"
SWEP.WorldModel					= "models/weapons/w_357.mdl"
SWEP.HoldType 					= "revolver"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_HasSecondaryFire = false -- Can the weapon have a secondary fire?
SWEP.NPC_SecondaryFireSound = {"weapons/ar2/ar2_altfire.wav"} -- The sound it plays when the secondary fire is used
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0 -- Damage
SWEP.Primary.ClipSize			= 6 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.9  -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"vj_weapons/hl2_357/357_single1.wav","vj_weapons/hl2_357/357_single2.wav","vj_weapons/hl2_357/357_single3.wav"}
SWEP.Primary.DistantSound		= {"weapons/357/357_fire2.wav"}
SWEP.Primary.DistantSoundVolume	= 0.7 -- Distant sound volume
SWEP.NPC_TimeUntilFireExtraTimers = {0.9, 1.8, 2.7} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_SpawnShells = false
SWEP.NPC_NextPrimaryFire = 4 -- Next time it can use primary fire
	-- ====== Secondary Fire Variables ====== --
SWEP.Secondary.Automatic = false -- Is it automatic?
SWEP.Secondary.Ammo = nil -- Ammo type
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound = false -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound = "weapons/pistol/pistol_reload1.wav"
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
	bullet:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos)
	bullet:SetAngles(self:GetOwner():GetAngles())
	bullet:SetOwner(self:GetOwner())
	bullet.TracerColor = Color(250, 191, 0)
	bullet.TracerWidth = 20
	bullet:Activate()
	bullet:Spawn()
	bullet.DirectDamage = 50

	local phy = bullet:GetPhysicsObject()
	if phy:IsValid() then
		local dir = (self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos())
		dir:Normalize()
		dir = dir + VectorRand() * 0.01
		dir:Normalize()
		phy:ApplyForceCenter(dir * 2500)
	end
end