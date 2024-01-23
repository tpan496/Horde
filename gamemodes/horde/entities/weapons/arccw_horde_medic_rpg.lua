if not ArcCWInstalled then return end
if (CLIENT) then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_rpg7")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_rpg7", "vgui/hud/arccw_horde_rpg7", color_white)
    killicon.Add("horde_projectile_rpg", "vgui/hud/arccw_horde_rpg7", color_white)
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Medic RPG"
SWEP.TrueName = "Medic Missile"
SWEP.Trivia_Class = "Medical Rocket Launcher"
SWEP.Trivia_Desc = "A portable, reusable, unguided, shoulder-launched, anti-tank, rocket-propelled Health launcher."
SWEP.Trivia_Manufacturer = "Vodka and beer"
SWEP.Trivia_Calibre = "Medic Missiles"
SWEP.Trivia_Mechanism = "Healing"
SWEP.Trivia_Country = "Abandoned Mall"
SWEP.Trivia_Year = 2024

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModel = "models/vj_weapons/c_medic_rpg7.mdl"
SWEP.WorldModel = "models/vj_weapons/c_medic_rpg7.mdl"
SWEP.DefaultBodygroups = "00000000"
SWEP.MirrorVMWM = true -- Copy the viewmodel, along with all its attachments, to the worldmodel. Super convenient!

SWEP.WorldModelOffset = {
    pos = Vector(-16.5, 5.5, -8),
    ang = Angle(-5, 0, 180),
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 400
SWEP.DamageMin = 400 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_medic_rpg" -- entity to fire, if any
SWEP.MuzzleVelocity = 2000 -- projectile or phys bullet muzzle velocity

SWEP.CanFireUnderwater = true

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(105, 255, 50)
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

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "vj_weapons/rpg/rpg_fire.wav"
SWEP.ShootSoundSilenced = "vj_weapons/rpg/rpg_fire_far.wav"
SWEP.DistantShootSound = "vj_weapons/rpg/rpg_fire_far.wav"

--SWEP.MuzzleEffect = "muzzleflash_pistol"
--SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 0

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.92
SWEP.SightedSpeedMult = 0.65
SWEP.SightTime = 0.2

--SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.IronSightStruct = {
    Pos = Vector(-3.12, 0, 1.8),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "rpg"
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

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
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
        SoundTable = { { s = "", p = 100, v = 75, t = 0.1, c = CHAN_ITEM, ind = 1, bg = 1, } },
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
        SoundTable = { {  s = "", p = 100, v = 75, t = 0.1, c = CHAN_ITEM, ind = 1, bg = 1, } },
    },
    ["reload"] = {
        Source = "reload",
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
        SoundTable = { { s = "", p = 100, v = 75, t = 1.8, c = CHAN_ITEM, ind = 1, bg = 0, }, },
    },
}

SWEP.ViewModelBoneMods = {
   -- ["missile"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
