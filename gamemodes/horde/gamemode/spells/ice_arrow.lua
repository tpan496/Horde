SPELL.PrintName      = "Ice Arrow"
SPELL.Weapon         = {"horde_void_projector"}
SPELL.Mind           = {5, 10, 20}

SPELL.ChargeTime     = {0, 0.5, 1}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 0.5
SPELL.Upgrades         = 5
SPELL.Slot           = HORDE.Spell_Slot_LMB
SPELL.DamageType     = {HORDE.DMG_COLD}
SPELL.Icon           = "spells/ice_arrow.png"
SPELL.Type           = {HORDE.Spell_Type_Projectile, HORDE.Spell_Type_AOE}
SPELL.Description    = [[Conjures ice arrows that can be fired rapidly. Charge for different effects.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    local function SpawnProjectile(pos, angles, force)
        local ent = ents.Create("projectile_horde_ice_arrow")
        local ar = ply:EyeAngles()
        ent:SetOwner(ply)
        ent:SetNWInt("charged", charge_stage)
        ent:SetPos(pos)
        ent:SetAngles(angles)
        local level = ply:Horde_GetSpellUpgrade("ice_arrow")
        ent:SetSpellLevel(level)
        ent:SetSpellBaseDamages({math.floor(25 + math.pow(level, 1.1) * 6.5)})
        ent:Spawn()
        ent:GetPhysicsObject():ApplyForceCenter( force )
    end
    
    local ar = ply:EyeAngles()
    if charge_stage == 1 then
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
    elseif charge_stage == 2 then
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar:RotateAroundAxis(ar:Up(), 3)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar = ply:EyeAngles()
        ar:RotateAroundAxis(ar:Up(), -3)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
    else
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar:RotateAroundAxis(ar:Up(), 3)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar = ply:EyeAngles()
        ar:RotateAroundAxis(ar:Up(), -3)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar = ply:EyeAngles()
        ar:RotateAroundAxis(ar:Up(), -6)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
        ar = ply:EyeAngles()
        ar:RotateAroundAxis(ar:Up(), 6)
        SpawnProjectile(ply:EyePos() + (ar:Forward() * 5), ar, ar:Forward() * 3000)
    end

    ply:EmitSound("horde/weapons/void_projector/ice_arrow_launch.ogg", 100, math.random(70, 90))
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end
SPELL.Levels          = {Necromancer=5}