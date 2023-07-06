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

LANGUAGE["Default_Font"] = "Microsoft YaHei"
LANGUAGE["Default_Font_Bold"] = "Microsoft YaHei"
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


-- Scoreboard
LANGUAGE["Scoreboard_Name"] = "玩家"
LANGUAGE["Scoreboard_Class"] = "职业"
LANGUAGE["Scoreboard_Perks"] = "技能"
LANGUAGE["Scoreboard_Gadget"] = "配件"
LANGUAGE["Scoreboard_Money"] = "金钱"
LANGUAGE["Scoreboard_Kill"] = "击杀"
LANGUAGE["Scoreboard_Death"] = "死亡"
LANGUAGE["Scoreboard_Ping"] = "延迟"


-- Shop
LANGUAGE["Shop_Not_Enough_Money_Or_Carrying_Capacity"] = "你没有足够的金钱或者负重来购买当前物品!"
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
LANGUAGE["Shop_Gadget"] = "器具"

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

LANGUAGE["Game_Preparing..."] = "准备中..."
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
LANGUAGE["Infusion_Arctic"] = "冰冷"
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


-- Gadgets
LANGUAGE["Gadget_Activation"] = [[按 T 使用。]]
LANGUAGE["Gadget_Consumed"] = [[此器具在使用后会消失！]]
LANGUAGE["Gadget_Seconds"] = [[秒]]
LANGUAGE["Gadget_Duration"] = [[持续时间]]
LANGUAGE["Gadget_Cooldown"] = [[冷却时间]]
LANGUAGE["Gadget_Owned_Warning"] = [[你只能拥有一个器具！]]


-- Subclasses
LANGUAGE["Class_Change_Subclass"] = "更换附属职业"
LANGUAGE["Class_Psycho"] = "暴徒"
LANGUAGE["Class_SpecOps"] = "特种兵"
LANGUAGE["Class_Carcass"] = "残骸"
LANGUAGE["Class_Hatcher"] = "孵化者"
LANGUAGE["Class_Warlock"] = "术士"
LANGUAGE["Class_Gunslinger"] = "神枪手"
LANGUAGE["Class_Necromancer"] = "死灵法师"
LANGUAGE["Class_Samurai"] = "武士"
LANGUAGE["Class_???"] = "???"
LANGUAGE["Class_Artificer"] = "信仰者"

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
提升 {7} 子弹伤害。（每级提升 {8}，最多至 {9}）。

杀死敌人后获得“肾上腺素”状态。通过技能的选择，“肾上腺素”可以进行堆叠。
“肾上腺素”提升 {4} 移速和输出。]]

LANGUAGE["Perk_heavy_base"] = [[
重装兵拥有高超的护甲防御机制，同时能使用重武器对敌人造成火力压制。
复杂度: 简单

提升 {6} 最大护甲值。（每级提升 {7}， 最多至 {8}）。

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

提升 {7} 爆炸伤害。（每级提升 {8}，最多至 {9}）。
提升 {1} 爆炸伤害抗性。（基础 {2} + 每级提升 {3}，最多至 {4}）。

在没有高爆手雷的前提下，每 {6} 秒获得 {5} 个高爆手雷。]]

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
获得一个能抵消伤害的反应装甲。
装甲在受到至少 {1} 伤害后激活，在 {2} 秒后重置。
激活会消耗 {3} 当前护甲值。]]

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
提升 {1} 起爆点附近敌人的爆炸伤害。
提升 {1} 钝器伤害。]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[震荡波]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
爆炸伤害产生额外的震荡波。
震荡波造成原本爆炸伤害 {1} 的物理伤害。
产生震荡波需要超过 {2} 爆炸伤害。]]

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
{2} 更多对头部造成的爆炸和钝器伤害。]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[连锁反应]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
对敌人造成 {1} 当前生命值的额外爆炸伤害。
额外爆炸伤害最高为 {2}。]]

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
光环提供 +{1} 额外伤害。
激活此效果需要至少 {1} 基础伤害。]]

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
受到伤害时，激活能够减少伤害的护盾。
护盾提供 {1} 伤害抗性，持续 {2} 秒。
护盾在 {3} 秒后可以被再次激活。]]

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

-- Default Perks: Psycho
LANGUAGE["Perk_psycho_base"] = [[
难度：中

+{1} 暴击率。(基础 {2} + 每级提升 {3}, 最多至 {4})。
暴击造成 {5} 更多伤害。

按 F 进入狂暴模式。
狂暴模式中，玩家会持续失去生命值，但不会致死。
狂暴模式中，提升 {6} 暴击概率。
狂暴模式中，提升 {7} 生命恢复值。]]

LANGUAGE["Perk_Title_Psycho_Tier_1"] = [[暴行]]
LANGUAGE["Perk_Title_psycho_ferocity"] = [[迅猛]]
LANGUAGE["Perk_psycho_ferocity"] = [[
+{1} 暴击率。
+{2} 近战暴击率。]]

LANGUAGE["Perk_Title_psycho_savor"] = [[品尝]]
LANGUAGE["Perk_psycho_savor"] = [[
提升 {1} 暴击伤害。
吸收 {2} 暴击伤害为生命值。
每次最多吸收 10 生命值。]]

LANGUAGE["Perk_Title_Psycho_Tier_2"] = [[Садизм]]
LANGUAGE["Perk_Title_psycho_bloodbath"] = [[血浴]]
LANGUAGE["Perk_psycho_bloodbath"] = [[
+{1} 暴击率。
每次暴击恢复 1 生命值。]]

LANGUAGE["Perk_Title_psycho_disembowel"] = [[肢解]]
LANGUAGE["Perk_psycho_disembowel"] = [[
提升 {1} 暴击伤害。
近战暴击伤害移除尸爆变异。]]

LANGUAGE["Perk_Title_Psycho_Tier_3"] = [[致命一击]]
LANGUAGE["Perk_Title_psycho_skewering"] = [[穿刺]]
LANGUAGE["Perk_psycho_skewering"] = [[
击中敌人头部使其陷入穿刺异常状态。
玩家对穿刺状态下敌人攻击时，获得 +{1} 暴击率。]]

LANGUAGE["Perk_Title_psycho_brutality"] = [[残暴]]
LANGUAGE["Perk_psycho_brutality"] = [[
近战击中敌人获得残暴增益效果。可叠加。
每层残暴提供 +{1} 暴击率。
每层残暴提升 {2} 暴击伤害。]]

LANGUAGE["Perk_Title_Psycho_Tier_4"] = [[崩坏]]
LANGUAGE["Perk_Title_psycho_grudge"] = [[咒怨]]
LANGUAGE["Perk_psycho_grudge"] = [[
每缺少 {2} 生命值，提升 {1} 暴击率。
每缺少 {4} 生命值，提升 {3} 移动速度。]]

LANGUAGE["Perk_Title_psycho_bestial_wrath"] = [[兽性]]
LANGUAGE["Perk_psycho_bestial_wrath"] = [[
{1} 提升暴击伤害。
狂暴模式中，近战伤害产生范围性伤害。
狂暴模式中，每杀死一个敌人提供 1 生命恢复。]]

-- Default Perks: Carcass
LANGUAGE["Perk_carcass_base"] = [[
难度：高

提升 {1} 最大生命值。(每级提升 {2}, 最多至 {3})。

击中敌人后有 {4} 概率获得“肌肉增殖”状态 (击中头部会有 {5} 概率)。
被敌人击中后也会获得“肌肉增值”状态。
通过技能的选择，“肌肉增殖”可以进行堆叠。
每一层“肌肉增殖”减少 {6} 玩家受到的物理伤害。
每一层“肌肉增殖”提供 2% 生命值恢复。

你被植入了残骸生化武器系统。
无法使用除了拳头以外的任何武器。

左键：出拳。长按进行蓄力。]]

LANGUAGE["Perk_Title_Carcass_Tier_1"] = [[肠胃]]
LANGUAGE["Perk_Title_carcass_grappendix"] = [[肠钩]]
LANGUAGE["Perk_carcass_grappendix"] = [[
提升 {1} 最大生命值。
右键发射大肠，用作抓钩。
使用肠钩消耗生命值。]]

LANGUAGE["Perk_Title_carcass_bio_thruster"] = [[生化推进器]]
LANGUAGE["Perk_carcass_bio_thruster"] = [[
+{1} “肌肉增值”堆叠数。
右键进行冲刺，消耗 {2} 生命值并获得 1 推进器堆叠数，最多 5 层。
每层推进器堆叠提升 {1} 近战伤害，但会增加 {4} 生命值消耗。]]

LANGUAGE["Perk_Title_Carcass_Tier_2"] = [[分泌]]
LANGUAGE["Perk_Title_carcass_tactical_spleen"] = [[战术肾脏]]
LANGUAGE["Perk_carcass_tactical_spleen"] = [[
提升 {1} 最大生命值。
获得一个能抵消异常状态的肾脏。
战术肾脏每过 {2} 秒会再生。.]]

LANGUAGE["Perk_Title_carcass_anabolic_gland"] = [[增值腺体]]
LANGUAGE["Perk_carcass_anabolic_gland"] = [[
+{1} “肌肉增值”堆叠数。
+{2} 击中敌人获得“肌肉增殖”概率。]]

LANGUAGE["Perk_Title_Carcass_Tier_3"] = [[四肢]]
LANGUAGE["Perk_Title_carcass_reinforced_arms"] = [[强化手臂]]
LANGUAGE["Perk_carcass_reinforced_arms"] = [[
+{1} “肌肉增值”堆叠数。
拳头伤害会根据当前移动速度提升。
拳头蓄力后，对表面攻击能产生垂直移速提升。]]

LANGUAGE["Perk_Title_carcass_pneumatic_legs"] = [[气动腿]]
LANGUAGE["Perk_carcass_pneumatic_legs"] = [[
+{1} “肌肉增值”堆叠数。
空中按空格能够快速下降，对范围内敌人造成物理伤害。
减少 {2} 掉落伤害。]]

LANGUAGE["Perk_Title_Carcass_Tier_4"] = [[核心]]
LANGUAGE["Perk_Title_carcass_twin_heart"] = [[双子心脏]]
LANGUAGE["Perk_carcass_twin_heart"] = [[
提升 {1} 最大生命值。
按R能够切换双子心脏状态恢复生命值。
双子心脏会积攒生命值至玩家最大生命值的 {2}。]]

LANGUAGE["Perk_Title_carcass_aas_perfume"] = [[AAS香水]]
LANGUAGE["Perk_carcass_aas_perfume"] = [[
+{1} “肌肉增值”堆叠数。
按R发射孢子，为范围内玩家提供“肌肉增值”效果。
效果持续 {2} 秒。有 {3} 秒冷却时间。]]

-- Default Perks: Hatcher
LANGUAGE["Perk_hatcher_base"] = [[
难度：高

提升 {1} 蚁狮进化速度。(每级提升 {2}, 最多至 {3})。
提升 {1} 毒素伤害。(每级提升 {2}, 最多至 {3})。

出身自带信息素胶囊。信息素胶囊可以商店升级。
升级信息素胶囊可以提升蚁狮伤害和生命值。

左键：释放胶囊
投掷信息素胶囊，强制蚁狮对目标进行攻击。
对蚁狮投掷胶囊能够恢复其 5% 生命值。

右键：召唤蚁狮 (40 能量)
创造一个蚁狮作为你的召唤物。治疗蚁狮能够加速其进化。
长按右键能迫使蚁狮前往玩家。
蚁狮进化后，每一阶段会获得新能力：
阶段I   - 信息素波动：每 5 秒中产生一个波动，恢复附近玩家 5% 生命值。
阶段II  - 提升伤害，生命值，波动频率，提升 50% 毒素伤害抗性。
阶段III - 提升伤害，生命值，波动频率，免疫毒素伤害和破坏异常状态。]]

-- Default Perks: Gunslinger
LANGUAGE["Perk_gunslinger_base"] = [[
难度：中等

提升 {1} 手枪类武器伤害。(每级提升 {2}, 最多至 {3})。
你可以在商店升级手枪类武器。

按 SHIFT+E 对敌人施加猎人标记。
猎人标记持续 5 秒钟。
最多可以存在 1 个猎人标记。
在猎人标记下死去的敌人有 {4} 概率掉落额外金钱。

你可以购买所有的手枪类武器。]]

-- Default Perks: Specops
LANGUAGE["Perk_specops_base"] = [[
难度：中等

按 F 进入战术模式。
战术模式提供夜视效果。
战术模式中无法跑步。
战术模式会减少玩家 50% 移动速度。

战术模式中，提升 {1} 更多移动速度。(每级提升 {2}, 最多至 {3})。
战术模式中，提升 {1} 更多爆头伤害。(每级提升 {2}, 最多至 {3})。]]


-- Default Perks: Necromancer
LANGUAGE["Perk_necromancer_base"] = [[
难度：中等

冰冷伤害造成 {1} 霜冻累计值。 (基础 {2} + 每级提升 {3}, 最多至 {4})。
提升 {5} 冰冷伤害抗性。(每级提升 {6}, 最多至 {7})。

使用精神值代替护甲。]]

-- Default Perks: Warlock
LANGUAGE["Perk_warlock_base"] = [[
难度：中等

提升 {1} 最大能量值。(每级提升 {2}, 最多至 {3})。

使用精神值代替护甲。]]

-- Default Perks: Artificer
LANGUAGE["Perk_artificer_base"] = [[
难度：中等

雷电伤害造成 {1} 感电累计值。 (每级提升 {2}, 最多至 {3})。
提升 {1} 火焰和雷电伤害。(每级提升 {2}, 最多至 {3})。

使用精神值代替护甲。]]

-- Default Perks: Samurai
LANGUAGE["Perk_samurai_base"] = [[
难度: 高
近战伤害造成 {1} 武器基础伤害的出血累计值。 (基础 {2} + 每级提升 {3}, 最多至 {4})。
提升 {5} 全局伤害抗性。 (每级提升 {6}，最多至 {7})。

使用 SHIFT + E 疾步，能够根据方向键快速移动。
疾步状态中获得 100% 闪避值。]]

LANGUAGE["Perk_Title_Samurai_Tier_1"] = [[技巧]]
LANGUAGE["Perk_Title_samurai_focus_slash"] = [[居合斩]]
LANGUAGE["Perk_samurai_focus_slash"] = [[
+1 疾步充能。
疾步中，增加 {1} 近战伤害。]]

LANGUAGE["Perk_Title_samurai_flesh_bloom"] = [[绽放]]
LANGUAGE["Perk_samurai_flesh_bloom"] = [[
近战伤害对范围内敌人累积出血值。]]

LANGUAGE["Perk_Title_Samurai_Tier_2"] = [[压倒]]
LANGUAGE["Perk_Title_samurai_demon_stomp"] = [[鬼步]]
LANGUAGE["Perk_samurai_demon_stomp"] = [[
+1 疾步充能。
使用疾步会产生冲击波，对附近敌人造成 {1} 物理伤害。
冲击波每击中一个敌人就能够提供 {2} 生命恢复。]]

LANGUAGE["Perk_Title_samurai_exsanguinate"] = [[血道]]
LANGUAGE["Perk_samurai_exsanguinate"] = [[
{1} 增加出血累计值。
在出血敌人附近时能够恢复生命值。
免疫出血异常状态。]]

LANGUAGE["Perk_Title_Samurai_Tier_3"] = [[精神]]
LANGUAGE["Perk_Title_samurai_foresight"] = [[见切]]
LANGUAGE["Perk_samurai_foresight"] = [[
+1 疾步充能。
获得见切被动效果，能够抵挡并反射一次物理伤害。
见切效果会在抵挡后消失，5 秒钟后恢复。]]

LANGUAGE["Perk_Title_samurai_resolution"] = [[决意]]
LANGUAGE["Perk_samurai_resolution"] = [[
玩家最大负重降低至7。
{1} 更多近战伤害。
+3 抵挡值。]]

LANGUAGE["Perk_Title_Samurai_Tier_4"] = [[武道]]
LANGUAGE["Perk_Title_samurai_blade_dance"] = [[剑舞]]
LANGUAGE["Perk_samurai_blade_dance"] = [[
+1 疾步充能。
击杀敌人恢复 2 疾步充能。
延长疾步带来的无敌时间。]]

LANGUAGE["Perk_Title_samurai_demon_strike"] = [[魔刃]]
LANGUAGE["Perk_samurai_demon_strike"] = [[
{1} 提升出血累计值。
{2} 提升对出血状态中敌人的近战伤害。
吸收 {3} 在疾步中造成的近战伤害为生命值。]]

-- Default Config Shop Items
-- Optional
-- Melee Items
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

LANGUAGE["Item_Machete"] = [[砍刀]]
LANGUAGE["Item_Desc_Bat"] = [[
大砍刀。
]]

LANGUAGE["Item_Fireaxe"] = [[消防服]]
LANGUAGE["Item_Desc_Fireaxe"] = [[
消防用斧头。
厚重，但是威力不小。
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

LANGUAGE["Item_Chainsaw"] = [[电锯]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
用来砍刀大树的工业电锯。

长按右键能对敌人造成持续伤害。
]]

LANGUAGE["Item_Mjollnir"] = [[雷神之锤]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
隐藏着雷电能力的战锤。

右键能够激活战锤的雷电能力。
战锤激活后，下一次攻击会对范围内敌人造成雷电伤害。
]]

LANGUAGE["Item_Inferno Blade"] = [[恶魔刀锋]]
LANGUAGE["Item_Desc_Inferno Blade"] = [[
蕴含着火焰力量的弯刀。

右键开启火焰模式，使攻击附带范围性火焰伤害。
火焰模式会对使用者造成持续的火焰伤害。
]]

LANGUAGE["Item_Thorn Mace"] = [[荆棘之星]]
LANGUAGE["Item_Desc_Thorn Mace"] = [[
蕴含着剧毒的锤矛。


]]

-- Pistol Items
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

LANGUAGE["Item_Deagle"] = [[沙漠之鹰]]
LANGUAGE["Item_Desc_Deagle"] = [[
Night Hawk .50C.
An iconic pistol that is diffcult to master.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt 1911.
Standard-issue sidearm for the United States Armed Forces.
]]

LANGUAGE["Item_FiveSeven"] = [[57式]]
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

LANGUAGE["Item_Dual Glock17"] = [[双持Glock17]]
LANGUAGE["Item_Dual M9"] = [[双持M9]]
LANGUAGE["Item_Dual Deagle"] = [[双持沙漠之鹰]]



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

LANGUAGE["Item_PP Bizon"] = [[PP-野牛]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
PP-19 Bizon.
Offers a high-capacity magazine that reloads quickly.
]]

LANGUAGE["Item_P90"] = [[P90]]
LANGUAGE["Item_Desc_P90"] = [[
ES C90.
A Belgian bullpup PDW with a magazine of 50 rounds.
]]

LANGUAGE["Item_Pump-Action"] = [[简易霰弹枪]]
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

LANGUAGE["Item_Winchester LAR"] = [[温切斯特杠杆步枪]]
LANGUAGE["Item_Desc_Winchester LAR"] = [[
温切斯特杠杆步枪。
经典步兵武器。
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

LANGUAGE["Item_Barret AMR"] = [[巴雷特反器材步枪]]
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

LANGUAGE["Item_GAU-19"] = [[GAU-19转轮机枪]]
LANGUAGE["Item_Desc_MG4"] = [[
GAU-19 转轮机枪。
每分钟发射1300发.50BMG机枪子弹。

长按右键预热机枪。
]]

LANGUAGE["Item_Frag Grenade"] = [[高爆手雷]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
常规军用手雷。
能对大片敌人造成爆炸伤害。
]]

LANGUAGE["Item_M67 Grenade"] = [[破片手雷]]
LANGUAGE["Item_Desc_M67 Grenade"] = [[
M67 破片手雷。
能对大片敌人造成大额爆炸伤害。
]]

LANGUAGE["Item_Stun Grenade"] = [[闪光弹]]
LANGUAGE["Item_Desc_Stun Grenade"] = [[
闪光手雷。
对范围内敌人造成小额爆炸伤害和眩晕。
]]

LANGUAGE["Item_Sonar Grenade"] = [[声纳手雷]]
LANGUAGE["Item_Desc_Sonar Grenade"] = [[
声纳手雷。
持续标记范围内的敌人。
被标记的敌人会受到 10% 更多爆头伤害。
]]

LANGUAGE["Item_Nanobot Grenade"] = [[纳米机器手雷]]
LANGUAGE["Item_Desc_Nanobot Grenade"] = [[
纳米机器手雷。
能够治疗玩家以及玩家的召唤物。
对于召唤物的治疗量更多。
]]

LANGUAGE["Item_Hemo Grenade"] = [[血浆弹]]
LANGUAGE["Item_Desc_Hemo Grenade"] = [[
用血浆制成的手雷。
对范围内敌人造成利器伤害。
]]

LANGUAGE["Item_EMP Grenade"] = [[电磁脉冲手雷]]
LANGUAGE["Item_Desc_EMP Grenade"] = [[
电磁脉冲手雷。
对范围内敌人造成快速的雷电伤害。
不会对玩家本身造成伤害。
]]

LANGUAGE["Item_Resistance RPG"] = [[反抗军RPG]]
LANGUAGE["Item_Desc_Resistance RPG"] = [[
反抗军粗制火箭筒。
发射可制导的迷你火箭。
]]

LANGUAGE["Item_M79 GL"] = [[M79榴弹发射器]]
LANGUAGE["Item_Desc_M79 GL"] = [[
M79 榴弹发射器。
发射 40x66 毫米榴弹炮。
]]

LANGUAGE["Item_Sticky Launcher"] = [[粘弹发射器]]
LANGUAGE["Item_Desc_Sticky Launcher"] = [[
粘弹发射器。
发射能够固定在物体表面的粘弹。

右键引爆所有的粘弹。
]]

LANGUAGE["Item_M32 GL"] = [[M32榴弹发射器]]
LANGUAGE["Item_Desc_M32 GL"] = [[
M32 榴弹发射器。
拥有六个转轮榴弹发射位。
发射 40x66 毫米榴弹炮。
]]

LANGUAGE["Item_RPG-7"] = [[RPG火箭筒]]
LANGUAGE["Item_Desc_RPG-7"] = [[
火箭推进榴弹。
对敌人能造成大量的爆炸伤害。
]]

LANGUAGE["Item_M72 LAW"] = [[M72反装甲武器]]
LANGUAGE["Item_Desc_M72 LAW"] = [[
M72 轻型反装甲武器。
比起爆炸范围，更加注重造成巨额的爆炸伤害。
]]

LANGUAGE["Item_SLAM"] = [[地雷]]
LANGUAGE["Item_Desc_SLAM"] = [[
反抗军地雷。

右键引爆。
对墙按左键激活镭射引爆模式。
]]

LANGUAGE["Item_Incendiary Grenade"] = [[燃烧手雷]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
一定延迟后引爆，产生大量火焰。
火焰对敌人造成持续伤害。
]]

LANGUAGE["Item_Molotov"] = [[莫咯托夫]]
LANGUAGE["Item_Desc_Molotov"] = [[
落地后产生大量火焰。
火焰对敌人造成持续伤害。
]]

LANGUAGE["Item_Incendiary Launcher"] = [[燃烧弹发射器]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
燃烧弹发射器。
发射炙热的易燃榴弹，在接触后引爆。
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

LANGUAGE["Item_Rocket Turret"] = [[榴弹步哨枪]]
LANGUAGE["Item_Desc_Rocket Turret"] = [[
光圈科技实验性步哨枪。
对敌人发射迷你榴弹。
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

LANGUAGE["Item_Welder"] = [[电焊]]
LANGUAGE["Item_Desc_Welder"] = [[
工程师使用的电焊枪。
能够治疗玩家的召唤物，也能对敌人造成伤害。
]]

LANGUAGE["Item_Health Vial"] = [[治疗药瓶]]
LANGUAGE["Item_Desc_Health Vial"] = [[
装有绿色液体的药瓶。
拾取后能直接回复生命值。
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[护甲包]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
提供 15 护甲。
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

LANGUAGE["Item_Spore Launcher"] = [[孢子枪]]
LANGUAGE["Item_Desc_Spore Launcher"] = [[
异星生物武器，发射溶解性的孢子。
对敌人造成毒素伤害，但是能够治疗队友。
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1医疗冲锋枪]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
MP7A1 医疗改进版。

按 B 或者 放大键 发射医疗针。
医疗针冷却时间为 1 秒。
Healing dart recharges every 1 second.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[维克多医疗冲锋枪]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
维克托冲锋枪，配备了先进的医疗针发射器。
有着无与伦比的射速。

按 B 或者 放大键 发射医疗针。
医疗针冷却时间为 1.5 秒。
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

LANGUAGE["Item_M2 Flamethrower"] = [[M2火焰喷射器]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
M2火焰喷射器。
由美国美国陆军化学战争工作局所设计的单兵携带及背负式火焰喷射器。
]]

LANGUAGE["Item_Gluon Gun"] = [[胶子枪]]
LANGUAGE["Item_Desc_Gluon Gun"] = [[
量子热力学溶解类武器。
能够发射极其危险的超高温镭射。
]]

LANGUAGE["Gadget_gadget_vitality_shard"] = [[生命碎片]]
LANGUAGE["Gadget_Desc_gadget_vitality_shard"] = [[
恢复 {1} 生命值。
]]

LANGUAGE["Gadget_gadget_damage_shard"] = [[伤害碎片]]
LANGUAGE["Gadget_Desc_gadget_damage_shard"] = [[
提升 {1} 全局伤害，持续 30 秒。
]]

LANGUAGE["Gadget_gadget_cleansing_shard"] = [[净化碎片]]
LANGUAGE["Gadget_Desc_gadget_cleansing_shard"] = [[
恢复 {1} 生命值。
去除所有异常状态。
]]

LANGUAGE["Gadget_gadget_agility_shard"] = [[敏捷碎片]]
LANGUAGE["Gadget_Desc_gadget_agility_shard"] = [[
提升 {1} 移动速度，持续 30 秒。
]]

LANGUAGE["Gadget_gadget_arctic_plating"] = [[抗冻涂层]]
LANGUAGE["Gadget_Desc_gadget_arctic_plating"] = [[
提升 {1} 寒冰伤害抗性。
]]

LANGUAGE["Gadget_gadget_blast_plating"] = [[防爆涂层]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
提升 {1} 爆炸伤害抗性。
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

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[企业头脑]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
闷声发大财。
大幅度提升骷髅币掉落概率。
]]

LANGUAGE["Gadget_gadget_vitality_booster"] = [[体力提升]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
增加 {1} 最大生命值。
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[伤害提升]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
提升 {1} 全局伤害。
]]

LANGUAGE["Gadget_gadget_resistance_booster"] = [[抗性提升]]
LANGUAGE["Gadget_Desc_gadget_resistance_booster"] = [[
提升 {1} 全局伤害抗性。
]]

LANGUAGE["Gadget_gadget_agility_booster"] = [[敏捷提升]]
LANGUAGE["Gadget_Desc_gadget_agility_booster"] = [[
提升 {1} 移动速度。
]]

LANGUAGE["Gadget_gadget_ultimate_booster"] = [[极限提升]]
LANGUAGE["Gadget_Desc_gadget_ultimate_booster"] = [[
增加 {1} 最大生命值。
提升 {1} 全局伤害。
提升 {1} 全局伤害抗性。
提升 {1} 移动速度。
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[生命注射剂]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
恢复 25 点生命值。
]]

LANGUAGE["Gadget_gadget_cortex"] = [[皮层刺激器]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[精神统一]]

LANGUAGE["Gadget_gadget_ouroboros"] = [[咬尾蛇]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[能量盾]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
获得额外 15 点护甲。
上限为当前最高护甲自动回复值。
]]

LANGUAGE["Gadget_gadget_exoskeleton"] = [[外骨骼]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[硬化注射剂]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
移动速度减缓 {1}。
提升 {2} 全局伤害抗性。
提升 {3} 物理伤害抗性。
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[活体扩散器]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[发射器（治愈弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
发射带有治愈效果的化学药弹。
治愈弹造成 {1} 范围性毒素伤害。
治愈弹对范围内友军提供 {2} 生命恢复。
]]

LANGUAGE["Gadget_gadget_healing_beam"] = [[治疗光波]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[近身制御]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
眩晕自身周围的所有敌人。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[发射器（破片弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
发射不稳定爆破弹。
爆破弹造成 {1} 范围性爆炸伤害。
爆破弹爆炸后，产生 {2} 个额外破片爆炸。
]]

LANGUAGE["Gadget_gadget_nitrous_propellor"] = [[氮气弹射器]]

LANGUAGE["Gadget_gadget_ied"] = [[应急地雷]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[光学迷彩]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
强制提供 5 秒迷彩效果。
迷彩效果期间，提升 50% 闪避概率。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[发射器（冲击弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
发射能产生大量冲击的弓箭。
弓箭造成 {1} 子弹伤害。
弓箭对击中敌人造成眩晕效果。
]]

LANGUAGE["Gadget_gadget_death_mark"] = [[死亡标记]]

LANGUAGE["Gadget_gadget_assassin_optics"] = [[刺客镜片]]

-- Engineer Gadgets
LANGUAGE["Gadget_gadget_displacer"] = [[传送器]]
LANGUAGE["Gadget_gadget_turret_pack"] = [[便携步哨]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[E-寄生虫]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
发射E-寄生虫，感染击中的目标。
E-寄生虫享有全部的召唤物技能效果。
E-寄生虫对感染目标造成持续伤害。
E-寄生虫为使用者提供持续生命恢复。
被感染的目标死亡后，造成等于目标最大生命值的爆炸伤害。
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_chakra"] = [[查克拉]]
LANGUAGE["Gadget_Desc_gadget_chakra"] = [[
去除全部异常状态。
恢复 10 生命值。
]]

LANGUAGE["Gadget_gadget_berserk_armor"] = [[狂战盔甲]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
提升 {1} 全局伤害。
提升 {2} 全局伤害抗性。
提升 {3} 移动速度。
]]

LANGUAGE["Gadget_gadget_gadget_flash"] = [[一闪]]
LANGUAGE["Gadget_Desc_gadget_flash"] = [[
向前快速移动，对路径上的所有敌人造成 {1} 利器伤害。
提供短暂的无敌时间。
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[血能炮]]
LANGUAGE["Gadget_Desc_gadget_hemocannon"] = [[
消耗 10 生命值，发射血浆制作的投射物。
血浆爆炸后对敌人造成 100 利器伤害并且累积出血值。
最多有 5 发充能。每 5 秒充能一次。
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[太阳能阵列]]
LANGUAGE["Gadget_gadget_watchtower_pack"] = [[便携守望塔]]
LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[发射器（雷电弹）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
发射能够穿透敌人的雷电弹。
雷电弹每穿透一个敌人，造成 {1} 范围性雷电伤害。
]]
LANGUAGE["Gadget_gadget_shock_nova"] = [[雷神]]

-- Cremator Gadgets
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

LANGUAGE["Gadget_gadget_barbeque"] = [[烧烤]]


-- Notifications
LANGUAGE["Notifications_Debuff_Bleeding"] = [[你陷入了出血状态。你的生命值在慢慢流失。]]
LANGUAGE["Notifications_Debuff_Ignite"] = [[你陷入了引燃状态。你在被火焰灼烧。]]
LANGUAGE["Notifications_Debuff_Frostbite"] = [[你陷入了霜冻状态。你的双脚难以行动。]]
LANGUAGE["Notifications_Debuff_Shock"] = [[你陷入了感电状态。你的防御力大幅降低。]]
LANGUAGE["Notifications_Debuff_Break"] = [[你陷入了毒破状态。你的生命值被大幅减少。]]
LANGUAGE["Notifications_Debuff_Decay"] = [[你陷入了衰退状态。你的身体无法恢复。]]
LANGUAGE["Notifications_Debuff_Necrosis"] = [[你陷入了即死状态。你的生命即将结束。]]