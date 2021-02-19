include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

ENT.ColorModulation = Color(0.25, 1, 0.25)