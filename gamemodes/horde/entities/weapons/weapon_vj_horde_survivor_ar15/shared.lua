SWEP.Base 				= "weapon_vj_base"
SWEP.PrintName			= "AR15"
SWEP.Author 			= "func_brush"
SWEP.Contact			= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose			= "This weapon is made for Players and NPCs"
SWEP.Instructions		= "Controls are like a regular weapon."
SWEP.Category			= "Horde"
SWEP.MadeForNPCsOnly	= true
SWEP.HoldType 			= "smg"

SWEP.WorldModel							= "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel_UseCustomPosition		= true
SWEP.WorldModel_CustomPositionAngle 	= Angle(-10, 0, 180)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-6, -11, 7)

SWEP.NPC_NextPrimaryFire 			= 0.165
SWEP.NPC_TimeUntilFire 				= 1

SWEP.NPC_HasReloadSound	= false

SWEP.HasDryFireSound = false

SWEP.Primary.Damage		= 30
SWEP.Primary.Force		= 5
SWEP.Primary.ClipSize	= 30
SWEP.Primary.Ammo		= "SMG1"

SWEP.Primary.Sound				= {")arccw_go/m4a1/m4a1_04.wav"}

SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_minimi"}
SWEP.PrimaryEffects_MuzzleAttachment 	= 1
SWEP.PrimaryEffects_ShellAttachment 	= 2
SWEP.PrimaryEffects_ShellType 			= "VJ_Weapon_RifleShell1"
SWEP.PrimaryEffects_SpawnDynamicLight 	= false

-- All related settings can be found here: https://github.com/DrVrej/VJ-Base/blob/v2.16.0/lua/weapons/weapon_vj_base/shared.lua