if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "M9"
att.Icon = Material("entities/acwatt_mw2_akimbo.png", "smooth")
att.Description = "Wholy."
att.Hidden = false
att.Desc_Pros = {
    "+100% more gun",
}
att.Desc_Cons = {
    "- Cannot use ironsights"
}
att.Desc_Neutrals = {
    "Don't toggle the UBGL"
}
att.AutoStats = true
att.Mult_HipDispersion = 4
att.Slot = "akimbom9"

att.GivesFlags = {"cantuseshitinakimboyet"}

att.SortOrder = 1738

att.AddSuffix = " + M9"

att.MountPositionOverride = 0

att.Model = "models/weapons/arccw/fesiugmw2/akimbo/c_beretta_left_4.mdl"

att.LHIK = true
att.LHIK_Animation = true
att.LHIK_MovementMult = 0

att.UBGL = true

att.UBGL_PrintName = "AKIMBO"
att.UBGL_Automatic = false
att.UBGL_MuzzleEffect = "muzzleflash_4"
att.UBGL_ClipSize = 15
att.UBGL_Ammo = "pistol"
att.UBGL_RPM = 60 / 0.079
att.UBGL_Recoil = .3
att.UBGL_RecoilSide = .225
att.UBGL_RecoilRise = .1
att.UBGL_Capacity = 15

att.Hook_ShouldNotSight = function(wep)
    return true
end

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("pistol") -- att.UBGL_Ammo
end

att.Hook_Think = function(wep)
    if wep:GetMW2Masterkey_ShellInsertTime() < CurTime() and wep:GetMW2Masterkey_ShellInsertTime() != 0 then
        wep:SetMW2Masterkey_ShellInsertTime(0)
        local clip = 15
        if wep:Clip2() >= clip then return end
        if Ammo(wep) <= 0 then return end

        local reserve = Ammo(wep)
        reserve = reserve + wep:Clip2()
        local load = math.Clamp(clip, 0, reserve)
        wep.Owner:SetAmmo(reserve - load, "pistol")
        wep:SetClip2(load)
    end

    if !IsFirstTimePredicted() then return end
    if wep:GetOwner():KeyPressed(IN_RELOAD) then
        wep:SetInUBGL(false)
        wep:ReloadUBGL()
    elseif wep:GetOwner():KeyPressed(IN_ATTACK) then
        wep:SetInUBGL(false)
    elseif wep:GetOwner():KeyPressed(IN_ATTACK2) then
        wep:SetInUBGL(true)
        wep:ShootUBGL()
    end
end

local awesomelist = {
    ["sprint_in_akimbo_right"] = {
        time = 10/30,
        anim = "sprint_in",
    },
    ["sprint_out_akimbo_right"] = {
        time = 10/30,
        anim = "sprint_out",
    },
    ["sprint_loop_akimbo_right"] = {
        time = 30/40,
        anim = "sprint_loop",
    },
    ["pullout_akimbo_right"] = {
        time = 26/30 /4,
        anim = "pullout",
    },
    ["putaway_akimbo_right"] = {
        time = 26/30 /4,
        anim = "putaway",
    },
}

att.Hook_TranslateSequence = function(wep, anim)
    if awesomelist[anim] then
        local bab = awesomelist[anim]
        wep:DoLHIKAnimation(bab.anim, bab.time)
    end
end

att.Hook_LHIK_TranslateAnimation = function(wep, anim)
    if anim == "idle" and wep:Clip2() <= 0 then
        return "idle_empty"
    end
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    -- this bitch
    local fixedcone = wep:GetDispersion() / 360 / 60

    wep.Owner:FireBullets({
		Src = wep.Owner:EyePos(),
		Num = 1,
		Damage = 29,
		Force = 1,
		Attacker = wep.Owner,
		Dir = wep.Owner:EyeAngles():Forward(),
		Spread = Vector(fixedcone, fixedcone, 0),
		Callback = function(_, tr, dmg)
			local dist = (tr.HitPos - tr.StartPos):Length() * ArcCW.HUToM

			local dmgmax = 29
			local dmgmin = 21

			local delta = dist / 800

			delta = math.Clamp(delta, 0, 1)

			local amt = Lerp(delta, dmgmax, dmgmin)

			dmg:SetDamage(amt)
		end
	})
    wep:EmitSound("weapons/fesiugmw2/fire/m9.wav", 110, 100 * math.Rand(1 - 0.05, 1 + 0.05))
                            -- This is kinda important
                                            -- Wep volume
                                                    -- Weapon pitch (along with the pitch randomizer)




    wep:SetClip2(wep:Clip2() - 1)
    
    if wep:Clip2() > 0 then
        wep:DoLHIKAnimation("fire", 6/30)
    else
        wep:DoLHIKAnimation("fire_last", 6/30)
    end

    wep:DoEffects()
end

att.UBGL_Reload = function(wep, ubgl)
        if wep:Clip2() >= 15 then return end
        if Ammo(wep) <= 0 then return end

    wep:SetInUBGL(false)
    wep:Reload()

    if wep:Clip2() <= 0 then
        wep:DoLHIKAnimation("reload_empty", 89/40)
        wep:SetNextSecondaryFire(CurTime() + 89/40)
        wep:SetMW2Masterkey_ShellInsertTime(CurTime() + 1.2)
        wep:PlaySoundTable({
            {s = "weapons/fesiugmw2/foley/wpfoly_beretta9mm_reload_clipout_v2.wav", 	t = 4/40},
            {s = "weapons/fesiugmw2/foley/wpfoly_beretta9mm_reload_clipin_v2.wav",  	t = 42/40},
            {s = "weapons/fesiugmw2/foley/wpfoly_beretta9mm_reload_chamber_v2.wav", 	t = 67/40},
        })
    else
        wep:DoLHIKAnimation("reload", 70/40)
        wep:SetNextSecondaryFire(CurTime() + 70/40)
        wep:SetMW2Masterkey_ShellInsertTime(CurTime() + 1.2)
        wep:PlaySoundTable({
            {s = "weapons/fesiugmw2/foley/wpfoly_beretta9mm_reload_clipout_v2.wav", 	t = 4/40},
            {s = "weapons/fesiugmw2/foley/wpfoly_beretta9mm_reload_clipin_v2.wav", 	    t = 36/40},
        })
    end
end

ArcCW.LoadAttachmentType(att, "horde_akimbo_m9")