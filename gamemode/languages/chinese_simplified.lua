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
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "天启"
LANGUAGE["Game_Enemies"] = "敌人数"
LANGUAGE["Game_HintBottomReady"] = "  F2 - 信息/设置, F3 - 商店/技能, F4 - 准备"
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
LANGUAGE["Game_Most_Heal"] = "最高队友治疗量"
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
LANGUAGE["Shop_Gadget"] = "道具"

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

-- Infusions
LANGUAGE["Game_Infusion"] = "变质"
LANGUAGE["Game_Infused"] = "已嵌入"
LANGUAGE["Infusion_None"] = "无"
LANGUAGE["Infusion_Hemo"] = "出血"
LANGUAGE["Infusion_Concussive"] = "眩晕"
LANGUAGE["Infusion_Septic"] = "剧毒"
LANGUAGE["Infusion_Flaming"] = "火焰"
LANGUAGE["Infusion_Arctic"] = "寒冰"
LANGUAGE["Infusion_Galvanizing"] = "雷电"
LANGUAGE["Infusion_Quality"] = "质量"
LANGUAGE["Infusion_Impaling"] = "穿刺"
LANGUAGE["Infusion_Rejuvenating"] = "恢复"
LANGUAGE["Infusion_Quicksilver"] = "水银"
LANGUAGE["Infusion_Titanium"] = "金刚"
LANGUAGE["Infusion_Siphoning"] = "汲取"
LANGUAGE["Infusion_Chrono"] = "时间"
LANGUAGE["Infusion_Ruination"] = "毁灭"

LANGUAGE["Infusion_Description_Hemo"] = [[
转换75%武器伤害为利器伤害。

武器只能造成利器伤害。

武器伤害对敌人累积出血值。
]]
LANGUAGE["Infusion_Description_Concussive"] = [[
转换75%武器伤害为钝器伤害。

武器只能造成钝器伤害。

武器伤害对敌人累积眩晕值。
]]
LANGUAGE["Infusion_Description_Septic"] = [[
转换75%武器伤害为毒素伤害。

武器只能造成剧毒伤害。

武器伤害对敌人累积毒爆值。
]]
LANGUAGE["Infusion_Description_Flaming"] = [[
转换75%武器伤害为火焰伤害。

武器只能造成火焰伤害。
]]
LANGUAGE["Infusion_Description_Arctic"] = [[
转换75%武器伤害为寒冰伤害。

武器只能造成寒冰伤害。

武器伤害对敌人累积霜冻值。
]]
LANGUAGE["Infusion_Description_Galvanizing"] = [[
转换75%武器伤害为雷电伤害。

武器只能造成雷电伤害。

武器伤害对敌人累积感电值。
]]
LANGUAGE["Infusion_Description_Quality"] = [[
提升20%武器伤害。

武器无法获得职业技能带来的任何效果和伤害提升！
]]
LANGUAGE["Infusion_Description_Impaling"] = [[
提升25%武器爆头伤害。

减少25%武器非爆头伤害。
]]
LANGUAGE["Infusion_Description_Rejuvenating"] = [[
提升25%生命恢复/汲取。

减少25%武器伤害。
]]
LANGUAGE["Infusion_Description_Quicksilver"] = [[
根据玩家的身上负重提升/减少武器伤害。
玩家身上的装备越少，伤害提升越高。

<= 15% 负重 -> 30% 伤害提升
<= 30% 负重 -> 25% 伤害提升 
<= 40% 负重 -> 15% 伤害提升 
  >40% 负重 -> 25% 伤害减少
]]
LANGUAGE["Infusion_Description_Titanium"] = [[
根据当前武器重量减少玩家收到的伤害。

每1负重，减少1%受到的伤害。

减少25%武器伤害。
]]
LANGUAGE["Infusion_Description_Siphoning"] = [[
每杀死一个敌人恢复1生命值。

减少25%武器伤害。
]]
LANGUAGE["Infusion_Description_Chrono"] = [[
Increases weapon damage the longer the weapon is being held by the user.
根据玩家持有武器的时间提升武器伤害。

每一回合持有当前武器，提升6%武器伤害。

武器伤害提升最多为50%。

减少20%武器伤害。
]]
LANGUAGE["Infusion_Description_Ruination"] = [[
根据玩家当前的即死累积值提升武器伤害。

每10即死累计值，提升5%武器伤害。

持有当前武器时，每秒钟玩家会获得10即死累计值。
]]

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

-- Infusions
LANGUAGE["Infusion"] = "变质"
LANGUAGE["Infusion_Hemo"] = "出血"
LANGUAGE["Infusion_Concussive"] = "笨重"
LANGUAGE["Infusion_Septic"] = "剧毒"
LANGUAGE["Infusion_Flaming"] = "火焰"
LANGUAGE["Infusion_Arctic"] = "冰霜"
LANGUAGE["Infusion_Galvanizing"] = "雷电"
LANGUAGE["Infusion_Quality"] = "质量"
LANGUAGE["Infusion_Impaling"] = "穿刺"
LANGUAGE["Infusion_Rejuvenating"] = "生命"
LANGUAGE["Infusion_Quicksilver"] = "水银"
LANGUAGE["Infusion_Siphoning"] = "汲取"
LANGUAGE["Infusion_Titanium"] = "白金"
LANGUAGE["Infusion_Chrono"] = "时间"
LANGUAGE["Infusion_Ruination"] = "毁灭"

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

{1} 更多移速。（每级提升 {2}，最多至 {3}）。

杀死敌人后获得“肾上腺素”状态。通过技能的选择，“肾上腺素”可以进行堆叠。
“肾上腺素”提升 {4} 移速和输出。]]

LANGUAGE["Perk_heavy_base"] = [[
重装兵拥有高超的护甲防御机制，同时能使用重武器对敌人造成火力压制。
复杂度: 简单

每秒恢复 {1} 点护甲。
护甲回复上限为 {2}。（基础{3} + 每级提升 {4}，最多至 {5}）。]]

LANGUAGE["Perk_medic_base"] = [[
医疗兵拥有强大的生命恢复能力，同时能为队友提供治疗以及各种增益效果。
复杂度: 中等

提升 {1} 治疗量。（每级提升 {2}，最多至 {3}）。

每秒恢复 {4} 生命值。]]

LANGUAGE["Perk_demolition_base"] = [[
爆破兵拥有强大的范围性输出。根据技能的选择，爆破兵也能提供超群的单体输出能力。
复杂度: 中等

提升 {1} 爆炸伤害抗性。（基础 {2} + 每级提升 {3}，最多至 {4}）。

在没有高爆手雷的前提下，每 {5} 秒获得 {6} 个高爆手雷。]]

LANGUAGE["Perk_ghost_base"] = [[
幻影是一个围绕着精准度和“迷彩”机制的职业。使用恰当的话，幻影可以提供无以匹敌的单体输出。
复杂度: 困难

{1} 更多爆头伤害。（每级提升 {2}，最多至 {3}）。

蹲下以激活“迷彩”状态，提供 {4} 闪避。
攻击，奔跑会取消“迷彩”状态。]]

LANGUAGE["Perk_engineer_base"] = [[
工程师是一个围绕着召唤物的职业。召唤物能有效地进行区域性防守并且为队友提供掩护。
复杂度: 中等

提升 {1} 召唤物伤害。（每级提升 {2}，最多至 {3}）。

步哨拥有 {4} 基础生命值和 {5} 基础伤害。]]

LANGUAGE["Perk_berserker_base"] = [[
狂战士是近距离格斗专家。
复杂度: 困难

提升 {1} 所有伤害抗性。（每级提升 {2}，最多至 {3}）。
提升 {4} 近战伤害。（每级提升 {5}，最多至 {6}）。

空中格挡：跳跃中减少 {7} 受到的物理伤害。]]

LANGUAGE["Perk_warden_base"] = [[
守望者是是一个使用自身光环和建筑来为队友提供各种有利效果的辅助职业。
复杂度：中等

提升 {1} “守望光环”半径。（每级提升 {2}，最多至 {3}）。

自身以及附近的玩家会受到“守望光环”效果。
“守望光环”阻挡 {4} 伤害。]]

LANGUAGE["Perk_cremator_base"] = [[
喷火兵使用火焰伤害进行进攻和防御。
复杂度：简单

提升 {1} 火焰伤害抗性。（基础 {2} + 每级提升 {3}，最多至 {4}）。

攻击有 {5} 概率引燃敌人。
引燃持续时间为 {6} 秒，造成基于攻击伤害的持续伤害。
火焰伤害有 {7} 概率引燃敌人。]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[生存]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[随机应变]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[防御]]
LANGUAGE["Perk_Title_Survivor_Tier_4"] = [[技巧复制]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[机动性]]
LANGUAGE["Perk_Title_assault_ambush"] = [[袭击]]
LANGUAGE["Perk_assault_ambush"] = [[
提升 {1} 爆头伤害。]]

LANGUAGE["Perk_Title_assault_charge"] = [[蓄能]]
LANGUAGE["Perk_assault_charge"] = [[
“肾上腺素”最大堆叠次数 +{1}。]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[适应性]]
LANGUAGE["Perk_Title_assault_drain"] = [[生命汲取]]
LANGUAGE["Perk_assault_drain"] = [[
满血前提下，提升 {1} 爆头伤害。
每击杀一个敌人恢复 {2} 生命值。]]

LANGUAGE["Perk_Title_assault_overclock"] = [[代谢超频]]
LANGUAGE["Perk_assault_overclock"] = [[
“肾上腺素”最大堆叠次数 +{1}。]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[进攻]]
LANGUAGE["Perk_Title_assault_cardiac_resonance"] = [[心室共鸣]]
LANGUAGE["Perk_assault_cardiac_resonance"] = [[
每次击杀敌人后，
附近玩家获得 {1} “肾上腺素”, 最多至 {2}.
“肾上腺素”最大堆叠次数 +{3}.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[心脏过载]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
“肾上腺素”持续时间提升 {1}。
“肾上腺素”最大堆叠次数 +{2}。]]

LANGUAGE["Perk_Title_Assault_Tier_4"] = [[条件反射]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[精神统一]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
提升 {1} 爆头伤害。
满“肾上腺素”前提下，提升 {2} 所有伤害抗性。]]

LANGUAGE["Perk_Title_assault_merciless_assault"] = [[势如破竹]]
LANGUAGE["Perk_assault_merciless_assault"] = [[
爆头有 {1} 几率 +1 层“肾上腺素”。
“肾上腺素”最大堆叠次数 +{2}。]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[压制]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[粘性化合物]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
子弹伤害击中的敌人受到“抑制”异常状态。
“抑制”状态下，造成 {1} 更少物理伤害。]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[粗糙弹壳]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
子弹伤害击中的敌人受到“虚弱”异常状态。
“虚弱”状态下，受到 {1} 更多物理伤害。]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[备用]]
LANGUAGE["Perk_Title_heavy_repair_catalyst"] = [[修复催化剂]]
LANGUAGE["Perk_heavy_repair_catalyst"] = [[
+{1} 最大护甲值恢复值。]]

LANGUAGE["Perk_Title_heavy_floating_carrier"] = [[悬浮仓]]
LANGUAGE["Perk_heavy_floating_carrier"] = [[
+5 最大负重.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[护甲强化]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[流体装甲]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
护甲值至少有 {1} 的前提下：
  提升 {2} 物理抗性。]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[反应装甲]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
护甲值至少有 {1} 的前提下：
  免疫火焰，爆炸伤害。]]

LANGUAGE["Perk_Title_Heavy_Tier_4"] = [[先进科技]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[纳米机器]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
提升 {1} 护甲值恢复速度.]]

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
“狂化”状态下，提升 {2} 伤害。]]

LANGUAGE["Perk_Title_medic_fortify"] = [[坚固]]
LANGUAGE["Perk_medic_fortify"] = [[
治疗的对象获得“坚固”增益状态。
“坚固”状态持续 {1} 秒。
“坚固”状态下，受到 {2} 更少伤害。]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[增强]]
LANGUAGE["Perk_Title_medic_purify"] = [[净化]]
LANGUAGE["Perk_medic_purify"] = [[
直接减少治疗对象的流血，破坏，坏死累计值。]]

LANGUAGE["Perk_Title_medic_haste"] = [[加速]]
LANGUAGE["Perk_medic_haste"] = [[
治疗的对象获得“加速”增益状态。
“加速”状态持续 {1} 秒。
“加速”状态下，提升 {2} 移速。]]

LANGUAGE["Perk_Title_Medic_Tier_4"] = [[物竞天择]]
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
提升 {1} 手雷冲击引爆伤害。
手雷击中敌人后直接引爆。
冲击引爆增加敌人的眩晕累计值。]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[子母弹]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
手雷爆炸后产生 {1} 个子雷。
子雷伤害比母雷少 {2}。]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[武器]]
LANGUAGE["Perk_Title_demolition_direct_hit"] = [[精确打击]]
LANGUAGE["Perk_demolition_direct_hit"] = [[
提升 {1} 起爆点附近敌人的爆炸伤害。]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[震荡波]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
爆炸类发射物在引爆后产生额外的冲击波。
冲击波造成原本爆炸伤害 {1} 的物理伤害。]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[爆破途径]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[破片]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
提升 {1} 爆炸伤害。]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[击晕]]
LANGUAGE["Perk_demolition_knockout"] = [[
爆炸伤害提升敌人的眩晕累计值。
眩晕累计值饱和后，对敌人造成 {1} 秒眩晕。
眩晕冷却时间为 {2} 秒。]]

LANGUAGE["Perk_Title_Demolition_Tier_4"] = [[毁灭]]
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
奔跑不会取消“迷彩”状态。
迷彩状态下提升 {1} 移速。]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[幻影披风]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
攻击不会取消“迷彩”状态。
迷彩激活速度提升 {1}。]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[弹道]]
LANGUAGE["Perk_Title_ghost_brain_snap"] = [[蚀脑]]
LANGUAGE["Perk_ghost_brain_snap"] = [[
爆头提升“霜冻”累计值，基于武器原始伤害。
“霜冻”状态下，大幅度减缓敌人行动速度 {1} 秒。
“霜冻”状态冷却时间为 {2} 秒。]]

LANGUAGE["Perk_Title_ghost_kinetic_impact"] = [[蓄能冲击]]
LANGUAGE["Perk_ghost_kinetic_impact"] = [[
基于攻击距离提升子弹伤害。
每 {2} 距离，提升 {1} 子弹伤害。
最多提升 {3} 子弹伤害。]]

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
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[匠魂]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
{1} 更多召唤物生命值。]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[先驱]]
LANGUAGE["Perk_engineer_pioneer"] = [[
提升 {2} 召唤物伤害。]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[核心]]
LANGUAGE["Perk_Title_engineer_fusion"] = [[聚变反应]]
LANGUAGE["Perk_engineer_fusion"] = [[
召唤物每秒恢复 {1} 最大生命值。
召唤物满血前提下，提升 {2} 召唤物伤害。]]

LANGUAGE["Perk_Title_engineer_metabolism"] = [[新陈代谢]]
LANGUAGE["Perk_engineer_metabolism"] = [[
召唤物吸收 {1} 对敌人造成的伤害为生命值。
召唤物不满血前提下，提升 {2} 召唤物伤害。]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[操控]]
LANGUAGE["Perk_Title_engineer_antimatter_shield"] = [[反物质护盾]]
LANGUAGE["Perk_engineer_antimatter_shield"] = [[
按 Shift+E 对目标召唤物附加护盾。
护盾吸收目标召唤物 {1} 最大生命值的伤害。
护盾殆尽后爆炸，冷却时间为 {2} 秒。]]

LANGUAGE["Perk_Title_engineer_displacer"] = [[传送器]]
LANGUAGE["Perk_engineer_displacer"] = [[
按 Shift+E 传送目标召唤物至身前。
传送后，目标召唤物恢复 {1} 最大生命值。
传送器冷却时间为 {2} 秒。]]

LANGUAGE["Perk_Title_Engineer_Tier_4"] = [[实验性模组]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[共生]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
{1} 更多召唤物最大生命值。
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
近战爆头伤害提升敌人眩晕值。
提升 {2} 移速。]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[残暴]]
LANGUAGE["Perk_berserker_savagery"] = [[
提升 {1} 近战伤害。
提升 {2} 最大生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[格挡]]
LANGUAGE["Perk_Title_berserker_graceful_guard"] = [[Graceful Guard]]
LANGUAGE["Perk_berserker_graceful_guard"] = [[
空中格挡成功后:
  - 移除所有的异常状态和异常状态累计值。
  - 恢复 {1} 生命值。]]

LANGUAGE["Perk_Title_berserker_unwavering_guard"] = [[Unwavering Guard]]
LANGUAGE["Perk_berserker_unwavering_guard"] = [[
空中格挡成功后:
  - 提升 {1} 物理伤害，持续 {3} 秒。
  - 减少 {2} 受到的伤害，持续 {3} 秒。]]

LANGUAGE["Perk_Title_Berserker_Tier_4"] = [[秘技]]
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

LANGUAGE["Perk_Title_warden_energize"] = [[充能]]
LANGUAGE["Perk_warden_energize"] = [[
光环提供 +{1} 额外基础伤害。]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[护送]]
LANGUAGE["Perk_Title_warden_rejection_pulse"] = [[排斥力场]]
LANGUAGE["Perk_warden_rejection_pulse"] = [[
守望塔每 {1} 秒产生冲击波。
冲击波造成 {2} 电击伤害。]]

LANGUAGE["Perk_Title_warden_inoculation"] = [[无垢化]]
LANGUAGE["Perk_warden_inoculation"] = [[
光环玩家内玩家获得 {1} 更少引燃，电感，霜冻累计值。]]

LANGUAGE["Perk_Title_Warden_Tier_4"] = [[广域化]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[机械降神]]
LANGUAGE["Perk_warden_ex_machina"] = [[
守望塔提供“守望光环”。]]

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

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[热量操控]]
LANGUAGE["Perk_Title_cremator_hyperthermia"] = [[超高温]]
LANGUAGE["Perk_cremator_hyperthermia"] = [[
基于敌人和玩家间的距离提升火焰伤害。
距离越近，火焰伤害越高。
火焰伤害最多提升 {1}。]]

LANGUAGE["Perk_Title_cremator_ionization"] = [[电离化]]
LANGUAGE["Perk_cremator_ionization"] = [[
提升 {1} 引燃伤害。
火焰伤害无视敌人火焰抗性。]]

LANGUAGE["Perk_Title_Cremator_Tier_4"] = [[能量释放]]
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

LANGUAGE["Item_DamageResistance RPG"] = [[反抗军RPG]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
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

LANGUAGE["Item_Watchtower MKII"] = [[守望塔 MKII]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
一个能提供补给的守望塔。
每 30 秒生成一个医疗包。
(实体名称：horde_watchtower）: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[守望塔 MKIII]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
一个用来击退敌人的守望塔。
每 1 秒对附近单个敌人发射电击。
电击造成 80 范围伤害。
(实体名称：horde_watchtower）: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[高斯枪]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
使用强大的电磁力产生炙热的等离子体。

长按右键进行蓄力。
蓄力攻击造成更多伤害。
蓄力时间过长会产生爆炸。
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1医疗冲锋枪]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
MP7A1 医疗改进版。

按 B 或者 放大键 发射医疗针。
医疗针冷却时间为 1 秒。
Healing dart recharges every 1 second.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[Vector医疗冲锋枪]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
维克托冲锋枪，配备了先进的医疗针发射器。
有着无与伦比的射速。

按 B 或者 放大键 发射医疗针。
医疗针冷却时间为 1.5 秒。
]]

LANGUAGE["Item_Chainsaw"] = [[电锯]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Brrrrrrrrrrrrrrrr.

长按右键进行持续劈砍。
]]

LANGUAGE["Item_Mjollnir"] = [[雷神之锤]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
蕴含着雷电力量的战锤。

右键对武器进行充能。
充能后，下次武器攻击命中敌人会造成范围性雷电伤害。
]]

LANGUAGE["Item_Inferno Blade"] = [[恶魔刀锋]]
LANGUAGE["Item_Desc_Inferno Blade"] = [[
蕴含着火焰力量的弯刀。

右键开启火焰模式，使攻击附带范围性火焰伤害。
火焰模式会对使用者造成持续的火焰伤害。
]]

LANGUAGE["Item_Double Barrel"] = [[双管猎枪]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
双管猎枪。

对近距离的敌人能造成大量伤害。
]]

LANGUAGE["Item_Manhack"] = [[巡逻无人机]]
LANGUAGE["Item_Desc_Manhack"] = [[
会自我再生的巡逻无人机。
巡逻无人机攻击敌人后直接死亡。
巡逻无人机对敌人造成自生生命值的伤害。
]]

LANGUAGE["Item_Vortigaunt"] = [[弗地冈]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
XEN星球的弗地冈地外种族。
会发射长距离的范围性雷电攻击。
]]

LANGUAGE["Item_Combat Bot"] = [[战斗机器人]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
解释可靠的战斗机器人。
会使用威力巨大的近距离攻击和远距离投掷攻击。
]]

LANGUAGE["Item_Hivehand"] = [[蜂巢枪]]
LANGUAGE["Item_Desc_Hivehand"] = [[
XEN星球士兵使用的生物兵器。

左键发射带有追踪功能的蜂群。
右键能够快速射出无追踪能力的蜂群。
]]

LANGUAGE["Item_M2 Flamethrower"] = [[M2 喷火器]]

LANGUAGE["Item_Gluon Gun"] = [[胶子枪]]
LANGUAGE["Item_Desc_Gluon Gun"] = [[
量子热力学溶解类武器。

能够发射极其危险的超高温镭射。
]]

LANGUAGE["Gadget_gadget_blast_plating"] = [[防爆涂层]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
提升 {1} 爆炸和声波伤害抗性。
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[绝缘涂层]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
提升 {1} 雷电伤害抗性。
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[抗热涂层]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
提升 {1} 火焰伤害抗性。
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[钻石涂层]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
提升 {1} 物理伤害抗性。
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[抗毒剂]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
提升 {1} 毒素伤害抗性。
]]

LANGUAGE["Gadget_gadget_vitality_booster"] = [[体力提升]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
增加 {1} 最大生命值。
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[伤害提升]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
提升 {1} 全局伤害。
]]

LANGUAGE["Gadget_gadget_berserk_armor"] = [[狂战盔甲]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
提升 {1} 全局伤害。
提升 {2} 全局伤害抗性。
提升 {3} 移动速度。
]]

LANGUAGE["Gadget_gadget_flash"] = [[一闪]]
LANGUAGE["Gadget_Desc_flash"] = [[
向前快速移动，对路径上的所有敌人造成 {1} 利器伤害。
提供短暂的无敌时间。
]]

LANGUAGE["Gadget_gadget_butane_can"] = [[易燃物]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
生成一个丙烷气罐。
丙烷气罐被攻击后爆炸，造成 {1} 范围性火焰伤害。
每个玩家最多保留一个生成的丙烷气罐。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[发射器（火焰弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
发射灼热的火焰弹。
火焰弹引燃效果范围内所有敌人。
火焰弹基础引燃伤害为 {1}。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[发射器（雷电弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
发射能够穿透敌人的雷电弹。
雷电弹每穿透一个敌人，造成 {1} 范围性雷电伤害。
]]


LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[发射器（冲击弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
发射能产生大量冲击的弓箭。
弓箭造成 {1} 子弹伤害。
弓箭对击中敌人造成眩晕效果。
]]


LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[发射器（破片弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
发射不稳定爆破弹。
爆破弹造成 {1} 范围性爆炸伤害。
爆破弹爆炸后，产生 {2} 个额外破片爆炸。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[发射器（治愈弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
发射带有治愈效果的化学药弹。
治愈弹造成 {1} 范围性毒素伤害。
治愈弹对范围内友军提供 {2} 生命恢复。
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[E-寄生虫]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
发射E-寄生虫，感染击中的目标。
E-寄生虫享有全部的召唤物技能效果。
E-寄生虫对感染目标造成持续伤害。
E-寄生虫为使用者提供持续生命恢复。
被感染的目标死亡后，造成等于目标最大生命值的爆炸伤害。
]]

LANGUAGE["Gadget_gadget_energy_shield"] = [[能量盾]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
暂时获得额外 25 点护甲。
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[硬化注射剂]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
移动速度减缓 {1}。
提升 {2} 全局伤害抗性。
提升 {3} 物理伤害抗性。
]]

LANGUAGE["Gadget_gadget_iv_injection"] = [[生命注射剂]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
恢复 25 点生命值。
]]

LANGUAGE["Gadget_gadget_proximity_defense"] = [[近身制御]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
眩晕自身周围的所有敌人。
]]

LANGUAGE["Gadget_gadget_optical_camouflage"] = [[光学迷彩]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
强制提供 5 秒迷彩效果。
迷彩效果期间，提升 50% 闪避概率。
]]

LANGUAGE["Gadget_gadget_life_diffuser"] = [[活体扩散器]]

LANGUAGE["Gadget_gadget_solar_array"] = [[太阳能阵列]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[便携步哨]]

LANGUAGE["Gadget_gadget_cortex"] = [[皮层刺激器]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[精神统一]]

LANGUAGE["Gadget_ouroboros"] = [[咬尾蛇]]

LANGUAGE["Gadget_exoskeleton"] = [[外骨骼]]

LANGUAGE["Gadget_t_virus"] = [[T-病毒]]

LANGUAGE["Gadget_healing_beam"] = [[治疗光波]]

LANGUAGE["Gadget_nitrous_propellor"] = [[氮气弹射器]]

LANGUAGE["Gadget_ied"] = [[应急地雷]]

LANGUAGE["Gadget_death_mark"] = [[死亡标记]]

LANGUAGE["Gadget_gunslinger"] = [[神枪手]]

LANGUAGE["Gadget_displacer"] = [[传送器]]

LANGUAGE["Gadget_aerial_guard"] = [[空中制御]]

LANGUAGE["Gadget_hemocannon"] = [[血能炮]]

LANGUAGE["Gadget_watchtower_pack"] = [[便携守望塔]]

LANGUAGE["Gadget_shock_nova"] = [[雷神]]

LANGUAGE["Gadget_barbeque"] = [[烧烤]]