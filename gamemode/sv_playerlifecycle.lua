if CLIENT then return end
-- Manages player spawn/death settings
hook.Add("PlayerSpawn", "Horde_PlayerSpawn", function(ply)
    if ply:IsValid() then
        ply:SetCollisionGroup(15)
        ply:SetCanZoom(false)
        ply:SetJumpPower(160)
        ply:SetWalkSpeed(180)
        ply:SetRunSpeed(230)
        ply:ConCommand([[mat_colorcorrection 1]])
        ply:ConCommand([[cl_showhints 0]])
        ply:SetMoveType(MOVETYPE_WALK)
    end
end)

hook.Add("PlayerDeath", "Horde_DeathSpectatingFunction", function(victim, inflictor, attacker)
    if not HORDE.start_game then return end
    timer.Simple(1, function()
        if victim:IsValid() then
            victim:SetObserverMode(OBS_MODE_CHASE)
            victim:SetMoveType(MOVETYPE_OBSERVER)
        end
    end)

    hook.Add("KeyPress", "Horde_SpectatingKeyPress", function(ply, key)
        if key == IN_ATTACK then
            if not ply:Alive() then
            local randomplayer = table.Random(player.GetAll())
                if randomplayer:IsValid() and randomplayer:Alive() and randomplayer ~= ply and randomplayer ~= ply:GetObserverTarget() then
                    if randomplayer == nil then return end
                    ply:SpectateEntity(randomplayer)
                end
            end
        end

        if key == IN_JUMP then
            if not ply:Alive() then
                local randomplayer = table.Random(player.GetAll())
                if randomplayer:IsValid() and randomplayer:Alive() and randomplayer ~= ply and randomplayer ~= ply:GetObserverTarget() then
                    if randomplayer == nil then return end
                    ply:SpectateEntity(randomplayer)
                end

                if ply:GetObserverMode() == OBS_MODE_IN_EYE then
                    ply:SetObserverMode(OBS_MODE_CHASE)
                elseif ply:GetObserverMode() == OBS_MODE_IN_EYE then
                    ply:SetObserverMode(OBS_MODE_CHASE)
                end
            end
        end
    end)
end)

function CheckAlivePlayers()
    local aliveplayers = 0 
    local deadplayers = 0
    for _, ply in pairs(player.GetAll()) do 
        if ply:IsValid() and ply:Alive() then 
            aliveplayers = aliveplayers + 1 
        end
        if ply:IsValid() and not ply:Alive() then 
            deadplayers = deadplayers + 1 
        end 
    end
    if aliveplayers == 0 and deadplayers > 0 then
        for _, ply in pairs(player.GetAll()) do 
            ply:ScreenFade(SCREENFADE.OUT, Color(0,0,0), 6, 2)
            ply:Freeze(true)
        end

        PrintMessage(HUD_PRINTTALK, "All players are dead! Restarting...")
        timer.Simple(5, function() timer.Simple(0, function() RunConsoleCommand("changelevel", game.GetMap()) end) end)
    end
end

hook.Add("PlayerDeathThink", "Horde_PlayerDeathThink", function (ply)
    if HORDE.start_game then return false end
    ply:Spawn()
    return true
end);

hook.Add("DoPlayerDeath", "Horde_DoPlayerDeath", function(victim)
    if not HORDE.start_game then return end
    CheckAlivePlayers()
end)