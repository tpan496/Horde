PERK.PrintName = "Bloodlust"
PERK.Description = "Leech 10% of melee damage done.\nLeech is capped at 10 hp per hit."
PERK.Icon = "materials/perks/bloodlust.png"

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmg, took)
    local attacker = dmg:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("berserker_bloodlust") then
        local leech = math.min(10, dmg:GetDamage() * 0.1)
        local ply = dmg:GetAttacker()
        ply:SetHealth(math.max(ply:GetMaxHealth(), leech + ply:Health()))
    end
end