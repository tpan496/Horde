--[[

Author: tochnonement
Email: tochnonement@gmail.com

15/05/2022

--]]

snoiNPCs = snoiNPCs or {count = 0}
local storage = snoiNPCs

hook.Add('OnEntityCreated', 'snoi.CacheNPC', function(ent)
    if ent:IsNPC() or ent:IsNextBot() then
        local index = storage.count + 1
        storage[index] = ent
        storage.count = index
        ent.snoiNPC = true
        hook.Run('snoi.OnNPCSpawned', ent)
    end
end)

hook.Add('EntityRemoved', 'snoi.RemoveNPCFromCache', function(ent)
    if ent.snoiNPC then
        for i = 1, storage.count do
            if storage[i] == ent then
                table.remove(storage, i)
                storage.count = storage.count - 1
                break
            end
        end
    end
end)

timer.Create('snoi.CleanNullNPCs', 0.5, 0, function()
    local bChanges = false
    for i, ent in ipairs(storage) do
        if not IsValid(ent) then
            table.remove(storage, i)
            bChanges = true
        end
    end
    if bChanges then
        print('snoi cleaned invalid npcs')
        storage.count = #storage
    end
end)