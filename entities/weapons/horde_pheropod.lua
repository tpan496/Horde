if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_pheropod" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_pheropod", "vgui/hud/horde_pheropod", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_pheropod", "vgui/hud/horde_pheropod", Color( 255, 255, 255, 255 ) )
end

SWEP.IronSightsPos = Vector(5.15, 0, 0.72)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.PrintName 		= "Pheropod"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Incubates and cotnrols Antlions."
SWEP.Purpose 		= "Hatcher Unique Weapon."

SWEP.AdminSpawnable = false
SWEP.Spawnable 		= true

SWEP.ViewModelFOV 	= 60
SWEP.ViewModel = "models/weapons/v_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"

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

SWEP.Primary.MaxAmmo = 90
SWEP.Primary.ClipSize = -1

if ( CLIENT ) then
--SWEP.WepSelectIcon = surface.GetTextureID( "/vgui/icons/icon_pyromancyflame1.vmt" )
end

SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true


SWEP.base = "weapon_base"

SWEP.Secondary.Sound = "Weapon_Pistol.NPC_Single"
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.ClipSize = 0

SWEP.Delay = 1

SWEP.Charging = 0
SWEP.ChargingTimer = 0
SWEP.ChargeSoundTimer = 0

SWEP.SecondaryCharging = 0
SWEP.SecondaryChargingTimer = 0
SWEP.SecondaryChargeSoundTimer = 0

SWEP.EnergyRegenTimer = 0

local ShootSound = Sound( "weapons/bugbait/bugbait_squeeze3.wav" )

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
	local size = 5
	render.SetMaterial(Material("Sprites/light_glow02_add_noz"))
	render.DrawQuadEasy(tr.HitPos, (self.Owner:EyePos() - tr.HitPos):GetNormal(), size, size, Color(0,255,0,255), 0)
	cam.End3D()
    end
end

function SWEP:Initialize()
	timer.Simple(0, function()
		if not self:IsValid() then return end
		if self.Owner and not self.Owner:IsValid() then return end
		self.Owner:SetAmmo(100, "Thumper")
	end)
end

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() then
        if IsValid(self.Owner) then
			if not self.Owner:Horde_GetPerk("hatcher_base") then return end
			self.Weapon:SendWeaponAnim( ACT_VM_HAULBACK )
			self:SetNextPrimaryFire( CurTime() + self.Delay )
			self:SetNextSecondaryFire( CurTime() + self.Delay )
			self.Charging = 1
			self.ChargingTimer = CurTime() + 1
        end
    end
end

function SWEP:Throw(level)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	timer.Simple(0.2, function ()
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end)
	self:EmitSound( ShootSound )
	if ( CLIENT ) then return end
	local ent	= ents.Create( "projectile_horde_pheropod" )
	if ( !IsValid( ent ) ) then return end
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 10 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent.properties = {level = 1, type = self.VirusType}
	ent.Owner = self.Owner
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
    local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000 * (level + 1)
	velocity = velocity + ( VectorRand() * 5 )
	phys:ApplyForceCenter( velocity )
end

function SWEP:UpgradeReset()
	if not HORDE.player_drop_entities[self.Owner:SteamID()] then return end
	for id, ent in pairs(HORDE.player_drop_entities[self.Owner:SteamID()]) do
        if ent:IsValid() and ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" then
            ent:UpgradeReset()
        end
    end
end

function SWEP:RaiseAntlion()
	if IsValid(self.Owner) then
		if not self.Owner:Horde_GetPerk("hatcher_base") then return end
	end
	if self.Owner:Horde_GetPerk("hatcher_swarm") then
		if HORDE:GetAntlionMinionsCount(self.Owner) > 1 then return end
	else
		if HORDE:GetAntlionMinionsCount(self.Owner) > 0 then return end
	end

	if self.Weapon:Clip1() < 40 then return end
	self:TakePrimaryAmmo(40)
	
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self.SecondaryCharging = 1
	self.SecondaryChargingTimer = CurTime() + 1
	
	local ply = self.Owner
	local ent = ents.Create("npc_vj_horde_antlion")
	local pos = ply:GetPos()
	local dir = (ply:GetEyeTrace().HitPos - pos)
	dir:Normalize()
	local drop_pos = pos + dir * 50
	ent:SetPos(drop_pos)
	ent:SetOwner(ply)
	ply:Horde_AddDropEntity(ent:GetClass(), ent)
	ent:SetNWEntity("HordeOwner", ply)
	local properties = {level = self.Owner:Horde_GetUpgrade("horde_pheropod")}
	ent.properties = properties
	ent:Spawn()

	timer.Simple(0.1, function ()
		ent:AddRelationship("player D_LI 99")
		ent:AddRelationship("ally D_LI 99")
		if HORDE.items["npc_vj_horde_vortigaunt"] then
			ent:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
		end
		if HORDE.items["npc_vj_horde_combat_bot"] then
			ent:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
		end
		if HORDE.items["npc_turret_floor"] then
			ent:AddRelationship("npc_turret_floor D_LI 99")
		end
		if HORDE.items["npc_manhack"] then
			ent:AddRelationship("npc_manhack D_LI 99")
		end
		ent:AddRelationship("npc_vj_horde_spectre D_LI 99")
		ent:AddRelationship("npc_vj_horde_shadow_hulk D_LI 99")
		ent:AddRelationship("npc_vj_horde_headcrab D_LI 99")

		ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)
		ent:CallOnRemove("Horde_EntityRemoved", function()
			if ent:IsValid() and ply:IsValid() then
				timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
				ply:Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
				ply:Horde_SyncEconomy()
				ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
			end
		end)

		ent.VJFriendly = false
	end)

	ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	local id = ent:GetCreationID()
	timer.Create("Horde_MinionCollision" .. id, 1, 0, function ()
		if not ent:IsValid() then timer.Remove("Horde_MinionCollision" .. id) return end
		ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	if IsValid(self.Owner) then
		if not self.Owner:Horde_GetPerk("hatcher_base") then return end
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		self.SecondaryCharging = 1
		self.SecondaryChargingTimer = CurTime() + 1
	end
end

function SWEP:Come()
	if not HORDE.player_drop_entities[self.Owner:SteamID()] then return end
	for id, ent in pairs(HORDE.player_drop_entities[self.Owner:SteamID()]) do
		if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" then
			ent:SetLastPosition(self.Owner:GetPos())
			ent:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function SWEP:Think()
	if self.Charging == 1 and !self.Owner:KeyDown( IN_ATTACK ) then
        self:SetNextPrimaryFire( CurTime() + self.Delay )
        --self:SetNextSecondaryFire( CurTime() + self.Delay )
        self.Charging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()

		if self.ChargingTimer <= CurTime() then
			self:Throw(2)
		elseif self.ChargingTimer <= CurTime() + 0.5 then
			self:Throw(1)
		else
			self:Throw(0)
		end
    end

	if self.SecondaryCharging == 1 and self.SecondaryChargingTimer <= CurTime() + 0.5 then
		self:Come()
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		self.SecondaryChargingTimer = CurTime() + 1
	end

	if self.SecondaryCharging == 1 and !self.Owner:KeyDown( IN_ATTACK2 ) then
        --self:SetNextPrimaryFire( CurTime() + self.Delay )
        --self:SetNextSecondaryFire( CurTime() + self.Delay )
        self.SecondaryCharging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()

		if self.SecondaryChargingTimer <= CurTime() then
			self:Come()
		elseif self.SecondaryChargingTimer <= CurTime() + 0.5 then
			self:Come()
		else
			self:RaiseAntlion()
		end
    end

	if SERVER and self.EnergyRegenTimer <= CurTime() then
		self.EnergyRegenTimer = CurTime() + 0.25
		self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + 1))
	end
end