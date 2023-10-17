if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = Material("items/hl2/weapon_357.png")
    killicon.AddAlias("arccw_horde_357", "weapon_357")
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "357 (Horde)"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Black Mesa standard issue."

SWEP.Trivia_Manufacturer = "Black Mesa"
SWEP.Trivia_Calibre = ".357 Magnum"
SWEP.Trivia_Mechanism = "Double-Action"
SWEP.Trivia_Country = "Black Mesa"
SWEP.Trivia_Year = 2000

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 25
SWEP.DamageMin = 20
SWEP.RangeMin = 500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Range = 1250 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 6

SWEP.Recoil = 1
SWEP.RecoilSide = 0.75
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 1

SWEP.Delay = 120 / 450 -- 30 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.NPCWeaponType = "weapon_357"
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 120 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			{"weapons/357/357_fire2.wav", "weapons/357/357_fire3.wav"}
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/anaconda.wav"
SWEP.DistantShootSound = "arccw_go/revolver/revolver-1_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.05

SWEP.IronSightStruct = {
    Pos = Vector(-4.7, -10, 0.5),
    Ang = Angle(0, 0, 2),
    ViewModelFOV = 65,
    Magnification = 1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(13.92, 1, -1.08)
SWEP.CustomizeAng = Angle(6.8, 37.7, 10.3)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-10, 25, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["rail"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/pistol_rail.mdl",
                Bone = "v_weapon.223_Parent",
                Offset = {
                    pos = Vector(-0.05, -1.6, 6),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0.95, 0.95, 0.95)
            }
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(-0.05, -1.2, 6),
            }
        }
    },
}

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_perk_pistol"}
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 2/30,
        TPAnim = ACT_HL2MP_IDLE_357,
    },
    ["draw"] = {
        Source = "draw",
        Time = 29/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 33/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire"] = {
        Source = "fire",
        Time = 12/30,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 12/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
						{s = "weapons/pistol/357_reload1.wav", t = 0},
                        {s = "weapons/pistol/357_reload3.wav", t = 0.4},
                        {s = "weapons/pistol/357_reload4.wav", t = 0.8},
					},
        Checkpoints = {24, 97, 131},
        FrameRate = 37,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.6,
        LastClip1OutTime = 1.5,
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIcon)

    surface.DrawTexturedRect(x, y, w, w / 2)
end
