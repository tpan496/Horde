---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "AR15"
SWEP.Author 					= "func_brush"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is this weapon meant to be for NPCs only?
SWEP.NPC_TimeUntilFire 			= 1
SWEP.NPC_NextPrimaryFire 		= 0.165
SWEP.WorldModel					= "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.HoldType 					= "ar2"
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Angle(-10, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-6, -11, 7)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 41 -- Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "smg1" -- Ammo type
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.Sound				= {")arccw_go/m4a1/m4a1_04.wav"}
SWEP.PrimaryEffects_MuzzleParticles = {"muzzleflash_minimi"}
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_RifleShell1"
