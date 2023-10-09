SWEP.Base = "arccw_base_nade"

function SWEP:FireRocket(ent, vel, ang, dontinheritvel)
    if CLIENT then return end

    local rocket = ents.Create(ent)

    ang = ang or (self:GetOwner():EyeAngles() + self:GetFreeAimOffset())

    local src = self:GetShootSrc()

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. ent) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)
    if ang and self.ShootEntityAngleCorrection then
        local up = ang:Up()
        local right = ang:Right()
        local forward = ang:Forward()
        rocketAng:RotateAroundAxis(up, self.ShootEntityAngleCorrection.y)
        rocketAng:RotateAroundAxis(right, self.ShootEntityAngleCorrection.p)
        rocketAng:RotateAroundAxis(forward, self.ShootEntityAngleCorrection.r)
    end

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(self:GetOwner())

    rocket.Inflictor = self

    local randfactor = self:GetBuff("DamageRand")
    local mul = 1
    if randfactor > 0 then
        mul = mul * math.Rand(1 - randfactor, 1 + randfactor)
    end
    rocket.Damage = self:GetBuff("Damage") * mul

    if self.BlastRadius then
        local r_randfactor = self:GetBuff("DamageRand")
        local r_mul = 1
        if r_randfactor > 0 then
            r_mul = r_mul * math.Rand(1 - r_randfactor, 1 + r_randfactor)
        end
        rocket.BlastRadius = self:GetBuff("BlastRadius") * r_mul
    end
    local RealVelocity
    if self.SecondaryThrow then
        RealVelocity = ang:Forward() * vel
    else
        RealVelocity = (!dontinheritvel and self:GetOwner():GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel
    end
    
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    if rocket.ArcCW_Killable == nil then
        rocket.ArcCW_Killable = true
    end

    rocket.ArcCWProjectile = true

    self:GetBuff_Hook("Hook_PostFireRocket", rocket)

    return rocket
end

function SWEP:Throw()
    if self:GetNextPrimaryFire() > CurTime() then return end

    local isCooked = self.isCooked
    self:SetGrenadePrimed(false)
    self.isCooked = nil

    local alt = self:GetGrenadeAlt()

    local anim = alt and self:SelectAnimation("throw_alt") or self:SelectAnimation("throw")
    self:PlayAnimation(anim, self:GetBuff_Mult("Mult_ThrowTime"), false, 0, true)

    local animevent = alt and self:GetBuff_Override("Override_AnimShootAlt", self.AnimShootAlt) or self:GetBuff_Override("Override_AnimShoot", self.AnimShoot)
    self:GetOwner():DoAnimationEvent(animevent)

    local heldtime = CurTime() - self.GrenadePrimeTime

    local mv = 0

    if alt then
        mv = self:GetBuff("MuzzleVelocityAlt", true) or self:GetBuff("MuzzleVelocity")
    else
        mv = self:GetBuff("MuzzleVelocity")
        local chg = self:GetBuff("WindupTime")
        if chg > 0 then
            mv = Lerp(math.Clamp(heldtime / chg, 0, 1), mv * self:GetBuff("WindupMinimum"), mv)
        end
    end

    local force = mv * ArcCW.HUToM

    self:SetTimer(self:GetBuff("ShootEntityDelay"), function()

        local ft = self:GetBuff("FuseTime", true)
        local data = {
            dodefault = true,
            force = force,
            shootentity = self:GetBuff_Override("Override_ShootEntity", self.ShootEntity),
            fusetime = ft and (ft - (isCooked and heldtime or 0)),
        }
        local ovr = self:GetBuff_Hook("Hook_Throw", data)
        if !ovr or ovr.dodefault then
            local rocket
            if self.SecondaryThrow then
                rocket = self:FireRocket(self:GetBuff_Override("Override_ShootEntity", self.ShootEntity), 200)
            else
                rocket = self:FireRocket(self:GetBuff_Override("Override_ShootEntity", self.ShootEntity), force / ArcCW.HUToM)
            end
            
            if !rocket then return end

            if ft then
                if isCooked then
                    rocket.FuseTime = ft - heldtime
                else
                    rocket.FuseTime = ft
                end
            else
                rocket.FuseTime = math.huge
            end

            local phys = rocket:GetPhysicsObject()

            local inertia = self:GetBuff_Override("Override_ThrowInertia", self.ThrowInertia)
            if inertia == nil then inertia = GetConVar("arccw_throwinertia"):GetBool() end
            if inertia and mv > 100 then
                phys:AddVelocity(self:GetOwner():GetVelocity())
            end

            phys:AddAngleVelocity( Vector(0, 750, 0) )
        end
        if !self:HasInfiniteAmmo() then
            local aps = self:GetBuff("AmmoPerShot")
            local a1 = self:Ammo1()
            if self:HasBottomlessClip() or a1 >= aps then
                self:TakePrimaryAmmo(aps)
            elseif a1 < aps then
                self:SetClip1(math.min(self:GetCapacity() + self:GetChamberSize(), self:Clip1() + a1))
                self:TakePrimaryAmmo(a1)
            end

            if (self.Singleton or self:Ammo1() == 0) and !self:GetBuff_Override("Override_KeepIfEmpty", self.KeepIfEmpty) then
                self:GetOwner():StripWeapon(self:GetClass())
                return
            end
        end

    end)
    local t = self:GetAnimKeyTime(anim) * self:GetBuff_Mult("Mult_ThrowTime")
    self:SetPriorityAnim(CurTime() + t)
    self:SetTimer(t, function()
        if !self:IsValid() then return end
        local a = self:SelectAnimation("reload") or self:SelectAnimation("draw")
        self:PlayAnimation(a, self:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
        self:SetPriorityAnim(CurTime() + self:GetAnimKeyTime(a, true) * self:GetBuff_Mult("Mult_ReloadTime"))
    end)

    self:SetNextPrimaryFire(CurTime() + self:GetFiringDelay())

    self:SetGrenadeAlt(false)

    self:SetShouldHoldType()

    self:GetBuff_Hook("Hook_PostThrow")
end

function SWEP:PrimaryAttack()
    self:PreThrow()
    self.SecondaryThrow = nil
end

function SWEP:SecondaryAttack()
    self:PreThrow()
    self.SecondaryThrow = true
end