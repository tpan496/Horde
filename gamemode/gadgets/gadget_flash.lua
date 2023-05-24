GADGET.PrintName = "Flash"
GADGET.Description = [[Dashes forward, dealing 100 Slashing damage to all enemies on the path.
Provides a short invincibility frame.
Provides Phasing.]]
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
    ply.Horde_In_Flash = true
    ply.Horde_Invincible = true
    ply:Horde_AddPhasing(0.25, function ()
        ply.Horde_In_Flash = nil
        ply.Horde_Invincible = nil
        ply:SetLocalVelocity(Vector(0,0,0))
        --ply:Horde_RemovePhasing() -- sv_phasing.lua already does that
    end)
    timer.Simple(0, function() ply:SetLocalVelocity(vel) end)
end

GADGET.Hooks.Horde_OnPhasingCollide = function (ply, npc)
    local dmg = DamageInfo()
    dmg:SetDamage(100)
    dmg:SetDamageType(DMG_SLASH)
    if ply.Horde_In_Flash and not npc.Horde_Taken_Flash_DMG then
        dmg:SetInflictor(ply)
        dmg:SetAttacker(ply)
        dmg:SetDamagePosition(npc:GetPos())
        npc:TakeDamageInfo(dmg)
        npc.Horde_Taken_Flash_DMG = true
        timer.Simple(0.25, function()
            if npc:IsValid() then
                npc.Horde_Taken_Flash_DMG = nil
            end
        end)
    end
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply.Horde_Invincible  then return end
    dmginfo:SetDamage(0)
    return true
end
