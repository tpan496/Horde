include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:Think()
    if not self.dlight then
        self.dlight = DynamicLight(0)
        self.dlight.Pos = self:GetPos() + Vector(0, 0, 75)
        self.dlight.r = 255
        self.dlight.g = 255
        self.dlight.b = 255
        self.dlight.Brightness = 4
        self.dlight.Size = 500
        self.dlight.DieTime = CurTime() + 1
    end
    if self.dlight then
        self.dlight.Pos = self:GetPos() + Vector(0, 0, 75)
        self.dlight.DieTime = CurTime() + 1
    end
end