MUTATION.PrintName = "Shadow"
MUTATION.Description = "Reduced opacity.\nBuilds up Frostbite on hit depending on amount of damage dealt.\nOnly randomly occurs starting from wave 8."
MUTATION.Wave = 8

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "shadow" then
        local c = ent:GetColor()
        ent:SetColor(Color(c.r/2, c.g/2, c.b/2, 150))
        ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
        ParticleEffectAttach("ice_smoke", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
    end
end

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_HasMutation("shadow") then
        if not HORDE:IsColdDamage(dmg) then
            ply:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmg:GetDamage() * 2)
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "shadow" then return end
end