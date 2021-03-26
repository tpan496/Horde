PERK.PrintName = "Unbreaking Stride"
PERK.Description = "Walk {speed}HU/s faster."

local speed = 20

-- OnSetPerk is *not* called per spawn, but speed is reset when spawning
-- We set a variable to make sure we don't accidently give or take more speed than needed
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if perk == "speed_bonus_walk" and not ply.Horde_Walk_Bonus then
        ply:SetWalkSpeed(ply:GetWalkSpeed() + speed)
        ply.Horde_Walk_Bonus = true
    end
end
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if perk == "speed_bonus_walk" and ply.Horde_Walk_Bonus then
        ply:SetWalkSpeed(ply:GetWalkSpeed() - speed)
        ply.Horde_Walk_Bonus = false
    end
end
PERK.Hooks.PlayerSpawn = function(ply)
    if ply:Horde_GetPerk("speed_bonus_walk") then
        ply:SetWalkSpeed(ply:GetWalkSpeed() + speed)
        ply.Horde_Walk_Bonus = true
    end
end