GADGET.PrintName = "Flash"
GADGET.Description = [[Dash forward dealing slashing damage to all enemies in your path.

Active Gadget:
Deals {1} slashing damage.
Invulnerable to all damage for {2} second during the dash.
You have Phasing for {3} second during the dash.
{4} reduced fall damage taken until you land on the ground.
{5} chance to send you and your allies straight to the shadow realm.]]

GADGET.Icon = "items/gadgets/flash.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 100},
	[2] = {value = 0.25},
	[3] = {value = 0.25},
	[4] = {value = 0.9, percent = true},
	[5] = {value = 0.05, percent = true},
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
	ply.Flash_Fall_Damage_Prevention = true
    ply:Horde_AddPhasing(0.25, function ()
        ply.Horde_In_Flash = nil
        ply.Horde_Invincible = nil
        ply:SetLocalVelocity(Vector(0,0,0))
        --ply:Horde_RemovePhasing() -- sv_phasing.lua already does that
    end)
    timer.Simple(0, function() ply:SetLocalVelocity(vel) end)
end

GADGET.Hooks.Horde_OnPhasingCollide = function (ply, npc)
    if ply.Horde_In_Flash and not npc.Horde_Taken_Flash_DMG then
		local dmg = DamageInfo()
		dmg:SetDamage(100)
		dmg:SetDamageType(DMG_SLASH)
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

GADGET.Hooks.Horde_GetFallDamage = function(ply, speed, bonus)
    if ply:Horde_GetGadget() ~= "gadget_flash" then return end
	if not ply.Flash_Fall_Damage_Prevention then return end
	bonus.less = bonus.less * 0.1
	ply.Flash_Fall_Damage_Prevention = nil
end

GADGET.Hooks.PlayerTick = function (ply, mv)
    if not ply.Flash_Fall_Damage_Prevention or not ply:Alive() then return end
    if ply:IsOnGround() and not ply.Horde_In_Flash then
        ply.Flash_Fall_Damage_Prevention = nil
    end
end
