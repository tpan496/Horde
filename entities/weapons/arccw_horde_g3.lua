if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_g3")
    killicon.Add("arccw_horde_g3", "arccw/weaponicons/arccw_go_g3", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "G3 (Horde)"
SWEP.Trivia_Class = "Battle Rifle"
SWEP.Trivia_Desc = "Slow-firing, heavy hitting battle rifle with origins tracing back to the end of World War 2. Developed to meet the needs of the newly-formed Bundeswehr."
SWEP.Trivia_Manufacturer = "Heckler und Koch"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "Roller-Delayed Blowback"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1958

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_g3.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_g3.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000000"

SWEP.Damage = 91
SWEP.DamageMin = 75 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 21
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 800

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.800
SWEP.RecoilSide = 0.550
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0.2

SWEP.Delay = 60 / 550 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 2 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/g3sg1/g3sg1_01.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/g3sg1/g3sg1_distant_01.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_g3"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 85
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-4.73312, -8.573, 2.2),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
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

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local barrel = false
    local tacms = false
    local ubrms = false

    for i, k in pairs(eles or {}) do
        if k == "go_g3_barrel_sd" then
            barrel = true
        elseif k == "ubrms" then
            ubrms = true
        elseif k == "tacms" then
            tacms = true
        end
    end

    if tacms then
        if barrel then
            vm:SetBodygroup(8, 2)
        else
            vm:SetBodygroup(8, 1)
        end
    end

    if ubrms then
        if barrel then
            vm:SetBodygroup(7, 2)
        else
            vm:SetBodygroup(7, 1)
        end
    end
end

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["ubrms"] = {},
    ["tacms"] = {},
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_g3_grip_black"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.g3sg1_Parent",
                Offset = {
                    pos = Vector(0, -3.25, -3.25),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_g3_stock_padded"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
    ["go_g3_stock_collapsible"] = {
        VMBodygroups = {
            {ind = 3, bg = 3},
        },
    },
    ["go_g3_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.3, 19),
            }
        }
    },
    ["go_g3_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.3, 24),
            }
        }
    },
    ["go_g3_barrel_sd"] = {
        VMBodygroups = {
            {ind = 1, bg = 3},
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(0, -1.75, 12),
            },
            [3] = {
                vpos = Vector(1.35, -3, 16)
            }
        }
    },
    ["go_g3_mag_10"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_g3_mag_30"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
    },
    ["go_g3_mag_20_556"] = {
        NameChange = "HK33",
        VMBodygroups = {
            {ind = 4, bg = 3},
        },
    },
    ["go_g3_mag_30_556"] = {
        NameChange = "HK33",
        VMBodygroups = {
            {ind = 4, bg = 4},
        },
    },
    ["go_g3_mag_60_556"] = {
        NameChange = "HK33",
        VMBodygroups = {
            {ind = 4, bg = 5},
        },
    },
    ["go_g3_scope"] = {
        NameChange = "G3SG1",
        VMBodygroups = {
            {ind = 9, bg = 1}
        },
    }
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-15, 5.5, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.g3sg1_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.15, -4.9, 2),
            vang = Angle(90 - 0.27, 0, -90),
        },
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(0.1, 0.1, 0),
        MergeSlots = {12}
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.g3sg1_Parent",
        Offset = {
            vpos = Vector(0, -2, 12),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.g3sg1_Parent",
        Offset = {
            vpos = Vector(1.3, -3, 16),
            vang = Angle(90, -1, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_g3_barrel",
        DefaultAttName = "450mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.g3sg1_Parent",
        Offset = {
            vpos = Vector(0, -3.3, 22),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
        ExcludeFlags = {"go_g3_barrel_sd"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_g3_mag",
        DefaultAttName = "20-Round 7.62mm Steel"
    },
    {
        PrintName = "Grip",
        Slot = {"go_g3_grip"},
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Stock",
        Slot = {"go_g3_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.g3sg1_Parent",
        Offset = {
            vpos = Vector(0, -3.25, -3.25),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk",
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.g3sg1_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -2, 3.5), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
    {
        Slot = "go_g3_scope",
        Bone = "v_weapon.g3sg1_Parent",
        Offset = {
            vpos = Vector(0, 2.25, -14),
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
    ["ready"] = {
        Source = "ready",
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
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.9,
        LHIKEaseOut = 0.7,
        Time = 2.5
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.9,
        LHIKEaseOut = 0.7,
        Time = 2.5
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_G3SG1.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_G3SG1.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_G3SG1.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_G3SG1.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_G3SG1.Slideforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_slideforward.wav"
})

sound.Add({
    name = "ARCCW_GO_G3SG1.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/g3sg1/g3sg1_slideback.wav"
})