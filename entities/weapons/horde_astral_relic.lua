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
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_astral_relic" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_astral_relic", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_nether_star", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_nether_mine", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
end

SWEP.IronSightsPos = Vector(5.15, 0, 0.72)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.PrintName 		= "Astral Relic"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates negative energy fields."
SWEP.Purpose 		= "Warlock Unique Weapon."

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
        sprite = "sprites/blueflare1",
        bone = "ValveBiped.Grenade_body",
        rel = "",
        pos = Vector(-0.519, 0.518, -0.519),
        size = { x = 6, y = 6 },
        color = Color(0, 255, 255, 255),
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
	util.AddNetworkString("Horde_NetherMineTracer")
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

	
	cam.Start3D(self.Owner:EyePos(), self.Owner:EyeAngles())
	render.SetMaterial(Material("Sprites/light_glow02_add_noz"))
	render.DrawQuadEasy(tr.HitPos, (self.Owner:EyePos() - tr.HitPos):GetNormal(), 5, 5, Color(0,255,255,255), 0)
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
    if self:CanPrimaryAttack() and self.Weapon:Clip1() >= 10 then
        if IsValid(self.Owner) then
			if not self.Owner:Horde_GetPerk("warlock_base") then return end
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
		if not self.Owner:Horde_GetPerk("warlock_base") then return end
		self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
		self.SecondaryCharging = 1
		self.SecondaryChargingTimer = CurTime() + 1
	end
end

function SWEP:RecoverEnergy(energy)
	if CLIENT then return end
	self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + energy))
end

function SWEP:NegativeBurst()
	if CLIENT then return end
	if self.Weapon:Clip1() < 30 then return true end
	self:TakePrimaryAmmo(30)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local missing = self.Primary.MaxAmmo - self:Clip1()
	timer.Simple(0.3, function ()
		if not self.Owner:IsValid() then return end
		local dmg_splash = DamageInfo()
		dmg_splash:SetAttacker(self.Owner)
		dmg_splash:SetInflictor(self)
		dmg_splash:SetDamageType(DMG_GENERIC)
		dmg_splash:SetDamage(5 * missing)
		dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)

		HORDE:ApplyDamageInRadius(self:GetPos(), 350, dmg_splash, function (ent)
			if ent:IsValid() then
				local dir = ent:GetPos() - self:GetPos()
				dir:Normalize()
				ent:SetVelocity(dir * 8000)

				if ent:Health() < 0 then
					self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + 10))
				end
			end
		end)

		local e = EffectData()
			e:SetOrigin(self:GetPos())
		util.Effect("negative_burst", e, true, true)
	end)

	hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 30)
    

	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	end)
end

function SWEP:GravityVacuum()
	if CLIENT then return end
	--if self.Weapon:Clip1() < 10 then return true end
	--self:TakePrimaryAmmo(10)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local tr = util.TraceLine(util.GetPlayerTrace(self.Owner))
	if tr.Entity and tr.Entity:IsValid() then
		sound.Play("horde/weapons/nether_relic/dirac_sea.ogg", self:GetPos(), 100, math.random(90, 110))
		if HORDE:IsEnemy(tr.Entity) then
			--ParticleEffect("dirac_star_attract", tr.Entity:GetPos() + tr.Entity:OBBCenter(), Angle(0,0,0))
			if self.Owner.Horde_Nether_Stars then
				for _, star in pairs(self.Owner.Horde_Nether_Stars) do
					star.Target = tr.Entity
					star:SetPos(star.Target:GetPos()+ star.Target:OBBCenter())
					star.AttachedToTarget = nil
				end
			end

			for _, ent in pairs(ents.FindInSphere(tr.Entity:GetPos(), 300)) do
				if ent:GetClass() == "projectile_horde_nether_mine" and ent.Owner == self.Owner then
					ent.Target = tr.Entity
				end
			end
		elseif self.Owner:Horde_GetPerk("warlock_celestial_bond") and tr.Entity:IsPlayer() then
			--ParticleEffect("dirac_star_attract", tr.Entity:GetPos() + tr.Entity:OBBCenter(), Angle(0,0,0))
			for _, star in pairs(self.Owner.Horde_Nether_Stars) do
				star.Target = tr.Entity
				star:SetPos(star.Target:GetPos()+ star.Target:OBBCenter())
				star.AttachedToTarget = nil
			end
		else
			return true
		end
	else
		return true
	end

	hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 10)

	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	end)
end

function SWEP:DiracSea()
	if CLIENT then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local tr = util.TraceLine(util.GetPlayerTrace(self.Owner))
	local pos = tr.HitPos
	local ent = ents.Create("projectile_horde_dirac_sea")
	ent:SetOwner(self.Owner)
	ent.Owner = self.Owner
	if (!IsValid(ent)) then return end
	ent:SetPos(pos + 32 * Vector(0,0,1))
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	end)
end

function SWEP:AstralJudegement()
	if CLIENT then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local tr = util.TraceLine(util.GetPlayerTrace(self.Owner))
	local detonated = nil
	if tr.Entity and tr.Entity:IsValid() then
		if HORDE:IsEnemy(tr.Entity) then
			for _, ent in pairs(ents.FindInSphere(tr.Entity:GetPos(), 250)) do
				if ent:GetClass() == "projectile_horde_nether_star" and ent.Owner == self.Owner then
					ent:Detonate()
					detonated = true
				elseif ent:GetClass() == "projectile_horde_nether_mine" and ent.Owner == self.Owner then
					ent:Detonate()
					detonated = true
				end
			end
			if not detonated then
				return true
			end
		end
	else
		return true
	end

	timer.Create("UniqueName1", self.Delay * (1 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	end)
end

function SWEP:NetherStar(charged)
    if CLIENT then return end
	if not self.Owner:Horde_GetPerk("warlock_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

	if self.Weapon:Clip1() < 10 then return end

	local stars_count = 0
	local max_stars_count = 2
	local ply = self.Owner
	local is_first = nil
	if ply:IsValid() then
		if ply:Horde_GetPerk("warlock_celestial_bond") then
			max_stars_count = max_stars_count + 1
		end
		if ply:Horde_GetPerk("warlock_magnetar") then
			max_stars_count = max_stars_count + 1
		end
		if ply:Horde_GetPerk("warlock_starscourge") then
			max_stars_count = max_stars_count + 1
		end
		if not ply.Horde_Nether_Stars then ply.Horde_Nether_Stars = {} end
		stars_count = table.Count(ply.Horde_Nether_Stars)
		if stars_count == 0 then
			is_first = true
		end
		if stars_count >= max_stars_count then
			local star = ply.Horde_Nether_Stars[1]
			if star and star:IsValid() then
				if star:GetCharged() == 1 then
					local star2 = ply.Horde_Nether_Stars[2]
					ply.Horde_Nether_Stars[1] = star2
					ply.Horde_Nether_Stars[2] = star
				end
				ply.Horde_Nether_Stars[1]:SilentRemove()
				table.remove(ply.Horde_Nether_Stars, 1)
			end
		end
	end

	self.ChargingTimer = CurTime() + 1
	self.Owner:EmitSound("horde/weapons/nether_relic/nether_star_launch.ogg", 100, math.random(90, 110))

	local tr = util.TraceHull( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100000 ),
		filter = self.Owner,
		mins = Vector( -10, -10, -10 ),
		maxs = Vector( 10, 10, 10 ),
		mask = MASK_SHOT_HULL
	})
	
	local properties = {coalesce = false, celestial_bond = false, magnetar = false, starscourge = false, target = tr.Entity, charged = charged, level = self.Owner:Horde_GetUpgrade("horde_astral_relic")}
	if is_first and self.Owner:Horde_GetPerk("warlock_starscourge") then
		properties.starscourge = true
	end
	hook.Run("Horde_OnNetherStarLaunch", self.Owner, properties)
	local ent = ents.Create("projectile_horde_nether_star")
    ent:SetOwner(self.Owner)
    ent.Owner = self.Owner
	ent.properties = properties
	if is_first == true and properties.starscourge == true then
		ent:SetCharged(1)
	else
		ent:SetCharged(0)
	end
	
    if (!IsValid(ent)) then return end

	self:TakePrimaryAmmo(10)
    ent:SetPos( self.Owner:EyePos() + (self.Owner:GetAimVector() * 16 ))
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = self.Owner:GetAimVector()
	velocity = velocity * 500
	--velocity = velocity + (VectorRand() * 10) -- a random element
	phys:ApplyForceCenter(velocity)
	timer.Create("UniqueName1", 0.75, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload( ACT_VM_DRAW )
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)

	table.insert(ply.Horde_Nether_Stars, ent)

	ply:Horde_SyncStatus(HORDE.Status_Nether_Star, table.Count(ply.Horde_Nether_Stars))

	hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 10)
end

function SWEP:NetherMine(charged)
    if CLIENT then return end
	if not self.Owner:Horde_GetPerk("warlock_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local expected_count_percentage = 0
	if charged == 3 then
	elseif charged == 2 then
		expected_count_percentage = 5
		if self.Weapon:Clip1() < 20 then
			return
		end
	elseif charged == 1 then
		expected_count_percentage = 3
		if self.Weapon:Clip1() < 10 then
			return
		end
	else
		expected_count_percentage = 1
		if self.Weapon:Clip1() < 5 then
			return
		end
	end

	local mines_count = 0
	local max_mines_count = 5
	local ply = self.Owner
	if ply:IsValid() then
		if ply:Horde_GetPerk("warlock_coalesce") then
			max_mines_count = max_mines_count + 5
		end
		local expected_count = expected_count_percentage
		if not ply.Horde_Nether_Mines then ply.Horde_Nether_Mines = {} end
		mines_count = table.Count(ply.Horde_Nether_Mines)
		local over_amount = mines_count + expected_count - max_mines_count
		for i = 1,over_amount do
			if ply.Horde_Nether_Mines[1] and ply.Horde_Nether_Mines[1]:IsValid() then
				ply.Horde_Nether_Mines[1]:Remove()
			end
			
			table.remove(ply.Horde_Nether_Mines, 1)
		end
	end

	self.ChargingTimer = CurTime() + 1
	if charged <= 1 then
		self.Owner:EmitSound("horde/weapons/nether_relic/nether_mine_launch.ogg", 100, math.random(90, 110))
	else
		self.Owner:EmitSound("horde/weapons/nether_relic/solar_orb_charged_launch.ogg", 100, math.random(90, 110))
	end
	
	local properties = {dirac_sea = false, coalesce = false, charged = charged, level = self.Owner:Horde_GetUpgrade("horde_astral_relic")}
	hook.Run("Horde_OnNetherMineLaunch", self.Owner, properties)

	local total = expected_count_percentage
	local speed = 500
	local spread = 0
	if charged == 2 then
		speed = 500
		spread = 0.3
	elseif charged == 1 then
		speed = 500
		spread = 0.2
	end
	
	for i = 1, total do
		local ent = ents.Create("projectile_horde_Nether_Mine")
		ent:SetOwner(self.Owner)
		ent.Owner = self.Owner
		ent.properties = properties
		ent:SetCharged(charged)
		if (!IsValid(ent)) then return end
		ent:SetPos( self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 16 ))
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if (!IsValid( phys )) then ent:Remove() return end
		local velocity = self.Owner:GetAimVector()
		if total > 1 then
			local angle = velocity:Angle()
			local spread_x = angle:Up()
			local spread_y = angle:Up():Cross(angle:Forward())
			--spread_y:Rotate(Angle(0, 0, 90))
			local p = (math.random() - 0.5) * spread
			local p2 = (math.random() - 0.5) * spread
			local spread_xy = spread_x * p + spread_y * p2
			velocity = velocity + spread_xy
		end
		
		velocity:Normalize()
		velocity = velocity * speed
		phys:ApplyForceCenter(velocity)

		if ply:IsValid() then
			if not ply.Horde_Nether_Mines then ply.Horde_Nether_Mines = {} end
			table.insert(ply.Horde_Nether_Mines, ent)
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

	ply:Horde_SyncStatus(HORDE.Status_Nether_Mine, table.Count(ply.Horde_Nether_Mines))

	hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 5)
	
	timer.Create("UniqueName1", self.Delay * (0.5 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
            self.Weapon:DefaultReload( ACT_VM_DRAW )
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
end

function SWEP:ChargeMines()
	if not self.Owner:Horde_GetPerk("warlock_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

	local ply = self.Owner
	if not ply.Horde_Nether_Mines then ply.Horde_Nether_Mines = {} return end

	for _, mine in pairs(ply.Horde_Nether_Mines) do
		--mine:StopParticles()
		local charge_level = mine:GetCharged() + 1
		if charge_level == 1 then
			mine:PhysicsInitSphere( 32 )
		elseif charge_level == 2 then
			mine:PhysicsInitSphere( 64 )
		end
		mine:SetCharged(math.min(2, mine:GetCharged() + 1))
		mine.ExplodeTimer = CurTime() + 60
	end

	hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 0)

	self.Owner:EmitSound("horde/weapons/nether_relic/nether_mine_charge.ogg", 100, math.random(90, 110))

	timer.Create("UniqueName1", self.Delay * (0.5 - 0.08 * self.Owner:Horde_GetIntensityStack()), 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		end
	end)
end

function SWEP:DetonateStars()
	local ply = self.Owner
	if !ply:IsValid() then return end
	if ply.Horde_Nether_Stars then
		for _, star in pairs(ply.Horde_Nether_Stars) do
			if star:IsValid() then
				star:Detonate(true)
			end
		end
		hook.Run("Horde_OnNetherRelicPostCast", self.Owner, self, 0)
	end
end

function SWEP:Reload()
	if CLIENT then return end
	HORDE:UsePerkSkill(self.Owner)
end

function SWEP:Think()
	if SERVER and self.Charging == 1 and self.SecondaryCharging == 0 and !self.Owner:KeyDown( IN_ATTACK ) then
        self:SetNextPrimaryFire( CurTime() + 0.75 )
        self.Charging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if self.ChargingTimer <= CurTime() then
			self:DetonateStars()
		elseif self.ChargingTimer <= CurTime() + 0.5 then
			self:DetonateStars()
		else
			self:NetherStar(0)
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

	if SERVER and self.Charging == 1 and self.ChargingTimer <= CurTime() + 0.5 then
		self:DetonateStars()
		self.Charging = 0
	end

	if SERVER and self.Charging == 0 and self.SecondaryCharging == 1 and !self.Owner:KeyDown( IN_ATTACK2 ) then
		self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.SecondaryCharging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if self.SecondaryChargingTimer <= CurTime() then
			self:ChargeMines()
		elseif self.SecondaryChargingTimer <= CurTime() + 0.5 then
			self:ChargeMines()
		else
			self:NetherMine(0)
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

	if SERVER and self.SecondaryCharging == 1 and self.SecondaryChargingTimer <= CurTime() + 0.5 then
		self:ChargeMines()
		self.SecondaryCharging = 0
	end

	if self.Charging == 1 and self.SecondaryCharging == 1 then
		self.SecondaryCharging = 0
	end

	--[[if SERVER and (self.Charging == 1 and self.SecondaryCharging == 0) and self.ChargeSoundTimer <= CurTime() then
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
	end]]--

	if SERVER and self.EnergyRegenTimer <= CurTime() then
		self.EnergyRegenTimer = CurTime() + 0.25
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


