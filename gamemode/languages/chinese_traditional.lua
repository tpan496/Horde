--[[
HORDE Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. {1}, %d. Keep those directly.
3. Keep translations short and concise.
4. Consistency, especially for perks.
increase vs. more: these two descriptions are DIFFERENT!
resistance vs. less damage taken: same as above.
5. Translate AS IS.
Transalted by Evilblue210
--]]

translate.AddLanguage("zh-TW", "Chinese Traditional")

LANGUAGE["Default_Font_Scale"] = 1.20

-- Game Info
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


-- Shop
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
LANGUAGE["Shop_Gadget"] = "道具"

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
LANGUAGE["Infusion"] = "變質"
LANGUAGE["Infusion_Hemo"] = "出血"
LANGUAGE["Infusion_Concussive"] = "笨重"
LANGUAGE["Infusion_Septic"] = "劇毒"
LANGUAGE["Infusion_Flaming"] = "火焰"
LANGUAGE["Infusion_Arctic"] = "冰霜"
LANGUAGE["Infusion_Galvanizing"] = "雷電"
LANGUAGE["Infusion_Quality"] = "品質"
LANGUAGE["Infusion_Impaling"] = "穿刺"
LANGUAGE["Infusion_Rejuvenating"] = "生命"
LANGUAGE["Infusion_Quicksilver"] = "水銀"
LANGUAGE["Infusion_Siphoning"] = "汲取"
LANGUAGE["Infusion_Titanium"] = "白金"
LANGUAGE["Infusion_Chrono"] = "時間"
LANGUAGE["Infusion_Ruination"] = "毀滅"

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
LANGUAGE["Gadget_Owned_Warning"] = "只能擁有 1 個道具！"
LANGUAGE["Gadget_Seconds"] = "秒"

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
複雜度：簡單

無額外特性。]]

LANGUAGE["Perk_assault_base"] = [[
突擊兵擁有出色的移動力和穩定的輸出，從而能應對任何場景。
複雜度：簡單

提升 {1} 移動速度。（每級提升 {2}，最多至 {3}）。

殺死敵人後獲得「腎上腺素」狀態。通過技能的選擇，「腎上腺素」可以進行堆疊。
「腎上腺素」提升 {4} 移動速度和輸出。]]

LANGUAGE["Perk_heavy_base"] = [[
重裝兵擁有高超的護甲防禦機制，同時能使用重武器對敵人造成火力壓制。
複雜度：簡單

每秒恢復 {1} 點護甲。
護甲回復上限為 {2}。（基礎{3} + 每級提升 {4}，最多至 {5}）。]]

LANGUAGE["Perk_medic_base"] = [[
醫療兵擁有強大的生命恢復能力，同時能為隊友提供治療以及各種增益效果。
複雜度：中等

提升 {1} 治療量。（每級提升 {2}，最多至 {3}）。

每秒恢復 {4} 生命值。]]

LANGUAGE["Perk_demolition_base"] = [[
爆破兵擁有強大的範圍性輸出。根據技能的選擇，爆破兵也能提供超群的單體輸出能力。
複雜度：中等

提升 {1} 爆炸傷害抗性。（基礎 {2} + 每級提升 {3}，最多至 {4}）。

在沒有高爆手榴彈的前提下，每 {5} 秒獲得 {6} 個高爆手榴彈。]]

LANGUAGE["Perk_ghost_base"] = [[
幻影是一個圍繞著精準度和「迷彩」機制的職業。使用恰當的話，幻影可以提供無以匹敵的單體輸出。
複雜度：困難

{1} 更多爆頭傷害。（每級提升 {2}，最多至 {3}）。

蹲下以啟動「迷彩」狀態，提供 {4} 閃避。
攻擊、奔跑會取消「迷彩」狀態。]]

LANGUAGE["Perk_engineer_base"] = [[
工程師是一個圍繞著召喚物的職業。召喚物能有效地進行區域性防守並且為隊友提供掩護。
複雜度：中等

提升 {1} 召喚物傷害。（每級提升 {2}，最多至 {3}）。

步哨擁有 {4} 基礎生命值和 {5} 基礎傷害。]]

LANGUAGE["Perk_berserker_base"] = [[
狂戰士是近距離格鬥專家。
複雜度：困難

提升 {1} 所有傷害抗性。（每級提升 {2}，最多至 {3}）。
提升 {4} 近戰傷害。（每級提升 {5}，最多至 {6}）。

空中格擋：跳躍中減少 {7} 受到的物理傷害。]]

LANGUAGE["Perk_warden_base"] = [[
守望者是是一個使用自身光環和建築來為隊友提供各種有利效果的輔助職業。
複雜度：中等

提升 {1} 「守望光環」半徑。（每級提升 {2}，最多至 {3}）。

自身以及附近的玩家會受到「守望光環」效果。
「守望光環」阻擋 {4} 傷害。]]

LANGUAGE["Perk_cremator_base"] = [[
火焰兵使用火焰傷害進行進攻和防禦。
複雜度：簡單

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
附近玩家獲得 {1} 「腎上腺素」, 最多至 {2}.
「腎上腺素」最大堆疊次數 +{3}.]]

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
+5 最大負重.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[護甲強化]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[流體裝甲]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
護甲值至少有 {1} 的前提下：
  提升 {2} 物理抗性。]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[反應裝甲]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
護甲值至少有 {1} 的前提下：
  免疫火焰，爆炸傷害。]]

LANGUAGE["Perk_Title_Heavy_Tier_4"] = [[先進科技]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[納米機器]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
提升 {1} 護甲值恢復速度.]]

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
提升 {1} 起爆點附近敵人的爆炸傷害。]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[震蕩波]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
爆炸類發射物在引爆後產生額外的衝擊波。
衝擊波造成原本爆炸傷害 {1} 的物理傷害。]]

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
對敵人造成 {2} 當前生命值的額外爆炸傷害。]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[連鎖反應]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
擊殺的敵人有 {1} 機率爆炸。
爆炸傷害為最大生命值的 {2}。]]

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
提升 {1} 利器傷害。
提升 {2} 移動速度。]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[殘暴]]
LANGUAGE["Perk_berserker_savagery"] = [[
提升 {1} 鈍器傷害。
提升 {2} 最大生命值。]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[格擋]]
LANGUAGE["Perk_Title_berserker_graceful_guard"] = [[Graceful Guard]]
LANGUAGE["Perk_berserker_graceful_guard"] = [[
空中格擋成功後：
  - 移除所有的異常狀態和異常狀態累計值。
  - 恢復 {1} 生命值。]]

LANGUAGE["Perk_Title_berserker_unwavering_guard"] = [[Unwavering Guard]]
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
光環提供 +{1} 額外基礎傷害。]]

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
LANGUAGE["Perk_cremator_entropy_shield"] = [[
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


-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[Stunstick]]
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

LANGUAGE["Item_M79 GL"] = [[M79 GL]]
LANGUAGE["Item_Desc_M79 GL"] = [[
M79 Grenade Launcher.
Shoots 40x46mm grenades the explodes on impact.
]]

LANGUAGE["Item_M32 GL"] = [[M32 GL]]
LANGUAGE["Item_Desc_M32 GL"] = [[
Milkor Multiple Grenade Launcher.
A lightweight 40mm six-shot revolver grenade launcher.
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ruchnoy Protivotankoviy Granatomyot.
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
Generates a pool of fire on impact.
Sets everything on fire within its effect.
]]

LANGUAGE["Item_Incendiary Launcher"] = [[Incendiary Launcher]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
Incendiary Grenade Launcher.
Shoots incendiary grenades the erupt into flames on impact.
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

LANGUAGE["Item_M2 Flamethrower"] = [[M2 噴火器]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
M2-2 Flamethrower.
An American man-portable backpack flamethrower.
]]


LANGUAGE["Item_Medkit"] = [[醫療包]]
LANGUAGE["Item_Desc_Medkit"] = [[
自動充能的醫療包。
右鍵治療自己，左鍵治療隊友。
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

LANGUAGE["Item_Chainsaw"] = [[電鋸]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Brrrrrrrrrrrrrrrr.

長按右鍵進行持續劈砍。
]]

LANGUAGE["Item_Mjollnir"] = [[雷神之錘]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
蘊含著雷電力量的戰錘。

右鍵對武器進行充能。
充能後，下次武器攻擊命中敵人會造成範圍性雷電傷害。
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
LANGUAGE["Gadget_gadget_blast_plating"] = [[防爆塗層]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
提升 20% 爆炸和聲波傷害抗性。
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

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Corporate Mindset]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Set goals. Have a ten year plan. Invest. Wake up Early. CEO Mindset."

Greatly increases skull tokens drop chance.
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
Shoots a projectile at the cost of 10 health.
The projectile travels for a short distance and explodes.
The explosion deals 100 Slashing damage.
Has a maximum of 5 charges.
Recharges after 5 seconds.
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