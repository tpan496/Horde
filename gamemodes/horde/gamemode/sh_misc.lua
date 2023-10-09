if SERVER then
util.AddNetworkString("Horde_Antimatter_Shield_Deploy")
util.AddNetworkString("Horde_Antimatter_Shield_Remove")
util.AddNetworkString("Horde_Void_Shield_Deploy")
util.AddNetworkString("Horde_Void_Shield_Remove")
end
local shldmat = Material('models/horde/antimatter_shield/stasisshield_sheet')
local shldmat2 = Material('models/horde/antimatter_shield/voidshield')

if CLIENT then
net.Receive("Horde_Antimatter_Shield_Deploy", function ()
    local ent = net.ReadEntity()
    local id = ent:EntIndex()
    local col_min, col_max = ent:GetCollisionBounds()
    local radius = col_max:Distance(col_min) / 2
    local height = math.abs(col_min.z - col_max.z)
    hook.Add("PostDrawTranslucentRenderables", "Horde_AntimatterShieldingEffect" .. id, function()
        if not ent:IsValid() then
            hook.Remove("PostDrawTranslucentRenderables", "Horde_AntimatterShieldingEffect" .. id)
            return
        end
        render.SetMaterial(shldmat)
        render.SetColorModulation(0,0,1)
        local pos = ent:GetPos()
        pos.z = pos.z + height / 2
        render.DrawSphere(pos, radius + 5, 50, 50)
    end)
end)

net.Receive("Horde_Antimatter_Shield_Remove", function ()
    local ent = net.ReadEntity()
    local id = ent:EntIndex()
    hook.Remove("PostDrawTranslucentRenderables", "Horde_AntimatterShieldingEffect" .. id)
end)

net.Receive("Horde_Void_Shield_Deploy", function ()
    local ent = net.ReadEntity()
    local id = ent:EntIndex()
    local col_min, col_max = ent:GetCollisionBounds()
    local radius = col_max:Distance(col_min) / 2
    local height = math.abs(col_min.z - col_max.z)
    hook.Add("PostDrawTranslucentRenderables", "Horde_VoidShieldingEffect" .. id, function()
        if not ent:IsValid() then
            hook.Remove("PostDrawTranslucentRenderables", "Horde_VoidShieldingEffect" .. id)
            return
        end
        render.SetMaterial(shldmat2)
        local pos = ent:GetPos()
        pos.z = pos.z + height / 2
        render.DrawSphere(pos, radius + 10, 50, 50)
    end)
end)

net.Receive("Horde_Void_Shield_Remove", function ()
    local ent = net.ReadEntity()
    local id = ent:EntIndex()
    hook.Remove("PostDrawTranslucentRenderables", "Horde_VoidShieldingEffect" .. id)
end)
end
-- Draw the antimatter shield
