PERK.PrintName = "In A Hurry"
PERK.Description = "Run 40HU/s faster."

local speed = 40

-- OnSetPerk is *not* called per spawn, but speed is reset when spawning
-- We set a variable to make sure we don't accidently give or take more speed than needed
PERK.Hooks = {}

hook.Add("Horde_PlayerMoveBonus", "Horde_SpeedBonusRun", function(ply, mv)
    if ply:Horde_GetPerk("speed_bonus_run") then
        ply:SetRunSpeed(ply:Horde_GetClass().sprintspd + speed)
    end
end)