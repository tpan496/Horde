ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Illuminati"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/dav0r/hoverball.mdl"

ENT.CollisionGroup = COLLISION_GROUP_DEBRIS
ENT.CollisionGroupType = COLLISION_GROUP_DEBRIS

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit(SOLID_VPHYSICS)
        self:DrawShadow( false )
        self:SetModelScale( 0.01, 0 )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetMass(1)
            phys:EnableGravity(false)
            phys:EnableDrag(false)
            phys:SetBuoyancyRatio(0)
        end
    end
end

function ENT:PhysicsCollide(data, physobj)
    if not SERVER then return end
    if !self:IsValid() or self.Removing then return end
    if data.HitEntity:GetClass() == "worldspawn" then
        local ply = self:GetOwner()
        self:EmitSound("ambient/fire/mtov_flame2.wav")
        local pos = self:GetPos()
        --pos.z = pos.z + 50
        local light = ents.Create("light_dynamic")
        light:SetKeyValue("brightness", "1")
        light:SetKeyValue("distance", "500")
        light:SetLocalPos(pos)
        light:SetLocalAngles( ply:EyeAngles() )
        light:Fire("Color", "255 255 255")
        light:Spawn()
        light:Activate()
        light:Fire("TurnOn", "", 0)
        light:Fire("Kill", "", 30)
    end
    self.Removing = true
    self:Remove()
end

local mat = Material("sprites/orangeflare1")
local col = Color(255, 141, 15, 255)
function ENT:Draw()
	local scale = 1 * math.random(20, 50)
	self:DrawModel()
	local pos = self:GetPos()
	render.SetMaterial(mat)
	
	local color = render.GetLightColor(pos) *2
	color.x = col.r * math.Clamp(color.x, 0, 1)
	color.y = col.g * math.Clamp(color.y, 0, 1)
	color.z = col.b * math.Clamp(color.z, 0, 1)
	
	render.DrawSprite(pos, scale, scale, color)
end
