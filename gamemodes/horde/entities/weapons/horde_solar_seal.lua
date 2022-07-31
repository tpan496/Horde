sound.Add({
	name = "horde_solar_seal.solar_orb_charge_1",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 100,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_orb_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_orb_charge_2",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 125,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_orb_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_orb_charge_3",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 150,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_orb_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_orb_charge_4",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 175,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_orb_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_storm_charge_1",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 100,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_storm_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_storm_charge_2",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 120,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_storm_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_storm_charge_3",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 140,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_storm_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.solar_storm_charge_4",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 160,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/solar_storm_charge.ogg"
})
sound.Add({
	name = "horde_solar_seal.floating_chaos_launch",
	channel = CHAN_WEAPON,
	volume = VOL_NORM,
	pitch = 100,
	soundlevel = SNDLVL_NORM,
	sound = "horde/weapons/solar_seal/floating_chaos_launch.ogg"
})

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_solar_seal" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_solar_seal", "vgui/hud/horde_solar_seal", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_solar_projectile", "vgui/hud/horde_solar_seal", Color( 255, 255, 255, 255 ) )
end

SWEP.IronSightsPos = Vector(5.15, 0, 0.72)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.PrintName 		= "Solar Seal"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates solar power."
SWEP.Purpose 		= "Artificer Unique Weapon."

SWEP.AdminSpawnable = false
SWEP.Spawnable 		= true

SWEP.ViewModelFOV 	= 60
SWEP.ViewModel = "models/weapons/v_grenade.mdl"
SWEP.WorldModel = "models/weapons/c_arms.mdl"

SWEP.AutoSwitchTo 	= true
SWEP.AutoSwitchFrom = true


SWEP.Slot 			= 2
SWEP.SlotPos        = 2

SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "Thumper"

SWEP.HoldType = "magic"

SWEP.FiresUnderwater = false
SWEP.MuzzleAttachment	= "muzzle"

SWEP.Weight = 2

SWEP.DrawCrosshair = false 

SWEP.Category = "ArcCW - Horde"

SWEP.DrawAmmo = true

SWEP.Primary.MaxAmmo = 100
SWEP.Primary.ClipSize = -1

if ( CLIENT ) then
--SWEP.WepSelectIcon = surface.GetTextureID( "/vgui/icons/icon_pyromancyflame1.vmt" )
end

SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

if CLIENT then
SWEP.VElements = {
	["solar_seal"] = {
        type = "Sprite",
        sprite = "sprites/orangeflare1",
        bone = "ValveBiped.Grenade_body",
        rel = "",
        pos = Vector(-0.519, 0.518, -0.519),
        size = { x = 6, y = 6 },
        color = Color(255, 255, 255, 255),
        nocull = true,
        additive = true,
        vertexalpha = true,
        vertexcolor = true,
        ignorez = false}
}
end


SWEP.base = "weapon_base"

SWEP.Secondary.Sound = "Weapon_Pistol.NPC_Single"
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.ClipSize = 100

SWEP.Delay = 1

SWEP.Charging = 0
SWEP.ChargingTimer = 0
SWEP.ChargeSoundTimer = 0

SWEP.SecondaryCharging = 0
SWEP.SecondaryChargingTimer = 0
SWEP.SecondaryChargeSoundTimer = 0

SWEP.EnergyRegenTimer = 0
SWEP.SpectreMaxCount = 1

SWEP.ChargePlayed1 = nil
SWEP.ChargePlayed2 = nil
SWEP.ChargePlayed3 = nil

if SERVER then
	util.AddNetworkString("Horde_SolarStormTracer")
	util.AddNetworkString("Horde_SolarOrbTracer")
end

function SWEP:DrawHUD()
    if CLIENT then
	local x, y
	local tr = self.Owner:GetEyeTrace()
	if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
		local coords = tr.HitPos:ToScreen()
		x, y = coords.x, coords.y
	else
		x, y = ScrW() / 2, ScrH() / 2
	end
	surface.SetTexture( surface.GetTextureID( "vgui/hud/special_crosshair" ) )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )

	local tr = self.Owner:GetEyeTrace()
	cam.Start3D(self.Owner:EyePos(), self.Owner:EyeAngles())
	render.SetMaterial(Material("Sprites/light_glow02_add_noz"))
	render.DrawQuadEasy(tr.HitPos, (self.Owner:EyePos() - tr.HitPos):GetNormal(), 5, 5, Color(255,100,0,255), 0)
	cam.End3D()
    end
end

function SWEP:Initialize()
	self:SetHoldType("magic")
	timer.Simple(0, function()
		if not self:IsValid() then return end
		if self.Owner and not self.Owner:IsValid() then return end
		self.Owner:SetAmmo(100, "Thumper")
	end)

	if CLIENT then
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)

		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() and self.Weapon:Clip1() >= 5 then
        if IsValid(self.Owner) then
			if not self.Owner:Horde_GetPerk("artificer_base") then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
			--self:SetNextSecondaryFire( CurTime() + self.Delay )
			self.Charging = 1
			self.ChargingTimer = CurTime() + 1
        end
    end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	if IsValid(self.Owner) then
		if not self.Owner:Horde_GetPerk("artificer_base") then return end
		self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
		self.SecondaryCharging = 1
		self.SecondaryChargingTimer = CurTime() + 1
	end
end

function SWEP:RecoverEnergy(energy)
	if CLIENT then return end
	self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + energy))
end

function SWEP:Launch(charged)
    if CLIENT then return end
	if not self.Owner:Horde_GetPerk("artificer_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	if charged == 3 then
		if self.Weapon:Clip1() < 30 then return end
	elseif charged == 2 then
		if self.Weapon:Clip1() < 20 then return end
	elseif charged == 1 then
		if self.Weapon:Clip1() < 10 then return end
	else
		if self.Weapon:Clip1() < 5 then return end
	end

	self.ChargingTimer = CurTime() + 1
	if charged <= 1 then
		self.Owner:EmitSound("horde/weapons/solar_seal/solar_orb_launch.ogg", 100, math.random(90, 110))
	else
		self.Owner:EmitSound("horde/weapons/solar_seal/solar_orb_charged_launch.ogg", 100, math.random(90, 110))
	end
	
	local properties = {warmth = false, draconic = false, charged = charged, level = self.Owner:Horde_GetUpgrade("horde_solar_seal")}
	hook.Run("Horde_OnSolarSealLaunch", self.Owner, properties)
	local ent = ents.Create("projectile_horde_solar_orb")
    ent:SetOwner(self.Owner)
    ent.Owner = self.Owner
	ent.properties = properties
	ent:SetCharged(charged)
    if (!IsValid(ent)) then return end
	if charged == 3 and self.Weapon:Clip1() >= 30 then
		self:TakePrimaryAmmo(30)
	elseif charged == 2 and self.Weapon:Clip1() >= 20 then
		self:TakePrimaryAmmo(20)
	elseif charged == 1 and self.Weapon:Clip1() >= 10 then
		self:TakePrimaryAmmo(10)
	else
		self:TakePrimaryAmmo(5)
	end
    ent:SetPos( self.Owner:EyePos() + (self.Owner:GetAimVector() * 16 ))
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	if charged == 3 then
		velocity = velocity * 1.25
	end
	--velocity = velocity + (VectorRand() * 10) -- a random element
	phys:ApplyForceCenter(velocity)
	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
            self.Weapon:DefaultReload( ACT_VM_DRAW )
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)

	if self.Owner.Horde_Floating_Chaos and self.Owner.Horde_Floating_Chaos:IsValid() then
		local pos = self.Owner.Horde_Floating_Chaos:GetPos()

		local fired
		local max_targets = 5
		if charged > 0 then
			max_targets = 1
		end
		for _, target in pairs(ents.FindInSphere(self.Owner.Horde_Floating_Chaos:GetPos(), 1000)) do
			if HORDE:IsEnemy(target) and max_targets > 0 then
				local ent2 = ents.Create("projectile_horde_solar_orb")
				ent2:SetOwner(self.Owner)
				ent2.Owner = self.Owner
				ent2.properties = properties
				ent2:SetNWInt("charged", charged)
				ent2:SetPos( pos )
				ent2:SetAngles( Angle(0,0,0) )
				ent2:Spawn()

				local target_pos = target:GetPos() + target:OBBCenter()

				local velocity2 = (target_pos - pos)
				velocity2:Normalize()
				velocity2 = velocity2 * 1000

				local phys2 = ent2:GetPhysicsObject()
				if (!IsValid( phys2 )) then ent2:Remove() return end
				phys2:ApplyForceCenter(velocity2)

				fired = true
				max_targets = max_targets - 1
			end
		end

		if not fired then
			local ent2 = ents.Create("projectile_horde_solar_orb")
			ent2:SetOwner(self.Owner)
			ent2.Owner = self.Owner
			ent2.properties = properties
			ent2:SetNWInt("charged", charged)
			ent2:SetPos( pos )
			ent2:SetAngles( Angle(0,0,0) )
			ent2:Spawn()

			local target_pos = pos - Vector(0,0,1) * 10

			local velocity2 = (target_pos - pos)
			velocity2:Normalize()
			velocity2 = velocity2 * 1000

			local phys2 = ent2:GetPhysicsObject()
			if (!IsValid( phys2 )) then ent2:Remove() return end
			phys2:ApplyForceCenter(velocity2)
		end
	end
end

function SWEP:FloatingChaos()
	if CLIENT then return end
	if not self.Owner:Horde_GetPerk("artificer_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	if self.Weapon:Clip1() < 25 then return end
	self:TakePrimaryAmmo(25)
	self.Owner:EmitSound( "horde_solar_seal.floating_chaos_launch" )

	local tr = self.Owner:GetEyeTrace()
	if not tr.Hit then return end
	local pos = tr.HitPos
	pos.z = pos.z + 100
	local ent = ents.Create("projectile_horde_floating_chaos")
	ent:SetOwner(self.Owner)
	ent.Owner = self.Owner
	ent:SetPos( pos )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = Vector(0,0,1)
	velocity = velocity * 15
	phys:ApplyForceCenter(velocity)
end

function SWEP:LSS(pos, base_damage, e, properties)
    if CLIENT then return end
	if e:IsValid() and e:IsNPC() then
		pos = e:GetPos()
	end

	sound.Play("horde/weapons/solar_seal/hallowed_bolt_hit.ogg", pos, 100, math.random(90, 110), 1)

	for i = 1,7 do
		local LT = ents.Create("info_target")
		LT:SetKeyValue("targetname","bolt_target_" .. self.Owner:Name().. "_" .. tostring(i))
		local f = math.random(-25,25)
		local g = math.random(-25,25)
		LT:SetPos(Vector(pos.x + f, pos.y + g, -500))
		LT:Fire("kill","",0.5)
		LT:Spawn()

		local recovered = nil
		if i == 5 then
			for _, ent in pairs(ents.FindInSphere(pos, 50)) do
				if HORDE:IsEnemy(ent) then
					local dmg2 = DamageInfo()
					dmg2:SetDamage(base_damage * 5)
					dmg2:SetDamageType(DMG_SHOCK)
					dmg2:SetAttacker(self.Owner)
					dmg2:SetInflictor(self)
					dmg2:SetDamagePosition(ent:GetPos())
					ent:TakeDamageInfo(dmg2)
					if (not recovered) and ent:Health() < 0 then
						HORDE:SelfHeal(self.Owner, 25)
						recovered = true
						self.Weapon:SetClip1(math.max(0, self.Weapon:Clip1() + 25))
					end
					if properties.godslayer then
						ent:Horde_SetMostRecentFireAttacker(self.Owner, dmg2)
						ent:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
					end
				end
			end
		elseif i == 10 then
			timer.Simple(0.2, function ()
				if not IsValid(self) or not IsValid(self.Owner) then return end
				for _, ent in pairs(ents.FindInSphere(pos, 50)) do
					if HORDE:IsEnemy(ent) then
						local dmg2 = DamageInfo()
						dmg2:SetDamage(base_damage * 5)
						dmg2:SetDamageType(DMG_SHOCK)
						dmg2:SetAttacker(self.Owner)
						dmg2:SetInflictor(self)
						dmg2:SetDamagePosition(ent:GetPos())
						ent:TakeDamageInfo(dmg2)
						if (not recovered) and ent:Health() < 0 then
							HORDE:SelfHeal(self.Owner, 25)
							recovered = true
							self.Weapon:SetClip1(math.max(0, self.Weapon:Clip1() + 25))
						end
						if properties.godslayer then
							ent:Horde_SetMostRecentFireAttacker(self.Owner, dmg2)
							ent:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
						end
					end
				end
			end)
		end
	end

	local tr = util.TraceLine({
		start = pos,
		endpos = pos + Vector(0,0,1) * 10000,
		filter = function (ent)
			return ent:IsWorld()
		end,
	})
	
	local z_max = 100
	if tr.Hit then
		z_max = tr.HitPos.z
	else
		z_max = 500
	end

	timer.Simple(0.1, function ()
		for i = 1,10 do
			local LA = ents.Create("env_laser")
			LA:SetKeyValue("lasertarget", "bolt_target_" .. self.Owner:Name() .. "_" .. tostring(i))
			LA:SetKeyValue("rendercolor", "255 255 " .. tostring(math.random(200,255)))
			LA:SetKeyValue("texture", "sprites/laserbeam.spr")
			LA:SetKeyValue("dissolvetype", "1")
			LA:SetKeyValue("width", "5")
			LA:SetKeyValue("damage", "0")
			LA:SetKeyValue("spawnflags", "32")
			LA:SetKeyValue("noiseamplitude", "10")
			LA:SetKeyValue("clipstyle", "0")
			LA:SetOwner(self)
			LA:Spawn()
			LA:Fire("Kill","",0.5)
			local f = math.random(-25,25)
			local g = math.random(-25,25)
			LA:SetPos(Vector(pos.x + f,pos.y + g,z_max))
		end
	end)
end

function SWEP:HallowedBolt()
	if CLIENT then return end
	if not self.Owner:Horde_GetPerk("artificer_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	if self.Weapon:Clip1() < 40 then return end
	self:TakePrimaryAmmo(40)
	self.Owner:EmitSound("horde/weapons/solar_seal/hallowed_bolt_launch.ogg", 100, math.random(90, 110))

	local level = self.Owner:Horde_GetUpgrade("horde_solar_seal")
	local base_damage = 25 + 4 * level
	base_damage = base_damage * 1.25

	local tr = self.Owner:GetEyeTrace()
	local properties = {godslayer = false}
	hook.Run("Horde_OnSolarSealStrike", self.Owner, properties)

	if properties.godslayer == true then
		timer.Simple(0.3, function ()
			local cloud = ents.Create("horde_solar_orb_fire")
			cloud.BaseDamage = 25 + 3 * level
			cloud:SetRadiusScale(1.25)

			if !IsValid(cloud) then return end

			local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

			cloud:SetPos(tr.HitPos)
			cloud:SetAbsVelocity(vel + self:GetVelocity())
			cloud:SetOwner(self:GetOwner())
			cloud:Spawn()
		end)
    end
	
	if tr.Hit then
		local pos = tr.HitPos
		local ent = tr.Entity
		timer.Simple(0.3, function()
			if !IsValid(self) then return end
			self:LSS(pos, base_damage, ent, properties)
		end)
	end
end

if CLIENT then
net.Receive("Horde_SolarStormTracer", function ()
	local charged = net.ReadUInt(3)
	local startpos = util.StringToType(net.ReadString(), "Vector")
	local endpos = util.StringToType(net.ReadString(), "Vector")
	if charged == 1 then
		util.ParticleTracerEx("solar_storm_charged", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		util.ParticleTracerEx("solar_storm_charged", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("solar_storm_hit", endpos, Angle(0,0,0), nil)
	elseif charged == 3 then
		util.ParticleTracerEx("draconic_storm", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("draconic_storm_hit", endpos, Angle(0,0,0), nil)
	else
		util.ParticleTracerEx("solar_storm", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("solar_storm_hit", endpos, Angle(0,0,0), nil)
	end
end)
end

function SWEP:Strike(charged)
	if CLIENT then return end
	if not self.Owner:Horde_GetPerk("artificer_base") then return end
	local base_damage
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	if charged == 3 then
		if self.Weapon:Clip1() < 30 then return end
	elseif charged == 2 then
		if self.Weapon:Clip1() < 20 then return end
	elseif charged == 1 then
		if self.Weapon:Clip1() < 10 then return end
	else
		if self.Weapon:Clip1() < 5 then return end
	end

	self.SecondaryChargingTimer = CurTime() + 1

	local level = self.Owner:Horde_GetUpgrade("horde_solar_seal")
	base_damage = 25 + 7 * level
	base_damage = base_damage * 1.25

	local properties = {godslayer = false}
	hook.Run("Horde_OnSolarSealStrike", self.Owner, properties)
	if charged < 2 then
		self:FireBullets({
			Attacker = self.Owner,
			Damage = base_damage * (1 + 0.5 * charged),
			Tracer = 0,
			Distance = 4000,
			Dir = self.Owner:GetAimVector(),
			Src = self.Owner:GetShootPos(),
			Callback = function(att, tr, dmg)
				dmg:SetDamageType(DMG_SHOCK)
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)
				net.Start("Horde_SolarStormTracer")
					net.WriteUInt(charged, 3)
					net.WriteString(tostring(self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519)))
					net.WriteString(tostring(tr.HitPos))
				net.Broadcast()
				if tr.Entity:IsValid() and tr.Entity:IsNPC() then
					tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage()/2, self.Owner)
					if properties.godslayer then
						tr.Entity:Horde_SetMostRecentFireAttacker(self.Owner, dmg)
						tr.Entity:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
					end
				end
	
				if charged == 0 then
					self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 100, math.random(70, 90))
					sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 80, math.random(70, 90))
				elseif charged >= 1 then
					self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 120, math.random(100, 120))
					sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 120, math.random(100, 120))
				end

				if properties.godslayer == true and tr.Entity:IsWorld() then
					local cloud = ents.Create("horde_solar_orb_fire")
					cloud.BaseDamage = base_damage
					cloud:SetRadiusScale(0.66 + 0.34 * charged)
			
					if !IsValid(cloud) then return end
			
					local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500
			
					cloud:SetPos(tr.HitPos)
					cloud:SetAbsVelocity(vel + self:GetVelocity())
					cloud:SetOwner(self:GetOwner())
					cloud:Spawn()

					timer.Simple(0.5 * (1 + charged), function ()
						if cloud:IsValid() then cloud:Remove() end
					end)
				end
			end
		})
    elseif charged == 2 then
		for i = 1, 4 do
			self:FireBullets({
				Attacker = self.Owner,
				Damage = base_damage,
				Tracer = 0,
				Distance = 4000,
				Dir = self.Owner:GetAimVector(),
				Src = self.Owner:GetShootPos(),
				Spread = Vector(0.2, 0.2, 0),
				Callback = function(att, tr, dmg)
					dmg:SetDamageType(DMG_SHOCK)
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					net.Start("Horde_SolarStormTracer")
					net.WriteUInt(charged, 3)
						net.WriteString(tostring(self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519)))
						net.WriteString(tostring(tr.HitPos))
					net.Broadcast()
					if tr.Entity:IsValid() and tr.Entity:IsNPC() then
						tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage()/2, self.Owner)
						if properties.godslayer then
							tr.Entity:Horde_SetMostRecentFireAttacker(self.Owner, dmg)
							tr.Entity:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
						end
					end
					self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 100, math.random(70, 90))
					sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 80, math.random(70, 90))
					
					if properties.godslayer == true and tr.Entity:IsWorld() then
						local cloud = ents.Create("horde_solar_orb_fire")
						cloud.BaseDamage = base_damage
						cloud:SetRadiusScale(0.66)
				
						if !IsValid(cloud) then return end
				
						local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500
				
						cloud:SetPos(tr.HitPos)
						cloud:SetAbsVelocity(vel + self:GetVelocity())
						cloud:SetOwner(self:GetOwner())
						cloud:Spawn()
	
						timer.Simple(0.5, function ()
							if cloud:IsValid() then cloud:Remove() end
						end)
					end
					--util.ParticleTracerEx("solar_storm_charged", self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519), tr.HitPos, true, self:EntIndex(), -1)nd
				end
			})
		end
	elseif charged == 3 then
		for i = 1, 2 do
			self:FireBullets({
				Attacker = self.Owner,
				Damage = base_damage * 1.5,
				Tracer = 0,
				Distance = 4000,
				Dir = self.Owner:GetAimVector(),
				Src = self.Owner:GetShootPos(),
				Callback = function(att, tr, dmg)
					dmg:SetDamageType(DMG_SHOCK)
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					net.Start("Horde_SolarStormTracer")
					net.WriteUInt(charged, 3)
						net.WriteString(tostring(self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519)))
						net.WriteString(tostring(tr.HitPos))
					net.Broadcast()
					if tr.Entity:IsValid() and tr.Entity:IsNPC() then
						tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage()/2, self.Owner)
						if properties.godslayer then
							tr.Entity:Horde_SetMostRecentFireAttacker(self.Owner, dmg)
							tr.Entity:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
						end
					end
					
					self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 150, math.random(30, 50))
					sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 150, math.random(30, 50))
		
					--util.ParticleTracerEx("solar_storm_charged", self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519), tr.HitPos, true, self:EntIndex(), -1)nd
				end
			})
		end
		for i = 1, 2 do
			self:FireBullets({
				Attacker = self.Owner,
				Damage = base_damage,
				Tracer = 0,
				Distance = 4000,
				Dir = self.Owner:GetAimVector(),
				Src = self.Owner:GetShootPos(),
				Spread = Vector(0.1, 0.1, 0),
				Callback = function(att, tr, dmg)
					dmg:SetDamageType(DMG_SHOCK)
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					net.Start("Horde_SolarStormTracer")
					net.WriteUInt(charged, 3)
						net.WriteString(tostring(self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519)))
						net.WriteString(tostring(tr.HitPos))
					net.Broadcast()
					if tr.Entity:IsValid() and tr.Entity:IsNPC() then
						tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage()/2, self.Owner)
						if properties.godslayer then
							tr.Entity:Horde_SetMostRecentFireAttacker(self.Owner, dmg)
							tr.Entity:Ignite(self.Owner:Horde_GetApplyIgniteDuration())
						end
					end
					
					self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 150, math.random(30, 50))
					sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 150, math.random(30, 50))
		
					--util.ParticleTracerEx("solar_storm_charged", self.Owner:GetShootPos() + Vector(-0.519, 0.518, -0.519), tr.HitPos, true, self:EntIndex(), -1)nd
				end
			})
		end
	end
	if charged == 3 and self.Weapon:Clip1() >= 30 then
		self:TakePrimaryAmmo(30)
	elseif charged == 2 and self.Weapon:Clip1() >= 20 then
		self:TakePrimaryAmmo(20)
	elseif charged == 1 and self.Weapon:Clip1() >= 10 then
		self:TakePrimaryAmmo(10)
	else
		self:TakePrimaryAmmo(5)
	end
	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	end)

	if self.Owner.Horde_Floating_Chaos and self.Owner.Horde_Floating_Chaos:IsValid() then
		local pos = self.Owner.Horde_Floating_Chaos:GetPos()
		local chaos = self.Owner.Horde_Floating_Chaos

		local fired
		local max_targets = 5
		for _, target in pairs(ents.FindInSphere(self.Owner.Horde_Floating_Chaos:GetPos(), 1000)) do
			if HORDE:IsEnemy(target) and max_targets > 0 then
				local target_pos = target:GetPos() + target:OBBCenter()
				local dir = target_pos - pos
				dir:Normalize()
				self:FireBullets({
					Attacker = self.Owner,
					Damage = base_damage * (1 + 0.5 * charged),
					Tracer = 0,
					Distance = 4000,
					Dir = dir,
					Src = pos,
					IgnoreEntity = chaos,
					Callback = function(att, tr, dmg)
						dmg:SetDamageType(DMG_SHOCK)
						dmg:SetAttacker(self.Owner)
						dmg:SetInflictor(self)
						net.Start("Horde_SolarStormTracer")
							net.WriteUInt(charged, 3)
							net.WriteString(tostring(pos))
							net.WriteString(tostring(tr.HitPos))
						net.Broadcast()
						if tr.Entity:IsValid() and tr.Entity:IsNPC() then
							tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage()/2, self.Owner)
						end
			
						if charged == 0 then
							self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 100, math.random(70, 90))
							sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 80, math.random(70, 90))
						elseif charged >= 1 then
							self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 120, math.random(100, 120))
							sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 120, math.random(100, 120))
						elseif charged == 3 then
							self.Owner:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 150, math.random(30, 50))
							sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 150, math.random(30, 50))
						end
					end
				})
			end
		end
	end
end

function SWEP:Reload()
	if CLIENT then return end
	HORDE:UsePerkSkill(self.Owner)
end

function SWEP:Think()
	if SERVER and self.Charging == 1 and self.SecondaryCharging == 0 and !self.Owner:KeyDown( IN_ATTACK ) then
        self:SetNextPrimaryFire( CurTime() + self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()) )
        self.Charging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if self.ChargingTimer <= CurTime() - 0.5 and self.Owner:Horde_GetPerk("artificer_godslayer") then
			self:Launch(3)
		elseif self.ChargingTimer <= CurTime() then
			self:Launch(2)
		elseif self.ChargingTimer <= CurTime() + 0.5 then
			self:Launch(1)
		else
			self:Launch(0)
		end

		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_1" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_2" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_3" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_4" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_1" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_2" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_3" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_4" )

		self.ChargePlayed1 = nil
		self.ChargePlayed2 = nil
		self.ChargePlayed3 = nil
		self.ChargePlayed4 = nil
    end

	if SERVER and self.Charging == 0 and self.SecondaryCharging == 1 and !self.Owner:KeyDown( IN_ATTACK2 ) then
        self:SetNextSecondaryFire( CurTime() + self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()) )
        self.SecondaryCharging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if self.SecondaryChargingTimer <= CurTime() - 0.5 and self.Owner:Horde_GetPerk("artificer_draconic_reckoning") then
			self:Strike(3)
		elseif self.SecondaryChargingTimer <= CurTime() then
			self:Strike(2)
		elseif self.SecondaryChargingTimer <= CurTime() + 0.5 then
			self:Strike(1)
		else
			self:Strike(0)
		end

		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_1" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_2" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_3" )
		self.Owner:StopSound( "horde_solar_seal.solar_orb_charge_4" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_1" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_2" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_3" )
		self.Owner:StopSound( "horde_solar_seal.solar_storm_charge_4" )

		self.ChargePlayed1 = nil
		self.ChargePlayed2 = nil
		self.ChargePlayed3 = nil
		self.ChargePlayed4 = nil
    end

	if self.Charging == 1 and self.SecondaryCharging == 1 then
		self.SecondaryCharging = 0
	end

	if SERVER and (self.Charging == 1 and self.SecondaryCharging == 0) and self.ChargeSoundTimer <= CurTime() then
		if self.ChargingTimer <= CurTime() - 0.5 and (not self.ChargePlayed4) and self.Owner:Horde_GetPerk("artificer_godslayer") then
			self.Owner:EmitSound( "horde_solar_seal.solar_orb_charge_4" )
			self.ChargePlayed4 = true
		elseif self.ChargingTimer <= CurTime() and (not self.ChargePlayed1) then
			self.Owner:EmitSound( "horde_solar_seal.solar_orb_charge_3" )
			self.ChargePlayed1 = true
		elseif self.ChargingTimer <= CurTime() + 0.5 and (not self.ChargePlayed2) then
			self.Owner:EmitSound( "horde_solar_seal.solar_orb_charge_2" )
			self.ChargePlayed2 = true
		elseif (not self.ChargePlayed3) then
			self.Owner:EmitSound( "horde_solar_seal.solar_orb_charge_1" )
			self.ChargePlayed3 = true
		end

		self.ChargeSoundTimer = CurTime() + 0.25
	end

	if SERVER and (self.SecondaryCharging == 1 and self.Charging == 0) and self.ChargeSoundTimer <= CurTime() then
		if self.SecondaryChargingTimer <= CurTime() - 0.5 and (not self.ChargePlayed4) and self.Owner:Horde_GetPerk("artificer_draconic_reckoning") then
			self.Owner:EmitSound( "horde_solar_seal.solar_storm_charge_4" )
			self.ChargePlayed4 = true
		elseif self.SecondaryChargingTimer <= CurTime() and (not self.ChargePlayed1) then
			self.Owner:EmitSound( "horde_solar_seal.solar_storm_charge_3" )
			self.ChargePlayed1 = true
		elseif self.SecondaryChargingTimer <= CurTime() + 0.5 and (not self.ChargePlayed2) then
			self.Owner:EmitSound( "horde_solar_seal.solar_storm_charge_2" )
			self.ChargePlayed2 = true
		elseif (not self.ChargePlayed3) then
			self.Owner:EmitSound( "horde_solar_seal.solar_storm_charge_1" )
			self.ChargePlayed3 = true
		end

		self.ChargeSoundTimer = CurTime() + 0.25
	end

	if SERVER and self.EnergyRegenTimer <= CurTime() then
		local regen_delay = {delay = 0.25}
		hook.Run("Horde_OnSolarSealRegen", self.Owner, regen_delay)
		local intensity_stack = self.Owner:Horde_GetIntensityStack()
		regen_delay.delay = regen_delay.delay * (1 - 0.1 * intensity_stack)
		self.EnergyRegenTimer = CurTime() + regen_delay.delay
		self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + 1))
	end
end

/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Dont come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/

if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		if self.Owner:KeyDown(IN_ATTACK) then
			local vm = LocalPlayer():GetViewModel()
			local endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150


		end
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		if IsValid(self.Owner) and self.Owner:KeyDown(IN_ATTACK) then
			local endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150


		end
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we cant do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or youll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end


