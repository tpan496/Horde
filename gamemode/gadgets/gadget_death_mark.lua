GADGET.PrintName = "Death Mark"
GADGET.Description =
[[Places a mark on the targeted enemy.
Marked enemy takes 15% increased damage.
Marked enemy explodes on death, dealing damage based on its health.
The mark lasts for 10 seconds.
You can only mark 1 enemy at a time.]]
GADGET.Icon = "items/gadgets/death_mark.png"
GADGET.Duration = 0
GADGET.Cooldown = 2
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.15, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_death_mark" then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() and ent:IsNPC() and (not ent:GetNWEntity("HordeOwner"):IsValid()) then
        local id = ent:GetCreationID()
        timer.Remove("Horde_DeathMarkExpire" .. id)
        if ply.Horde_Death_Mark_Target and ply.Horde_Death_Mark_Target:IsValid() and ply.Horde_Death_Mark_Target ~= ent then
            timer.Remove("Horde_DeathMarkExpire" .. ply.Horde_Death_Mark_Target:GetCreationID())
            net.Start("Horde_RemoveDeathMarkHighlight")
                net.WriteEntity(ply.Horde_Death_Mark_Target)
            net.Broadcast()
            ent.Horde_Death_Mark_Target = nil
        end
        ent.Horde_Has_Death_Mark = ply
        net.Start("Horde_DeathMarkHighlight")
            net.WriteEntity(ent)
        net.Broadcast()
        ply.Horde_Death_Mark_Target = ent
        sound.Play("buttons/combine_button1.wav", ply:GetPos(), 70, 100)
        timer.Create("Horde_DeathMarkExpire" .. id, 5, 1, function ()
            net.Start("Horde_RemoveDeathMarkHighlight")
                net.WriteEntity(ent)
            net.Broadcast()
            ent.Horde_Has_Death_Mark = nil
        end)
    else
        return true
    end
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if npc.Horde_Has_Death_Mark then
        bonus.increase = bonus.increase + 0.15
    end
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    ply.Horde_Death_Mark_Target = nil
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    ply.Horde_Death_Mark_Target = nil
end

GADGET.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not victim.Horde_Has_Death_Mark then return end
    local health = victim:GetMaxHealth()
    local dmg = DamageInfo()
    dmg:SetAttacker(victim.Horde_Has_Death_Mark)
    dmg:SetInflictor(victim)
    dmg:SetDamageType(DMG_CLUB)
    dmg:SetDamagePosition(victim:GetPos())
    dmg:SetDamage(health + 50)
    util.BlastDamageInfo(dmg, victim:GetPos(), 175)
    local e = EffectData()
    e:SetOrigin(victim:GetPos())
    e:SetScale(100)
    util.Effect("parasite_explosion", e)
end