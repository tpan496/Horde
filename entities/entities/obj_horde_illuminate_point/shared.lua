ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil

function ENT:Initialize()
    if SERVER then
        self:SetRenderMode(RENDERMODE_TRANSCOLOR)
        self:SetColor(Color(0,0,0,0))
    else
        local dlight = DynamicLight(0)
        dlight.Pos = self:GetPos()
        dlight.r = 255
        dlight.g = 255
        dlight.b = 200
        dlight.Brightness = self:GetBrightness() or 8
        dlight.Size = 250
        dlight.DieTime = CurTime() + 5
    end

    timer.Simple(10, function ()
        if self:IsValid() then self:Remove() end
    end)
end
function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Brightness" )
end