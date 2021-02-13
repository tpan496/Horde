if CLIENT then return end
EnemiesList = {}
EnemiesList[1] = {
    npc_vj_zss_zombie1=1,
    npc_vj_zss_zombie2=1,
    npc_vj_zss_zombie3=1,
    npc_vj_zss_zombie4=1,
    npc_vj_zss_zombie5=1,
    npc_vj_zss_zombie6=1,
    npc_vj_zss_zombie7=1,
    npc_vj_zss_zombie8=1,
    npc_vj_zss_zombie9=1,
    npc_vj_zss_zombie10=1,
    npc_vj_zss_zombie11=1,
    npc_vj_zss_zombie12=1,
    npc_vj_zss_czombie=1,
    npc_vj_zss_czombietors=3,
    npc_vj_zss_cpzombie=2
}

EnemiesList[2] = {
    npc_vj_zss_zombie1=1,
    npc_vj_zss_zombie2=1,
    npc_vj_zss_zombie3=1,
    npc_vj_zss_zombie4=1,
    npc_vj_zss_zombie5=1,
    npc_vj_zss_zombie6=1,
    npc_vj_zss_zombie7=1,
    npc_vj_zss_zombie8=1,
    npc_vj_zss_zombie9=1,
    npc_vj_zss_zombie10=1,
    npc_vj_zss_zombie11=1,
    npc_vj_zss_zombie12=1,
    npc_vj_zss_czombie=1,
    npc_vj_zss_cpzombie=2,
    npc_vj_zss_zombguard=2,
}

EnemiesList[3] = {
    npc_vj_zss_zombie1=1,
    npc_vj_zss_zombie2=1,
    npc_vj_zss_zombie3=1,
    npc_vj_zss_zombie4=1,
    npc_vj_zss_zombie5=1,
    npc_vj_zss_zombie6=1,
    npc_vj_zss_zombie7=1,
    npc_vj_zss_zombie8=1,
    npc_vj_zss_zombie9=1,
    npc_vj_zss_zombie10=1,
    npc_vj_zss_zombie11=1,
    npc_vj_zss_zombie12=1,
    npc_vj_zss_czombie=1,
    npc_vj_zss_cpzombie=2,
    npc_vj_zss_zombguard=2,
    npc_vj_zss_cfastzombie=2
}

EnemiesList[4] = {
    npc_vj_zss_zombie1=1,
    npc_vj_zss_zombie2=1,
    npc_vj_zss_zombie3=1,
    npc_vj_zss_zombie4=1,
    npc_vj_zss_zombie5=1,
    npc_vj_zss_zombie6=1,
    npc_vj_zss_zombie7=1,
    npc_vj_zss_zombie8=1,
    npc_vj_zss_zombie9=1,
    npc_vj_zss_zombie10=1,
    npc_vj_zss_zombie11=1,
    npc_vj_zss_zombie12=1,
    npc_vj_zss_czombie=1,
    npc_vj_zss_cpzombie=2,
    npc_vj_zss_cfastzombie=2,
    npc_vj_zss_zhulk=2
}

EnemiesList[5] = {
    npc_vj_zss_zombie1=1,
    npc_vj_zss_zombie2=1,
    npc_vj_zss_zombie3=1,
    npc_vj_zss_zombie4=1,
    npc_vj_zss_zombie5=1,
    npc_vj_zss_zombie6=1,
    npc_vj_zss_zombie7=1,
    npc_vj_zss_zombie8=1,
    npc_vj_zss_zombie9=1,
    npc_vj_zss_zombie10=1,
    npc_vj_zss_zombie11=1,
    npc_vj_zss_zombie12=1,
    npc_vj_zss_czombie=1,
    npc_vj_zss_cpzombie=2,
    npc_vj_zss_cfastzombie=2,
    npc_vj_zss_zhulk=2,
    npc_vj_zss_burnzie=2,
}

-- Normalize
for i=1,5 do
    local enemies = EnemiesList[i]
    local total_weight = 0
    for key, value in pairs(enemies) do
        total_weight = total_weight + value
    end
    for key, value in pairs(enemies) do
        EnemiesList[i][key] = value / total_weight
    end
    print(total_weight)
end