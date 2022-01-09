if not ArcCWInstalled then return end
if (CLIENT) then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_rpg7")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
	killicon.Add("arccw_horde_rpg7", "vgui/hud/arccw_horde_rpg7", color_white)
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "RPG7"
SWEP.TrueName = "Ruchnoy Protivotankoviy Granatomyot"
SWEP.Trivia_Class = "Rocket Launcher"
SWEP.Trivia_Desc = "Designed by the Soviet Union."
SWEP.Trivia_Manufacturer = "???"
SWEP.Trivia_Calibre = "Rockets"
SWEP.Trivia_Mechanism = "Explosive"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = 1958

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModel = "models/vj_weapons/c_rpg7.mdl"
SWEP.WorldModel = "models/vj_weapons/w_ins_rpg7.mdl"
SWEP.ViewModelFOV = 60

SWEP.Damage = 500
SWEP.DamageMin = 500 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "obj_vj_rpg_rocket" -- entity to fire, if any
SWEP.MuzzleVelocity = 2000 -- projectile or phys bullet muzzle velocity

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 5
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 1

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

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "vj_weapons/rpg/rpg_fire.wav"
SWEP.ShootSoundSilenced = "vj_weapons/rpg/rpg_fire_far.wav"
SWEP.DistantShootSound = "vj_weapons/rpg/rpg_fire_far.wav"

--SWEP.MuzzleEffect = "muzzleflash_pistol"
--SWEP.ShellModel = "models/shells/shell_9mm.mdl"
--SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.90
SWEP.SightedSpeedMult = 0.65
SWEP.SightTime = 0.2

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-3, 0, 2),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 0, 0)
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

SWEP.Attachments = {}

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
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
}