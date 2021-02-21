function GM:RegisterCustomConfig(name)
    local classfiles, classdirectories = file.Find(self.FolderName.."/gamemode/custom/*", "LUA")
	table.sort(classfiles)
	table.sort(classdirectories)

    
	for i, filename in ipairs(classfiles) do
		if string.sub(filename, -4) == ".lua" then
            -- Just supporting one config so far
            CONFIG = {}
			AddCSLuaFile("custom/"..filename)
			include("custom/"..filename)

			if CONFIG.name then
				print(CONFIG.name)
			else
				ErrorNoHalt("CONFIG "..filename.." has no 'name' member!")
			end

            if CONFIG.name == name then
                return true
            end
		end
	end

    return false
end

if GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "" then
    local found = GM:RegisterCustomConfig(GetConVarString("horde_external_lua_config"))
    if not found then
        local str = "Custom config " .. GetConVarString("horde_external_lua_config") .. " not found!"
        if CLIENT then
            timer.Simple(1,function () notification.AddLegacy(str, NOTIFY_ERROR, 5) end)
        end
        print(str)
        return
    end
    local str = "Custom config " .. GetConVarString("horde_external_lua_config") .. " is loaded!"
    if CLIENT then
        timer.Simple(1,function()notification.AddLegacy(str, NOTIFY_GENERIC, 5)end)
    end
    
    if CONFIG.items then
        HORDE.items = CONFIG.items
    end
    
    if CONFIG.enemies then
        HORDE.enemies = {}
        for _, enemy in pairs(CONFIG.enemies) do
            HORDE.enemies[enemy.name .. tostring(enemy.wave)] = enemy
        end
    end

    HORDE.SaveTempData()
    HORDE.LoadTempData()
end