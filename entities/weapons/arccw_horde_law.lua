if not ArcCWInstalled then return end
if (CLIENT) then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_law")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
	killicon.Add("arccw_horde_law", "vgui/hud/arccw_horde_law", color_white)
    killicon.Add("horde_projectile_law", "vgui/hud/arccw_horde_law", color_white)
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M72 LAW"
SWEP.TrueName = "M72 Light Anti-Armor Weapon"
SWEP.Trivia_Class = "Rocket Launcher"
SWEP.Trivia_Desc = "Portable one-shot 66-mm unguided anti-tank weapon."
SWEP.Trivia_Manufacturer = "NAMMO Defense Systems"
SWEP.Trivia_Calibre = "Rockets"
SWEP.Trivia_Mechanism = "Explosive"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1963

SWEP.Slot = 3

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

sound.Add({
	name = 			"KF_law_lift",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/law/LAW_Reload_006.ogg"
})
sound.Add({
	name = 			"KF_law_open",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 	    "horde/weapons/law/LAW_Reload_040.ogg"
})
sound.Add({
	name = 			"KF_law_insert",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/law/LAW_Reload_076.ogg"
})
sound.Add({
	name = 			"KF_law_close",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/law/LAW_Reload_101.ogg"
})
sound.Add({
	name = 			"KF_law_foley",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/law/LAW_Aim.ogg"
})

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_law.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 12, -10),
    ang = Angle(0, 0, 180),
}
SWEP.ViewModelFOV = 45

SWEP.Damage = 1000
SWEP.DamageMin = 1000 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_law" -- entity to fire, if any
SWEP.MuzzleVelocity = 100000 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 15
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 2

SWEP.Delay = 60 / 100 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "horde/weapons/law/law_fire.ogg"
SWEP.ShootSoundSilenced = "horde/weapons/law/law_fire.ogg"
SWEP.DistantShootSound = "horde/weapons/law/law_fire.ogg"

--SWEP.MuzzleEffect = "muzzleflash_pistol"
--SWEP.ShellModel = "models/shells/shell_9mm.mdl"
--SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.5

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 2),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "rpg"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(-2, 2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 5

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Ammo",
        Slot = "horde_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.1,
        SoundTable = {
            {
            s = "weapons/arccw/draw_secondary.wav",
            t = 0
            }
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
        RestoreAmmo = 1,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 3.2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
}