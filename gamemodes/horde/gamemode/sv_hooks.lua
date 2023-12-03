-- Custom Horde Hooks for developers

-- Called when a wave starts.
hook.Add("HordeWaveStart", "Horde_WaveStart", function(wave)
    return
end)

-- Called when a wave ends.
hook.Add("HordeWaveEnd", "Horde_WaveEnd", function(wave)
    return
end)

-- Called when Horde spawns an enemy NPC.
hook.Add("HordeEnemySpawn", "Horde_EnemySpawn", function(enemy)
    return
end)

-- Called when Horde spawns a Boss NPC.
hook.Add("HordeBossSpawn", "Horde_BossSpawn", function (enemy)
    return
end)

-- Remove tinnitus
hook.Add( "OnDamagedByExplosion", "HordeDisableTinnitus", function()
    return true
end)
