PERK.PrintName = "High Jumper"
PERK.Description = "Jump {bonus}HU higher."

PERK.Parameters = {
    ["bonus"] = {type = "i", default = 50, min = 0},
}

-- OnSetPerk is *not* called per spawn, but speed is reset when spawning
-- We set a variable to make sure we don't accidently give or take more speed than needed
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if perk == "speed_bonus_jump" and not ply.Horde_Jump_Bonus then
        ply:SetWalkSpeed(ply:GetWalkSpeed() + params.bonus)
        ply.Horde_Jump_Bonus = true
    end
end
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if perk == "speed_bonus_jump" and ply.Horde_Jump_Bonus then
        ply:SetWalkSpeed(ply:GetWalkSpeed() - ply:Horde_GetPerkParam("speed_bonus_jump", "bonus"))
        ply.Horde_Jump_Bonus = false
    end
end
PERK.Hooks.PlayerSpawn = function(ply)
    if ply:Horde_GetPerk("speed_bonus_jump") then
        ply:SetWalkSpeed(ply:GetWalkSpeed() + ply:Horde_GetPerkParam("speed_bonus_jump", "bonus"))
        ply.Horde_Jump_Bonus = true
    end
end