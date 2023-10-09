GADGET.PrintName = "Omnislash"
GADGET.Description = [[Phasing out of reality and repeatedly slashes the target enemy.
Each slash deals {1} damage.
Bounces to a nearby target if the main target is dead.
You are invulnerable during Omnislash.]]
GADGET.Icon = "items/gadgets/omnislash.png"
GADGET.Duration = 4
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 50},
}
GADGET.Hooks = {}

local function SpawnPlayer(ply, ply_pos, ply_angles, armor)
    if !IsValid(ply) then return end
    if ply:GetNoDraw() == false then return end
    local health = ply:Health()
    ply:UnSpectate()
    ply:DrawViewModel(true)
    ply:Spawn()
    ply.Horde_Fake_Respawn = nil
    ply:SetPos(ply_pos)
    ply:SetAngles(ply_angles)
    ply:SetNoTarget(false)
    ply.Horde_Invincible = nil
    ply:SetNoDraw(false)
    ply:DrawWorldModel(true)
    timer.Simple(0, function ()
        ply:SetHealth(health)
        ply:SetArmor(armor)
    end)
end

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_omnislash" then return end

    local tr = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 5000,
        filter = {ply},
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })
    
    local ent = tr.Entity
    if HORDE:IsEnemy(ent) then
        local ply_pos = ply:GetPos()
        local ply_angles = ply:GetAngles()
        ply:Spectate(OBS_MODE_CHASE)
        ply:SpectateEntity(ent)
        ply:SetNoDraw(true)
        ply:DrawWorldModel(false)
        ply:SetNoTarget(true)
        ply:SetMoveType(MOVETYPE_NONE)
        ply:DrawViewModel(false)
        ply.Horde_In_Omni = true
        ply.Horde_Fake_Respawn = true
        ply.Horde_Invincible = true
        local armor = ply:Armor()

        local p = ent:GetPos()
        for i = 1, 10 do
            timer.Simple(i*0.25, function ()
                if not ply.Horde_In_Omni then return end
                if !IsValid(ent) then
                    for _, e in pairs(ents.FindInSphere(p, 200)) do
                        if HORDE:IsEnemy(e) then
                            ent = e
                            ply:SpectateEntity(ent)
                            break
                        end
                    end

                    if !IsValid(ent) then
                        ply.Horde_In_Omni = nil
                        timer.Simple(0.5, function ()
                            SpawnPlayer(ply, ply_pos, ply_angles, armor)
                        end)
                    end
                end
                local dmg = DamageInfo()
                dmg:SetAttacker(ply)
                dmg:SetInflictor(ply)
                dmg:SetDamageType(DMG_SLASH)
                dmg:SetDamage(50)
                if IsValid(ent) then
                    dmg:SetDamagePosition(ent:GetPos())
                    ent:TakeDamageInfo(dmg)
                    sound.Play("weapons/physcannon/energy_sing_explosion2.wav", ply:GetPos(), 100, 150)
                    local ed = EffectData()
                    ed:SetOrigin(ent:GetPos() + ent:OBBCenter())
                    util.Effect("horde_omnislash_effect", ed, true, true)
                    p = ent:GetPos()
                else
                    ply.Horde_In_Omni = nil
                    timer.Simple(0.5, function ()
                        SpawnPlayer(ply, ply_pos, ply_angles, armor)
                    end)
                    return
                end

                if i == 10 then
                    ply.Horde_In_Omni = nil
                    timer.Simple(0.5, function ()
                        SpawnPlayer(ply, ply_pos, ply_angles, armor)
                    end)
                end
            end)
        end
    else
        return true
    end
end