--[[
HORDE Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. {1}, %d. Keep those directly.
3. Keep translations short and concise.
4. Consistency, especially for perks.
increase vs. more: these two descriptions are DIFFERENT!
resistance vs. less damage taken: same as above.
5. Translate AS IS.
--]]

translate.AddLanguage("zh-CN", "Chinese Simplified")

LANGUAGE["Default_Font"] = "微软雅黑"
LANGUAGE["Default_Font_Scale"] = 1.20

-- Game Info
LANGUAGE["Game_Ready"] = "     准备"
LANGUAGE["Game_Not Ready"] = "     未准备"
LANGUAGE["Game_Players_Ready"] = "等待玩家"
LANGUAGE["Game_Next_Wave_Starts_In"] = "下一波在 %d 秒后开始"
LANGUAGE["Game_Difficulty_NORMAL"] = "普通"
LANGUAGE["Game_Difficulty_HARD"] = "困难"
LANGUAGE["Game_Difficulty_REALISM"] = "写实"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "噩梦"
LANGUAGE["Game_Enemies"] = "敌人数"
LANGUAGE["Game_HintBottomReady"] = "  F3 - 商店/技能, F4 - 准备"
LANGUAGE["Game_HintBottom"] = "  F3 - 商店/技能, V - 扔钱"
LANGUAGE["Game_Result_VICTORY"] = "胜利"
LANGUAGE["Game_Result_DEFEAT"] = "失败"
LANGUAGE["Game_Result_Change Map"] = "地图更换中"
LANGUAGE["Game_Wave"] = "波数"
LANGUAGE["Game_Wave_Has_Started"] = "第 %d 波即将开始"
LANGUAGE["Game_Wave_Completed"] = "目标达成"
LANGUAGE["Game_Remaining_Time"] = "剩余时间"
LANGUAGE["Game_Vote_Map"] = "地图投票"
LANGUAGE["Game_Game_Summary"] = "游戏数据"
LANGUAGE["Game_Most_Damage_Dealt"] = "最高伤害"
LANGUAGE["Game_Damage"] = "伤害"
LANGUAGE["Game_Most_Damage_Taken"] = "最高伤害承受"
LANGUAGE["Game_Damage_Taken"] = "承受伤害"
LANGUAGE["Game_Most_Kills"] = "最多杀敌"
LANGUAGE["Game_Kills"] = "击杀"
LANGUAGE["Game_Elite_Killer"] = "精英杀手"
LANGUAGE["Game_Elite_Kills"] = "精英怪击杀"
LANGUAGE["Game_SharpShooter"] = "神射手"
LANGUAGE["Game_Headshots"] = "爆头数"
LANGUAGE["Game_Most_Heal"] = "最高治疗量"
LANGUAGE["Game_Healed"] = "治疗量"
LANGUAGE["Game_Healed_You"] = "治疗了你"


-- Ranks
LANGUAGE["Rank_Novice"] = "入门"
LANGUAGE["Rank_Amateur"] = "学徒"
LANGUAGE["Rank_Skilled"] = "高手"
LANGUAGE["Rank_Professional"] = "专业"
LANGUAGE["Rank_Expert"] = "大师"
LANGUAGE["Rank_Champion"] = "冠绝"
LANGUAGE["Rank_Master"] = "宗师"


-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "职业"
LANGUAGE["Shop_Cash"] = "金钱"
LANGUAGE["Shop_Weight"] = "负重"
LANGUAGE["Shop_Melee"] = "近战"
LANGUAGE["Shop_Pistol"] = "手枪"
LANGUAGE["Shop_Shotgun"] = "霰弹枪"
LANGUAGE["Shop_SMG"] = "微型冲锋枪"
LANGUAGE["Shop_Rifle"] = "步枪"
LANGUAGE["Shop_MG"] = "重机枪"
LANGUAGE["Shop_Explosive"] = "爆炸物"
LANGUAGE["Shop_Special"] = "特殊"
LANGUAGE["Shop_Equipment"] = "装备"
LANGUAGE["Shop_Attachment"] = "配件"

-- Attachments
LANGUAGE["Shop_Optic"] = "瞄具"
LANGUAGE["Shop_Underbarrel"] = "下挂"
LANGUAGE["Shop_Tactical"] = "战术工具"
LANGUAGE["Shop_Barrel"] = "枪管"
LANGUAGE["Shop_Muzzle"] = "枪口"
LANGUAGE["Shop_Magazine"] = "弹匣"
LANGUAGE["Shop_Stock"] = "枪托"
LANGUAGE["Shop_Ammo Type"] = "子弹类型"
LANGUAGE["Shop_Perk"] = "武器技能"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "职业/技能"
LANGUAGE["Shop_Select_Class"] = "选择职业（拥有物品会被去除）"
LANGUAGE["Shop_Show_Perks"] = "显示技能树"
LANGUAGE["Shop_Hide_Perks"] = "隐藏技能树"
LANGUAGE["Shop_Unlocks_After_Wave"] = "第 %d 波后解锁"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "购买弹匣"
LANGUAGE["Shop_Sell_For"] = "卖出"
LANGUAGE["Shop_Sell_All_For"] = "卖出全部"
LANGUAGE["Shop_Buy_Item"] = "购买物品"
LANGUAGE["Shop_OWNED"] = "已拥有"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "购买副弹药"
LANGUAGE["Shop_Primary_Ammo"] = "主弹药"
LANGUAGE["Shop_Secondary_Ammo"] = "副弹药"

-- Classes
LANGUAGE["Class_Survivor"] = "生存者"
LANGUAGE["Class_Assault"] = "突击兵"
LANGUAGE["Class_Heavy"] = "重装兵"
LANGUAGE["Class_Medic"] = "医疗兵"
LANGUAGE["Class_Demolition"] = "爆破兵"
LANGUAGE["Class_Ghost"] = "幻影"
LANGUAGE["Class_Engineer"] = "工程师"
LANGUAGE["Class_Berserker"] = "狂战士"
LANGUAGE["Class_Warden"] = "守望者"
LANGUAGE["Class_Cremator"] = "火焰兵"


-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
能使用除了特殊武器和职业独有武器外的大部分武器。]]

LANGUAGE["Class_Description_Assault"] = [[
能使用全部的突击步枪武器。]]

LANGUAGE["Class_Description_Heavy"] = [[
能使用全部的重机枪和高负重武器。]]

LANGUAGE["Class_Description_Medic"] = [[
能使用大部分轻武器以及医疗类工具。]]

LANGUAGE["Class_Description_Demolition"] = [[
能使用全部的爆炸类武器。]]

LANGUAGE["Class_Description_Ghost"] = [[
能使用全部的狙击步枪武器和独特的轻武器。]]

LANGUAGE["Class_Description_Engineer"] = [[
能使用特殊类武器和道具。]]

LANGUAGE["Class_Description_Berserker"] = [[
只能使用近战类武器。]]

LANGUAGE["Class_Description_Warden"] = [[
能使用全部的霰弹枪武器以及制造守望塔 (horde_watchtower)。]]

LANGUAGE["Class_Description_Cremator"] = [[
能使用基于热学原理的武器。]]

-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
生存者拥有最大的武器池，从而可以弥补团队中需缺的任何角色。
复杂度: 简单

无额外特性。]]

LANGUAGE["Perk_assault_base"] = [[
突击兵拥有出色的移动力和稳定的输出，从而能应对任何场景。
复杂度: 简单

提升 {1} 移速。
杀死敌人后获得“肾上腺素”状态。通过技能的选择，“肾上腺素”可以进行堆叠。
“肾上腺素”提升 {2} 移速和输出。]]

LANGUAGE["Perk_heavy_base"] = [[
重装兵拥有高超的护甲防御机制，同时能使用重武器对敌人造成火力压制。
复杂度: 简单

+{1} 最大负重。
每秒恢复 {2} 点护甲。
护甲回复上限为 {3}。]]

LANGUAGE["Perk_medic_base"] = [[
医疗兵拥有强大的生命恢复能力，同时能为队友提供治疗以及各种增益效果。
复杂度: 中等

每秒恢复 {1} 生命值。]]

LANGUAGE["Perk_demolition_base"] = [[
爆破兵拥有强大的范围性输出。根据技能的选择，爆破兵也能提供超群的单体输出能力。
复杂度: 中等

提升 {1} 爆炸伤害抗性。
在没有高爆手雷的前提下，每 {3} 秒获得 {2} 个高爆手雷。]]

LANGUAGE["Perk_ghost_base"] = [[
幻影是一个围绕着精准度和“迷彩”机制的职业。使用恰当的话，幻影可以提供无以匹敌的单体输出。
复杂度: 困难

{1} 更多爆头伤害。
蹲下以激活“迷彩”状态，提供 {2} 闪避。
攻击，奔跑或者跳跃会取消“迷彩”状态。]]

LANGUAGE["Perk_engineer_base"] = [[
工程师是一个围绕着召唤物的职业。召唤物能有效地进行区域性防守并且为队友提供掩护。
复杂度: 中等

提升 {1} 召唤物生命值和伤害。
步哨拥有 {2} 基础生命值和 {3} 基础伤害。]]

LANGUAGE["Perk_berserker_base"] = [[
狂战士是近距离格斗专家。
复杂度: 困难

提升 {1} 所有伤害抗性。
提升 {2} 毒素伤害抗性。]]

LANGUAGE["Perk_warden_base"] = [[
守望者是是一个使用自身光环和建筑来为队友提供各种有利效果的辅助职业。
复杂度：中等

自身以及附近的玩家会受到“守望光环”效果。
“守望光环”阻挡 {1} 伤害。]]

LANGUAGE["Perk_cremator_base"] = [[
喷火兵使用火焰伤害进行进攻和防御。
复杂度：简单

提升 {1} 火焰伤害抗性。
攻击有 {2} 概率引燃敌人。

引燃持续时间为 {3} 秒，造成基于攻击伤害的持续伤害。
火焰伤害有 {1} 概率引燃敌人。]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[生存]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[随机应变]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[技巧复制]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[机动性]]
LANGUAGE["Perk_Title_assault_ambush"] = [[强袭]]
LANGUAGE["Perk_assault_ambush"] = [[
提升 {1} 爆头伤害。]]

LANGUAGE["Perk_Title_assault_charge"] = [[蓄能]]
LANGUAGE["Perk_assault_charge"] = [[
“肾上腺素”最大堆叠次数 +{1}。]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[适应性]]
LANGUAGE["Perk_Title_assault_drain"] = [[生命汲取]]
LANGUAGE["Perk_assault_drain"] = [[
满血前提下，提升 {1} 爆头伤害。
每击杀一个敌人恢复 {2} 最大生命值。]]

LANGUAGE["Perk_Title_assault_overclock"] = [[代谢超频]]
LANGUAGE["Perk_assault_overclock"] = [[
“肾上腺素”持续时间提升 {1}。
“肾上腺素”最大堆叠次数 +{2}。]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[条件反射]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[精神统一]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
提升 {1} 爆头伤害。
满血前提下，提升 {2} 所有伤害抗性。]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[心脏过载]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
爆头有 {1} 几率 +1 层“肾上腺素”。
“肾上腺素”最大堆叠次数 +{2}。]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[压制]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[粘性化合物]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
子弹伤害击中的敌人受到“减速”异常状态。
“减速”状态下，行动速度减少 {1}。]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[粗糙弹壳]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
子弹伤害击中的敌人受到“虚弱”异常状态。
“虚弱”状态下，受到 {1} 更多伤害。
“虚弱”状态下，造成 {2} 更少伤害。]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[护甲强化]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[流体装甲]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
护甲值至少有 {1} 的前提下：
  提升 {2} 物理抗性。]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[反应装甲]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
护甲值至少有 {1} 的前提下：
  免疫火焰，毒素，爆炸伤害。]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[先进科技]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[纳米机器]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
提升 {1} 护甲值恢复速度.
护甲值可以最多恢复至 {2} 点。]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[弹道冲击]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
造成的异常状态时间提升 {1}。
造成的异常状态效果提升 {2}。]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[药物]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[抗生素]]
LANGUAGE["Perk_medic_antibiotics"] = [[
提升 {1} 治疗量。]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[止痛剂]]
LANGUAGE["Perk_medic_painkillers"] = [[
提升 {1} 治疗生命值最大上限。]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[生物工程]]
LANGUAGE["Perk_Title_medic_berserk"] = [[狂化]]
LANGUAGE["Perk_medic_berserk"] = [[
治疗的对象获得“狂化”增益状态。
“狂化”状态持续 {1} 秒。
“狂化”状态下，提升 {2} 伤害和移速。]]

LANGUAGE["Perk_Title_medic_fortify"] = [[坚固]]
LANGUAGE["Perk_medic_fortify"] = [[
治疗的对象获得“坚固”增益状态。
“坚固”状态持续 {1} 秒。
“坚固”状态下，受到 {2} 更少伤害。]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[物竞天择]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[细胞坍缩]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
击杀的敌人有 {1} 概率产生治疗烟雾。]]

LANGUAGE["Perk_Title_medic_xcele"] = [[治愈因子]]
LANGUAGE["Perk_medic_xcele"] = [[
提升 {1} 增益状态效果。
提升 {2} 增益状态持续时间。]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[手雷改装]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[冲击起爆]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
提升 {1} 爆炸伤害。
提升 {2} 手雷伤害。]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[子母弹]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
手雷爆炸后产生 {1} 个子雷。
子雷伤害比母雷少 {2}。]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[爆破途径]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[冲击]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
对满血敌人造成的爆炸伤害提升 {1}。]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[击晕]]
LANGUAGE["Perk_demolition_knockout"] = [[
爆炸伤害对敌人累计眩晕值。
眩晕值到达 {2} 后，对敌人造成 {1} 秒眩晕。
眩晕冷却时间为 {3} 秒。
]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[毁灭]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[高压弹头]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
提升 {1} 对精英敌人造成的爆炸伤害。
对敌人造成 {2} 当前生命值的额外爆炸伤害。]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[连锁反应]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
击杀的敌人有 {1} 概率爆炸。
爆炸伤害为最大生命值的 {2}。]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[策略]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[猎头]]
LANGUAGE["Perk_ghost_headhunter"] = [[
爆头伤害能够进行堆叠，最多堆叠 {1} 次。
每层堆叠提升 {2} 爆头伤害。]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[狙击]]
LANGUAGE["Perk_ghost_sniper"] = [[
蹲下状态提升 {1} 子弹伤害。]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[战略转移]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[幽灵漫步]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
奔跑，跳跃不会取消“迷彩”状态。
迷彩状态下提升 {1} 移速。]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[幻影披风]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
攻击不会取消“迷彩”状态。
迷彩激活速度提升 {1}。]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[歼灭]]
LANGUAGE["Perk_Title_ghost_coup"] = [[恩赐解脱]]
LANGUAGE["Perk_ghost_coup"] = [[
直接击杀生命值小于 {1} 最大生命值的敌人。]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[斩首]]
LANGUAGE["Perk_ghost_decapitate"] = [[
“迷彩”状态下：
  提升 {1} 子弹伤害。
  提升 {2} 对精英敌人造成的爆头伤害。]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[制造]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[工匠]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
提升 {1} 召唤物最大生命值。]]

LANGUAGE["Perk_Title_engineer_manhack"] = [[无人机]]
LANGUAGE["Perk_engineer_manhack"] = [[
步哨替换为无人机。
无人机撞击敌人后死亡，死亡后会自动再生。
无人机撞击伤害为自身生命值。]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[原型]]
LANGUAGE["Perk_Title_engineer_golem"] = [[魔像]]
LANGUAGE["Perk_engineer_golem"] = [[
召唤物每秒恢复 {1} 最大生命值。
召唤物攻击带有增强的击退效果。]]

LANGUAGE["Perk_Title_engineer_spectre"] = [[鬼影]]
LANGUAGE["Perk_engineer_spectre"] = [[
召唤物吸收 {1} 对敌人造成的伤害为生命值。
召唤物提升 {2} 伤害。]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[实验性模组]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[共生]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
召唤物提升 {1} 最大生命值。
每有一个存活的召唤物，提升 {2} 所有伤害抗性。]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[神风]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
召唤物死亡时会产生爆炸。
爆炸伤害为召唤物最大生命值的 {1}。]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[基本功]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[波纹呼吸]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
每秒恢复 {1} 最大生命值。
免疫毒素伤害。]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[嗜血狂怒]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
吸收 {1} 造成的近战伤害为生命值。
每次攻击最多吸收 {2} 点生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[技巧]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[剑舞]]
LANGUAGE["Perk_berserker_bushido"] = [[
提升 {1} 利器伤害。
提升 {2} 移速。]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[残暴]]
LANGUAGE["Perk_berserker_savagery"] = [[
提升 {1} 钝器伤害。
提升 {2} 最大生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[秘技]]
LANGUAGE["Perk_Title_berserker_mindeye"] = [[心眼]]
LANGUAGE["Perk_berserker_mindeye"] = [[
每次近战攻击可以获得一层心眼状态，最多 {1} 层。
每层提升 {2} 闪避和 {3} 近战伤害。
被敌人攻击命中或者层数超过最大时，层数清零。]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[肉斩骨断]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
{1} 更多近战伤害。
近战攻击可以溅射。
溅射伤害为基础伤害的 {2}。]]

-- Default Perks: Warden
LANGUAGE["Perk_Title_Warden_Tier_1"] = [[维持]]
LANGUAGE["Perk_Title_warden_bulwark"] = [[制御]]
LANGUAGE["Perk_warden_bulwark"] = [[
守望塔每 {1} 秒生成 1 个护甲包。]]

LANGUAGE["Perk_Title_warden_vitality"] = [[活性化]]
LANGUAGE["Perk_warden_vitality"] = [[
光环提供每秒 {1} 点生命恢复。]]

LANGUAGE["Perk_Title_Warden_Tier_2"] = [[资源利用]]
LANGUAGE["Perk_Title_warden_restock"] = [[快速补充]]
LANGUAGE["Perk_warden_restock"] = [[
守望塔资源生成冷却时间减少 {1}。]]

LANGUAGE["Perk_Title_warden_energize"] = [[残暴]]
LANGUAGE["Perk_warden_energize"] = [[
光环提供 +{1} 额外基础伤害。]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[广域化]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[机械降神]]
LANGUAGE["Perk_warden_ex_machina"] = [[
守望塔提供“守望光环”。
守望塔每 {1} 秒产生冲击波。
冲击波造成 {2} 电击伤害。]]

LANGUAGE["Perk_Title_warden_resonance_cascade"] = [[级联共振]]
LANGUAGE["Perk_warden_resonance_cascade"] = [[
光环效果增加 {1}。
光环半径增加 {2}。]]

-- Default Perks: Cremator
LANGUAGE["Perk_Title_Cremator_Tier_1"] = [[化合物]]
LANGUAGE["Perk_Title_cremator_methane"] = [[甲烷]]
LANGUAGE["Perk_cremator_methane"] = [[
对被引燃的敌人提升 {1} 火焰伤害。]]

LANGUAGE["Perk_Title_cremator_napalm"] = [[凝固汽油弹]]
LANGUAGE["Perk_cremator_napalm"] = [[
提升 {1} 引燃半径。
提升 {2} 引燃持续时间。]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[能量汲取]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[阳电子阵列]]
LANGUAGE["Perk_cremator_positron_array"] = [[
免疫火焰伤害。
吸收 {1} 受到的火焰伤害为生命值。]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[熵护盾]]
LANGUAGE["Perk_cremator_entropy_shield"] = [[
获得一个能抵消一次伤害的护盾。
护盾被击中后爆炸，在 {1} 秒后重生。
护盾爆炸造成 {2} 火焰伤害。]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[能量释放]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[烈焰风暴]]
LANGUAGE["Perk_cremator_firestorm"] = [[
火焰伤害对敌人累计爆裂值。
爆裂值到达 {1} 后产生爆炸。
爆炸造成 {2} 爆炸伤害。]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[燃烧殆尽]]
LANGUAGE["Perk_cremator_incineration"] = [[
提升 {1} 引燃伤害。
提升 {2} 引燃概率。]]

-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[电击棍]]
LANGUAGE["Item_Desc_Stunstick"] = [[
能放出电流的警棍。
]]

LANGUAGE["Item_Crowbar"] = [[撬棍]]
LANGUAGE["Item_Desc_Crowbar"] = [[
略微生锈的撬棍。
]]

LANGUAGE["Item_Combat Knife"] = [[战术匕首]]
LANGUAGE["Item_Desc_Combat Knife"] = [[
可靠的匕首。
右键能使出威力更大的横砍。
]]

LANGUAGE["Item_Katana"] = [[武士刀]]
LANGUAGE["Item_Desc_Katana"] = [[
忍者武士刀。
有优越的攻击距离和劈砍速度。
]]

LANGUAGE["Item_Bat"] = [[棒球棍]]
LANGUAGE["Item_Desc_Bat"] = [[
扎实的棒球棍。
对敌人造成钝器伤害。
]]


LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
联合军标配手枪。
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Colt python magnum pistol.
Used by Black Mesa security guards.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
奥地利制造半自动手枪。
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Universelle Selbstladepistole.
德国公司H&K制造的半自动手枪。
]]

LANGUAGE["Item_P2000"] = [[P2000]]
LANGUAGE["Item_Desc_P2000"] = [[
Heckler & Koch P2000.
A serviceable first-round pistol made by H&K.
]]

LANGUAGE["Item_P250"] = [[P250]]
LANGUAGE["Item_Desc_P250"] = [[
SIG Sauer P250.
A low-recoil sidearm with a high rate of fire.
]]

LANGUAGE["Item_R8"] = [[R8]]
LANGUAGE["Item_Desc_R8"] = [[
R8 Revolver.
Delivers a highly accurate and powerful round,
at the expense of a lengthy trigger-pull.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Night Hawk .50C.
An iconic pistol that is diffcult to master.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt 1911.
Standard-issue sidearm for the United States Armed Forces.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
A Belgian semi-automatic pistol made by FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
A semi-automatic pistol manufactured in Czech Republic.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Sidearm used by the United States Armed Forces.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
A Swedish-made semi-automatic pistol.
Lethal in close quarters.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
A select-fire 9×19mm Parabellum caliber machine pistol.
]]

LANGUAGE["Item_Anaconda"] = [[Anaconda]]
LANGUAGE["Item_Desc_Anaconda"] = [[
Colt Anaconda.
Chambered for the powerful .44 Magnum.
]]


LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
A compact, fully automatic firearm.
Armed with an M203 launcher.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Military Armament Corporation Model 10.
Boasts a high rate of fire,
with poor spread accuracy and high recoil as trade-offs.
]]

LANGUAGE["Item_MP9"] = [[MP9]]
LANGUAGE["Item_Desc_MP9"] = [[
Brügger & Thomet MP9.
Manufactured in Switzerland,
the MP9 is favored by private security firms world-wide.
]]

LANGUAGE["Item_MP5K"] = [[MP5K]]
LANGUAGE["Item_Desc_MP5K"] = [[
Heckler & Koch MP5K.
A more convert and mobile version of the MP5.
]]

LANGUAGE["Item_MP5"] = [[MP5]]
LANGUAGE["Item_Desc_MP5"] = [[
Heckler & Koch MP5.
Often imitated but never equaled,
the MP5 is perhaps the most versatile SMG in the world.
]]

LANGUAGE["Item_UMP45"] = [[UMP45]]
LANGUAGE["Item_Desc_UMP45"] = [[
KM UMP45.
A lighter and cheaper successor to the MP5.
]]

LANGUAGE["Item_PP Bizon"] = [[PP Bizon]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
PP-19 Bizon.
Offers a high-capacity magazine that reloads quickly.
]]

LANGUAGE["Item_P90"] = [[P90]]
LANGUAGE["Item_Desc_P90"] = [[
ES C90.
A Belgian bullpup PDW with a magazine of 50 rounds.
]]

LANGUAGE["Item_Vector"] = [[Vector]]
LANGUAGE["Item_Desc_Vector"] = [[
KRISS Vector Gen I.
Uses an unconventional blowback system that results in its high firerate.
]]


LANGUAGE["Item_Pump-Action"] = [[Pump-Action]]
LANGUAGE["Item_Desc_Pump-Action"] = [[
A standard 12-gauge shotgun.
RMB to fire 2 shots at once.
]]

LANGUAGE["Item_Nova"] = [[Nova]]
LANGUAGE["Item_Desc_Nova"] = [[
Benelli Nova.
Italian pump-action 12-gauge shotgun.
]]

LANGUAGE["Item_M870"] = [[M870]]
LANGUAGE["Item_Desc_M870"] = [[
Remington 870 Shotgun.
Manufactured in the United States.
]]

LANGUAGE["Item_MAG7"] = [[MAG7]]
LANGUAGE["Item_Desc_MAG7"] = [[
Techno Arms MAG-7.
Fires a specialized 60mm 12 gauge shell.
]]

LANGUAGE["Item_XM1014"] = [[XM1014]]
LANGUAGE["Item_Desc_XM1014"] = [[
Benelli M4 Super 90.
Fully automatic shotgun.
]]

LANGUAGE["Item_SPAS-12"] = [[SPAS-12]]
LANGUAGE["Item_Desc_SPAS-12"] = [[
Franchi SPAS-12.
A combat shotgun manufactured by Italian firearms company Franchi.
]]

LANGUAGE["Item_Striker"] = [[Striker]]
LANGUAGE["Item_Desc_Striker"] = [[
Armsel Striker.
A 12-gauge shotgun with a revolving cylinder from South Africa.
]]

LANGUAGE["Item_AA12"] = [[AA12]]
LANGUAGE["Item_Desc_AA12"] = [[
Atchisson Assault Shotgun.
Devastating firepower at close to medium range.
]]


LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
AR-15 Style Rifle.
A lightweight semi-automatic rifle based on ArmaLite AR-15 design.
]]

LANGUAGE["Item_FAMAS"] = [[FAMAS]]
LANGUAGE["Item_Desc_FAMAS"] = [[
FAMAS bullpup assault rifle.
Recognised for its high rate of fire."
]]

LANGUAGE["Item_Galil"] = [[Galil]]
LANGUAGE["Item_Desc_Galil"] = [[
Galil ACE 22.
Developed and originally manufactured by Israel Military Industries.
]]

LANGUAGE["Item_AK47"] = [[AK47]]
LANGUAGE["Item_Desc_AK47"] = [[
Avtomat Kalashnikova.
A gas-operated, 7.62×39mm assault rifle developed in the Soviet Union.
]]

LANGUAGE["Item_M4A1"] = [[M4A1]]
LANGUAGE["Item_Desc_M4A1"] = [[
Colt M4.
A 5.56×45mm NATO, air-cooled, gas-operated, select fire carbine.
]]

LANGUAGE["Item_SG556"] = [[SG556]]
LANGUAGE["Item_Desc_SG556"] = [[
SIG SG 550.
An assault rifle manufactured by Swiss Arms AG.
]]

LANGUAGE["Item_AUG"] = [[AUG]]
LANGUAGE["Item_Desc_AUG"] = [[
Steyr AUG.
An Austrian bullpup assault rifle.
]]

LANGUAGE["Item_F2000"] = [[F2000]]
LANGUAGE["Item_Desc_F2000"] = [[
FN F2000.
An ambidextrous bullpup rifle developed by FN.
]]

LANGUAGE["Item_Tavor"] = [[Tavor]]
LANGUAGE["Item_Desc_Tavor"] = [[
IWI Tavor-21.
Designed to maximize reliability, durability, and simplicity.
]]


LANGUAGE["Item_ACR"] = [[ACR]]
LANGUAGE["Item_Desc_ACR"] = [[
Remington Adaptive Combat Rifle.
A modular semi-Auto rifle.
]]

LANGUAGE["Item_AWP"] = [[AWP]]
LANGUAGE["Item_Desc_AWP"] = [[
Magnum Ghost Rifle.
A series of sniper rifles manufactured by the United Kingdom.
]]

LANGUAGE["Item_SCAR"] = [[SCAR]]
LANGUAGE["Item_Desc_SCAR"] = [[
FN SCAR.
An assault rifle developed by Belgian manufacturer FN Herstal.
]]

LANGUAGE["Item_G3"] = [[G3]]
LANGUAGE["Item_Desc_G3"] = [[
G3 Battle Rifle.
A 7.62×51mm NATO, select-fire battle rifle developed by H&K.
]]

LANGUAGE["Item_Barret AMR"] = [[Barret AMR]]
LANGUAGE["Item_Desc_Barret AMR"] = [[
.50 Cal Anti-Material Sniper Rifle.
能对目标造成巨额的子弹伤害。
]]


LANGUAGE["Item_SSG08 Medic SR"] = [[SSG08医疗狙击枪]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
一把改造过的狙击枪，能够发射医疗针。
医疗针能够治疗队友并且伤害敌人。
]]

LANGUAGE["Item_Negev"] = [[Negev]]
LANGUAGE["Item_Desc_Negev"] = [[
IWI Negev.
A 5.56×45mm NATO light machine gun developed by the IWI.
]]

LANGUAGE["Item_M249"] = [[M249]]
LANGUAGE["Item_Desc_M249"] = [[
M249 light machine gun.
A gas operated and air-cooled weapon of destruction.
]]

LANGUAGE["Item_M240B"] = [[M240B]]
LANGUAGE["Item_Desc_M240B"] = [[
M240 Bravo.
Fires 7.62mm NATO ammunition.
Equipped by U.S. Armed Forces.
]]

LANGUAGE["Item_MG4"] = [[MG4]]
LANGUAGE["Item_Desc_MG4"] = [[
Heckler & Koch MG4.
A belt-fed 5.56 mm light machine gun that replaced MG3.
]]


LANGUAGE["Item_Frag Grenade"] = [[高爆手雷]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
常规军用手雷。
能对大片敌人造成伤害。
]]

LANGUAGE["Item_Resistance RPG"] = [[反抗军RPG]]
LANGUAGE["Item_Desc_Resistance RPG"] = [[
反抗军粗制火箭筒。
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ruchnoy Protivotankoviy Granatomyot.
对敌人能造成大量的爆炸伤害。
]]

LANGUAGE["Item_SLAM"] = [[SLAM]]
LANGUAGE["Item_Desc_SLAM"] = [[
Selectable Lightweight Attack Munition.
右键引爆。对墙按左键激活镭射引爆模式。
]]

LANGUAGE["Item_Incendiary Grenade"] = [[燃烧手雷]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
引爆后产生大量火焰。
火焰对敌人造成持续伤害。
]]


LANGUAGE["Item_Heat Crossbow"] = [[十字弩]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
临时制作的远距离狙击武器。
使用炙热的钢管作为弹药。
]]

LANGUAGE["Item_Turret"] = [[步哨枪]]
LANGUAGE["Item_Desc_Turret"] = [[
联合军专用步哨枪。
能够用来看守固定区域。
]]

LANGUAGE["Item_Medic Grenade"] = [[医疗手雷]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
引爆后持续散发出医疗烟雾。
医疗烟雾能治疗队友并且对敌人造成持续伤害。
]]

LANGUAGE["Item_Throwing Knives"] = [[飞刀]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
远距离飞刀。
扔出去的刀可以被回收。
]]

LANGUAGE["Item_Watchtower"] = [[守望塔]]
LANGUAGE["Item_Desc_Watchtower"] = [[
一个能提供补给的守望塔。
每 30 秒生成 1 个弹药包。
（实体名称：horde_watchtower）
]]


LANGUAGE["Item_Medkit"] = [[医疗包]]
LANGUAGE["Item_Desc_Medkit"] = [[
自动充能的医疗包。
右键治疗自己，左键治疗队友。
]]

LANGUAGE["Item_Health Vial"] = [[治疗药瓶]]
LANGUAGE["Item_Desc_Health Vial"] = [[
装有绿色液体的药瓶。
拾取后能直接回复生命值。
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[护甲包]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
提供15护甲。
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[全套护甲]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
提供100%护甲。
]]