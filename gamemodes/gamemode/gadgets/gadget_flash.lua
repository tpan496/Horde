GADGET.PrintName = "Flash"
GADGET.Description = "Dashes forward, dealing 100 Slashing damage to all enemies on the path.\nProvides a short invincibility frame."
GADGET.Icon = "items/gadgets/flash.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 100},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_flash" then return end
    sound.Play("weapons/physcannon/energy_sing_explosion2.wav", ply:GetPos())
    local dir = ply:GetAimVector()
    local vel = dir * 8000
    ply:SetLocalVelocity(vel)
    ply.Horde_In_Flash = true
    timer.Simple(0.25, function()
        if ply:IsValid() then
            ply.Horde_In_Flash = nil
            ply:SetLocalVelocity(Vector(0,0,0))
        end
    end)
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply.Horde_In_Flash  then return end
    bonus.resistance = bonus.resistance + 1.00
end