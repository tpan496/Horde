SWEP.Base = "horde_spell_weapon_base"

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_astral_relic" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_astral_relic", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_nether_star", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_nether_mine", "vgui/hud/horde_astral_relic", Color( 255, 255, 255, 255 ) )
end

SWEP.PrintName 		= "Astral Relic"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates negative energy fields."
SWEP.Purpose 		= "Warlock Unique Weapon."
SWEP.Category = "ArcCW - Horde"
SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

if CLIENT then
SWEP.VElements = {
	["astral_relic"] = {
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

function SWEP:Horde_GetChargingSound()
    return "horde/spells/charge.ogg"
end

function SWEP:Horde_GetChargingSoundNextThink()
    return 1
end

if SERVER then
	util.AddNetworkString("Horde_NetherMineTracer")
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