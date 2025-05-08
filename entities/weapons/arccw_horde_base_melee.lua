
SWEP.Base = "arccw_base_melee"
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = 100

SWEP.MaximumDurability = 100 -- How much durability the melee weapon has (it works like ammo)
SWEP.DurabilityCostPerHit = 1
SWEP.SecondaryAttackCostMul = 2 -- 200% Durability cost on secondary attack
SWEP.IsHordeMelee = true
SWEP.UseHordeDurability = true
SWEP.WasHeadshot = false -- This check is for vjank base vs exploders bandaid

SWEP.Dur_BaseDamageScale = 0.5 -- Damage multiplier when weapon has no durability

DEFINE_BASECLASS(SWEP.Base)

function SWEP.Initialize(self, ...)
    self:SetNWFloat("HORDE_Durability", self.MaximumDurability) -- Use Networked Variable so it syncs to client
    BaseClass.Initialize(self, ...) -- Call original
end

local IsValidEntity = function(owner, ent)
    return (IsValid(ent) && (ent != owner) && !ent:GetNWEntity("HordeOwner"):IsPlayer() && ((ent:IsNPC() || ent:IsNextBot())))
end

local VisCheck = function(owner, pos)
    return util.TraceLine({
        start = pos,
        endpos = owner:EyePos(),
        filter = {owner},
        mask = MASK_SHOT,
        collisiongroup = COLLISION_GROUP_DEBRIS,
    }).Fraction == 1
end

--[[
SWEP.MaxHits = 2 -- Change this number to change maximum target hits on the swep
SWEP.MaxHitsSecondary = 2
SWEP.MeleeBoundingBox = { -- If weapon has no bounding box, it will scale length based on MeleeRange and Melee2Range
    primary = {
        wide = 8,
        tall = 1,
        length = 75, -- 75 ~ 2.5 meters
    },
    secondary = {
        wide = 8,
        tall = 1,
        length = 75,
    },
}
]]

SWEP.HipDispersion = 75 -- This is here so that way the crosshair isn't so big

function SWEP:MeleeAttack(melee2)
    local owner = self:GetOwner()
    local reach = 32 + self:GetBuff_Add("Add_MeleeRange") + self.MeleeRange
    local dmg = self:GetBuff_Override("Override_MeleeDamage", self.MeleeDamage) or 20
    local dmgtype = self:GetBuff_Override("Override_MeleeDamageType") or self.MeleeDamageType or DMG_CLUB
    local ragdoll_force = owner:GetRight() * math.random(-4912, 4912) + owner:GetForward() * math.random(2048, 9989)
    
    if melee2 then
        reach = 32 + self:GetBuff_Add("Add_MeleeRange") + self.Melee2Range
        dmg = self:GetBuff_Override("Override_MeleeDamage", self.Melee2Damage) or 20
    end
    dmg = dmg * self:GetBuff_Mult("Mult_MeleeDamage")

    local durability = self:GetNWFloat("HORDE_Durability", 100)
    if(durability <= 0) then
        dmg = dmg * self.Dur_BaseDamageScale
    end

    owner:LagCompensation(true)

    local filter = {owner, self}
    local mins, maxs = Vector(-16, -16, -4), Vector(16, 16, 4)
    local bbox = self.MeleeBoundingBox
    if(bbox) then
        if(!melee2) then
            if(bbox.primary) then
                mins = Vector(-bbox.primary.wide, -bbox.primary.wide, -bbox.primary.tall)
                maxs = Vector(bbox.primary.wide, bbox.primary.wide, bbox.primary.tall)
                reach = bbox.primary.length
            end
        else
            if(bbox.secondary) then
                mins = Vector(-bbox.secondary.wide, -bbox.secondary.wide, -bbox.secondary.tall)
                maxs = Vector(bbox.secondary.wide, bbox.secondary.wide, bbox.secondary.tall)
                reach = bbox.secondary.length
            end
        end
    end
    local trace_reach = reach + (mins:Distance(maxs) * 0.5)
    local trace_endpos = owner:EyePos() + owner:EyeAngles():Forward() * reach
    local maxhits = self.MaxHits || 2
    if melee2 and self.MaxHits then
        maxhits = self.MaxHitsSecondary || self.MaxHits
    end
    local hits = 0
    local tr = {
        start = owner:EyePos(),
        endpos = owner:EyePos() + owner:EyeAngles():Forward() * trace_reach,
        filter = filter,
        mask = MASK_SHOT,
    }
    local developer = GetConVar("developer"):GetInt() > 0
    local hitTargets = {}
    local enemies_hit = {}
    local preTr = util.TraceLine(tr)
    local preHit = preTr.Entity
    -- Prevent playing sounds multiple times
    local hitworldSD = false
    local hitFleshSD = false
    if(IsValidEntity(owner, preHit)) then -- Check if you hit any entity directly
        if(SERVER) then
            local dmginfo = DamageInfo()
                dmginfo:SetAttacker(owner)
                dmginfo:SetInflictor(self)
                dmginfo:SetDamage(dmg)
                dmginfo:SetDamageType(dmgtype)
                dmginfo:SetDamageForce(ragdoll_force)
                dmginfo:SetDamagePosition(preHit:NearestPoint(preTr.HitPos))
            
            if(preTr.HitGroup == 1) then
                if(preHit:IsNPC()) then
                    hook.Run("ScaleNPCDamage", preHit, preTr.HitGroup, dmginfo)
                elseif(preHit:IsPlayer()) then
                    hook.Run("ScalePlayerDamage", preHit, preTr.HitGroup, dmginfo)
                end
                self.WasHeadshot = true
            else
                self.WasHeadshot = false
            end
            
            preHit:TakeDamageInfo(dmginfo)
        end
        table.insert(enemies_hit, preHit)
        hits = hits + 1
        hitTargets[preHit:EntIndex()] = true -- Prevent double hit from cleaving
        
        if(!hitFleshSD) then
            self:MyEmitSound(self.MeleeHitNPCSound, 75, 100, 1, CHAN_STATIC)
            hitFleshSD = true
        end
    else
        if(preTr.Hit && !hitworldSD) then
            if !preHit:IsPlayer() and !preHit:GetNWEntity("HordeOwner"):IsValid() then
                self:MyEmitSound(self.MeleeHitSound, 75, 100, 1, CHAN_STATIC)
            end
            hitworldSD = true
            -- To destroy destructible props
            local dmginfo = DamageInfo()
                dmginfo:SetAttacker(owner)
                dmginfo:SetInflictor(self)
                dmginfo:SetDamage(dmg)
                dmginfo:SetDamageType(dmgtype)
                dmginfo:SetDamageForce(ragdoll_force)
                dmginfo:SetDamagePosition(preHit:NearestPoint(preTr.HitPos))
            preHit:DispatchTraceAttack(dmginfo, tr)
        end
    end
    self:MyEmitSound(self.MeleeMissSound, 75, 100, 1, CHAN_STATIC)

    if(hits < maxhits) then -- Anything hit by cleaving cannot be heatshotted
        local targets_in_range = {}
        local eyepos = owner:EyePos()
        for _, ent in ipairs(ents.FindAlongRay(owner:EyePos(), trace_endpos, mins, maxs)) do
            if(!IsValidEntity(owner, ent)) then continue end
            if(hits > maxhits) then break end
            if(hitTargets[ent:EntIndex()]) then continue end
            if(!VisCheck(owner, ent:NearestPoint(eyepos))) then continue end
            if(developer) then
                debugoverlay.Cross(ent:NearestPoint(eyepos), 3, 1, Color(255, 0, 255, 255), true)
            end
            table.insert(targets_in_range, ent)
        end
        -- We want to hit targets that are closest to us first
        table.sort(targets_in_range, function(a, b) return a:GetPos():Distance(eyepos) < b:GetPos():Distance(eyepos) end)
        for _, target in ipairs(targets_in_range) do
            if(SERVER) then
                local dmginfo = DamageInfo()
                    dmginfo:SetAttacker(owner)
                    dmginfo:SetInflictor(self)
                    dmginfo:SetDamage(dmg)
                    dmginfo:SetDamageType(dmgtype)
                    dmginfo:SetDamageForce(ragdoll_force)
                    dmginfo:SetDamagePosition(target:GetPos() + target:OBBCenter())
                target:TakeDamageInfo(dmginfo)
            end
            table.insert(enemies_hit, target)
            hits = hits + 1
            if(!hitFleshSD) then
                self:MyEmitSound(self.MeleeHitNPCSound, 75, 100, 1, CHAN_STATIC)
                hitFleshSD = true
            end
            
            if(hits >= maxhits) then
                break
            end
        end
        
        if(developer) then
            debugoverlay.SweptBox(owner:EyePos(), trace_endpos, mins, maxs, Angle(0, 0, 0), 2, Color(255, 0, 0), true)
        end
    end
    if(developer) then
        debugoverlay.Line(owner:EyePos(), tr.endpos, 2, Color(255, 255, 255), true)
    end

    local cost = self.DurabilityCostPerHit
    if (melee2) then
        cost = cost * self.SecondaryAttackCostMul
    end
    if hits > 0 and self.UseHordeDurability and HORDE.enable_ammobox == 1 then
        self:SetNWFloat("HORDE_Durability", math.max(self:GetNWFloat("HORDE_Durability", self.MaximumDurability) - (cost * hits), 0))
    end

    self:GetBuff_Hook("Hook_PostBash", {tr = preTr, dmg = dmg, melee2 = melee2, cleave = enemies_hit, ply = owner, dmgtype = dmgtype})
    owner:LagCompensation(false)
end

hook.Add("Horde_OnPlayerDamagePost", "Horde_Splash_DamageInfo", function(ply, npc, bonus, hitgroup, dmginfo)
    if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon().IsHordeMelee then
        ply:GetActiveWeapon().splash_dmg_check = dmginfo:GetDamage()
    end
end)

--[[
-------Keep the oldge melee code just in case---------
SWEP.Base = "arccw_base_melee"

function SWEP:MeleeAttack(melee2)
    local reach = 32 + self:GetBuff_Add("Add_MeleeRange") + self.MeleeRange
    local dmg = self:GetBuff_Override("Override_MeleeDamage", self.MeleeDamage) or 20

    if melee2 then
        reach = 32 + self:GetBuff_Add("Add_MeleeRange") + self.Melee2Range
        dmg = self:GetBuff_Override("Override_MeleeDamage", self.Melee2Damage) or 20
    end

    dmg = dmg * self:GetBuff_Mult("Mult_MeleeDamage")

    self:GetOwner():LagCompensation(true)

    local filter = {self:GetOwner()}

    table.Add(filter, self.Shields)

    local tr = util.TraceLine({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * reach,
        filter = filter,
        mask = MASK_SHOT_HULL
    })

    if (!IsValid(tr.Entity)) then
        tr = util.TraceHull({
            start = self:GetOwner():GetShootPos(),
            endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * reach,
            filter = filter,
            mins = Vector(-16, -16, -8),
            maxs = Vector(16, 16, 8),
            mask = MASK_SHOT_HULL
        })
    end

    -- Backstab damage if applicable
    local backstab = tr.Hit and self:CanBackstab(melee2, tr.Entity)
    if backstab then
        if melee2 then
            local bs_dmg = self:GetBuff_Override("Override_Melee2DamageBackstab", self.Melee2DamageBackstab)
            if bs_dmg then
                dmg = bs_dmg * self:GetBuff_Mult("Mult_MeleeDamage")
            else
                dmg = dmg * self:GetBuff("BackstabMultiplier") * self:GetBuff_Mult("Mult_MeleeDamage")
            end
        else
            local bs_dmg = self:GetBuff_Override("Override_MeleeDamageBackstab", self.MeleeDamageBackstab)
            if bs_dmg then
                dmg = bs_dmg * self:GetBuff_Mult("Mult_MeleeDamage")
            else
                dmg = dmg * self:GetBuff("BackstabMultiplier") * self:GetBuff_Mult("Mult_MeleeDamage")
            end
        end
    end

    -- We need the second part for single player because SWEP:Think is ran shared in SP
    if !(game.SinglePlayer() and CLIENT) then
        if tr.Hit then
            if tr.Entity:IsNPC() or tr.Entity:IsNextBot() or tr.Entity:IsPlayer() then
                self:MyEmitSound(self.MeleeHitNPCSound, 75, 100, 1, CHAN_USER_BASE + 2)
            else
                self:MyEmitSound(self.MeleeHitSound, 75, 100, 1, CHAN_USER_BASE + 2)
            end

            if tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_BLOODYFLESH then
                local fx = EffectData()
                fx:SetOrigin(tr.HitPos)

                util.Effect("BloodImpact", fx)
            end
        else
            self:MyEmitSound(self.MeleeMissSound, 75, 100, 1, CHAN_USER_BASE + 3)
        end
    end

    if SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:Health() > 0) then
        local attacker = self:GetOwner()
        if !IsValid(attacker) then attacker = self end
        
        self:FireBullets({
            Attacker = attacker,
            Inflictor = self,
            Damage = dmg,
            Tracer = -1,
            Distance = reach,
            Dir = tr.HitPos - self:GetOwner():GetShootPos(),
            Src = self:GetOwner():GetShootPos(),
            Callback = function(att, trb, dmginfo)
                dmginfo:SetDamage(dmg)
                dmginfo:SetDamageForce(self:GetOwner():GetRight() * -4912 + self:GetOwner():GetForward() * 9989)
                dmginfo:SetDamageType(self:GetBuff_Override("Override_MeleeDamageType") or self.MeleeDamageType or DMG_CLUB)

                if (not trb.Entity:IsValid()) or (not trb.Entity:IsNPC()) then
                    tr.Entity:TakeDamageInfo(dmginfo)
                end
            end
        })

        if tr.Entity:GetClass() == "func_breakable_surf" then
            tr.Entity:Fire("Shatter", "0.5 0.5 256")
        end

    end

    if SERVER and IsValid(tr.Entity) and IsValid(self:GetOwner()) then
        local phys = tr.Entity:GetPhysicsObject()
        if IsValid(phys) then
            phys:ApplyForceOffset(self:GetOwner():GetAimVector() * 80 * phys:GetMass(), tr.HitPos)
        end
    end

    self:GetBuff_Hook("Hook_PostBash", {tr = tr, dmg = dmg, melee2 = melee2})

    self:GetOwner():LagCompensation(false)
end
]]
