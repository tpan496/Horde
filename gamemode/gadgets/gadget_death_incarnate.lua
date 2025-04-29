GADGET.PrintName = "Death Incarnate"
GADGET.Description = [[Active Gadget:
Your presence ignores line of sight.
Enemies in your presence have Necrosis.

Passive Effect:
Immune to Necrosis.]]
GADGET.Icon = "materials/perks/overlord/death_incarnate.png"
GADGET.Duration = 5
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 5},
    [2] = {value = 2},
    [3] = {value = 1, percent = true},
    [4] = {value = 0.5, percent = true},
    [5] = {value = 0.5, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_death_incarnate" then return end
    
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_death_incarnate" then return end
    
end

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
    if ply:Horde_GetGadget() ~= "gadget_death_incarnate" then return end
    if debuff == HORDE.Status_Necrosis then
        bonus.apply = 0
        return true
    end
end

-- functionality in overlord_base.lua
GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_death_incarnate" then return end
    if ply.Is_Death_Incarnate_LoS then return true end
    ply.Is_Death_Incarnate_LoS = true
    timer.Simple(5, function()
        ply.Is_Death_Incarnate_LoS = nil
    end)
    
    --local myPos = ply:GetPos()
    --ParticleEffect("aurora_shockwave_debris", ply:GetPos(), Angle(0, 0, 0), nil)
    --ParticleEffect("aurora_shockwave", ply:GetPos(), Angle(0, 0, 0), nil)
    
	--effects.BeamRingPoint(ply:GetPos(), 1.5, 0, 200, 10, 64, Color(255, 255, 255))
    
    --sound.Play("npc/combine_gunship/gunship_ping_search.wav", ply:GetPos())
    --ply:EmitSound("weapons/cguard/charging.wav", 100, 125, .5, CHAN_AUTO)
    local rand = math.Rand(75, 100)
    ply:EmitSound("npc/combine_gunship/ping_patrol.wav", 100, rand, .5, CHAN_AUTO)
end
