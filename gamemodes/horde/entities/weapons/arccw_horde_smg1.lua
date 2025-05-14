if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_smg1.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_smg1.png")
    killicon.AddAlias("arccw_horde_smg1", "weapon_smg1")
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SMG-1"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "A compact, fully automatic firearm."
SWEP.Trivia_Manufacturer = "Resistance"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Roller-Delayed Blowback"
SWEP.Trivia_Country = "Earth"
SWEP.Trivia_Year = 2007

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 65

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 10
SWEP.DamageMin = 6 -- damage done at maximum range
SWEP.Range = 30 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1000 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 45 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.15
SWEP.RecoilSide = 0.105
SWEP.RecoilRise = 0.05
SWEP.RecoilPunch = 1.5

SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = -12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "SMG1" -- what ammo type the gun uses

SWEP.ShootVol = 80 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = ")weapons/smg1/smg1_fire1.wav"
SWEP.DistantShootSound = "^weapons/smg1/npc_smg1_fire1.wav"
SWEP.ShootSoundSilenced = ")weapons/tmp/tmp-1.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/weapons/rifleshell.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 0.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.275

SWEP.IronSightStruct = {
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0),
    Magnification = 1.5,
    SwitchToSound = "", -- sound that plays when switching to this sight
    ViewModelFOV = 40,
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = false

SWEP.Attachments = {
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "ValveBiped.base",
        Offset = {
            vpos = Vector(0.425, 0.345, 6.935),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "ValveBiped.base",
        Offset = {
            vpos = Vector(0.05, -0.78, 13.5),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(0.8, 0.8, 0.8),
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["fire"] = {
        Source = "fire01",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire01",
        ShellEjectAt = 0,
    },
    ["draw"] = {
        Source = "draw",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "weapons/smg1/smg1_reload.wav", t = 0},
        },
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIconMat)

    surface.DrawTexturedRect(x, y, w, w / 2)
end
