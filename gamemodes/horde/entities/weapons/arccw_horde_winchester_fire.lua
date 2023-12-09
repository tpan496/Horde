if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_kf1lever")
    killicon.Add("arccw_horde_lever_fire", "arccw/weaponicons/arccw_kf1lever", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Winchester Incendiary"
SWEP.TrueName = "Winchester 1894 Incendiary"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "A lever action rifle that uses incendiary ammo."
SWEP.Trivia_Manufacturer = "Winchester"
SWEP.Trivia_Calibre = ".44 Magnum"
SWEP.Trivia_Mechanism = "Lever-Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1894

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_kf_winchester.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"
SWEP.ViewModelFOV = 45

SWEP.Damage = 200
SWEP.DamageMin = 150 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 20
SWEP.DamageType = DMG_BURN
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false
SWEP.ShotgunReload = true

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 15
SWEP.ReducedClipSize = 7

SWEP.Recoil = 1
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 1
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 80 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
		PrintName = "LEVER",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 0.05 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 5 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "KF_winchester.Fire"
SWEP.ShootSoundSilenced = "weapons/fesiugmw2/fire/sniper_sil.wav"
SWEP.DistantShootSound = "KF_winchester.Fire"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
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

SWEP.ManualAction = true

SWEP.IronSightStruct = {
    Pos = Vector(-4.95, 1, 2),
    Ang = Angle(-0.2, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-1, -5, 1.5)
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

SWEP.Attachments = {
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
        Bone = "RepeatingRifle",
        Offset = {
            vpos = Vector(9, -0.4, 2),
            vang = Angle(0, 0, 0),
            wpos = Vector(22, 0.8, -6.5),
            wang = Angle(-5, 0, 90)
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
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 10,
    },
	["cycle"] = {
        Source = "shoot",
        Time = 0.7,
        ShellEjectAt = 0,
    },
    ["cycle_iron"] = {
        Source = "shoot",
        Time = 0.7,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        RestoreAmmo = 1,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        Time = 0.7,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "reload_end",
        Time = 0.7,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_end",
        Time = 0.7,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
}

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    self.Primary.Automatic = true

    if !self:CanPrimaryAttack() then return end

    local clip = self:Clip1()
    local aps = self:GetBuff("AmmoPerShot")

    if self:HasBottomlessClip() then
        clip = self:Ammo1()

        if self:HasInfiniteAmmo() then
            clip = 10
        end
    end

    if clip < aps then
        self:SetBurstCount(0)
        self:DryFire()

        self.Primary.Automatic = false

        return
    end

    local desync = GetConVar("arccw_desync"):GetBool()
    local desyncnum = (desync and math.random()) or 0
    math.randomseed(math.Round(util.SharedRandom(self:GetBurstCount(), -1337, 1337, !game.SinglePlayer() and self:GetOwner():GetCurrentCommand():CommandNumber() or CurTime()) * (self:EntIndex() % 30241)) + desyncnum)

    self.Primary.Automatic = true

    local dir = owner:GetAimVector()
    local src = self:GetShootSrc()

    if bit.band(util.PointContents(src), CONTENTS_WATER) == CONTENTS_WATER and !(self.CanFireUnderwater or self:GetBuff_Override("Override_CanFireUnderwater")) then
        self:DryFire()

        return
    end

    local spread = ArcCW.MOAToAcc * self:GetBuff("AccuracyMOA")

    --dir:Rotate(Angle(0, ArcCW.StrafeTilt(self), 0))

    dir = dir + VectorRand() * self:GetDispersion() / 360 / 60

    local delay = self:GetFiringDelay()

    self:SetNextPrimaryFire(CurTime() + delay)
    self:SetNextPrimaryFireSlowdown(CurTime() + delay) -- shadow for ONLY fire time

    local num = self:GetBuff_Override("Override_Num") or self.Num

    num = num + self:GetBuff_Add("Add_Num")

    local tracernum = self:GetBuff_Override("Override_TracerNum") or self.TracerNum
    local lastout = self:GetBuff_Override("Override_TracerFinalMag") or self.TracerFinalMag

    if lastout >= clip then
        tracernum = 1
    end

    local bullet      = {}
    bullet.Attacker   = owner
    bullet.Dir        = dir
    bullet.Src        = src
    bullet.Spread     = Vector(0, 0, 0) --Vector(spread, spread, spread)
    bullet.Damage     = 0
    bullet.Num        = num
    bullet.Force      = (self:GetDamage(0) + self:GetDamage(self:GetBuff("Range"))) / 50
    bullet.Distance   = 33000
    bullet.AmmoType   = self.Primary.Ammo
    bullet.HullSize   = (self:GetBuff_Override("Override_HullSize") or self.HullSize or 0) + self:GetBuff_Add("Add_HullSize")
    bullet.Tracer     = tracernum or 0
    bullet.TracerName = self:GetBuff_Override("Override_Tracer") or self.Tracer
    bullet.Weapon     = self
    bullet.Callback   = function(att, tr, dmg)
        local hitpos, hitnormal = tr.HitPos, tr.HitNormal
        local trent = tr.Entity

        local dist = (hitpos - src):Length() * ArcCW.HUToM
        local pen  = self:GetBuff("Penetration")

        if SERVER then
            debugoverlay.Cross(hitpos, 5, 5, Color(255, 0, 0), true)
        else
            debugoverlay.Cross(hitpos, 5, 5, Color(0, 0, 255), true)
        end

        local randfactor = self:GetBuff("DamageRand")
        local mul = 1
        if randfactor > 0 then
            mul = mul * math.Rand(1 - randfactor, 1 + randfactor)
        end

        local hit   = {}
        hit.att     = att
        hit.tr      = tr
        hit.dmg     = dmg
        hit.range   = dist
        hit.damage  = self:GetDamage(dist, true) * mul
        hit.dmgtype = self:GetBuff_Override("Override_DamageType") or self.DamageType
        hit.penleft = pen

        hit = self:GetBuff_Hook("Hook_BulletHit", hit)

        if !hit then return end

        dmg:SetDamageType(hit.dmgtype)
        dmg:SetDamage(hit.damage)

        local effect = self.ImpactEffect
        local decal  = self.ImpactDecal

        if dmg:IsDamageType(DMG_BURN) and hit.range <= self.Range then
            effect = "arccw_incendiaryround"
            decal  = "FadingScorch"

            if SERVER then
                if vFireInstalled then
                    CreateVFire(trent, hitpos, hitnormal, hit.damage * 0.02)
                end
            end
        end

        if SERVER then self:TryBustDoor(trent, dmg) end

        self:DoPenetration(tr, hit.penleft, { [trent:EntIndex()] = true })

        effect = self:GetBuff_Override("Override_ImpactEffect") or effect

        if effect then
            local ed = EffectData()
            ed:SetOrigin(hitpos)
            ed:SetNormal(hitnormal)

            util.Effect(effect, ed)
        end

        decal = self:GetBuff_Override("Override_ImpactDecal") or decal

        if decal then util.Decal(decal, tr.StartPos, hitpos - (hitnormal * 16), self:GetOwner()) end
    end

    local shootent = self:GetBuff("ShootEntity", true) --self:GetBuff_Override("Override_ShootEntity", self.ShootEntity)
    local shpatt   = self:GetBuff_Override("Override_ShotgunSpreadPattern", self.ShotgunSpreadPattern)
    local shpattov = self:GetBuff_Override("Override_ShotgunSpreadPatternOverrun", self.ShotgunSpreadPatternOverrun)

    local extraspread = AngleRand() * self:GetDispersion() / 360 / 60

    local projectiledata = {}

    if shpatt or shpattov or shootent then
        if shootent then
            projectiledata.ent = shootent
            projectiledata.vel = self:GetBuff("MuzzleVelocity") * ArcCW.HUToM
            --(self:GetBuff_Override("Override_MuzzleVelocity") or self.MuzzleVelocity) * ArcCW.HUToM * self:GetBuff_Mult("Mult_MuzzleVelocity")
        end

        bullet = self:GetBuff_Hook("Hook_FireBullets", bullet)

        if !bullet then return end

        local doent = shootent and num or bullet.Num
        local minnum = shootent and 1 or 0

        if doent > minnum then
            for n = 1, bullet.Num do
                bullet.Num = 1

                local dispers = self:GetBuff_Override("Override_ShotgunSpreadDispersion") or self.ShotgunSpreadDispersion
                local offset  = self:GetShotgunSpreadOffset(n)
                local calcoff = dispers and (offset * self:GetDispersion() / 360 / 60) or (offset + extraspread)

                local ang = owner:EyeAngles()
                ang:RotateAroundAxis(owner:EyeAngles():Right(), -1 * calcoff.p)
                ang:RotateAroundAxis(owner:EyeAngles():Up(), calcoff.y)
                ang:RotateAroundAxis(owner:EyeAngles():Forward(), calcoff.r)

                if !self:GetBuff_Override("Override_NoRandSpread") then -- Needs testing
                    ang = ang + AngleRand() * spread / 5
                end

                if shootent then
                    projectiledata.ang = ang

                    self:DoPrimaryFire(true, projectiledata)
                else
                    bullet.Dir = ang:Forward()

                    self:DoPrimaryFire(false, bullet)
                end
            end
        elseif shootent then
            local ang = owner:EyeAngles()

            if !self:GetBuff_Override("Override_NoRandSpread") then
                ang = (dir + VectorRand() * spread / 5):Angle()
            end

            projectiledata.ang = ang

            self:DoPrimaryFire(true, projectiledata)
        end
    else
        if !bullet then return end

        for n = 1, bullet.Num do
            bullet.Num = 1
            math.randomseed(math.Round(util.SharedRandom(n, -1337, 1337, !game.SinglePlayer() and self:GetOwner():GetCurrentCommand():CommandNumber() or CurTime()) * (self:EntIndex() % 30241)) + desyncnum)
            if !self:GetBuff_Override("Override_NoRandSpread") then
                bullet.Dir = dir + VectorRand() * spread
            end
            bullet = self:GetBuff_Hook("Hook_FireBullets", bullet) or bullet

            self:DoPrimaryFire(false, bullet)
        end
    end

    self:DoRecoil()

    self:SetNthShot(self:GetNthShot() + 1)

    owner:DoAnimationEvent(self:GetBuff_Override("Override_AnimShoot") or self.AnimShoot)

    local shouldsupp = SERVER and !game.SinglePlayer()

    if shouldsupp then SuppressHostEvents(owner) end

    self:DoEffects()

    self:TakePrimaryAmmo(aps)

    self:SetBurstCount(self:GetBurstCount() + 1)

    if self:HasBottomlessClip() and self:Clip1() > 0 then
        self:Unload()
    end

    self:DoShootSound()
    self:DoPrimaryAnim()

    if self:GetCurrentFiremode().Mode < 0 and self:GetBurstCount() == self:GetBurstLength() then
        local postburst = (self:GetCurrentFiremode().PostBurstDelay or 0)
        self:SetWeaponOpDelay(CurTime() + postburst * self:GetBuff_Mult("Mult_PostBurstDelay") + self:GetBuff_Add("Add_PostBurstDelay"))
    end

    if (self:GetIsManualAction()) and !(self.NoLastCycle and self:Clip1() == 0) then
        local fireanim = self:GetBuff_Hook("Hook_SelectFireAnimation") or self:SelectAnimation("fire")
        local firedelay = self.Animations[fireanim].MinProgress or 0
        self:SetNeedCycle(true)
        self:SetWeaponOpDelay(CurTime() + firedelay)
        self:SetNextPrimaryFire(CurTime() + 0.1)
    end

    self:ApplyAttachmentShootDamage()

    self:AddHeat(1)

    self:GetBuff_Hook("Hook_PostFireBullets")

    if shouldsupp then SuppressHostEvents(nil) end
end

sound.Add({
	name = 			"KF_winchester_pump",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_winchester/Rifle_Reload_242.wav"
})
sound.Add({
	name = 			"KF_winchester_foley",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_winchester/Rifle_Reload_000.wav"
})
sound.Add({
	name = 			"KF_winchester_bolt",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			{ "weapons/kf_winchester/winchester_pump_1.wav", "weapons/kf_winchester/winchester_pump_2.wav", "weapons/kf_winchester/winchester_pump_3.wav", "weapons/kf_winchester/winchester_pump_4.wav" }
})
sound.Add({
	name = 			"KF_winchester_draw",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_winchester/Rifle_Pickup.wav"
})
sound.Add({
	name = 			"KF_winchester_insert",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			{ "weapons/kf_winchester/Rifle_Reload_014.wav", "weapons/kf_winchester/Rifle_Reload_037.wav", "weapons/kf_winchester/Rifle_Reload_060.wav", "weapons/kf_winchester/Rifle_Reload_083.wav", "weapons/kf_winchester/Rifle_Reload_107.wav", "weapons/kf_winchester/Rifle_Reload_130.wav", "weapons/kf_winchester/Rifle_Reload_151.wav", "weapons/kf_winchester/Rifle_Reload_176.wav", "weapons/kf_winchester/Rifle_Reload_199.wav", "weapons/kf_winchester/Rifle_Reload_224.wav"}
})
sound.Add({
	name = 			"KF_winchester.Fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			{ "weapons/kf_winchester/Rifle_FireST1.wav", "weapons/kf_winchester/Rifle_FireST2.wav", "weapons/kf_winchester/Rifle_FireST3.wav", "weapons/kf_winchester/Rifle_FireST4.wav"}
})
