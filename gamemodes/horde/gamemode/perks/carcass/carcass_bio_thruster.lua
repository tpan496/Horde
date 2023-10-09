PERK.PrintName = "Bio Thruster"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks.
Press RMB to propel at the cost of {2} health and gain 1 Bio Thruster stack, up to 5.
Each Bio Thruster stack increases {3} Melee damage, but also adds {4} health cost.]]
PERK.Icon = "materials/perks/carcass/bio_thruster.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.05, percent = true},
    [3] = {value = 0.10, percent = true},
    [4] = {value = 0.05, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_bio_thruster" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 1)
        local id = ply:SteamID()
        ply.Horde_Bio_Thruster_Stack = 0
        net.Start("Horde_SyncStatus")
			net.WriteUInt(HORDE.Status_Bio_Thruster, 8)
			net.WriteUInt(ply.Horde_Bio_Thruster_Stack, 8)
		net.Send(ply) 
        timer.Create("Horde_BioThrusterDegen" .. id, 3, 0, function ()
            if !ply:IsValid() then timer.Remove("Horde_BioThrusterDegen" .. id) end
            if !ply:Alive() then return end
            ply.Horde_Bio_Thruster_Stack = math.max(0, ply.Horde_Bio_Thruster_Stack - 1)
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_bio_thruster" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 1)
        local id = ply:SteamID()
        ply.Horde_Bio_Thruster_Stack = 0
        timer.Remove("Horde_BioThrusterDegen" .. id)
        net.Start("Horde_SyncStatus")
			net.WriteUInt(HORDE.Status_Bio_Thruster, 8)
			net.WriteUInt(ply.Horde_Bio_Thruster_Stack, 8)
		net.Send(ply)
    end
end