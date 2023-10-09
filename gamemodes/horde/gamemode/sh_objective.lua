-- Adds more objectives to the gamemode
if SERVER then
util.AddNetworkString("Horde_SyncHoldProgress")
util.AddNetworkString("Horde_SyncHoldLocation")
util.AddNetworkString("Horde_SyncHoldEnd")

util.AddNetworkString("Horde_SyncPayloadIcon")
util.AddNetworkString("Horde_SyncPayloadLocation")
util.AddNetworkString("Horde_SyncPayloadDestinationLocation")
util.AddNetworkString("Horde_SyncPayloadSpawnEnd")
util.AddNetworkString("Horde_SyncPayloadEnd")

util.AddNetworkString("Horde_SyncEscapeStart")
util.AddNetworkString("Horde_SyncEscapeLocation")
util.AddNetworkString("Horde_SyncEscapeEnd")

util.AddNetworkString("Horde_RenderObjectives")
end

HORDE.OBJECTIVE_HOLD = 0
HORDE.OBJECTIVE_PAYLOAD = 1
HORDE.OBJECTIVE_ESCAPE = 2

HORDE.Objective_Icon = {
    [HORDE.OBJECTIVE_HOLD] = "status/hold.png",
    [HORDE.OBJECTIVE_PAYLOAD] = "status/objective.png",
    [HORDE.OBJECTIVE_ESCAPE] = "status/escape.png",
}

HORDE.Payload_Icon = {
    [0] = "status/objective.png",
    [1] = "status/payload/key.png",
    [2] = "status/payload/card.png",
    [3] = "status/payload/chemical.png",
}

if SERVER then
local plymeta = FindMetaTable("Player")

function plymeta:Horde_SetEscape(can)
    self.Horde_EscapeProgress = can
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_CanEscape, 8)
        net.WriteUInt(can, 8)
    net.Send(self)
end

function plymeta:Horde_SetPayloadSpawn(payload)
    self.Horde_Payload_Spawn = payload
    HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, self:Name():sub(1,20) .. " picked up " .. (payload.Horde_Payload_Label or "the payload") .."!")
    sound.Play("horde/objective/gunpickup2.wav", self:GetPos())

    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HasPayload, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

hook.Add("PlayerTick", "Horde_PayloadTrack", function(ply, mv)
    if not ply.Horde_Payload_Spawn then return end
    net.Start("Horde_SyncPayloadLocation")
        net.WriteUInt(ply.Horde_Payload_Spawn.Horde_Payload_Spawn_Id, 4)
        net.WriteVector(ply:GetPos())
    net.Broadcast()
end)

hook.Add("DoPlayerDeath", "Horde_DeathRemovePayload", function(victim)
    if victim:IsPlayer() and victim:Horde_HasPayload() then
        victim:Horde_LostPayload()
    end
end)

function plymeta:Horde_HasPayload()
    return self.Horde_Payload_Spawn
end

function plymeta:Horde_LostPayload()
    if not self.Horde_Payload_Spawn then return end
    self.Horde_Payload_Spawn:Horde_SpawnPayload()
    HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, self:Name():sub(1,20) .. " lost " .. (self.Horde_Payload_Spawn.Horde_Payload_Label or "the payload") .."!")
    self.Horde_Payload_Spawn = nil

    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HasPayload, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_DeliverPayload()
    if not self.Horde_Payload_Spawn then return end
    HORDE:EndObjective(HORDE.OBJECTIVE_PAYLOAD, {spawn=self.Horde_Payload_Spawn})
    HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, self:Name():sub(1,20) .. " delivered " .. (self.Horde_Payload_Spawn.Horde_Payload_Label or "the payload") .."!")
    self.Horde_Payload_Spawn = nil
    sound.Play("horde/objective/fin" .. tonumber(math.random(1,3)) .. ".wav", self:GetPos())

    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HasPayload, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function HORDE:LoadObjectives()
    -- Load escape zone
    HORDE.escape_zones = ents.FindByClass("trigger_horde_escapezone")
    HORDE.has_escape_zones = not table.IsEmpty(HORDE.escape_zones)

    -- Load hold zone
    local hold_zones = ents.FindByClass("trigger_horde_holdzone")
    if not table.IsEmpty(hold_zones) then
        HORDE.hold_zones = {}
        HORDE.hold_zones_all_waves = {}
        HORDE.has_hold_zones = true
        for _, hold_zone in pairs(hold_zones) do
            if hold_zone.Horde_Active_Wave <= 0 then
                table.insert(HORDE.hold_zones_all_waves, hold_zone)
            else
                if not HORDE.hold_zones[hold_zone.Horde_Active_Wave] then
                    HORDE.hold_zones[hold_zone.Horde_Active_Wave] = {}
                end
                table.insert(HORDE.hold_zones[hold_zone.Horde_Active_Wave], hold_zone)
            end
        end
    end

    -- Load payloads
    local payload_spawns = ents.FindByClass("info_horde_payload_spawn")
    if not table.IsEmpty(payload_spawns) then
        HORDE.payload_spawns = {}
        HORDE.payload_spawns_all_waves = {}
        HORDE.has_payload_spawns = true
        for _, spawn in pairs(payload_spawns) do
            if spawn.Horde_Active_Wave <= 0 then
                table.insert(HORDE.payload_spawns_all_waves, spawn)
            else
                if not HORDE.payload_spawns[spawn.Horde_Active_Wave] then
                    HORDE.payload_spawns[spawn.Horde_Active_Wave] = {}
                end
                table.insert(HORDE.payload_spawns[spawn.Horde_Active_Wave], spawn)
            end
        end
    end

    local payload_destinations = ents.FindByClass("trigger_horde_payload_destination")
    if not table.IsEmpty(payload_destinations) then
        HORDE.payload_destinations = {}
        HORDE.payload_destinations_all_waves = {}
        HORDE.has_payload_destinations = true
        for _, destination in pairs(payload_destinations) do
            if destination.Horde_Active_Wave <= 0 then
                table.insert(HORDE.payload_destinations_all_waves, destination)
            else
                if not HORDE.payload_destinations[destination.Horde_Active_Wave] then
                    HORDE.payload_destinations[destination.Horde_Active_Wave] = {}
                end
                table.insert(HORDE.payload_destinations[destination.Horde_Active_Wave], destination)
            end
        end
    end
end

function HORDE:GetEscapeZones()
    if not HORDE.has_escape_zones then return end
    local zones = {}
    if not table.IsEmpty(HORDE.escape_zones) then
        for _, zone in pairs(HORDE.escape_zones) do
            if not zones[zone.Horde_Zone_Group] then
                zones[zone.Horde_Zone_Group] = {}
            end
            table.insert(zones[zone.Horde_Zone_Group], zone)
        end
    end

    local final_zones = {}
    for group, zs in pairs(zones) do
        if #zs == 1 then
            final_zones[zs[1].Horde_Zone_Id] = zs[1]
        else
            local p = math.random(1, #zs)
            final_zones[zs[p].Horde_Zone_Id] = zs[p]
        end
    end
    return final_zones
end

function HORDE:GetHoldZones(wave)
    if not HORDE.has_hold_zones then return end
    local zones = {}
    local total_progress = 90
    if not table.IsEmpty(HORDE.hold_zones_all_waves) then
        for _, zone in pairs(HORDE.hold_zones_all_waves) do
            if not zones[zone.Horde_Zone_Group] then
                zones[zone.Horde_Zone_Group] = {}
            end
            table.insert(zones[zone.Horde_Zone_Group], zone)
        end
    end

    if not table.IsEmpty(HORDE.hold_zones) and HORDE.hold_zones[wave] and not table.IsEmpty(HORDE.hold_zones[wave]) then
        for _, zone in pairs(HORDE.hold_zones[wave]) do
            local group = zone.Horde_Zone_Group
            if not group then group = 0 end
            if not zones[group] then
                zones[group] = {}
            end
            table.insert(zones[group], zone)
        end
    end

    local final_zones = {}
    for group, zs in pairs(zones) do
        if #zs == 1 then
            final_zones[zs[1].Horde_Zone_Id] = zs[1]
        else
            local p = math.random(1, #zs)
            final_zones[zs[p].Horde_Zone_Id] = zs[p]
        end
    end

    local count = table.Count(final_zones)
    local progress = total_progress / count
    for _, zone in pairs(final_zones) do
        zone.Horde_Total_Progress = progress / count
    end

    return final_zones
end

function HORDE:GetPayloadSpawns(wave)
    if not HORDE.payload_spawns or not HORDE.has_payload_destinations then return end
    local payload_spawns = {}
    if not table.IsEmpty(HORDE.payload_spawns_all_waves) then
        for _, spawn in pairs(HORDE.payload_spawns_all_waves) do
            if not payload_spawns[spawn.Horde_Payload_Spawn_Group] then
                payload_spawns[spawn.Horde_Payload_Spawn_Group] = {}
            end
            table.insert(payload_spawns[spawn.Horde_Payload_Spawn_Group], spawn)
        end
    end

    if not table.IsEmpty(HORDE.payload_spawns) and HORDE.payload_spawns[wave] and not table.IsEmpty(HORDE.payload_spawns[wave]) then
        for _, spawn in pairs(HORDE.payload_spawns[wave]) do
            if not payload_spawns[spawn.Horde_Payload_Spawn_Group] then
                payload_spawns[spawn.Horde_Payload_Spawn_Group] = {}
            end
            table.insert(payload_spawns[spawn.Horde_Payload_Spawn_Group], spawn)
        end
    end

    local final_payload_spawns = {}
    for group, zs in pairs(payload_spawns) do
        if #zs == 1 then
            final_payload_spawns[zs[1].Horde_Payload_Spawn_Id] = zs[1]
        else
            local p = math.random(1, #zs)
            final_payload_spawns[zs[p].Horde_Payload_Spawn_Id] = zs[p]
        end
    end

    return final_payload_spawns
end

function HORDE:GetPayloadDestinations(wave)
    if not HORDE.payload_spawns or not HORDE.has_payload_destinations then return end
    local payload_destinations = {}
    if not table.IsEmpty(HORDE.payload_destinations_all_waves) then
        for _, destination in pairs(HORDE.payload_destinations_all_waves) do
            if not payload_destinations[destination.Horde_Payload_Destination_Group] then
                payload_destinations[destination.Horde_Payload_Destination_Group] = {}
            end
            table.insert(payload_destinations[destination.Horde_Payload_Destination_Group], destination)
        end
    end

    if not table.IsEmpty(HORDE.payload_destinations) and HORDE.payload_destinations[wave] and not table.IsEmpty(HORDE.payload_destinations[wave]) then
        for _, destination in pairs(HORDE.payload_destinations[wave]) do
            if not payload_destinations[destination.Horde_Payload_Destination_Group] then
                payload_destinations[destination.Horde_Payload_Destination_Group] = {}
            end
            table.insert(payload_destinations[destination.Horde_Payload_Destination_Group], destination)
        end
    end

    local final_payload_destinations = {}
    for group, zs in pairs(payload_destinations) do
        if #zs == 1 then
            final_payload_destinations[zs[1].Horde_Payload_Destination_Id] = zs[1]
        else
            local p = math.random(1, #zs)
            final_payload_destinations[zs[p].Horde_Payload_Destination_Id] = zs[p]
        end
    end

    return final_payload_destinations
end

function HORDE:SyncHoldZoneProgress(id, progress)
    net.Start("Horde_SyncHoldProgress")
        net.WriteUInt(id, 4)
        net.WriteUInt(progress, 8)
    net.Broadcast()
end

function HORDE:StartObjective(objective, param, ply)
    if objective == HORDE.OBJECTIVE_HOLD then
        local zone = param.zone
        net.Start("Horde_SyncHoldLocation")
            net.WriteUInt(zone.Horde_Zone_Id, 4)
            net.WriteVector(zone:GetPos())
            net.WriteVector(zone:OBBMins())
            net.WriteVector(zone:OBBMaxs())
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end
        HORDE:SendNotificationObjective(HORDE.OBJECTIVE_HOLD, "Defend and hold " .. (zone.Horde_Zone_Label or "the area") .. "!")
        HORDE.max_objs = HORDE.max_objs + 1
    elseif objective == HORDE.OBJECTIVE_PAYLOAD then
        local spawn = param.spawn
        net.Start("Horde_SyncPayloadLocation")
            net.WriteUInt(spawn.Horde_Payload_Spawn_Id, 4)
            net.WriteVector(spawn:GetPos())
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end

        net.Start("Horde_SyncPayloadIcon")
            net.WriteUInt(spawn.Horde_Payload_Spawn_Id, 4)
            net.WriteUInt(spawn.Horde_Payload_Icon, 4)
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end

        spawn:Horde_SpawnPayload()
        HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, "Collect and deliver " .. (spawn.Horde_Payload_Label or "the payload") .. "!")
        HORDE.max_objs = HORDE.max_objs + 1
    elseif objective == HORDE.OBJECTIVE_ESCAPE then
        local zones = param.zones
        for _, zone in pairs(zones) do
            net.Start("Horde_SyncEscapeLocation")
            net.WriteUInt(zone.Horde_Zone_Id, 4)
            net.WriteVector(zone:GetPos())
            net.WriteVector(zone:OBBMins())
            net.WriteVector(zone:OBBMaxs())
            if ply then
                net.Send(ply)
            else
                net.Broadcast()
            end
        end
        net.Start("Horde_SyncEscapeStart")
        net.Broadcast()
        HORDE:SendNotificationObjective(HORDE.OBJECTIVE_ESCAPE, "Escape to the exit!")
        HORDE.max_objs = HORDE.max_objs + 1
        return
    end

    net.Start("Horde_RenderObjectives")
    net.WriteUInt(HORDE.finished_objs, 4)
    net.WriteUInt(HORDE.max_objs, 4)
    if ply then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

function HORDE:StartPayloadDestination(dest, ply)
    net.Start("Horde_SyncPayloadDestinationLocation")
        net.WriteUInt(dest.Horde_Payload_Destination_Id, 4)
        net.WriteVector(dest:GetPos())
        net.WriteVector(dest:OBBMins())
        net.WriteVector(dest:OBBMaxs())
    if ply then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

function HORDE:EndObjective(objective, param, ply)
    if objective == HORDE.OBJECTIVE_HOLD then
        local zone = param.zone
        net.Start("Horde_SyncHoldEnd")
        net.WriteUInt(zone.Horde_Zone_Id, 4)
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end
        zone:Input("oncompleted", zone, zone)

        HORDE.horde_active_holdzones[zone.Horde_Zone_Id] = nil
        HORDE.horde_has_active_objective = nil
        HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, "You have defended " .. (zone.Horde_Zone_Label or "the area") .."!")
        HORDE.finished_objs = HORDE.finished_objs + 1
        sound.Play("horde/objective/fin" .. tonumber(math.random(1,3)) .. ".wav", zone:GetPos())

        if table.IsEmpty(HORDE.horde_active_holdzones) then
            HORDE.horde_active_holdzones = nil

            if ply then
                net.Send(ply)
            else
                net.Broadcast()
            end
            HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, "All objectives have been completed!")
            -- Check if all holdzones are completed. If this is the case, end all objectives.
            if HORDE.endless == 1 then
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. " / ∞", HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            else
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. " / " .. tostring(HORDE.max_waves), HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
            return
        end
    elseif objective == HORDE.OBJECTIVE_PAYLOAD then
        local spawn = param.spawn
        spawn:Horde_RemovePayload()
        net.Start("Horde_SyncPayloadSpawnEnd")
        net.WriteUInt(spawn.Horde_Payload_Spawn_Id, 4)
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end
        spawn:Input("oncompleted", spawn, spawn)

        -- Check if all payloads have been delievered.
        HORDE.horde_active_payload_spawns[spawn.Horde_Payload_Spawn_Id].Horde_Activated = nil
        HORDE.horde_active_payload_spawns[spawn.Horde_Payload_Spawn_Id] = nil
        HORDE.finished_objs = HORDE.finished_objs + 1
        if table.IsEmpty(HORDE.horde_active_payload_spawns) then
            for _, dest in pairs(HORDE.horde_active_payload_destinations) do
                dest.Horde_Activated = nil
            end

            net.Start("Horde_SyncPayloadEnd")
            if ply then
                net.Send(ply)
            else
                net.Broadcast()
            end

            HORDE.horde_active_payload_spawns = nil
            HORDE.horde_has_active_objective = nil

            if ply then
                net.Send(ply)
            else
                net.Broadcast()
            end
            HORDE:SendNotificationObjective(HORDE.OBJECTIVE_PAYLOAD, "All objectives have been completed!")
             -- Check if all holdzones are completed. If this is the case, end all objectives.
             if HORDE.endless == 1 then
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. " / ∞", HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            else
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. " / " .. tostring(HORDE.max_waves), HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
            return
        end
    end

    net.Start("Horde_RenderObjectives")
    net.WriteUInt(HORDE.finished_objs, 4)
    net.WriteUInt(HORDE.max_objs, 4)
    net.Broadcast()
end

end