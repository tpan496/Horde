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

translate.AddLanguage("zh-TW", "Chinese Traditional")

LANGUAGE["Default_Font_Scale"] = 1.20

-- Game Info
LANGUAGE["Game_Preparing..."] = "準備中..."
LANGUAGE["Game_Ready"] = "    準備"
LANGUAGE["Game_Not Ready"] = "    未準備"
LANGUAGE["Game_Players_Ready"] = "等待玩家"
LANGUAGE["Game_Next_Wave_Starts_In"] = "下一波在 %d 秒後開始"
LANGUAGE["Game_Difficulty_NORMAL"] = "普通"
LANGUAGE["Game_Difficulty_HARD"] = "困難"
LANGUAGE["Game_Difficulty_REALISM"] = "寫實"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "夢魘"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "天啟"
LANGUAGE["Game_Enemies"] = "敵人數"
LANGUAGE["Game_HintBottomReady"] = "F2 - 訊息/設定, F3 - 商店/技能, F4 - 準備"
LANGUAGE["Game_HintBottom"] = "F2 - 訊息/設定, F3 - 商店/技能, V - 扔出金錢"
LANGUAGE["Game_Result_VICTORY"] = "勝利"
LANGUAGE["Game_Result_DEFEAT"] = "失敗"
LANGUAGE["Game_Result_Change Map"] = "地圖變更中"
LANGUAGE["Game_Wave"] = "波數"
LANGUAGE["Game_Wave_Has_Started"] = "第 %d 波即將開始"
LANGUAGE["Game_Wave_Completed"] = "目標達成"
LANGUAGE["Game_Remaining_Time"] = "剩餘時間"
LANGUAGE["Game_Vote_Map"] = "地圖投票"
LANGUAGE["Game_Game_Summary"] = "遊戲數據"
LANGUAGE["Game_Most_Damage_Dealt"] = "最高傷害"
LANGUAGE["Game_Damage"] = "傷害"
LANGUAGE["Game_Most_Damage_Taken"] = "最高傷害承受"
LANGUAGE["Game_Damage_Taken"] = "承受傷害"
LANGUAGE["Game_Most_Kills"] = "最多殺敵"
LANGUAGE["Game_Kills"] = "擊殺"
LANGUAGE["Game_Elite_Killer"] = "精英殺手"
LANGUAGE["Game_Elite_Kills"] = "精英怪擊殺"
LANGUAGE["Game_SharpShooter"] = "神射手"
LANGUAGE["Game_Headshots"] = "爆頭數"
LANGUAGE["Game_Most_Heal"] = "最高隊友治療量"
LANGUAGE["Game_Healed"] = "治療量"
LANGUAGE["Game_Healed_You"] = "治療了你"


-- Ranks
LANGUAGE["Rank_Novice"] = "入門"
LANGUAGE["Rank_Amateur"] = "學徒"
LANGUAGE["Rank_Skilled"] = "高手"
LANGUAGE["Rank_Professional"] = "專業"
LANGUAGE["Rank_Expert"] = "大師"
LANGUAGE["Rank_Champion"] = "冠軍"
LANGUAGE["Rank_Master"] = "宗師"
LANGUAGE["Rank_Not_Met"] = "未達等級需求"


-- Scoreboard
LANGUAGE["Scoreboard_Name"] = "玩家"
LANGUAGE["Scoreboard_Class"] = "職業"
LANGUAGE["Scoreboard_Perks"] = "技能"
LANGUAGE["Scoreboard_Gadget"] = "配件"
LANGUAGE["Scoreboard_Money"] = "金錢"
LANGUAGE["Scoreboard_Kill"] = "擊殺"
LANGUAGE["Scoreboard_Death"] = "死亡"
LANGUAGE["Scoreboard_Ping"] = "延遲"

-- Shop
LANGUAGE["Shop_Not_Enough_Money_Or_Carrying_Capacity"] = "沒有足夠的金錢或負重來購買當前物品！"
-- Categories
LANGUAGE["Shop_Class"] = "職業"
LANGUAGE["Shop_Cash"] = "金錢"
LANGUAGE["Shop_Weight"] = "負重"
LANGUAGE["Shop_Melee"] = "近戰"
LANGUAGE["Shop_Pistol"] = "手槍"
LANGUAGE["Shop_Shotgun"] = "霰彈槍"
LANGUAGE["Shop_SMG"] = "衝鋒槍"
LANGUAGE["Shop_Rifle"] = "步槍"
LANGUAGE["Shop_MG"] = "重機槍"
LANGUAGE["Shop_Explosive"] = "爆炸物"
LANGUAGE["Shop_Special"] = "特殊"
LANGUAGE["Shop_Equipment"] = "裝備"
LANGUAGE["Shop_Attachment"] = "配件"
LANGUAGE["Shop_Gadget"] = "器具"

-- Attachments
LANGUAGE["Shop_Optic"] = "瞄具"
LANGUAGE["Shop_Underbarrel"] = "下掛"
LANGUAGE["Shop_Tactical"] = "戰術工具"
LANGUAGE["Shop_Barrel"] = "槍管"
LANGUAGE["Shop_Muzzle"] = "槍口"
LANGUAGE["Shop_Magazine"] = "彈匣"
LANGUAGE["Shop_Stock"] = "槍托"
LANGUAGE["Shop_Ammo Type"] = "子彈類型"
LANGUAGE["Shop_Perk"] = "武器技能"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "職業/技能"
LANGUAGE["Shop_Select_Class"] = "選擇職業（失去擁有物品）"
LANGUAGE["Shop_Show_Perks"] = "顯示技能樹"
LANGUAGE["Shop_Hide_Perks"] = "隱藏技能樹"
LANGUAGE["Shop_Unlocks_After_Wave"] = "第 %d 波後解鎖"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "購買彈匣"
LANGUAGE["Shop_Sell_For"] = "賣出"
LANGUAGE["Shop_Sell_All_For"] = "賣出全部"
LANGUAGE["Shop_Buy_Item"] = "購買物品"
LANGUAGE["Shop_OWNED"] = "已擁有"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "購買次要彈藥"
LANGUAGE["Shop_Primary_Ammo"] = "主要彈藥"
LANGUAGE["Shop_Secondary_Ammo"] = "次要彈藥"

-- Infusions
LANGUAGE["Game_Infusion"] = "變質"
LANGUAGE["Game_Infused"] = "已嵌入"
LANGUAGE["Infusion"] = "變質"
LANGUAGE["Infusion_Hemo"] = "出血"
LANGUAGE["Infusion_Concussive"] = "笨重"
LANGUAGE["Infusion_Septic"] = "劇毒"
LANGUAGE["Infusion_Flaming"] = "火焰"
LANGUAGE["Infusion_Arctic"] = "冰冷"
LANGUAGE["Infusion_Galvanizing"] = "雷電"
LANGUAGE["Infusion_Quality"] = "品質"
LANGUAGE["Infusion_Impaling"] = "穿刺"
LANGUAGE["Infusion_Rejuvenating"] = "生命"
LANGUAGE["Infusion_Quicksilver"] = "水銀"
LANGUAGE["Infusion_Siphoning"] = "汲取"
LANGUAGE["Infusion_Titanium"] = "白金"
LANGUAGE["Infusion_Chrono"] = "時間"
LANGUAGE["Infusion_Ruination"] = "毀滅"

LANGUAGE["Infusion_Description_Hemo"] = [[
轉換 75% 武器傷害為利器傷害。

武器只能造成利器傷害。

武器傷害對敵人累積出血值。
]]
LANGUAGE["Infusion_Description_Concussive"] = [[
轉換 75% 武器傷害為鈍器傷害。

武器只能造成鈍器傷害。

武器傷害對敵人累積眩暈值。
]]
LANGUAGE["Infusion_Description_Septic"] = [[
轉換 75% 武器傷害為毒素傷害。

武器只能造成劇毒傷害。

武器傷害對敵人累積毒爆值。
]]
LANGUAGE["Infusion_Description_Flaming"] = [[
轉換 75% 武器傷害為火焰傷害。

武器只能造成火焰傷害。
]]
LANGUAGE["Infusion_Description_Arctic"] = [[
轉換 75% 武器傷害為寒冰傷害。

武器只能造成寒冰傷害。

武器傷害對敵人累積霜凍值。
]]
LANGUAGE["Infusion_Description_Galvanizing"] = [[
轉換 75% 武器傷害為雷電傷害。

武器只能造成雷電傷害。

武器傷害對敵人累積感電值。
]]
LANGUAGE["Infusion_Description_Quality"] = [[
提升 20% 武器傷害。

武器無法獲得職業技能帶來的任何效果和傷害提升！
]]
LANGUAGE["Infusion_Description_Impaling"] = [[
提升 25% 武器爆頭傷害。

減少 25% 武器非爆頭傷害。
]]
LANGUAGE["Infusion_Description_Rejuvenating"] = [[
提升 25% 生命恢復/汲取。

減少 25% 武器傷害。
]]
LANGUAGE["Infusion_Description_Quicksilver"] = [[
根據玩家的身上負重提升/減少武器傷害。
玩家身上的裝備越少，傷害提升越高。

<= 15% 負重 -> 30% 傷害提升
<= 30% 負重 -> 25% 傷害提升 
<= 40% 負重 -> 15% 傷害提升 
  >40% 負重 -> 25% 傷害減少
]]
LANGUAGE["Infusion_Description_Titanium"] = [[
根據當前武器重量減少玩家受到的傷害。

每 1 負重，減少 1% 受到的傷害。

減少 25% 武器傷害。
]]
LANGUAGE["Infusion_Description_Siphoning"] = [[
每殺死一個敵人恢復 1 生命值。

減少 25% 武器傷害。
]]
LANGUAGE["Infusion_Description_Chrono"] = [[
根據玩家持有武器的時間提升武器傷害。

每一回合持有當前武器，提升 6% 武器傷害。

武器傷害提升最多為 50%。

減少 20% 武器傷害。
]]
LANGUAGE["Infusion_Description_Ruination"] = [[
根據玩家當前的即死累積值提升武器傷害。

每 10 即死累計值，提升 5% 武器傷害。

持有當前武器時，每秒玩家會獲得 10 即死累計值。
]]

-- Classes
LANGUAGE["Class_Survivor"] = "倖存者"
LANGUAGE["Class_Assault"] = "突擊兵"
LANGUAGE["Class_Heavy"] = "重裝兵"
LANGUAGE["Class_Medic"] = "醫療兵"
LANGUAGE["Class_Demolition"] = "爆破兵"
LANGUAGE["Class_Ghost"] = "幻影"
LANGUAGE["Class_Engineer"] = "工程師"
LANGUAGE["Class_Berserker"] = "狂戰士"
LANGUAGE["Class_Warden"] = "守望者"
LANGUAGE["Class_Cremator"] = "火焰兵"

-- Gadgets
LANGUAGE["Gadget_Activation"] = "按 T 啟動。"
LANGUAGE["Gadget_Cooldown"] = "冷卻時間"
LANGUAGE["Gadget_Duration"] = "持續時間"
LANGUAGE["Gadget_Owned_Warning"] = "只能擁有 1 個器具！"
LANGUAGE["Gadget_Seconds"] = "秒"


-- Subclasses
LANGUAGE["Class_Change_Subclass"] = "變更附屬職業"
LANGUAGE["Class_Psycho"] = "暴徒"
LANGUAGE["Class_SpecOps"] = "特種兵"
LANGUAGE["Class_Carcass"] = "殘骸"
LANGUAGE["Class_Hatcher"] = "孵化者"
LANGUAGE["Class_Warlock"] = "術士"
LANGUAGE["Class_Gunslinger"] = "神槍手"
LANGUAGE["Class_Necromancer"] = "死靈法師"
LANGUAGE["Class_Samurai"] = "武士"
LANGUAGE["Class_???"] = "???"
LANGUAGE["Class_Artificer"] = "信仰者"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
能使用除了特殊武器和職業獨有武器外的大部分武器。]]

LANGUAGE["Class_Description_Assault"] = [[
能使用全部的突擊步槍武器。]]

LANGUAGE["Class_Description_Heavy"] = [[
能使用全部的重機槍和高負重武器。]]

LANGUAGE["Class_Description_Medic"] = [[
能使用大部分輕武器以及醫療類工具。]]

LANGUAGE["Class_Description_Demolition"] = [[
能使用全部的爆炸類武器。]]

LANGUAGE["Class_Description_Ghost"] = [[
能使用全部的狙擊步槍武器和獨特的輕武器。]]

LANGUAGE["Class_Description_Engineer"] = [[
能使用特殊類武器和道具。]]

LANGUAGE["Class_Description_Berserker"] = [[
只能使用近戰類武器。]]

LANGUAGE["Class_Description_Warden"] = [[
能使用全部的霰彈槍武器以及製造守望塔 (horde_watchtower)。]]

LANGUAGE["Class_Description_Cremator"] = [[
能使用基於熱學原理的武器。]]


-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
倖存者擁有最大的武器池，從而可以彌補團隊中所缺的任何角色。
難度：簡單

無額外特性。]]

LANGUAGE["Perk_assault_base"] = [[
突擊兵擁有出色的移動力和穩定的輸出，從而能應對任何場景。
難度：簡單

提升 {1} 移動速度。（每級提升 {2}，最多至 {3}）。
提升 {7} 子彈傷害。 （每級提升 {8}，最多至 {9}）。

殺死敵人後獲得「腎上腺素」狀態。通過技能的選擇，「腎上腺素」可以進行堆疊。
「腎上腺素」提升 {4} 移動速度和輸出。]]

LANGUAGE["Perk_heavy_base"] = [[
重裝兵擁有高超的護甲防禦機制，同時能使用重武器對敵人造成火力壓制。
難度：簡單

提升 {6} 最大護甲值。（每級提升 {7}， 最多至 {8}）。

每秒恢復 {1} 點護甲。
護甲回復上限為 {2}。（基礎{3} + 每級提升 {4}，最多至 {5}）。]]

LANGUAGE["Perk_medic_base"] = [[
醫療兵擁有強大的生命恢復能力，同時能為隊友提供治療以及各種增益效果。
難度：中等

提升 {1} 治療量。（每級提升 {2}，最多至 {3}）。

每秒恢復 {4} 生命值。]]

LANGUAGE["Perk_demolition_base"] = [[
爆破兵擁有強大的範圍性輸出。根據技能的選擇，爆破兵也能提供超群的單體輸出能力。
難度：中等

提升 {7} 爆炸傷害。 （每級提升 {8}，最多至 {9}）。
提升 {1} 爆炸傷害抗性。（基礎 {2} + 每級提升 {3}，最多至 {4}）。

在沒有高爆手榴彈的前提下，每 {6} 秒獲得 {5} 個高爆手榴彈。]]

LANGUAGE["Perk_ghost_base"] = [[
幻影是一個圍繞著精準度和「迷彩」機制的職業。使用恰當的話，幻影可以提供無以匹敵的單體輸出。
難度：困難

{1} 更多爆頭傷害。（每級提升 {2}，最多至 {3}）。

蹲下以啟動「迷彩」狀態，提供 {4} 閃避。
攻擊、奔跑會取消「迷彩」狀態。]]

LANGUAGE["Perk_engineer_base"] = [[
工程師是一個圍繞著召喚物的職業。召喚物能有效地進行區域性防守並且為隊友提供掩護。
難度：中等

提升 {1} 召喚物傷害。（每級提升 {2}，最多至 {3}）。

步哨擁有 {4} 基礎生命值和 {5} 基礎傷害。]]

LANGUAGE["Perk_berserker_base"] = [[
狂戰士是近距離格鬥專家。
難度：困難

提升 {1} 所有傷害抗性。（每級提升 {2}，最多至 {3}）。
提升 {4} 近戰傷害。（每級提升 {5}，最多至 {6}）。

空中格擋：跳躍中減少 {7} 受到的物理傷害。]]

LANGUAGE["Perk_warden_base"] = [[
守望者是是一個使用自身光環和建築來為隊友提供各種有利效果的輔助職業。
難度：中等

提升 {1} 「守望光環」半徑。（每級提升 {2}，最多至 {3}）。

自身以及附近的玩家會受到「守望光環」效果。
「守望光環」阻擋 {4} 傷害。]]

LANGUAGE["Perk_cremator_base"] = [[
火焰兵使用火焰傷害進行進攻和防禦。
難度：簡單

提升 {1} 火焰傷害抗性。（基礎 {2} + 每級提升 {3}，最多至 {4}）。

攻擊有 {5} 機率引燃敵人。
引燃持續時間為 {6} 秒，造成基於攻擊傷害的持續傷害。
火焰傷害有 {7} 機率引燃敵人。]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[生存]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[隨機應變]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[防禦]]
LANGUAGE["Perk_Title_Survivor_Tier_4"] = [[技巧複製]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[機動性]]
LANGUAGE["Perk_Title_assault_ambush"] = [[襲擊]]
LANGUAGE["Perk_assault_ambush"] = [[
提升 {1} 爆頭傷害。]]

LANGUAGE["Perk_Title_assault_charge"] = [[蓄能]]
LANGUAGE["Perk_assault_charge"] = [[
「腎上腺素」最大堆疊次數 +{1}。
（每層堆疊提升 {2} 傷害和移動速度。）]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[適應性]]
LANGUAGE["Perk_Title_assault_drain"] = [[生命汲取]]
LANGUAGE["Perk_assault_drain"] = [[
滿血前提下，提升 {1} 爆頭傷害。
每擊殺一個敵人恢復 {2} 生命值。]]

LANGUAGE["Perk_Title_assault_overclock"] = [[代謝超頻]]
LANGUAGE["Perk_assault_overclock"] = [[
「腎上腺素」最大堆疊次數 +{1}。]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[進攻]]

LANGUAGE["Perk_Title_assault_cardiac_resonance"] = [[心室共鳴]]
LANGUAGE["Perk_assault_cardiac_resonance"] = [[
每次擊殺敵人後，
附近玩家獲得 {1} 「腎上腺素」，最多至 {2}。
「腎上腺素」最大堆疊次數 +{3}。]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[心臟過載]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
「腎上腺素」持續時間提升 {1}。
「腎上腺素」最大堆疊次數 +{2}。]]

LANGUAGE["Perk_Title_Assault_Tier_4"] = [[條件反射]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[精神統一]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
提升 {1} 爆頭傷害。
滿「腎上腺素」前提下，提升 {2} 所有傷害抗性。]]

LANGUAGE["Perk_Title_assault_merciless_assault"] = [[勢如破竹]]
LANGUAGE["Perk_assault_merciless_assault"] = [[
爆頭有 {1} 機率 +1 層「腎上腺素」。
「腎上腺素」最大堆疊次數 +{2}。]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[壓制]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[黏性化合物]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
子彈傷害擊中的敵人受到「抑制」異常狀態。
「抑制」狀態下，造成 {1} 更少物理傷害。]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[粗糙彈殼]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
子彈傷害擊中的敵人受到「虛弱」異常狀態。
「虛弱」狀態下，受到 {1} 更多物理傷害。]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[備用]]
LANGUAGE["Perk_Title_heavy_repair_catalyst"] = [[修復催化劑]]
LANGUAGE["Perk_heavy_repair_catalyst"] = [[
+{1} 最大護甲值恢復值。]]

LANGUAGE["Perk_Title_heavy_floating_carrier"] = [[懸浮倉]]
LANGUAGE["Perk_heavy_floating_carrier"] = [[
+5 最大負重。]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[護甲強化]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[流體裝甲]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
護甲值至少有 {1} 的前提下：
  提升 {2} 物理抗性。]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[反應裝甲]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
獲得一個能抵消傷害的反應裝甲。
裝甲在受到至少 {1} 傷害後激活，在 {2} 秒後重置。
激活會消耗 {3} 當前護甲值。]]

LANGUAGE["Perk_Title_Heavy_Tier_4"] = [[先進科技]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[納米機器]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
提升 {1} 護甲值恢復速度。]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[彈道衝擊]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
造成的異常狀態時間提升 {1}。
造成的異常狀態效果提升 {2}。]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[藥物]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[抗生素]]
LANGUAGE["Perk_medic_antibiotics"] = [[
提升 {1} 治療量。]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[止痛劑]]
LANGUAGE["Perk_medic_painkillers"] = [[
提升 {1} 治療生命值最大上限。]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[生物工程]]
LANGUAGE["Perk_Title_medic_berserk"] = [[狂化]]
LANGUAGE["Perk_medic_berserk"] = [[
治療的對象獲得「狂化」增益狀態。
「狂化」狀態持續 {1} 秒。
「狂化」狀態下，提升 {2} 傷害。]]

LANGUAGE["Perk_Title_medic_fortify"] = [[堅固]]
LANGUAGE["Perk_medic_fortify"] = [[
治療的對象獲得「堅固」增益狀態。
「堅固」狀態持續 {1} 秒。
「堅固」狀態下，受到 {2} 更少傷害。]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[增強]]
LANGUAGE["Perk_Title_medic_purify"] = [[凈化]]
LANGUAGE["Perk_medic_purify"] = [[
直接減少治療對象的流血，破壞，壞死累計值。]]

LANGUAGE["Perk_Title_medic_haste"] = [[加速]]
LANGUAGE["Perk_medic_haste"] = [[
治療的對象獲得「加速」增益狀態。
「加速」狀態持續 {1} 秒。「加速」狀態下，提升 {2} 移動速度。]]

LANGUAGE["Perk_Title_Medic_Tier_4"] = [[物競天擇]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[細胞坍縮]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
擊殺的敵人有 {1} 機率產生治療煙霧。]]

LANGUAGE["Perk_Title_medic_xcele"] = [[治癒因子]]
LANGUAGE["Perk_medic_xcele"] = [[
提升 {1} 增益狀態效果。
提升 {2} 增益狀態持續時間。]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[手榴彈改裝]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[衝擊起爆]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
提升 {1} 手榴彈衝擊引爆傷害。
手榴彈擊中敵人後直接引爆。
衝擊引爆增加敵人的眩暈累計值。]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[子母彈]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
手榴彈爆炸後產生 {1} 個小型手榴彈。
小型手榴彈傷害比手榴彈少 {2}。]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[武器]]
LANGUAGE["Perk_Title_demolition_direct_hit"] = [[精確打擊]]
LANGUAGE["Perk_demolition_direct_hit"] = [[
提升 {1} 起爆點附近敵人的爆炸傷害。
提升 {1} 鈍器傷害。]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[震蕩波]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
爆炸傷害產生額外的震蕩波。
震蕩波造成原本爆炸傷害 {1} 的物理傷害。
產生震蕩波需要超過 {2} 爆炸傷害。]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[爆破途徑]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[破片]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
提升 {1} 爆炸傷害。]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[擊暈]]
LANGUAGE["Perk_demolition_knockout"] = [[
爆炸傷害提升敵人的眩暈累計值。
眩暈累計值飽和後，對敵人造成 {1} 秒眩暈。
眩暈冷卻時間為 {2} 秒。]]

LANGUAGE["Perk_Title_Demolition_Tier_4"] = [[毀滅]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[高壓彈頭]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
提升 {1} 對精英敵人造成的爆炸傷害。
{2} 更多對頭部造成的爆炸和鈍器傷害。。]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[連鎖反應]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
對敵人造成 {1} 當前生命值的額外爆炸傷害。
額外爆炸傷害最高為 {2}。]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[策略]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[獵頭]]
LANGUAGE["Perk_ghost_headhunter"] = [[
爆頭傷害能夠進行堆疊，最多堆疊 {1} 次。
每層堆疊提升 {2} 爆頭傷害。]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[狙擊]]
LANGUAGE["Perk_ghost_sniper"] = [[
蹲下狀態提升 {1} 子彈傷害。]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[戰略轉移]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[幽靈漫步]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
奔跑不會取消「迷彩」狀態。
迷彩狀態下提升 {1} 移動速度。
迷彩狀態下提升 {2} 閃避機率。]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[幻影披風]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
攻擊不會取消「迷彩」狀態。
迷彩啟動速度提升 {1}。
「迷彩」狀態下提升 {2} 子彈傷害。]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[彈道]]
LANGUAGE["Perk_Title_ghost_brain_snap"] = [[蝕腦]]
LANGUAGE["Perk_ghost_brain_snap"] = [[
爆頭提升「霜凍」累計值，基於武器原始傷害。
「霜凍」狀態下，大幅度減緩敵人行動速度 {1} 秒。
「霜凍」狀態冷卻時間為 {2} 秒。]]

LANGUAGE["Perk_Title_ghost_kinetic_impact"] = [[蓄能衝擊]]
LANGUAGE["Perk_ghost_kinetic_impact"] = [[
基於攻擊距離提升子彈傷害。
每 {2} 距離，提升 {1} 子彈傷害。
最多提升 {3} 子彈傷害。]]

LANGUAGE["Perk_Title_Ghost_Tier_4"] = [[殲滅]]
LANGUAGE["Perk_Title_ghost_coup"] = [[恩賜解脫]]
LANGUAGE["Perk_ghost_coup"] = [[
直接擊殺生命值小於 {1} 最大生命值的敵人。]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[斬首]]
LANGUAGE["Perk_ghost_decapitate"] = [[
「迷彩」狀態下：
  提升 {1} 子彈傷害。
  提升 {2} 對精英敵人造成的爆頭傷害。]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[製造]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[匠魂]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
{1} 更多召喚物生命值。]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[先驅]]
LANGUAGE["Perk_engineer_pioneer"] = [[
提升 {2} 召喚物傷害。]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[核心]]
LANGUAGE["Perk_Title_engineer_fusion"] = [[聚變反應]]
LANGUAGE["Perk_engineer_fusion"] = [[
召喚物每秒恢復 {1} 最大生命值。
召喚物滿血前提下，提升 {2} 召喚物傷害。]]

LANGUAGE["Perk_Title_engineer_metabolism"] = [[新陳代謝]]
LANGUAGE["Perk_engineer_metabolism"] = [[
召喚物吸收 {1} 對敵人造成的傷害為生命值。
召喚物不滿血前提下，提升 {2} 召喚物傷害。]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[操控]]
LANGUAGE["Perk_Title_engineer_antimatter_shield"] = [[反物質護盾]]
LANGUAGE["Perk_engineer_antimatter_shield"] = [[
按 Shift+E 對目標召喚物附加護盾。
護盾吸收目標召喚物 {1} 最大生命值的傷害。
護盾殆盡後爆炸，冷卻時間為 {2} 秒。]]

LANGUAGE["Perk_Title_engineer_displacer"] = [[傳送器]]
LANGUAGE["Perk_engineer_displacer"] = [[
按 Shift+E 傳送目標召喚物至身前。
傳送後，目標召喚物恢復 {1} 最大生命值。
傳送器冷卻時間為 {2} 秒。]]

LANGUAGE["Perk_Title_Engineer_Tier_4"] = [[實驗性模組]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[共生]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
{1} 更多召喚物最大生命值。
每有一個存活的召喚物，提升 {2} 所有傷害抗性。]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[神風]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
召喚物死亡時會產生爆炸。
爆炸傷害為召喚物最大生命值的 {1}。]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[基本功]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[波紋呼吸]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
每秒恢復 {1} 最大生命值。
免疫毒素傷害。]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[嗜血狂怒]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
吸收 {1} 造成的近戰傷害為生命值。
每次攻擊最多吸收 {2} 點生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[技巧]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[劍舞]]
LANGUAGE["Perk_berserker_bushido"] = [[
近戰爆頭傷害提升敵人眩暈值。
提升 {2} 移動速度。]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[殘暴]]
LANGUAGE["Perk_berserker_savagery"] = [[
提升 {1} 近戰傷害。
提升 {2} 最大生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[格擋]]
LANGUAGE["Perk_Title_berserker_graceful_guard"] = [[優雅護衛]]
LANGUAGE["Perk_berserker_graceful_guard"] = [[
空中格擋成功後：
  - 移除所有的異常狀態和異常狀態累計值。
  - 恢復 {1} 生命值。]]

LANGUAGE["Perk_Title_berserker_unwavering_guard"] = [[堅定護衛]]
LANGUAGE["Perk_berserker_unwavering_guard"] = [[
空中格擋成功後：
  - 提升 {1} 物理傷害，持續 {3} 秒。
  - 減少 {2} 受到的傷害，持續 {3} 秒。]]

LANGUAGE["Perk_Title_Berserker_Tier_4"] = [[秘技]]
LANGUAGE["Perk_Title_berserker_mindeye"] = [[心眼]]
LANGUAGE["Perk_berserker_mindeye"] = [[
每次近戰攻擊可以獲得一層心眼狀態，最多 {1} 層。
每層提升 {2} 閃避和 {3} 近戰傷害。
被敵人攻擊命中或者層數超過最大時，層數清零。]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[肉斬骨斷]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
{1} 更多近戰傷害。
近戰攻擊可以濺射。
濺射傷害為基礎傷害的 {2}。]]

-- Default Perks: Warden
LANGUAGE["Perk_Title_Warden_Tier_1"] = [[維持]]
LANGUAGE["Perk_Title_warden_bulwark"] = [[制御]]
LANGUAGE["Perk_warden_bulwark"] = [[
守望塔每 {1} 秒產生 1 個護甲包。]]

LANGUAGE["Perk_Title_warden_vitality"] = [[活性化]]
LANGUAGE["Perk_warden_vitality"] = [[
光環提供每秒 {1} 點生命恢復。]]

LANGUAGE["Perk_Title_Warden_Tier_2"] = [[資源利用]]
LANGUAGE["Perk_Title_warden_restock"] = [[快速補充]]
LANGUAGE["Perk_warden_restock"] = [[
守望塔資源產生冷卻時間減少 {1}。]]

LANGUAGE["Perk_Title_warden_energize"] = [[充能]]
LANGUAGE["Perk_warden_energize"] = [[
光環提供 +{1} 額外傷害。
激活此效果需要至少 {1} 基礎傷害。]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[護送]]
LANGUAGE["Perk_Title_warden_rejection_pulse"] = [[排斥力場]]
LANGUAGE["Perk_warden_rejection_pulse"] = [[
守望塔每 {1} 秒產生衝擊波。
衝擊波造成 {2} 電擊傷害。]]

LANGUAGE["Perk_Title_warden_inoculation"] = [[無垢化]]
LANGUAGE["Perk_warden_inoculation"] = [[
光環玩家內玩家獲得 {1} 更少引燃，電感，霜凍累計值。]]

LANGUAGE["Perk_Title_Warden_Tier_4"] = [[廣域化]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[機械降神]]
LANGUAGE["Perk_warden_ex_machina"] = [[
守望塔提供「守望光環」。]]

LANGUAGE["Perk_Title_warden_resonance_cascade"] = [[級聯共振]]
LANGUAGE["Perk_warden_resonance_cascade"] = [[
光環效果增加 {1}。
光環半徑增加 {2}。]]

-- Default Perks: Cremator
LANGUAGE["Perk_Title_Cremator_Tier_1"] = [[化合物]]
LANGUAGE["Perk_Title_cremator_methane"] = [[甲烷]]
LANGUAGE["Perk_cremator_methane"] = [[
對被引燃的敵人提升 {1} 火焰傷害。]]

LANGUAGE["Perk_Title_cremator_napalm"] = [[凝固汽油彈]]
LANGUAGE["Perk_cremator_napalm"] = [[
提升 {1} 引燃持續時間。]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[能量汲取]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[陽電子陣列]]
LANGUAGE["Perk_cremator_positron_array"] = [[
免疫火焰傷害。
吸收 {1} 受到的火焰傷害為生命值。]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[熵護盾]]
--[[LANGUAGE["Perk_cremator_entropy_shield"] = [[
獲得一個能抵消一次傷害的護盾。
護盾被擊中後爆炸，在 {1} 秒後重生。
護盾爆炸造成 {2} 火焰傷害。]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[熱量操控]]
LANGUAGE["Perk_Title_cremator_hyperthermia"] = [[超高溫]]
LANGUAGE["Perk_cremator_hyperthermia"] = [[
基於敵人和玩家間的距離提升火焰傷害。
距離越近，火焰傷害越高。
火焰傷害最多提升 {1}。]]

LANGUAGE["Perk_Title_cremator_ionization"] = [[電離化]]
LANGUAGE["Perk_cremator_ionization"] = [[
提升 {1} 引燃傷害。
火焰傷害無視敵人火焰抗性。]]

LANGUAGE["Perk_Title_Cremator_Tier_4"] = [[能量釋放]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[烈焰風暴]]
LANGUAGE["Perk_cremator_firestorm"] = [[
火焰傷害對敵人累計爆裂值。
爆裂值到達 {1} 後產生爆炸。
爆炸造成 {2} 爆炸傷害。]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[燃燒殆盡]]
LANGUAGE["Perk_cremator_incineration"] = [[
提升 {1} 引燃傷害。]]

-- Default Perks: Psycho
LANGUAGE["Perk_psycho_base"] = [[
難度：中等

+{1} 暴擊率。(基礎 {2} + 每級提升 {3}，最多至 {4})。
暴擊造成 {5} 更多傷害。

按 F 進入狂暴模式。
狂暴模式中，玩家會持續失去生命值，但不會致死。
狂暴模式中，提升 {6} 暴擊機率。
狂暴模式中，提升 {7} 生命恢復值。]]

LANGUAGE["Perk_Title_Psycho_Tier_1"] = [[暴行]]
LANGUAGE["Perk_Title_psycho_ferocity"] = [[迅猛]]
LANGUAGE["Perk_psycho_ferocity"] = [[
+{1} 暴擊率。
+{2} 近戰暴擊率。]]

LANGUAGE["Perk_Title_psycho_savor"] = [[品嘗]]
LANGUAGE["Perk_psycho_savor"] = [[
提升 {1} 暴擊傷害。
吸收 {2} 暴擊傷害為生命值。
每次最多吸收 10 生命值。]]

LANGUAGE["Perk_Title_Psycho_Tier_2"] = [[虐待狂]]
LANGUAGE["Perk_Title_psycho_bloodbath"] = [[血浴]]
LANGUAGE["Perk_psycho_bloodbath"] = [[
+{1} 暴擊率。
每次暴擊恢復 1 生命值。]]

LANGUAGE["Perk_Title_psycho_disembowel"] = [[肢解]]
LANGUAGE["Perk_psycho_disembowel"] = [[
提升 {1} 暴擊傷害。
近戰暴擊傷害移除屍爆變異。]]

LANGUAGE["Perk_Title_Psycho_Tier_3"] = [[致命一擊]]
LANGUAGE["Perk_Title_psycho_skewering"] = [[穿刺]]
LANGUAGE["Perk_psycho_skewering"] = [[
擊中敵人頭部使其陷入穿刺異常狀態。
玩家對穿刺狀態下敵人攻擊時，獲得 +{1} 暴擊率。]]

LANGUAGE["Perk_Title_psycho_brutality"] = [[殘暴]]
LANGUAGE["Perk_psycho_brutality"] = [[
近戰擊中敵人獲得殘暴增益效果。可疊加。
每層殘暴提供 +{1} 暴擊率。
每層殘暴提升 {2} 暴擊傷害。]]

LANGUAGE["Perk_Title_Psycho_Tier_4"] = [[崩壞]]
LANGUAGE["Perk_Title_psycho_grudge"] = [[咒怨]]
LANGUAGE["Perk_psycho_grudge"] = [[
每缺少 {2} 生命值，提升 {1} 暴擊率。
每缺少 {4} 生命值，提升 {3} 移動速度。]]

LANGUAGE["Perk_Title_psycho_bestial_wrath"] = [[獸性]]
LANGUAGE["Perk_psycho_bestial_wrath"] = [[
{1} 提升暴擊傷害。
狂暴模式中，近戰傷害產生範圍性傷害。
狂暴模式中，每殺死一個敵人提供 1 生命恢復。]]

-- Default Perks: Carcass
LANGUAGE["Perk_carcass_base"] = [[
難度：困難

提升 {1} 最大生命值。(每級提升 {2}，最多至 {3})。

擊中敵人後有 {4} 機率獲得「肌肉增殖」狀態 (擊中頭部會有 {5} 機率)。
被敵人擊中後也會獲得「肌肉增值」狀態。
透過技能的選擇，「肌肉增殖」可以進行堆疊。
每一層「肌肉增殖」減少 {6} 玩家受到的物理傷害。
每一層「肌肉增殖」提供 2% 生命值恢復。

你被植入了殘骸生化武器系統。
無法使用除了拳頭以外的任何武器。

左鍵：出拳。長按進行蓄力。]]

LANGUAGE["Perk_Title_Carcass_Tier_1"] = [[腸胃]]
LANGUAGE["Perk_Title_carcass_grappendix"] = [[腸鉤]]
LANGUAGE["Perk_carcass_grappendix"] = [[
提升 {1} 最大生命值。
右鍵發射大腸，用作抓鉤。
使用腸鉤消耗生命值。]]

LANGUAGE["Perk_Title_carcass_bio_thruster"] = [[生化推進器]]
LANGUAGE["Perk_carcass_bio_thruster"] = [[
+{1} 「肌肉增值」堆疊數。
右鍵進行衝刺，消耗 {2} 生命值並獲得 1 推進器堆疊數，最多 5 層。
每層推進器堆疊提升 {1} 近戰傷害，但會增加 {4} 生命值消耗。]]

LANGUAGE["Perk_Title_Carcass_Tier_2"] = [[分泌]]
LANGUAGE["Perk_Title_carcass_tactical_spleen"] = [[戰術腎臟]]
LANGUAGE["Perk_carcass_tactical_spleen"] = [[
提升 {1} 最大生命值。
獲得一個能抵消異常狀態的腎臟。
戰術腎臟每過 {2} 秒會再生。]]

LANGUAGE["Perk_Title_carcass_anabolic_gland"] = [[增值腺體]]
LANGUAGE["Perk_carcass_anabolic_gland"] = [[
+{1} 「肌肉增值」堆疊數。
+{2} 擊中敵人獲得「肌肉增殖」機率。]]

LANGUAGE["Perk_Title_Carcass_Tier_3"] = [[四肢]]
LANGUAGE["Perk_Title_carcass_reinforced_arms"] = [[強化手臂]]
LANGUAGE["Perk_carcass_reinforced_arms"] = [[
+{1} 「肌肉增值」堆疊數。
拳頭傷害會根據當前移動速度提升。
拳頭蓄力後，對表面攻擊能產生垂直移速提升。]]

LANGUAGE["Perk_Title_carcass_pneumatic_legs"] = [[氣動腿]]
LANGUAGE["Perk_carcass_pneumatic_legs"] = [[
+{1} 「肌肉增值」堆疊數。
空中按空格能夠快速下降，對範圍內敵人造成物理傷害。
減少 {2} 掉落傷害。]]

LANGUAGE["Perk_Title_Carcass_Tier_4"] = [[核心]]
LANGUAGE["Perk_Title_carcass_twin_heart"] = [[雙子心臟]]
LANGUAGE["Perk_carcass_twin_heart"] = [[
提升 {1} 最大生命值。
按 R 能夠切換雙子心臟狀態恢復生命值。
雙子心臟會積攢生命值至玩家最大生命值的 {2}。]]

LANGUAGE["Perk_Title_carcass_aas_perfume"] = [[AAS香水]]
LANGUAGE["Perk_carcass_aas_perfume"] = [[
+{1} 「肌肉增值」堆疊數。
按 R 發射孢子，為範圍內玩家提供「肌肉增值」效果。
效果持續 {2} 秒。有 {3} 秒冷卻時間。]]

-- Default Perks: Hatcher
LANGUAGE["Perk_hatcher_base"] = [[
難度：困難

提升 {1} 蟻獅進化速度。(每級提升 {2}，最多至 {3})。
提升 {1} 毒素傷害。(每級提升 {2}，最多至 {3})。

出身自帶費洛蒙膠囊。費洛蒙膠囊可以商店升級。
升級費洛蒙膠囊可以提升蟻獅傷害和生命值。

左鍵：釋放膠囊
投擲費洛蒙膠囊，強制蟻獅對目標進行攻擊。
對蟻獅投擲膠囊能夠恢復其 5% 生命值。

右鍵：召喚蟻獅 (40 能量)
創造一個蟻獅作為你的召喚物。治療蟻獅能夠加速其進化。
長按右鍵能迫使蟻獅前往玩家。
蟻獅進化後，每一階段會獲得新能力：
階段I   - 費洛蒙波動：每 5 秒中產生一個波動，恢復附近玩家 5% 生命值。
階段II  - 提升傷害，生命值，波動頻率，提升 50% 毒素傷害抗性。
階段III - 提升傷害，生命值，波動頻率，免疫毒素傷害和破壞異常狀態。]]

-- Default Perks: Gunslinger
LANGUAGE["Perk_gunslinger_base"] = [[
難度：中等

提升 {1} 手槍類武器傷害。(每級提升 {2}，最多至 {3})。
你可以在商店升級手槍類武器。

按 SHIFT+E 對敵人施加獵人標記。
獵人標記持續 5 秒鐘。
最多可以存在 1 個獵人標記。
在獵人標記下死去的敵人有 {4} 機率掉落額外金錢。

你可以購買所有的手槍類武器。]]

-- Default Perks: Specops
LANGUAGE["Perk_specops_base"] = [[
難度：中等

按 F 進入戰術模式。
戰術模式提供夜視效果。
戰術模式中無法跑步。
戰術模式會減少玩家 50% 移動速度。

戰術模式中，提升 {1} 更多移動速度。(每級提升 {2}，最多至 {3})。
戰術模式中，提升 {1} 更多爆頭傷害。(每級提升 {2}，最多至 {3})。]]


-- Default Perks: Necromancer
LANGUAGE["Perk_necromancer_base"] = [[
難度：中等

冰冷傷害造成 {1} 霜凍累計值。 (基礎 {2} + 每級提升 {3}，最多至 {4})。
提升 {5} 冰冷傷害抗性。(每級提升 {6}，最多至 {7})。

出身自帶虛空投射器。虛空投射器能夠通過商店升級。
升級虛空投射器能提升虛空之矛傷害，死靈傷害和死靈生命值。

左鍵：虛空之矛 (消耗 5/10/20 能量)
投射能夠造成冰冷傷害的暗物質，並造成霜凍累計值。
長按左鍵能夠進行蓄力。

右鍵：召喚死靈 (消耗 40 能量)
創造一個死靈為你的召喚物。
死靈能對敵人造成近戰傷害並造成霜凍累計值。
長按右鍵能將全部死靈召喚至你身旁。]]

-- Default Perks: Warlock
LANGUAGE["Perk_warlock_base"] = [[
難度：中等

提升 {1} 最大能量值。(每級提升 {2}，最多至 {3})。

出身自帶星體遺物。星體遺物能夠通過商店升級。
升級星體遺物能提升其傷害。

左鍵：星體波動 (消耗 10 能量)
創造 1 個能自動搜尋並纏繞敵人的能量體，對其造成持續性物理傷害。
最多可以存在 2 個星體波動。
長按左鍵可以引爆所有的星體波動。

右鍵：星體殘影 (消耗 5 能量)
創造會接觸引爆的能量體，對範圍內敵人造成物理傷害。
最多可以存在 5 個星體殘影。
長按右鍵可以增加星體殘影的大小並刷新持續時間。]]

-- Default Perks: Artificer
LANGUAGE["Perk_artificer_base"] = [[
難度：中等

雷電傷害造成 {1} 感電累計值。 (每級提升 {2}，最多至 {3})。
提升 {1} 火焰和雷電傷害。(每級提升 {2}，最多至 {3})。

出身自帶炎陽護符。炎陽護符能夠通過商店升級。
升級炎陽護符能提升其傷害。

左鍵：炎陽火球 (消耗 5/10/20 能量)
發射能夠造成火焰傷害的炙熱能量球。
長按左鍵能夠進行蓄力。

右鍵：炎陽雷擊 (消耗 5/10/20 能量)
製造閃電，對敵人瞬間造成雷電傷害。
長按右鍵能夠進行蓄力。]]

-- Default Perks: Samurai
LANGUAGE["Perk_samurai_base"] = [[
難度：困難
近戰傷害造成 {1} 武器基礎傷害的出血累計值。 (基礎 {2} + 每級提升 {3}，最多至 {4})。
提升 {5} 全局傷害抗性。 (每級提升 {6}，最多至 {7})。

使用 SHIFT + E 疾步，能夠根據方向鍵快速移動。
疾步狀態中獲得 100% 閃避值。]]

LANGUAGE["Perk_Title_Samurai_Tier_1"] = [[技巧]]
LANGUAGE["Perk_Title_samurai_focus_slash"] = [[居合斬]]
LANGUAGE["Perk_samurai_focus_slash"] = [[
+1 疾步充能。
疾步中，增加 {1} 近戰傷害。]]

LANGUAGE["Perk_Title_samurai_flesh_bloom"] = [[綻放]]
LANGUAGE["Perk_samurai_flesh_bloom"] = [[
近戰傷害對範圍內敵人累積出血值。]]

LANGUAGE["Perk_Title_Samurai_Tier_2"] = [[壓倒]]
LANGUAGE["Perk_Title_samurai_demon_stomp"] = [[鬼步]]
LANGUAGE["Perk_samurai_demon_stomp"] = [[
+1 疾步充能。
使用疾步會產生衝擊波，對附近敵人造成 {1} 物理傷害。
衝擊波每擊中一個敵人就能夠提供 {2} 生命恢復。]]

LANGUAGE["Perk_Title_samurai_exsanguinate"] = [[血道]]
LANGUAGE["Perk_samurai_exsanguinate"] = [[
{1} 增加出血累計值。
在出血敵人附近時能夠恢復生命值。
免疫出血異常狀態。]]

LANGUAGE["Perk_Title_Samurai_Tier_3"] = [[精神]]
LANGUAGE["Perk_Title_samurai_foresight"] = [[見切]]
LANGUAGE["Perk_samurai_foresight"] = [[
+1 疾步充能。
獲得見切被動效果，能夠抵擋並反射一次物理傷害。
見切效果會在抵擋後消失，5 秒鐘後恢復。]]

LANGUAGE["Perk_Title_samurai_resolution"] = [[決意]]
LANGUAGE["Perk_samurai_resolution"] = [[
玩家最大負重降低至 7。
{1} 更多近戰傷害。
+3 抵擋值。]]

LANGUAGE["Perk_Title_Samurai_Tier_4"] = [[武道]]
LANGUAGE["Perk_Title_samurai_blade_dance"] = [[劍舞]]
LANGUAGE["Perk_samurai_blade_dance"] = [[
+1 疾步充能。
擊殺敵人恢復 2 疾步充能。
延長疾步帶來的無敵時間。]]

LANGUAGE["Perk_Title_samurai_demon_strike"] = [[魔刃]]
LANGUAGE["Perk_samurai_demon_strike"] = [[
{1} 提升出血累計值。
{2} 提升對出血狀態中敵人的近戰傷害。
吸收 {3} 在疾步中造成的近戰傷害為生命值。]]

-- Default Config Shop Items
-- Optional
-- Melee Items
LANGUAGE["Item_Stunstick"] = [[電擊棒]]
LANGUAGE["Item_Desc_Stunstick"] = [[
能放出電流的武器。
]]

LANGUAGE["Item_Crowbar"] = [[鐵撬]]
LANGUAGE["Item_Desc_Crowbar"] = [[
略微生鏽的鐵撬。
]]

LANGUAGE["Item_Combat Knife"] = [[戰術匕首]]
LANGUAGE["Item_Desc_Combat Knife"] = [[
可靠的匕首。
右鍵能使出威力更大的橫砍。
]]

LANGUAGE["Item_Machete"] = [[砍刀]]
LANGUAGE["Item_Desc_Bat"] = [[
大砍刀。
]]

LANGUAGE["Item_Fireaxe"] = [[消防斧]]
LANGUAGE["Item_Desc_Fireaxe"] = [[
消防用斧頭。
厚重，但是威力不小。
]]

LANGUAGE["Item_Katana"] = [[武士刀]]
LANGUAGE["Item_Desc_Katana"] = [[
忍者武士刀。
有優越的攻擊距離和劈砍速度。
]]

LANGUAGE["Item_Bat"] = [[棒球棍]]
LANGUAGE["Item_Desc_Bat"] = [[
扎實的棒球棍。
對敵人造成鈍器傷害。
]]

LANGUAGE["Item_Chainsaw"] = [[鏈鋸]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
用來砍刀大樹的工業電鋸。

長按右鍵能對敵人造成持續傷害。
]]

LANGUAGE["Item_Mjollnir"] = [[雷神之錘]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
蘊含著雷電力量的戰錘。

右鍵對武器進行充能。
充能後，下次武器攻擊命中敵人會造成範圍性雷電傷害。
]]

LANGUAGE["Item_Inferno Blade"] = [[惡魔刀鋒]]
LANGUAGE["Item_Desc_Inferno Blade"] = [[
蘊含著火焰力量的彎刀。

右鍵開啟火焰模式，使攻擊附帶範圍性火焰傷害。
火焰模式會對使用者造成持續的火焰傷害。
]]

LANGUAGE["Item_Thorn Mace"] = [[荊棘之星]]
LANGUAGE["Item_Desc_Thorn Mace"] = [[
蘊含著劇毒的錘矛。


]]

-- Pistol Items
LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
合成人標配手槍。
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Colt python magnum pistol.
Used by Black Mesa security guards.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
奧地利製造半自動手槍。
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Universelle Selbstladepistole.
德國公司 H&K 製造的半自動手槍。
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

LANGUAGE["Item_Deagle"] = [[沙漠之鷹]]
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

LANGUAGE["Item_Flare Gun"] = [[Flare Gun]]
LANGUAGE["Item_Desc_Flare Gun"] = [[
Orion Safety Flare Gun.
Ignites enemies and deals Fire damage.
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

LANGUAGE["Item_Trench Gun"] = [[Trench Gun]]
LANGUAGE["Item_Desc_Trench Gun"] = [[
Winchester Model 1200.
Shoots incendiary pellets.
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
Recognised for its high rate of fire.
]]

LANGUAGE["Item_Galil"] = [[Galil]]
LANGUAGE["Item_Desc_Galil"] = [[
Galil ACE 22.
Developed and originally manufactured by IMI.
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
能對目標造成巨額的子彈傷害。
]]


LANGUAGE["Item_SSG08 Medic SR"] = [[SSG08 醫療狙擊槍]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
一把改造過的狙擊槍，能夠發射醫療針。
醫療針能夠治療隊友並且傷害敵人。
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


LANGUAGE["Item_Frag Grenade"] = [[高爆手榴彈]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
常規軍用手榴彈。
能對大片敵人造成傷害。
]]

LANGUAGE["Item_DamageResistance RPG"] = [[反抗軍 RPG]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
反抗軍粗製火箭筒。
]]

LANGUAGE["Item_M79 GL"] = [[M79 榴彈發射器]]
LANGUAGE["Item_Desc_M79 GL"] = [[
M79 榴彈發射器。
發射 40x66 毫米榴彈炮。
]]

LANGUAGE["Item_M32 GL"] = [[M32 榴彈發射器]]
LANGUAGE["Item_Desc_M32 GL"] = [[
M32 榴彈發射器。
擁有六個轉輪榴彈發射位。
發射 40x66 毫米榴彈炮。
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
火箭推進榴彈。
對敵人能造成大量的爆炸傷害。
]]

LANGUAGE["Item_SLAM"] = [[SLAM]]
LANGUAGE["Item_Desc_SLAM"] = [[
Selectable Lightweight Attack Munition.
右鍵引爆。對牆按左鍵啟動雷射引爆模式。
]]

LANGUAGE["Item_Incendiary Grenade"] = [[燃燒手榴彈]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
引爆後產生大量火焰。
火焰對敵人造成持續傷害。
]]

LANGUAGE["Item_Molotov"] = [[莫洛托夫汽油彈]]
LANGUAGE["Item_Desc_Molotov"] = [[
落地後產生大量火焰。
火焰對敵人造成持續傷害。
]]

LANGUAGE["Item_Incendiary Launcher"] = [[燃燒彈發射器]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
燃燒彈發射器。
發射炙熱的易燃榴彈，在接觸後引爆。
]]


LANGUAGE["Item_Heat Crossbow"] = [[十字弓]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
臨時製作的遠距離狙擊武器。
使用炙熱的鋼管作為彈藥。
]]

LANGUAGE["Item_Turret"] = [[步哨槍]]
LANGUAGE["Item_Desc_Turret"] = [[
合成人專用步哨槍。
能夠用來看守固定區域。
]]

LANGUAGE["Item_Rocket Turret"] = [[榴彈步哨槍]]
LANGUAGE["Item_Desc_Rocket Turret"] = [[
光圈科技實驗性步哨槍。
對敵人發射迷你榴彈。
]]

LANGUAGE["Item_Medic Grenade"] = [[醫療手榴彈]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
引爆後持續散發出醫療煙霧。
醫療煙霧能治療隊友並且對敵人造成持續傷害。
]]

LANGUAGE["Item_Throwing Knives"] = [[飛刀]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
遠距離飛刀。
扔出去的刀可以被回收。
]]

LANGUAGE["Item_Watchtower"] = [[守望塔]]
LANGUAGE["Item_Desc_Watchtower"] = [[
一個能提供補給的守望塔。
每 30 秒產生 1 個彈藥包。
（實體名稱：horde_watchtower）
]]

LANGUAGE["Item_M2 Flamethrower"] = [[M2 火焰噴射器]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
M2 火焰噴射器。
由美國陸軍化學戰爭工作局所設計的單兵攜帶及背負式火焰噴射器。
]]

LANGUAGE["Item_Medkit"] = [[醫療包]]
LANGUAGE["Item_Desc_Medkit"] = [[
自動充能的醫療包。
右鍵治療自己，左鍵治療隊友。
]]

LANGUAGE["Item_Welder"] = [[電焊]]
LANGUAGE["Item_Desc_Welder"] = [[
工程師使用的電焊槍。
能夠治療玩家的召喚物，也能對敵人造成傷害。
]]

LANGUAGE["Item_Health Vial"] = [[治療藥瓶]]
LANGUAGE["Item_Desc_Health Vial"] = [[
裝有綠色液體的藥瓶。
拾取後能直接回復生命值。
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[護甲包]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
提供 15 護甲。
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[全套護甲]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
提供 100% 護甲。
]]

LANGUAGE["Item_Watchtower MKII"] = [[守望塔 MKII]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
一個能提供補給的守望塔。
每 30 秒產生一個醫療包。
(實體名稱：horde_watchtower）: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[守望塔 MKIII]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
一個用來擊退敵人的守望塔。
每 1 秒對附近單個敵人發射電擊。
電擊造成 80 範圍傷害。
(實體名稱：horde_watchtower）: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[高斯槍]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
使用強大的電磁力產生炙熱的等離子體。
長按右鍵進行蓄力。
蓄力攻擊造成更多傷害。
蓄力時間過長會產生爆炸。
]]

LANGUAGE["Item_Spore Launcher"] = [[孢子槍]]
LANGUAGE["Item_Desc_Spore Launcher"] = [[
異星生物武器，發射溶解性的孢子。
對敵人造成毒素傷害，但是能夠治療隊友。
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1 醫療衝鋒槍]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
MP7A1 醫療改進版。

按 B 或者 放大鍵 發射醫療針。
醫療針冷卻時間為 1 秒。
]]

LANGUAGE["Item_Vector Medic PDW"] = [[Vector 醫療衝鋒槍]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
Vector 衝鋒槍，配備了先進的醫療針發射器。
有著無與倫比的射速。

按 B 或者 放大鍵 發射醫療針。
醫療針冷卻時間為 1.5 秒。
]]

LANGUAGE["Item_Double Barrel"] = [[雙管獵槍]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
雙管獵槍。
對近距離的敵人能造成大量傷害。
]]

LANGUAGE["Item_FN FAL"] = [[FN FAL]]
LANGUAGE["Item_Desc_FN FAL"] = [[
FN FAL.
A battle rifle designed by Belgian and manufactured by FN Herstal.
]]

LANGUAGE["Item_AUG HBAR"] = [[AUG HBAR]]
LANGUAGE["Item_Desc_AUG HBAR"] = [[
Steyr AUG HBAR.
A light-support machine gun variant of the AUG assault rifle.
]]

LANGUAGE["Item_Manhack"] = [[巡邏無人機]]
LANGUAGE["Item_Desc_Manhack"] = [[
會自我再生的巡邏無人機。
巡邏無人機攻擊敵人後直接死亡。
巡邏無人機對敵人造成自生生命值的傷害。
]]

LANGUAGE["Item_Vortigaunt"] = [[弗地岡]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
XEN 星球的弗地岡地外種族。
會發射長距離的範圍性雷電攻擊。
]]

LANGUAGE["Item_Combat Bot"] = [[戰鬥機器人]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
解釋可靠的戰鬥機器人。
會使用威力巨大的近距離攻擊和遠距離投擲攻擊。
]]

LANGUAGE["Item_Hivehand"] = [[蜂巢槍]]
LANGUAGE["Item_Desc_Hivehand"] = [[
XEN 星球士兵使用的生物兵器。

左鍵發射帶有追蹤功能的蜂群。
右鍵能夠快速射出無追蹤能力的蜂群。
]]

LANGUAGE["Item_Advanced Kevlar Armor"] = [[Advanced Kevlar Armor]]
LANGUAGE["Item_Desc_Advanced Kevlar Armor"] = [[
Distinguished Survivor armor.

Fills up 100% of your armor bar.
Provides 5% increased damage resistance.
]]

LANGUAGE["Item_Assault Vest"] = [[Assault Vest]]
LANGUAGE["Item_Desc_Assault Vest"] = [[
Distinguished Assault armor.

Fills up 100% of your armor bar.
Provides 8% increased Ballistic damage resistance.
]]

LANGUAGE["Item_Bulldozer Suit"] = [[Bulldozer Suit]]
LANGUAGE["Item_Desc_Bulldozer Suit"] = [[
Distinguished Heavy armor.

Fills up 125% of your armor bar.
]]

LANGUAGE["Item_Hazmat Suit"] = [[Hazmat Suit]]
LANGUAGE["Item_Desc_Hazmat Suit"] = [[
Distinguished Medic armor.

Fills up 100% of your armor bar.
Provides 8% increased Poison damage resistance.
]]

LANGUAGE["Item_Bomb Suit"] = [[Bomb Suit]]
LANGUAGE["Item_Desc_Bomb Suit"] = [[
Distinguished Demolition armor.

Fills up 100% of your armor bar.
Provides 8% increased Blast damage resistance.
]]

LANGUAGE["Item_Assassin's Cloak"] = [[Assassin's Cloak]]
LANGUAGE["Item_Desc_Assassin's Cloak"] = [[
Distinguished Ghost armor.

Fills up 100% of your armor bar.
Provides 5% increased evasion.
]]

LANGUAGE["Item_Defense Matrix"] = [[Defense Matrix]]
LANGUAGE["Item_Desc_Defense Matrix"] = [[
Distinguished Engineer armor.

Fills up 100% of your armor bar.
Provides 5% increased damage resistance.
]]

LANGUAGE["Item_Riot Armor"] = [[Riot Armor]]
LANGUAGE["Item_Desc_Riot Armor"] = [[
Distinguished Warden armor.

Fills up 100% of your armor bar.
Provides 8% increased Shock and Sonic damage resistance.
]]

LANGUAGE["Item_Molten Armor"] = [[Molten Armor]]
LANGUAGE["Item_Desc_Molten Armor"] = [[
Distinguished Cremator armor.

Fills up 100% of your armor bar.
Provides 8% increased Fire damage resistance.
]]

LANGUAGE["Item_Battle Vest"] = [[Battle Vest]]
LANGUAGE["Item_Desc_Battle Vest"] = [[
Distinguished Berserker armor.

Fills up 100% of your armor bar.
Provides 8% increased Slashing and Blunt damage resistance.
]]

-- Gadgets
LANGUAGE["Gadget_gadget_vitality_shard"] = [[生命碎片]]
LANGUAGE["Gadget_Desc_gadget_vitality_shard"] = [[
恢復 {1} 生命值。
]]

LANGUAGE["Gadget_gadget_damage_shard"] = [[傷害碎片]]
LANGUAGE["Gadget_Desc_gadget_damage_shard"] = [[
提升 {1} 全局傷害，持續 30 秒。
]]

LANGUAGE["Gadget_gadget_cleansing_shard"] = [[淨化碎片]]
LANGUAGE["Gadget_Desc_gadget_cleansing_shard"] = [[
恢復 {1} 生命值。
移除所有異常狀態。
]]

LANGUAGE["Gadget_gadget_agility_shard"] = [[敏捷碎片]]
LANGUAGE["Gadget_Desc_gadget_agility_shard"] = [[
提升 {1} 移動速度，持續 30 秒。
]]

LANGUAGE["Gadget_gadget_arctic_plating"] = [[抗凍塗層]]
LANGUAGE["Gadget_Desc_gadget_arctic_plating"] = [[
提升 {1} 寒冰傷害抗性。
]]

LANGUAGE["Gadget_gadget_blast_plating"] = [[防爆塗層]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
提升 20% 爆炸傷害抗性。
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[絕緣塗層]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
提升 20% 雷電傷害抗性。
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[抗熱塗層]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
提升 20% 火焰傷害抗性。
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[抗毒劑]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
提升 20% 毒素傷害抗性。
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[鑽石塗層]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
提升 15% 物理傷害抗性。
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[企業頭腦]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Set goals. Have a ten year plan. Invest. Wake up Early. CEO Mindset."

大幅度提升骷髏幣掉落機率。
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_vitality_booster"] = [[體力提升]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
增加 25 最大生命值。
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[傷害提升]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
提升 25% 全局傷害。
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[生命注射劑]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
恢復 25 點生命值。
]]

LANGUAGE["Gadget_gadget_cortex"] = [[皮層刺激器]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
For each enemy near you, gain 1 Adrenaline stack.
Elite enemies grant 2 stacks.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[精神統一]]
LANGUAGE["Gadget_Desc_neuro_amplifier"] = [[
「腎上腺素」提升 6% 閃避機率。
]]

LANGUAGE["Gadget_ouroboros"] = [[咬尾蛇]]
LANGUAGE["Gadget_Desc_ouroboros"] = [[
Ouroboros nervous system assistant.
Removes body regulations to increase combat capabilities.

When you have more than 50% health, you lose 1 health per second.
When you have less than 50% health, you gain 2 health per second.
For each 1% health missing, increase your damage by 0.8%.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[能量盾]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
暫時獲得額外 25 點護甲。
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[硬化注射劑]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
移動速度減緩 50%。
提升 25% 全局傷害抗性。
提升 25% 物理傷害抗性。
]]

LANGUAGE["Gadget_exoskeleton"] = [[外骨骼]]
LANGUAGE["Gadget_Desc_exoskeleton"] = [[
Using the active ability activates a short boost.

You cannot run.
Passively provides 20% increased Global damage resistance.
]]

LANGUAGE["Gadget_t_virus"] = [[T-病毒]]
LANGUAGE["Gadget_Desc_t_virus"] = [[
Converts your armor to health.
Cannot convert pass 250% health.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[活體擴散器]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
釋放脈衝治療自身周圍的玩家。
治療 20 生命。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[發射器（治癒彈）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
發射帶有治癒效果的化學藥彈。
治癒彈造成 75 範圍性毒素傷害。
治癒彈對範圍內友軍提供 25 生命恢復。
]]

LANGUAGE["Gadget_healing_beam"] = [[治療光波]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Connects a healing beam between the user and target.
If the target is an enemy, leeches health from the target.
If the target is an ally, restores health to the ally.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[光學迷彩]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
強制提供 5 秒迷彩效果。
迷彩效果期間，提升 50% 閃避機率。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[發射器（衝擊彈）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
發射能產生大量衝擊的弓箭。
弓箭造成 150 子彈傷害。
弓箭對擊中敵人造成眩暈效果。
]]

LANGUAGE["Gadget_death_mark"] = [[死亡標記]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
標記指向的敵人。
被標記的敵人遭受 15% 更多傷害。
被標記的敵人死亡時會爆炸造成傷害基於目標生命值。
標記持續 10 秒。
一次只能標記 1 個敵人。
]]

LANGUAGE["Gadget_gunslinger"] = [[神槍手]]
LANGUAGE["Gadget_Desc_gadget_gunslinger"] = [[
25% 更多手槍傷害。
25% 更多手槍爆頭傷害。
]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[近身制御]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
眩暈自身周圍的所有敵人。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[發射器（破片彈）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
發射不穩定爆破彈。
爆破彈造成 100 範圍性爆炸傷害。
爆破彈爆炸後，產生 3 個額外破片爆炸。
]]

LANGUAGE["Gadget_nitrous_propellor"] = [[氮氣彈射器]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Propells you forward and upward with a chemical explosion.
]]

LANGUAGE["Gadget_ied"] = [[應急地雷]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Drops an Improvised Explosive Device on the ground.
IED explodes when an enemy comes in range.
You have 5 IED charges.
IED recharges after detonation.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_displacer"] = [[傳送器]]
LANGUAGE["Gadget_Desc_gadget_displacer"] = [[
Instantly moves the targeted minion to your side.
]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[便攜步哨]]
LANGUAGE["Gadget_Desc_gadget_turret_pack"] = [[
Deploys a temporary turret.
Turret has 50% less health.
Turret is destroyed when duration expires.
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[E-寄生蟲]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
發射E-寄生蟲，感染擊中的目標。
E-寄生蟲享有全部的召喚物技能效果。
E-寄生蟲對感染目標造成持續傷害。
E-寄生蟲為使用者提供持續生命恢復。
被感染的目標死亡後，造成等於目標最大生命值的爆炸傷害。
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_chakra"] = [[查克拉]]
LANGUAGE["Gadget_Desc_gadget_chakra"] = [[
移除所有異常狀態。
恢復 10 生命值。
]]

LANGUAGE["Gadget_gadget_berserk_armor"] = [[狂戰盔甲]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
提升 25% 全局傷害。
提升 25% 全局傷害抗性。
提升 25% 移動速度。
]]

LANGUAGE["Gadget_gadget_flash"] = [[一閃]]
LANGUAGE["Gadget_Desc_flash"] = [[
向前快速移動，對路徑上的所有敵人造成 100 利器傷害。
提供短暫的無敵時間。
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[空中制御]]
LANGUAGE["Gadget_Desc_aerial_guard"] = [[
While in air, take 65% less Physical damage.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[血能炮]]
LANGUAGE["Gadget_Desc_hemocannon"] = [[
消耗 10 生命值，發射血漿製作的投射物。
血漿爆炸後對敵人造成 100 利器傷害並且累積出血值。
最多有 5 發充能。每 5 秒充能一次。
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[太陽能陣列]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
產生一個護甲包。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[發射器（雷電彈）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
發射能夠穿透敵人的雷電彈。
雷電彈每穿透一個敵人，造成 125 範圍性雷電傷害。
]]

LANGUAGE["Gadget_watchtower_pack"] = [[便攜守望塔]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
部署額外的守望塔。
]]

LANGUAGE["Gadget_shock_nova"] = [[雷神]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
Warden Aura rapidly generates a series of shockwaves.
Each shockwave deals 50 Lightning damage.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[易燃物]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
產生一個丙烷氣罐。
丙烷氣罐被攻擊後爆炸，造成 375 範圍性火焰傷害。
每個玩家最多保留一個產生的丙烷氣罐。
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[發射器（火焰彈）]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
發射灼熱的火焰彈。
火焰彈引燃效果範圍內所有敵人。
火焰彈基礎引燃傷害為 20。
]]

LANGUAGE["Gadget_barbeque"] = [[燒烤]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Ignited enemies killed by you drop edible gibs.
Each gib restores 5 health.
]]

-- Notifications
LANGUAGE["Notifications_Debuff_Bleeding"] = [[你陷入了出血狀態。你的生命值在慢慢流失。]]
LANGUAGE["Notifications_Debuff_Ignite"] = [[你陷入了引燃狀態。你在被火焰灼燒。]]
LANGUAGE["Notifications_Debuff_Frostbite"] = [[你陷入了霜凍狀態。你的雙腳難以行動。]]
LANGUAGE["Notifications_Debuff_Shock"] = [[你陷入了感電狀態。你的防禦力大幅降低。]]
LANGUAGE["Notifications_Debuff_Break"] = [[你陷入了毒破狀態。你的生命值被大幅減少。]]
LANGUAGE["Notifications_Debuff_Decay"] = [[你陷入了衰退狀態。你的身體無法恢復。]]
LANGUAGE["Notifications_Debuff_Necrosis"] = [[你陷入了即死狀態。你的生命即將結束。]]