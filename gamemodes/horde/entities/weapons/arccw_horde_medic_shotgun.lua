if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_kf1trench")
    killicon.Add("arccw_horde_medic_shotgun", "arccw/weaponicons/arccw_kf1trench", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Medic Shotgun"
SWEP.TrueName = "Medic Model 1897"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "A pump-action shotgun that fires buckshot rounds that heal other players."
SWEP.Trivia_Manufacturer = "Winchester"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1897

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_kf_trench.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.ViewModelFOV = 45

SWEP.Damage = 30
SWEP.DamageMin = 15
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false
SWEP.ShotgunReload = true

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 4

SWEP.Recoil = 3
SWEP.RecoilSide = 2
SWEP.VisualRecoilMult = 3
SWEP.RecoilRise = 2
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 60 -- 60 / RPM.
SWEP.Num = 10 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
	    PrintName = "PUMP",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 40 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "KF_trench.Fire"
SWEP.ShootSoundSilenced = "weapons/fesiugmw2/fire/shot_sil.wav"
SWEP.DistantShootSound = "KF_trench.Fire"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 1.5),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-1, -2, 1.5)
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

SWEP.ManualAction = true

SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "TrenchGun",
        Offset = {
            vpos = Vector(45, 0, 3.1),
            vang = Angle(0, 0, 0),
            wpos = Vector(10, 0.8, -5.5),
            wang = Angle(-5, 1, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "TrenchGun",
        Offset = {
            vpos = Vector(40, 0, 2),
            vang = Angle(0, 0, 0),
            wpos = Vector(9, 1, -4.5),
            wang = Angle(-5, 1, 180)
        },
        VMScale = Vector(1.2, 1.2, 1.2),
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
	{
        PrintName = "Charms",
        Slot = "charm",
        Bone = "TrenchGun",
        Offset = {
            vpos = Vector(12, -0.8, 3),
            vang = Angle(0, 0, 0),
            wpos = Vector(7, 2, -4.5),
            wang = Angle(-5, 1, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["enter_sight"] = {
        Source = "idle",
        Time = 0,
        },
    ["idle_sights"] = {
        Source = "idle",
        Time = 0,
        },
        ["exit_sight"] = {
            Source = "idle",
            Time = 0,
            },
    ["draw"] = {
        Source = "draw",
        Time = 0.5,
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
        Source = "idle",
        Time = 10,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 10,
        ShellEjectAt = 0,
    },
	["cycle"] = {
        Source = "shoot",
        Time = 0.9,
        ShellEjectAt = 0,
    },
    ["cycle_iron"] = {
        Source = "shoot",
        Time = 0.7,
        ShellEjectAt = 0,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        Time = 0.2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "reload_end",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_end",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
}

function SWEP:DoPrimaryFire(isent, data)
    local clip = self:Clip1()
    if self:HasBottomlessClip() then
        clip = self:Ammo1()
    end
    local owner = self:GetOwner()

    local shouldphysical = GetConVar("arccw_bullet_enable"):GetBool()

    if self.AlwaysPhysBullet or self:GetBuff_Override("Override_AlwaysPhysBullet") then
        shouldphysical = true
    end

    if self.NeverPhysBullet or self:GetBuff_Override("Override_NeverPhysBullet") then
        shouldphysical = false
    end

    if isent then
        self:FireRocket(data.ent, data.vel, data.ang, self.PhysBulletDontInheritPlayerVelocity)
    else
        -- if !game.SinglePlayer() and !IsFirstTimePredicted() then return end
        if !IsFirstTimePredicted() then return end

        if shouldphysical then
            local vel = self:GetBuff_Override("Override_PhysBulletMuzzleVelocity") or self.PhysBulletMuzzleVelocity

            local tracernum = data.TracerNum or 1
            local prof

            if tracernum == 0 or clip % tracernum != 0 then
                prof = 7
            end

            if !vel then
                vel = math.Clamp(self:GetBuff("Range"), 30, 300) * 8

                if self.DamageMin > self.Damage then
                    vel = vel * 3
                end
            end

            vel = vel / ArcCW.HUToM

            vel = vel * self:GetBuff_Mult("Mult_PhysBulletMuzzleVelocity") * self:GetBuff_Mult("Mult_Range")

            vel = vel * GetConVar("arccw_bullet_velocity"):GetFloat()

            vel = vel * data.Dir:GetNormalized()

            ArcCW:ShootPhysBullet(self, data.Src, vel, prof)
        else
            if owner:IsPlayer() then
                owner:LagCompensation(true)
            end
            self:FireBullets(data)
            if owner:IsPlayer() then
                owner:LagCompensation(false)
            end
        end
    end
end

hook.Add("Hook_BulletHit", "Horde_MedicShotgunHeal", function(wpn, data)
    if wpn:GetClass() ~= "arccw_horde_medic_shotgun" then return end
        if SERVER then
            if (data.tr.Entity:IsPlayer()) then
                data.Damage = 0
                local healinfo = HealInfo:New({amount=5, healer=wpn:GetOwner()})
                HORDE:OnPlayerHeal(data.tr.Entity, healinfo)
            end
        end
        if CLIENT then
            local emitter = ParticleEmitter(data.tr.HitPos)
            local smoke = emitter:Add("particles/smokey", data.tr.HitPos)
            smoke:SetGravity( Vector(0, 0, 1500) )
            smoke:SetDieTime( math.Rand(0.5, 1) )
            smoke:SetStartAlpha(100)
            smoke:SetEndAlpha(0)
            smoke:SetStartSize(10)
            smoke:SetEndSize(50)
            smoke:SetRoll( math.Rand(-180, 180) )
            smoke:SetRollDelta( math.Rand(-0.2,0.2) )
            smoke:SetColor(50, 200, 50)
            smoke:SetAirResistance(1000)
            smoke:SetLighting( false )
            smoke:SetCollide(false)
            smoke:SetBounce(0)
            emitter:Finish()
        end
end)

function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if not self.CanBash and not self:GetBuff_Override("Override_CanBash") then return end
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
                local healinfo = HealInfo:New({amount = 10, healer = ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount = 10, healer = ply})
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

    self:SetNextSecondaryFire(CurTime() + 1)
    self:SetNextPrimaryFire(CurTime() + 0.25)
    return true
end

sound.Add({
	name = 			"KF_trench_pumpforward",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_trench/TrenchGun_Pump_Forward.wav"
})
sound.Add({
	name = 			"KF_trench_pumpback",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_trench/TrenchGun_Pump_Back.wav"
})
sound.Add({
	name = 			"KF_trench_insert",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			{ "weapons/kf_trench/TrenchGun_Bullet_Insert_01.wav", "weapons/kf_trench/TrenchGun_Bullet_Insert_02.wav", "weapons/kf_trench/TrenchGun_Bullet_Insert_03.wav"}
})
sound.Add({
	name = 			"KF_trench.Fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf_trench/KF_Shotgun_Dragon_Fire_S.wav"
})
