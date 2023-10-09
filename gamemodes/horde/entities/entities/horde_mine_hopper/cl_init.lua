include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

local lmat = Material("effects/reactive_mine/glow01")

function ENT:Glow()
    render.SetMaterial(lmat)
    render.DrawSprite(self:GetPos() + Vector(0,0,10), 32, 32, Color(255,0,0))
end

function ENT:Draw()
    if SERVER then return end
    self.Entity:DrawModel()
    --self:Glow()
end