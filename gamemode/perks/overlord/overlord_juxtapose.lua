PERK.PrintName = "Juxtapose"
PERK.Description = [[Dark Energy Blast Perk skill is replaced with Summon Projection Clone.
Projection Clone has {1} health and uses a pump shotgun.
Projection Clone lasts for {2} seconds and has a {3} second cooldown.]]
PERK.Icon = "materials/perks/overlord/juxtapose.png"
PERK.Params = {
    [1] = { value = 125 },
    [2] = { value = 15 },
    [3] = { value = 15 },
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_juxtapose" then
        ply:Horde_SetPerkCooldown(15)
        ply:Horde_SetPerkInternalCooldown(0)
        
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Juxtapose, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        
        net.Start("Horde_PerkStartCooldown")
            net.WriteUInt(ply:Horde_GetPerkInternalCooldown(), 8)
        net.Send(ply)
        
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_juxtapose" then
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_Juxtapose, 8)
        net.WriteUInt(0, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end
--Additional effects are in entities\npc_vj_horde_overlord_projection\init.lua
PERK.Hooks.Horde_UseActivePerk = function(ply)
    if not SERVER then return end
    if not ply:Horde_GetPerk("overlord_juxtapose") then return end
    if IsValid(ply.Horde_overlord_juxtapose) then return true end
    
    sound.Play("horde/player/overlord/projection.mp3", ply:GetPos(), 100, math.random(80, 120))
    
    ply.Horde_overlord_juxtapose = ents.Create("npc_vj_horde_overlord_projection")
    ply.Horde_overlord_juxtapose:SetPos(ply:GetPos() + ply:GetRight() * 45)
    ply.Horde_overlord_juxtapose:SetAngles(ply:GetAngles())
    ply.Horde_overlord_juxtapose:SetNWEntity("HordeOwner", ply)
    ply.Horde_overlord_juxtapose:SetOwner(ply)
    ply.Horde_overlord_juxtapose:Give("weapon_vj_horde_projection_shotgun")
    ply.Horde_overlord_juxtapose:Spawn()
end
