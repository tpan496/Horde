PERK.PrintName = "Bloodlust"
PERK.Description = "Leech {1} of melee damage done.\nLeech is capped at {2} hp per hit."
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmg, took)
    local attacker = dmg:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("berserker_bloodlust") then
        local leech = math.min(PERK.Params[2].value, dmg:GetDamage() * PERK.Params[1].value)
        local ply = dmg:GetAttacker()
        ply:SetHealth(math.min(ply:GetMaxHealth(), leech + ply:Health()))
    end
end