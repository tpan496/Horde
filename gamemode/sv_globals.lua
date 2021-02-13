if CLIENT then return end
_G.start_game = false
_G.total_enemies_per_wave = {10, 40, 60, 80, 100}
_G.total_enemies_this_wave = 0
_G.alive_enemies_this_wave = 0
_G.current_wave = 0
_G.total_break_time = 10
_G.current_break_time = _G.total_break_time
_G.max_spawn_distance = 3000
_G.min_spawn_distance = 500
_G.max_enemies_alive = 20
_G.spawned_enemies = {}
_G.ai_nodes = {}
_G.found_ai_nodes = false
_G.enemy_spawn_z = 15