SPELL.PrintName       = "Void Cascade"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {30}
SPELL.Price           = 1500
SPELL.ChargeTime      = {1}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 10
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = {HORDE.DMG_COLD}
SPELL.Icon            = "spells/void_cascade.png"
SPELL.Type            = {HORDE.Spell_Type_Projectile, HORDE.Spell_Type_AOE}
SPELL.Description     = [[Conjures a projectile that periodically deals heavy Cold damage to nearby enemies.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    local ent = ents.Create("projectile_horde_void_projectile")
    ent:SetOwner(ply)
    ent.VoidCascade = true
    ent:SetPos( ply:EyePos() + (ply:GetAimVector() * 16 ))
    ent:SetAngles( ply:EyeAngles() )
    local level = ply:Horde_GetSpellUpgrade("void_cascade")
    ent:SetSpellLevel(level)
    ent:SetSpellBaseDamages({math.floor(70 + math.pow(level, 1.1) * 30, 10 + math.pow(level, 1.1) * 7)})
    ent:Spawn()

    local phys = ent:GetPhysicsObject()
    if (!IsValid( phys )) then ent:Remove() return end
    local velocity = ply:GetAimVector()
    velocity = velocity * 100
    phys:ApplyForceCenter(velocity)
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end