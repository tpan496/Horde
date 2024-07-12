if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ssg08")
    killicon.Add("arccw_horde_medic_rifle", "arccw/weaponicons/arccw_go_ssg08", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ssg08"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SSG08 Medic SR"
SWEP.Trivia_Desc = "Precision sniper rifle that fires healing rounds. Heals players and damages enemies."
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"

SWEP.Damage = 200
SWEP.DamageMin = 200 -- damage done at maximum range
SWEP.Range = 2000 -- in METRES
SWEP.MuzzleVelocity = 1000 -- projectile or phys bullet muzzle velocity
SWEP.Recoil = 1
SWEP.RecoilSide = 0.2

SWEP.RecoilPunch = 0


SWEP.AccuracyMOA = 0.05 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 10 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 10

SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 1.00
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.10

SWEP.BarrelLength = 20


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
        if not IsFirstTimePredicted() then return end

        if shouldphysical then
            local vel = self:GetBuff_Override("Override_PhysBulletMuzzleVelocity") or self.PhysBulletMuzzleVelocity

            local tracernum = data.TracerNum or 1
            local prof

            if tracernum == 0 or clip % tracernum != 0 then
                prof = 7
            end

            if not vel then
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

hook.Add("Hook_BulletHit", "Horde_MedicRifleHeal", function(wpn, data)
    if wpn:GetClass() == "arccw_horde_medic_rifle" then
        if SERVER and (data.tr.Entity:IsPlayer()) then
                data.Damage = 0
                local healinfo = HealInfo:New({amount = 60, healer = wpn:GetOwner()})
                HORDE:OnPlayerHeal(data.tr.Entity, healinfo)
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
    end
end)
