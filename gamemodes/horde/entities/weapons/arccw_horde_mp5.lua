if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp5")
    killicon.Add("arccw_horde_mp5m", "arccw/weaponicons/arccw_go_mp5", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - GSO (SMGs)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP5A3"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Popular lightweight 9mm submachine gun used by police and militaries around the world. Well-balanced performance."
SWEP.Trivia_Manufacturer = "Heckler und Koch"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Roller-Delayed Blowback"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1966

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp5.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 33 * 1.25
SWEP.DamageMin = 21 * 1.25 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.275
SWEP.RecoilSide = 0.125
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 800 -- 60 / RPM.
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

SWEP.AccuracyMOA = 9 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "mp5" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/mp5/mp5_unsil.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/mp9/mp9-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_mp5"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.96
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.275

SWEP.IronSightStruct = {
    Pos = Vector(-5.2, -7, 1.5),
    Ang = Angle(0.75, 0.05, 0),
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

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["ubrms"] = {},
    ["tacms"] = {},
    ["go_mp5_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, 13, 4),
            },
            [2] = {
                vpos = Vector(0, 12, 1.75),
            },
            [3] = {
                vpos = Vector(1.65, 8.5, 3.75),
            }
        }
    },
    ["go_mp5_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, 21.5, 4),
            }
        }
    },
    ["go_mp5_barrel_sd"] = {
        VMBodygroups = {
            {ind = 1, bg = 3},
        },
        WMBodygroups = {
            {ind = 1, bg = 3},
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(0, 12, 1.75),
            },
            [3] = {
                vpos = Vector(1.65, 8.5, 3.75),
            }
        }
    },
    ["go_mp5_mag_15"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_mp5_mag_40"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
    ["go_mp5_stock_in"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
        WMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mp5sd_Parent",
                Offset = {
                    pos = Vector(0, -2, 3.75),
                    ang = Angle(0, -90, 0),
                },
            }
        },
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
        WMBodygroups = {
            {ind = 4, bg = 2},
        },
    },
    ["go_mp5_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 4, bg = 3},
        },
        WMBodygroups = {
            {ind = 4, bg = 3},
        },
    },
    ["go_mp5_stock_contractor"] = {
        VMBodygroups = {
            {ind = 4, bg = 4},
        },
        WMBodygroups = {
            {ind = 4, bg = 4},
        },
    },
    ["go_mp5_stock_heavy"] = {
        VMBodygroups = {
            {ind = 4, bg = 5},
        },
        WMBodygroups = {
            {ind = 4, bg = 5},
        },
    },
}

SWEP.Hook_NameChange = function(wep, name)
    local eles = wep:GetActiveElements()

    local prefix = "MP5A"
    local stock = "3"

    for i, k in pairs(eles or {}) do
        if k == "go_mp5_barrel_sd" then
            prefix = "MP5SD"
        elseif k == "go_mp5_stock_heavy" then
            stock = "2"
        elseif k == "go_stock_none" then
            stock = "1"
        elseif k == "go_mp5_barrel_long" then
            prefix = "HK94A"
        end
    end

    return prefix .. stock
end

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local barrel = false
    local tacms = false
    local ubrms = false

    for i, k in pairs(eles or {}) do
        if k == "go_mp5_barrel_sd" then
            barrel = true
        elseif k == "go_mp5_barrel_short" then
            barrel = true
        elseif k == "ubrms" then
            ubrms = true
        elseif k == "tacms" then
            tacms = true
        end
    end

    if tacms then
        if barrel then
            vm:SetBodygroup(7, 2)
        else
            vm:SetBodygroup(7, 1)
        end
    end

    if ubrms then
        if barrel then
            vm:SetBodygroup(6, 2)
        else
            vm:SetBodygroup(6, 1)
        end
    end
end

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.mp5sd_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, 4.5, 5.7),
            vang = Angle(0, -90, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(0, 180, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.mp5sd_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, 12, 2.5),
            vang = Angle(0, -90, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mp5sd_parent",
        Offset = {
            vpos = Vector(1.15, 14, 4.175),
            vang = Angle(0, -90, 90),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_mp5_barrel",
        DefaultAttName = "230mm HK Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mp5sd_parent",
        Offset = {
            vpos = Vector(0, 17, 4),
            vang = Angle(0, -90, 0),
        },
        ExcludeFlags = {"go_mp5_barrel_sd"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_mp5_mag",
        DefaultAttName = "30-Round 9mm MP5"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mp5_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.mp5sd_parent",
        Offset = {
            vpos = Vector(0, -2, 3.75),
            vang = Angle(0, -90, 0),
        },
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
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.mp5sd_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, 3, 2), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 0),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
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
        Time = 0.25,
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
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
}

sound.Add({
    name = "ARCCW_GO_MP5.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_Slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Slideforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_Slideforward.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_cliphit.wav"
})


function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if !self.CanBash and !self:GetBuff_Override("Override_CanBash") then return end
    if CLIENT then return end
    local ply = self:GetOwner()
    local filter = {self:GetOwner()}
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })
    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin(tr.HitPos)
        effectdata:SetRadius(50)
        util.Effect("horde_heal_mist", effectdata)

        for _, ent in pairs(ents.FindInSphere(tr.HitPos, 100)) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New({amount=10, healer=ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount=10, healer=ply})
                HORDE:OnAntlionHeal(ent, healinfo)
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(25)
                dmg:SetDamageType(DMG_NERVEGAS)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(tr.HitPos)
                ent:TakeDamageInfo(dmg)
            end
        end
    end

    ply:EmitSound("horde/weapons/mp7m/heal.ogg", 125, 100, 1, CHAN_AUTO)

    self:SetNextSecondaryFire(CurTime() + 1.5)
    return true
end

function SWEP:Hook_Think()
    if SERVER then return end
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-20, -20, -8),
        maxs = Vector(20, 20, 8),
        mask = MASK_SHOT_HULL
    })

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer()then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center(self.Horde_HealTarget):ToScreen()
		surface.SetDrawColor(Color(50, 200, 50))
        surface.DrawCircle(pos.x, pos.y, 30)
        --surface.DrawLine(pos.x, 0, pos.x, ScrH())
        --surface.DrawLine(0, pos.y, ScrW(), pos.y)
        draw.DrawText(self.Horde_HealTarget:Health(), "Trebuchet24",
        pos.x - 15, pos.y - 15, Color(50, 200, 50), TEXT_ALIGN_LEFT)
    end
end