function GM:RegisterCustomConfig(name)
    local classfiles, classdirectories = file.Find(self.FolderName .. "/gamemode/custom/*", "LUA")
    table.sort(classfiles)
    table.sort(classdirectories)
    print("[HORDE] Attempting to register config: " .. name)

    for i, filename in ipairs(classfiles) do
        if string.sub(filename, -4) == ".lua" then
            -- Just supporting one config so far
            CONFIG = {}
            AddCSLuaFile("custom/" .. filename)
            include("custom/" .. filename)

            if CONFIG.name then
                print("[HORDE] Config " .. CONFIG.name .. " found!")
            else
                ErrorNoHalt("CONFIG " .. filename .. " has no 'name' member!")
            end

            if CONFIG.name == name then
                print("[HORDE] Config " .. CONFIG.name .. " selected!")
                return true
            end
        end
    end

    return false
end

HORDE.SaveTempData = function ()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
    end
    if GetConVar("horde_external_lua_config"):GetString() and GetConVar("horde_external_lua_config"):GetString() ~= "" then
        file.Write("horde/temp_enemies.dat", util.TableToJSON(HORDE.enemies))
        file.Write("horde/temp_items.dat", util.TableToJSON(HORDE.items))
        print("[HORDE] External lua config found.")
    end
end

HORDE.LoadTempData = function ()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
        return
    end

    if file.Read("horde/temp_items.dat", "DATA") then
        local t1 = util.JSONToTable(file.Read("horde/temp_items.dat", "DATA"))

        for _, item in pairs(t1) do
            if item.name == "" or item.class == "" or item.name == nil or item.category == nil or item.class == nil or item.ammo_price == nil or item.secondary_ammo_price == nil then
                if CLIENT then
                    HORDE:PlayNotification("Item config file validation failed! Please update your file or delete it.", 1)
                    HORDE:PlayNotification("Falling back to default config.", 1)
                end
                return
            end
        end

        if file.Read("horde/temp_enemies.dat", "DATA") then
            local t2 = util.JSONToTable(file.Read("horde/temp_enemies.dat", "DATA"))
            -- Integrity
            for _, enemy in pairs(t2) do
                if enemy.name == nil or enemy.name == "" or enemy.class == nil or enemy.class == "" or enemy.weight == nil or enemy.wave == nil then
                    if CLIENT then
                        HORDE:PlayNotification("Enemy config file validation failed! Please update your file or delete it.", 1)
                        HORDE:PlayNotification("Falling back to default config.", 1)
                    end
                    return
                else
                    if not enemy.weapon then
                        enemy.weapon = ""
                    end
                end
            end

            -- Be careful of backwards compataiblity
            HORDE.items = t1
            HORDE.enemies = t2
            HORDE:NormalizeEnemiesWeight()
        end
    end
end

if SERVER then
util.AddNetworkString("Horde_UseExternalLuaConfig")

net.Receive("Horde_UseExternalLuaConfig", function ()
    HORDE.LoadTempData()
end)
end

if GetConVar("horde_external_lua_config"):GetString() and GetConVar("horde_external_lua_config"):GetString() ~= "" then
    local found = GM:RegisterCustomConfig(GetConVar("horde_external_lua_config"):GetString())
    if not found then
        local str = "Custom config " .. GetConVar("horde_external_lua_config"):GetString() .. " failed to load!"
        if CLIENT then
            timer.Simple(1,function () HORDE:PlayNotification(str, 1) end)
        end
        print("[HORDE] " .. str)
        return
    end
    local str = "Custom config " .. GetConVar("horde_external_lua_config"):GetString() .. " is loaded!"
    if CLIENT then
        timer.Simple(1, function() HORDE:PlayNotification(str, 0) end)
    end
    print("[HORDE] " .. str)

    if CONFIG.items then
        HORDE.items = CONFIG.items
    else
        HORDE:GetDefaultItemsData()
    end

    if CONFIG.enemies then
        HORDE.enemies = {}
        for _, enemy in pairs(CONFIG.enemies) do
            HORDE.enemies[enemy.name .. tostring(enemy.wave)] = enemy
        end
    else
        HORDE:GetDefaultEnemiesData()
    end

    HORDE.SaveTempData()
    HORDE.LoadTempData()
end