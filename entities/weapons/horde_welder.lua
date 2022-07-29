if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/horde_welder")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("horde_welder", "vgui/hud/horde_welder", Color(0, 0, 0, 255))
end
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Welder"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
end

SWEP.Instructions = "Electrical welder."
SWEP.Purpose = "Heals minions."
SWEP.WorldModel = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category = "ArcCW - Horde"
SWEP.HoldType = "pistol"

SWEP.Primary.Automatic		= true
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.Delay = 0.1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.1
SWEP.Weight = 5

SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = false
SWEP.DrawViewModel = false
SWEP.ShowWorldModel = false
SWEP.ReloadSound            = "ambient/machines/keyboard2_clicks.wav"

SWEP.ViewModelBoneMods = {
	["ValveBiped.square"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/horde/weapons/c_welder.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, 3.834, -2.504), angle = Angle(90, 0, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["v_sprite1"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.square", rel = "v_element", pos = Vector(8.821, -0.239, 4.459), size = { x = 8, y = 8 }, color = Color(25, 25, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["v_sprite2"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.square", rel = "v_element", pos = Vector(4.6, -2.334, 2.74), size = { x = 2, y = 2 }, color = Color(255, 25, 25, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.WElements = {
	["w_element"] = { type = "Model", model = "models/horde/weapons/c_welder.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.734, 1.621, 0.794), angle = Angle(-6.981, 0, 174.233), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["w_sprite1"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.104, 2.558, -5.288), size = { x = 10, y = 10 }, color = Color(25, 25, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)
	
	if CLIENT then
	
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
        self:SetWeaponHoldType( self.HoldType )
		
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end
end

----------------------------------------------------
if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			-- we build a render order because sprites need to be drawn after models
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
				--model:SetModelScale(v.size)
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
				local fade = math.abs(math.sin(CurTime() * math.Rand(3.549,3.55)))
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				if name:find("sprite1") then
					render.DrawSprite(drawpos, v.size.x, v.size.y, Color(43, 57, 192, 255 * fade))
				else
					render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				end
				
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
			-- when the weapon is dropped
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
				--model:SetModelScale(v.size)
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
				ang.r = -ang.r -- Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

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
				-- make sure we create a unique name based on the selected options
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
			
			-- !! WORKAROUND !! --
			-- We need to check all model names :/
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
			-- !! ----------- !! --
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				-- !! WORKAROUND !! --
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
				-- !! ----------- !! --
				
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


	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
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
----------------------------------------------------

if SERVER then
	StuffToFixTable = {}
	StuffToFixTable["openPropDoor"] = function(Welder, ent, trace)
		if ent:GetSaveTable().m_eDoorState ~= 2 then
			ent:Fire("Unlock", 1, 0)
			ent:Fire("Open", 1, 0)
			return true
		else
			return false
		end
	end
	
	StuffToFixTable["DoDamage"] = function(Welder, ent, trace)

		Welder:FireBullets({
			Attacker = Welder:GetOwner(),
			Inflitor = Welder,
			Damage = 10,
			Tracer = 0,
			Distance = 4000,
			Dir = trace.Normal,
			Src = trace.HitPos,
			Callback = function(att, tr, dmg)
				dmg:SetDamageType(DMG_BLAST)
				dmg:SetDamageForce(Welder:GetOwner():GetForward() * 50 )
			end
		})

		return true
	end

	StuffToFixTable["propFix"] = function(Welder, ent, trace)
		local hp = ent:Health()

		if hp <= ent:GetMaxHealth() - 50 then
			hp = hp + 50
		else
			hp = ent:GetMaxHealth() + ent:GetMaxHealth() / 2
		end

		if hp != ent:Health() and ent:Health() > 0 then
			ent:SetHealth(hp)
			return true
		else
			return false
		end
	end
	
	StuffToFixTable["alydus_destructablefortification"] = function(Welder, ent, trace)
		if alydusDestructableFortificationExtension and GetConVar("alydus_defaultfortificationhealth") then
			local defaultHealth = GetConVar("alydus_defaultfortificationhealth"):GetInt()
			local hp = ent:GetNWInt("fortificationHealth", false)

			if hp == false then
				return false
			end

			if hp <= defaultHealth - 50 then
				hp = hp + 50
			else
				hp = defaultHealth
			end

			if hp != ent:GetNWInt("fortificationHealth") then
				ent:SetNWInt("fortificationHealth", hp)
				return true
			else
				return false
			end
		end
	end

	StuffToFixTable["droneRefuel"] = function(Welder, ent, trace)
		if ent:IsDroneDestroyed() then
			return false
		else
			if math.Round(ent:GetFuel()) < ent.MaxFuel then
				ent:SetFuel(ent:GetFuel() + 10)
				return true
			else
				return false
			end
		end
	end
	StuffToFixTable["starwarsVehicleRepair"] = function(Welder, ent, trace)
		local hp = ent:GetNWInt("Health", 0)

		if hp <= ent.StartHealth - 50 then
			hp = hp + 50
		else
			hp = ent.StartHealth
		end

		if hp != ent:GetNWInt("Health", 0) then
			ent:SetNWInt("Health", hp)
			return true
		else
			return false
		end
	end
	StuffToFixTable["lfsVehicleRepair"] = function(Welder, ent, trace)
		local hp = ent:GetHP()

		if hp <= ent.MaxHealth - 50 then
			hp = hp + 50
		else
			hp = ent.MaxHealth
		end

		if hp != ent:GetHP() then
			ent:SetHP(hp)
			return true
		else
			return false
		end
	end
	StuffToFixTable["simfphysVehicleRepair"] = function(Welder, ent, trace)
		local hp = ent:GetCurHealth()

		if hp <= ent:GetMaxHealth() - 100 then
			hp = hp + 100
		else
			hp = ent:GetMaxHealth()
		end

		if hp != ent:GetCurHealth() then
			if hp > ent:GetMaxHealth()/7 then
				ent:SetOnFire(false)
			end
			if hp > ent:GetMaxHealth()/3 then
				ent:SetOnSmoke(false)
			end

			if hp > ent:GetMaxHealth()/1.2 then
				net.Start("simfphys_lightsfixall")
					net.WriteEntity(ent)
				net.Broadcast()

				if istable(ent.Wheels) then
					for i = 1, table.Count( ent.Wheels ) do
						local Wheel = ent.Wheels[ i ]
						if IsValid(Wheel) then
							Wheel:SetDamaged( false )
						end
					end
				end
			end

			ent:SetCurHealth(hp)
			return true
		else
			return false
		end
	end
	StuffToFixTable["scarsVehicleRepair"] = function(Welder, ent, trace)
		if ent:IsDamaged() then
			ent.DoRepair = true
			ent:EmitSound("carStools/tune.wav", 100, math.random(80, 150))
			return true
		end
		
		return false
	end

	function exceptionContinue(ent)
		if ent:GetClass() == "prop_door_rotating" then
			return "openPropDoor"
		elseif ent:IsPlayer() or ent:IsNPC() or ent.Type == "nextbot" then
			return "DoDamage"
		elseif ent.IS_DRR then
			return "droneRefuel"
		elseif ent.IsSWVehicle then
			return "starwarsVehicleRepair"
		elseif ent.LFS then
			return "lfsVehicleRepair"
		elseif string.find(ent:GetClass(), "sent_sakarias_car") or string.find(ent:GetClass(), "sent_sakarias_carwheel") or string.find(ent:GetClass(), "sent_sakarias_carwheel_punked") then
			return "scarsVehicleRepair"
		elseif ent:GetClass() == "gmod_sent_vehicle_fphysics_base" then
			return "simfphysVehicleRepair"
		elseif ent:Health() > 0 then
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				return "propFix"
			end
		end
		return false
	end
end

function SWEP:ShouldDrawViewModel()
	if CLIENT then
		return true
	end
end

function SWEP:Equip()
	self.Owner:EmitSound(Sound("horde/weapons/welder/gunpickup2.wav"))
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self:EmitSound(Sound("horde/weapons/welder/blowtorch-1.wav"))
   return true
end

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:SendWeaponAnim(ACT_VM_HOLSTER)
	self:SetNextPrimaryFire(CurTime() + 1)
	timer.Simple(1, function ()
		if !IsValid(self.Weapon) then return end
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
		local clip = math.min(self.Primary.ClipSize, ammo + self:Clip1())
		local diff = clip - self:Clip1()
		self.Owner:SetAmmo(ammo - diff, self.Primary.Ammo)
		self.Weapon:SetClip1(clip)
	end)
end

function SWEP:PrimaryAttack()
	if (not self:CanPrimaryAttack()) then return end
	self:TakePrimaryAmmo(1)
	if SERVER then
		local ply = self:GetOwner()
		local Trace = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 85,
			filter = self.Owner
		} )

		local vm = ply:GetViewModel()
		local bone = "ValveBiped.square"

		if Trace.Hit == true then
			local spark = ents.Create( "env_spark" )
			spark:SetPos(Trace.HitPos + Trace.HitNormal*2)
			spark:SetKeyValue( "spawnflags", "256" + "128" + "64" )
			spark:SetKeyValue( "traillength", "2" )
			spark:SetKeyValue( "magnitude", "1" )
			spark:SetParent(Trace.Entity)
			spark:Spawn()
			spark:Fire( "SparkOnce", "", 0.05 )
			spark:Fire( "kill", "", 0.1 )
			self:DeleteOnRemove(spark)

			sound.Play("horde/weapons/welder/spark"..math.random(1,6)..".wav", Trace.HitPos, 75, 100, 1)
		end

		if IsValid(ply) and IsValid(Trace.Entity) then
			if HORDE:IsPlayerMinion(Trace.Entity) then
				Trace.Entity:SetHealth(math.min(Trace.Entity:GetMaxHealth(), Trace.Entity:Health() + 0.01 * Trace.Entity:GetMaxHealth()))
			elseif Trace.Entity:IsPlayer() then
			else
				if StuffToFixTable[Trace.Entity:GetClass()] or exceptionContinue(Trace.Entity) != false then
					if ply:GetPos():Distance(Trace.Entity:GetPos()) > 300 then
						ply:EmitSound("horde/weapons/welder/medshotno1.wav",75,100,0.5)
					else
						local success = false
						if exceptionContinue(Trace.Entity) == false then
							success = StuffToFixTable[Trace.Entity:GetClass()](self, Trace.Entity, Trace)
						else
							success = StuffToFixTable[exceptionContinue(Trace.Entity)](self, Trace.Entity, Trace)
						end
	
						if success == true then
							if IsValid(vm) and vm:LookupBone(bone) then
								local atch = vm:GetBoneMatrix(vm:LookupBone(bone))
								local pos, ang = vm:GetBonePosition(vm:LookupBone(bone)), vm:GetBoneMatrix(vm:LookupBone(bone)):GetAngles()
	
								--[[local effectData = EffectData()
								effectData:SetOrigin(pos)
								util.Effect("MuzzleFlash", effectData, true, true)]]--
	
								local effectData = EffectData()
								effectData:SetOrigin(pos)
								effectData:SetNormal(pos:GetNormalized())
								effectData:SetMagnitude(1)
								effectData:SetScale(1)
								effectData:SetRadius(2)
								util.Effect("Sparks", effectData)
							end
						else
							ply:EmitSound("horde/weapons/welder/medshotno1.wav",75,100,0.5)
						end
					end
				else
					ply:EmitSound("horde/weapons/welder/medshotno1.wav",75,100,0.5)
				end
			end
			end
	end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
	self.Weapon:SendWeaponAnim( ACT_VM_DRYFIRE )

	return false
end

function SWEP:SecondaryAttack()

end

function SWEP:Holster()
	if SERVER then
		if !IsValid(self.Owner) then return end
		self.Owner:EmitSound("horde/weapons/welder/wpn_moveselect.wav",75,100,0.8)
	end
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:OnDrop()
	self:Holster()
end

function IsReallyValid(trace)
	if (!trace.Hit) then return false end
	if (!trace.HitNonWorld) then return false end
	--if (trace.Entity:IsPlayer()) then return false end
	if CLIENT then return true end
	if (!trace.Entity:GetPhysicsObject():IsValid()) then return false end
	return true
end

function SWEP:Think()
	if CLIENT then
		local pl = self:GetOwner()
		if not (pl:GetActiveWeapon():IsValid()) then return end
		if not (pl:GetActiveWeapon():GetClass() == "weapon_tf2_welder") then return end
		local tr = util.GetPlayerTrace(pl, pl:GetAimVector())
		local trace = util.TraceLine( tr )
		
		if IsValid( trace.Entity ) && ((( trace.Entity:GetClass():find("prop_physics") or trace.Entity:GetClass():find("prop_dynamic") or trace.Entity:GetClass():find("func_breakable") or trace.Entity:GetClass():find("func_physbox")) and trace.Entity:Health() > 0) or trace.Entity:GetClass():find("gmod_sent_vehicle_fphysics_base") or  ( trace.Entity:GetClass():find("lunasflightschool") or trace.Entity:GetClass():find("lfs_") ) and not trace.Entity:GetClass():find("lfs_vehicle_spammer")) then
			self.VElements["v_sprite2"].color = Color(25, 255, 25, 255)
		else
			self.VElements["v_sprite2"].color = Color(255, 25, 25, 255)
		end
	else
		local pl = self:GetOwner()
		if not (pl:GetActiveWeapon():IsValid()) then return end
		if not (pl:GetActiveWeapon():GetClass() == "weapon_tf2_welder") then return end
		local tr = util.GetPlayerTrace(pl, pl:GetAimVector())
		local trace = util.TraceLine( tr )
		if not IsReallyValid(trace) then return end
		
		if ( IsValid( trace.Entity ) && ( trace.Entity:GetClass():find("prop_physics") or trace.Entity:GetClass():find("prop_dynamic") or trace.Entity:GetClass():find("func_breakable") or trace.Entity:GetClass():find("func_physbox")) ) then
			pl:SetNWInt("WelderHealth", trace.Entity:Health())
		elseif ( IsValid( trace.Entity ) && trace.Entity:GetClass():find("gmod_sent_vehicle_fphysics_base") ) then
			pl:SetNWInt("WelderHealth", trace.Entity:GetCurHealth())
		elseif ( IsValid( trace.Entity ) && ( ( trace.Entity:GetClass():find("lunasflightschool") or trace.Entity:GetClass():find("lfs_") ) and not trace.Entity:GetClass():find("lfs_vehicle_spammer") ) ) then
			pl:SetNWInt("WelderHealth", trace.Entity:GetHP())
		end
	end
end

if CLIENT then
	
	local TipColor = Color( 250, 250, 200, 255 )

surface.CreateFont( "WelderFont_Arial", {
	font = "Arial",
	size = 24,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

	local function DrawHealthTip()
		if not (LocalPlayer():GetActiveWeapon():IsValid()) then return end
		if not (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_tf2_welder") then return end
		--local tr = util.GetPlayerTrace( LocalPlayer(), LocalPlayer():GetAimVector() )
		--local trace = util.TraceLine( tr )
		local trace = util.TraceLine( {
			start = LocalPlayer():GetShootPos(),
			endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 75,
			filter = LocalPlayer()
		} )
		
		if (!trace.Hit) then return end
		if (!trace.HitNonWorld) then return end
		if !(((trace.Entity:GetClass():find("prop_physics") or trace.Entity:GetClass():find("prop_dynamic") or trace.Entity:GetClass():find("func_breakable") or trace.Entity:GetClass():find("func_physbox")) and trace.Entity:Health() > 0) or trace.Entity:GetClass():find("gmod_sent_vehicle_fphysics_base") or trace.Entity:GetClass():find("lunasflightschool") or trace.Entity:GetClass():find("lfs_")) then return end
		if trace.Entity:GetClass():find("lfs_vehicle_spammer") then return end
		if (trace.Entity:IsPlayer()) then return end
		
		local health = LocalPlayer():GetNWInt("WelderHealth") or 0
		local text = "Health: "..health
	
		local pos = (trace.Entity:GetPos()):ToScreen()
		
		local outline = Color( 200, 25, 25, 255 )
		local tipcol = Color( TipColor.r, TipColor.g, TipColor.b, 255 )
		
		local x = 0
		local y = 0
		local padding = 10
		local offset = 50
		
		surface.SetFont( "TF2" )
		local w, h = surface.GetTextSize( text )
		
		x = pos.x - w 
		y = pos.y - h 
		
		x = x - offset
		y = y - offset

		draw.RoundedBox( 8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, outline )
		
		
		local verts = {}
		verts[1] = { x=x+w/1.5-2, y=y+h+2 }
		verts[2] = { x=x+w+2, y=y+h/2-1 }
		verts[3] = { x=pos.x-offset/2+2, y=pos.y-offset/2+2 }
		
		draw.NoTexture()
		surface.SetDrawColor( outline )
		surface.DrawPoly( verts )
		
		
		draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, tipcol )
		
		local verts = {}
		verts[1] = { x=x+w/1.5, y=y+h }
		verts[2] = { x=x+w, y=y+h/2 }
		verts[3] = { x=pos.x-offset/2, y=pos.y-offset/2 }
		
		draw.NoTexture()
		surface.SetDrawColor( tipcol.r, tipcol.g, tipcol.b, tipcol.a )
		surface.DrawPoly( verts )
		
		draw.DrawText( text, "TF2", x + w/2, y, outline, TEXT_ALIGN_CENTER )
	end
	
	hook.Add("HUDPaint", "WelderWorldTip", DrawHealthTip)
	
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap) -- it was spinning, but now it doesnt spin
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
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
    end
end