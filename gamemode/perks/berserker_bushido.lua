PERK.PrintName = "Bushido"
PERK.Description = "25% increased slashing damage.\n20% increased movement speed."
PERK.Icon = "materials/perks/bushido.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup, dmgtype)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    if dmgtype == DMG_SLASH then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, mv)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    ply:SetWalkSpeed(ply:GetWalkSpeed() * 1.20)
    ply:SetRunSpeed(ply:GetRunSpeed() * 1.20)
end