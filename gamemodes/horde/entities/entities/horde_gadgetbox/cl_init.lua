include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

ENT.ColorModulation = Color(1, 0.25, 0.25)