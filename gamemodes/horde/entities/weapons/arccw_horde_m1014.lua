if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m1014")
    killicon.Add("arccw_horde_m1014", "arccw/weaponicons/arccw_go_m1014", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - GSO (SGs)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M1014"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Semi-Automatic tube-fed shotgun used by the US military and various tactical units around the world. The 1998 testing prototypes were named 'XM1014', but after it was accepted into US service, the X was dropped."
SWEP.Trivia_Manufacturer = "Benelli Armi SpA"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Gas-Operated Rotating Bolt"
SWEP.Trivia_Country = "Italy"
SWEP.Trivia_Year = 1998

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_m1014.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_m1014.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "001000000000"

SWEP.Damage = 18
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Num = 8
SWEP.Range = 60 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 350

SWEP.Recoil = 4
SWEP.RecoilSide = 2
SWEP.RecoilRise = 0.1

SWEP.ShotgunReload = true
SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 50 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/xm1014/xm1014-1.wav"
SWEP.ShootSoundSilenced = "arccw_go/m590_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/xm1014/xm1014-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_m3"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-4.30635, -5, 2.8417),
    Ang = Angle(0, 0.05, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.ActivePos = Vector(-1, 0, -1)
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
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.xm1014_Parent",
                Offset = {
                    pos = Vector(0, -2.3, 0.5),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["ubrms"] = {
        VMBodygroups = {
            {ind = 5, bg = 1}
        }
    },
    ["tacms"] = {
        VMBodygroups = {
            {ind = 6, bg = 1}
        }
    },
    ["go_m1014_mag_4"] = {
        VMBodygroups = {
            {ind = 3, bg = 1}
        }
    },
    ["go_m1014_mag_7"] = {
        VMBodygroups = {
            {ind = 3, bg = 2}
        }
    },
    ["go_m1014_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.6, 20),
            }
        }
    },
    ["go_m1014_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.7, 29.5),
            }
        }
    },
}

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local mag = 1
    local barrel = 1
    local bracket = 1

    for i, k in pairs(eles or {}) do
        if k == "go_m1014_barrel_short" then
            barrel = 0
        elseif k == "go_m1014_barrel_long" then
            barrel = 2
        elseif k == "go_m1014_mag_4" then
            mag = 0
        elseif k == "go_m1014_mag_7" then
            mag = 2
        end
    end

    if barrel == 0 then
        bracket = 2
    else
        if mag == 0 then
            bracket = 2
        elseif mag == 1 then
            bracket = 1
        elseif mag == 2 then
            bracket = 0
        end
    end

    vm:SetBodygroup(2, bracket)
end

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 5, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.StripperClipBones = {
    [3] = "v_weapon.xm1014_Shell2",
    [4] = "v_weapon.xm1014_Shell3",
    [5] = "v_weapon.xm1014_Shell4",
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.xm1014_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.03, -4.45, 6),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.xm1014_Parent",
        Offset = {
            vpos = Vector(0, -1.75, 12.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.xm1014_parent",
        Offset = {
            vpos = Vector(0.75, -3.6, 18),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_m1014_barrel",
        DefaultAttName = "450mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.xm1014_Parent",
        Offset = {
            vpos = Vector(0, -3.7, 25.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"no_fh"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_m1014_mag",
        DefaultAttName = "6-Round 12-Gauge Tube"
    },
    {
        PrintName = "Stock",
        Slot = {"go_stock", "go_stock_none"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.xm1014_Parent",
        Offset = {
            vpos = Vector(0, -2.3, 0.5),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Buckshot Shells"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.xm1014_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.75, -3, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "end_reload",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
    ["sgreload_finish_empty"] = {
        Source = "end_reload_empty",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
}

sound.Add({
    name = "ARCCW_GO_M1014.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/xm1014/xm1014_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_M1014.Insertshell",
    channel = 16,
    volume = 1.0,
    sound = {
        "arccw_go/xm1014/xm1014_insertshell_01.wav",
        "arccw_go/xm1014/xm1014_insertshell_02.wav",
        "arccw_go/xm1014/xm1014_insertshell_03.wav"}
})

sound.Add({
    name = "ARCCW_GO_M1014.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_M1014.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_boltforward.wav"
})
