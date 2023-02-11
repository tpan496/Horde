sound.Add({
name = "Weapon_Void_Projector.Double_2",
channel = CHAN_WEAPON,
volume = VOL_NORM,
pitch = 100,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})
sound.Add({
name = "Weapon_Void_Projector.Double_3",
channel = CHAN_WEAPON,
volume = VOL_NORM,
pitch = 125,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})
sound.Add({
name = "Weapon_Void_Projector.Double_4",
channel = CHAN_WEAPON,
volume = VOL_NORM,
pitch = 150,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_void_projector" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_void_projector", "vgui/hud/horde_void_projector", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_void_projectile", "vgui/hud/horde_void_projector", Color( 255, 255, 255, 255 ) )
end

SWEP.IronSightsPos = Vector(5.15, 0, 0.72)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.PrintName 		= "Void Projector"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates dark energy."
SWEP.Purpose 		= "Necromancer Unique Weapon."

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
	["void_projector"] = {
        type = "Sprite",
        sprite = "sprites/blueflare1",
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
SWEP.Secondary.ClipSize = 0

SWEP.Delay = 1

SWEP.Charging = 0
SWEP.ChargingTimer = 0
SWEP.ChargeSoundTimer = 0

SWEP.SecondaryCharging = 0
SWEP.SecondaryChargingTimer = 0
SWEP.SecondaryChargeSoundTimer = 0

SWEP.EnergyRegenTimer = 0
SWEP.SpectreMaxCount = 1

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
	render.DrawQuadEasy(tr.HitPos, (self.Owner:EyePos() - tr.HitPos):GetNormal(), size, size, Color(100,150,200,255), 0)
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
			if not self.Owner:Horde_GetPerk("necromancer_base") then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
			self:SetNextPrimaryFire( CurTime() + self.Delay )
			--self:SetNextSecondaryFire( CurTime() + self.Delay )
			self.Charging = 1
			self.ChargingTimer = CurTime() + 1
        end
    end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	if IsValid(self.Owner) then
		if not self.Owner:Horde_GetPerk("necromancer_base") then return end
		self.SecondaryCharging = 1
		self.SecondaryChargingTimer = CurTime() + 1
	end
end

function SWEP:CreateSpectre(ply, properties, pos2)
	local ent = ents.Create("npc_vj_horde_spectre")
	ent.properties = properties
	local pos = ply:GetPos()
	local dir = (ply:GetEyeTrace().HitPos - pos)
	dir:Normalize()
	local drop_pos = pos + dir * 50
	drop_pos.z = pos.z + 24
	if pos2 then
		drop_pos = pos2
	end
	ent:SetPos(drop_pos)
	ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
	ply:Horde_AddDropEntity(ent:GetClass(), ent)
	ent:SetNWEntity("HordeOwner", ply)
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

		--ent.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
	end)
	local npc_info = list.Get("NPC")[ent:GetClass()]
	if not npc_info then
		print("[HORDE] NPC does not exist in ", list.Get("NPC"))
	end

	-- Special case for turrets
	local id = ent:GetCreationID()
	ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	timer.Create("Horde_MinionCollision" .. id, 1, 0, function ()
		if not ent:IsValid() then timer.Remove("Horde_MinionCollision" .. id) return end
		ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	end)

	-- Count Minions
	self.Owner:Horde_SetMinionCount(self.Owner:Horde_GetMinionCount() + 1)

	ent:CallOnRemove("Horde_EntityRemoved", function()
		if ent:IsValid() and ply:IsValid() then
			timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
			ply:Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
			ply:Horde_SyncEconomy()
			ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
		end
	end)
end

function SWEP:RaiseSpectre()
	local cost = 40
	local properties = {hollow_essence = false, abyssal_might = false, necromastery = false, level = self.Owner:Horde_GetUpgrade("horde_void_projector")}
	hook.Run("Horde_OnRaiseSpectre", self.Owner, properties)
	if properties.hollow_essence == true then
		cost = cost - 16
	end
	--if properties.necromastery == true then
	--	cost = cost - 12.5
	--end
	if self.Weapon:Clip1() >= cost then
		--self:SetNextSecondaryFire( CurTime() + self.Delay / 2 )
		local ply = self.Owner
		if not ply:Horde_GetPerk("necromancer_base") then return end
		if ply.Horde_drop_entities["npc_vj_horde_spectre"] and ply.Horde_drop_entities["npc_vj_horde_spectre"] >= (ply.Horde_Spectre_Max_Count) then
			return
		end
		self.SecondaryCharging = 0
		self:TakePrimaryAmmo(cost)
		self:CreateSpectre(ply, properties)
	end
end

function SWEP:RecoverEnergy(energy)
	if CLIENT then return end
	self:SetClip1(math.min(self.Primary.MaxAmmo, self:Clip1() + energy))
end

function SWEP:Launch(charged)
    if CLIENT then return end
	if not self.Owner:Horde_GetPerk("necromancer_base") then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	if charged == 2 then
		if self.Weapon:Clip1() < 20 then return end
	elseif charged == 1 then
		if self.Weapon:Clip1() < 10 then return end
	else
		if self.Weapon:Clip1() < 5 then return end
	end
	self.Owner:EmitSound("horde/weapons/void_projector/void_spear_launch.ogg", 100, math.random(70, 90))
	local properties = {sphere = false, battery = false, energy = self.Weapon:Clip1(), field = false, charged = charged, beacon_of_void = false, level = self.Owner:Horde_GetUpgrade("horde_void_projector")}
	hook.Run("Horde_OnVoidProjectorLaunch", self.Owner, properties)
	local ent = ents.Create("projectile_horde_void_projectile")
    ent:SetOwner(self.Owner)
    ent.Owner = self.Owner
	ent.properties = properties
	ent:SetCharged(charged)
    if (!IsValid(ent)) then return end
	if charged == 2 and self.Weapon:Clip1() >= 20 then
		self:TakePrimaryAmmo(20)
	elseif charged == 1 and self.Weapon:Clip1() >= 10 then
		self:TakePrimaryAmmo(10)
	else
		self:TakePrimaryAmmo(5)
	end
    ent:SetPos( self.Owner:EyePos() + (self.Owner:GetAimVector() * 16 ))
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	if charged == 1 then
		local p2 = table.Copy(properties)
		p2.charged = 0
		local ent1 = ents.Create("projectile_horde_void_projectile")
		ent1:SetOwner(self.Owner)
		ent1.Owner = self.Owner
		ent1.properties = p2
		ent1:SetNWInt("charged", 0)
		if (!IsValid(ent1)) then return end
		local ar = self.Owner:EyeAngles()
		ar:RotateAroundAxis(ar:Up(), 15 )
		ent1:SetPos( self.Owner:EyePos() + (ar:Forward() * 16 ))
		ent1:SetAngles(ar)
		ent1:Spawn()
		local phys1 = ent1:GetPhysicsObject()
		local v1 = ar:Forward()
		v1 = v1 * 1000
		phys1:ApplyForceCenter(v1)

		local ent2 = ents.Create("projectile_horde_void_projectile")
		ent2:SetOwner(self.Owner)
		ent2.Owner = self.Owner
		ent2.properties = p2
		ent2:SetNWInt("charged", 0)
		if (!IsValid(ent2)) then return end
		local al = self.Owner:EyeAngles()
		al:RotateAroundAxis(ar:Up(), -15 )
		ent2:SetPos( self.Owner:EyePos() + (al:Forward() * 16 ))
		ent2:SetAngles(al)
		ent2:Spawn()
		local phys2 = ent2:GetPhysicsObject()
		local v2 = al:Forward()
		v2 = v2 * 1000
		phys2:ApplyForceCenter(v2)
	end
	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	--velocity = velocity + (VectorRand() * 10) -- a random element
	phys:ApplyForceCenter(velocity)
	timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload( ACT_VM_DRAW )
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
end

function SWEP:Reload()
	if CLIENT then return end
	HORDE:UsePerkSkill(self.Owner)
end

function SWEP:VoidCascade()
	if CLIENT then return end
	if not self.Owner:Horde_GetPerk("necromancer_base") then return end
	if self.Weapon:Clip1() < 30 then return true end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	local ent = ents.Create("projectile_horde_void_projectile")
    ent:SetOwner(self.Owner)
    ent.Owner = self.Owner
	local properties = {sphere = false, battery = false, energy = self.Weapon:Clip1(), field = false, charged = 2, beacon_of_void = false, level = self.Owner:Horde_GetUpgrade("horde_void_projector"), cascade=true}
	hook.Run("Horde_OnVoidProjectorLaunch", self.Owner, properties)
	ent.properties = properties
	ent:SetNWInt("charged", 1)
    if (!IsValid(ent)) then return end
	self:TakePrimaryAmmo(30)
    ent:SetPos( self.Owner:EyePos() + (self.Owner:GetAimVector() * 16 ))
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = self.Owner:GetAimVector()
	velocity = velocity * 100
	--velocity = velocity + (VectorRand() * 10) -- a random element
	phys:ApplyForceCenter(velocity)
	timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload( ACT_VM_DRAW )
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
end

function SWEP:Recall()
	if CLIENT then return end
	if not HORDE.player_drop_entities[self.Owner:SteamID()] then return true end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	for id, ent in pairs(HORDE.player_drop_entities[self.Owner:SteamID()]) do
		if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_spectre" then
			local rand = VectorRand() * 50
			rand.z = 0
			ent:SetPos(self.Owner:GetPos() + rand)
			--local healinfo = HealInfo:New({amount=10, healer=self.Owner})
            --HORDE:OnPlayerHeal(self.Owner, healinfo)
			--self:SetClip1(math.min(100, self:Clip1() + 20))
		end
	end
	timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	self.SecondaryChargingTimer = CurTime() + 1
	self:SetNextSecondaryFire( CurTime() + self.Delay )
end)
end

function SWEP:Devour()
	if CLIENT then return end
	local ply = self.Owner

	local filter = {self:GetOwner()}
    local tr = util.TraceLine({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500,
        filter = filter,
        mask = MASK_SHOT_HULL
    })
	if !IsValid(tr.Entity) or not HORDE:IsEnemy(tr.Entity) then return true end
	if tr.Entity:GetVar("is_elite") then return true end

	if ply.Horde_drop_entities["npc_vj_horde_spectre"] and ply.Horde_drop_entities["npc_vj_horde_spectre"] >= (ply.Horde_Spectre_Max_Count) then
		return
	end

	tr.Entity:TakeDamage(tr.Entity:GetMaxHealth() + 1, ply, ply)

	local properties = {hollow_essence = false, abyssal_might = false, necromastery = false, level = self.Owner:Horde_GetUpgrade("horde_void_projector")}
	hook.Run("Horde_OnRaiseSpectre", self.Owner, properties)
	self:CreateSpectre(ply, properties, tr.Entity:GetPos())
	sound.Play("horde/weapons/void_projector/devour.ogg", tr.Entity:GetPos(), 150, 100)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

	timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
		self.Weapon:DefaultReload( ACT_VM_DRAW )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
end)
end

function SWEP:Think()
	if self.Charging == 1 and !self.Owner:KeyDown( IN_ATTACK ) then
        self:SetNextPrimaryFire( CurTime() + self.Delay )
        --self:SetNextSecondaryFire( CurTime() + self.Delay )
        self.Charging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()

		if self.ChargingTimer <= CurTime() then
			self:Launch(2)
		elseif self.ChargingTimer <= CurTime() + 0.5 then
			self:Launch(1)
		else
			self:Launch(0)
		end

		self.Owner:StopSound( "Weapon_Void_Projector.Double_2" )
		self.Owner:StopSound( "Weapon_Void_Projector.Double_3" )
		self.Owner:StopSound( "Weapon_Void_Projector.Double_4" )
    end

	if self.SecondaryCharging == 1 and !self.Owner:KeyDown( IN_ATTACK2 ) then
        --self:SetNextPrimaryFire( CurTime() + self.Delay )
        --self:SetNextSecondaryFire( CurTime() + self.Delay )
        self.SecondaryCharging = 0
        --self.Idle = 0
        --self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()

		if self.SecondaryChargingTimer <= CurTime() then
			self:Recall()
		elseif self.SecondaryChargingTimer <= CurTime() + 0.5 then
			self:Recall()
		else
			self:RaiseSpectre()
		end

		self.Owner:StopSound( "Weapon_Void_Projector.Double_2" )
		self.Owner:StopSound( "Weapon_Void_Projector.Double_3" )
		self.Owner:StopSound( "Weapon_Void_Projector.Double_4" )
    end

	if SERVER and self.SecondaryCharging == 1 and self.SecondaryChargingTimer <= CurTime() then
		self:Recall()
		self.SecondaryCharging = 0
	end

	if SERVER and self.Charging == 1 and self.ChargeSoundTimer <= CurTime() then
		if self.ChargingTimer <= CurTime() then
			self.Owner:EmitSound( "Weapon_Void_Projector.Double_4" )
		elseif self.ChargingTimer <= CurTime() + 0.5 then
			self.Owner:EmitSound( "Weapon_Void_Projector.Double_3" )
		else
			self.Owner:EmitSound( "Weapon_Void_Projector.Double_2" )
		end

		self.ChargeSoundTimer = CurTime() + 0.25
	end

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


