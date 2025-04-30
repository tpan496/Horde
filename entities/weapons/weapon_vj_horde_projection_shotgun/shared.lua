if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "DANK-12"
SWEP.Author = "Dank"
SWEP.Purpose = "Overlord's Clone Weapons."
SWEP.Instructions = "Use on Overlord's Clone."
SWEP.Category = "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	SWEP.Slot = 3 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
	SWEP.SlotPos = 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
	SWEP.UseHands = true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = 0.8 -- Next time it can use primary fire
SWEP.NPC_CustomSpread = 2.5 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
SWEP.NPC_ExtraFireSound = {"weapons/shotgun/shotgun_cock.wav"} -- Plays an extra sound after it fires (Example: Bolt action sound)
SWEP.NPC_FiringDistanceScale = 0.08 -- Changes how far the NPC can fire | 1 = No change, x < 1 = closer, x > 1 = farther
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.HoldType = "shotgun"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 20 -- Damage
SWEP.Primary.PlayerDamage = "Double" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.Force = 1 -- Force applied on the object the bullet hits
SWEP.Primary.NumberOfShots = 8 -- How many shots per attack?
SWEP.Primary.ClipSize = 18 -- Max amount of bullets per clip
SWEP.Primary.Cone = 12 -- How accurate is the bullet? (Players)
SWEP.Primary.Delay = 0.8 -- Time until it can shoot again
SWEP.Primary.Automatic = true -- Is it automatic?
SWEP.Primary.Ammo = "Buckshot" -- Ammo type
SWEP.Primary.Sound = {"weapons/shotgun/shotgun_fire6.wav", "weapons/shotgun/shotgun_fire7.wav"}
SWEP.Primary.DistantSound = "arccw_go/sawedoff/sawedoff-1-distant.wav"
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_ShotgunShell1"
	-- ====== Secondary Fire Variables ====== --
SWEP.Secondary.Automatic = true -- Is it automatic?
SWEP.Secondary.Ammo = "Buckshot" -- Ammo type
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound = true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound = {"weapons/shotgun/shotgun_reload1.wav","weapons/shotgun/shotgun_reload2.wav","weapons/shotgun/shotgun_reload3.wav"}
SWEP.Reload_TimeUntilAmmoIsSet = 0 -- Time until ammo is set to the weapon
SWEP.Primary.Tracer = 0
SWEP.Primary.DisableBulletCode = false
---------------------------------------------------------------------------------------------------------------------------------------------

function SWEP:CustomOnInitialize()
    local owner = self:GetOwner():GetNWEntity("HordeOwner")
    if owner.Horde_Special_Upgrades and owner.Horde_Special_Upgrades["module_paranoia"] then
        self.NPC_FiringDistanceScale = 0.08 * 1.5
        self.NPC_CustomSpread = 2.5 / 1.5
    end
end
