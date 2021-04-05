PERK.PrintName = "Unbreaking Stride"
PERK.Description = "Walk 20HU/s faster."

local speed = 20

-- OnSetPerk is *not* called per spawn, but speed is reset when spawning
-- We set a variable to make sure we don't accidently give or take more speed than needed
PERK.Hooks = {}
hook.Add("Horde_PlayerMoveBonus", "Horde_SpeedBonusWalk", function(ply, mv)
    if ply:Horde_GetPerk("speed_bonus_walk") then
        ply:SetWalkSpeed(ply:Horde_GetClass().movespd + speed)
    end
end)