PERK.PrintName = "Savagery"
PERK.Description = "{1} increased Blunt damage.\n{2} increased maximum health."
PERK.Icon = "materials/perks/savagery.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_savagery" then
        ply:SetMaxHealth(ply:GetMaxHealth() * 1.25)
        ply:SetHealth(ply:GetMaxHealth())
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_savagery" then
        ply:SetMaxHealth(ply:GetMaxHealth() / 1.25)
        ply:SetHealth(ply:GetMaxHealth())
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_savagery")  then return end
    if dmginfo:GetDamageType() == DMG_CLUB then
        bonus.increase = bonus.increase + 0.25
    end
end