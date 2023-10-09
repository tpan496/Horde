--[[
HORDE Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. {1}, %d. Keep those directly.
3. Keep translations short and concise.
4. Consistency, especially for perks.
increase vs. more: these two descriptions are DIFFERENT!
resistance vs. less damage taken: same as above.
5. Translate AS IS.

Translator: HexStrain
--]]

translate.AddLanguage("tr", "Turkish")

LANGUAGE["Game_Ready"] = "Hazir"
LANGUAGE["Game_Not Ready"] = "Hazir Degil"
LANGUAGE["Game_Players_Ready"] = "Hazir Oyuncular"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Bir sonraki dalga %d icinde basliyor"
LANGUAGE["Game_Difficulty_NORMAL"] = "NORMAL"
LANGUAGE["Game_Difficulty_HARD"] = "ZOR"
LANGUAGE["Game_Difficulty_REALISM"] = "GERCEKCI"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "KABUS"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "KIYAMET"
LANGUAGE["Game_Enemies"] = "Dusmanlar"
LANGUAGE["Game_HintBottomReady"] = "F2 - Info/Config, F3 - Shop/Perk, F4 - Hazir"
LANGUAGE["Game_HintBottom"] = "F2 - Info/Config, F3 - Shop/Perk, V - $ Birak"
LANGUAGE["Game_Result_VICTORY"] = "ZAFER"
LANGUAGE["Game_Result_DEFEAT"] = "KAYBETTIN"
LANGUAGE["Game_Result_Change Map"] = "Map Degis"
LANGUAGE["Game_Wave"] = "Dalga"
LANGUAGE["Game_Wave_Has_Started"] = "Dalga %d basladi"
LANGUAGE["Game_Wave_Completed"] = "Dalga Tamamlandi"
LANGUAGE["Game_Remaining_Time"] = "Kalan Sure"
LANGUAGE["Game_Vote_Map"] = "Map Oyla"
LANGUAGE["Game_Game_Summary"] = "Oyun Sonucu"
LANGUAGE["Game_Most_Damage_Dealt"] = "Verilen En Cok Hasar"
LANGUAGE["Game_Damage"] = "Hasar"
LANGUAGE["Game_Most_Damage_Taken"] = "Alinan En Cok Hasar"
LANGUAGE["Game_Damage_Taken"] = "Alinan Hasar"
LANGUAGE["Game_Most_Kills"] = "En Cok Oldurme"
LANGUAGE["Game_Kills"] = "Oldurmeler"
LANGUAGE["Game_Elite_Killer"] = "Seckin Oldurucu"
LANGUAGE["Game_Elite_Kills"] = "Seckin Oldurmeler"
LANGUAGE["Game_SharpShooter"] = "KeskinNisanci"
LANGUAGE["Game_Headshots"] = "Kafadan vurus"
LANGUAGE["Game_Most_Heal"] = "Takım şifacı"
LANGUAGE["Game_Healed"] = "Iyilestin"
LANGUAGE["Game_Healed_You"] = "seni iyilestirdi"


-- Ranks
LANGUAGE["Rank_Novice"] = "Acemi"
LANGUAGE["Rank_Amateur"] = "Amator"
LANGUAGE["Rank_Skilled"] = "Yetenekli"
LANGUAGE["Rank_Professional"] = "Profesyonel"
LANGUAGE["Rank_Expert"] = "Uzman"
LANGUAGE["Rank_Champion"] = "Sampiyon"
LANGUAGE["Rank_Master"] = "Usta"
LANGUAGE["Rank_Not_Met"] = "Rank Gereksinimleri Karsilanmadi"


-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "Sinif"
LANGUAGE["Shop_Cash"] = "Nakit"
LANGUAGE["Shop_Weight"] = "Agirlik"
LANGUAGE["Shop_Melee"] = "Yakin Dovus"
LANGUAGE["Shop_Pistol"] = "Tabanca"
LANGUAGE["Shop_Shotgun"] = "Pompali"
LANGUAGE["Shop_SMG"] = "SMG"
LANGUAGE["Shop_Rifle"] = "Tufek"
LANGUAGE["Shop_MG"] = "MG"
LANGUAGE["Shop_Explosive"] = "Patlayici"
LANGUAGE["Shop_Special"] = "Ozel"
LANGUAGE["Shop_Equipment"] = "Ekipman"
LANGUAGE["Shop_Attachment"] = "Silah eklentileri"
LANGUAGE["Shop_Gadget"] = "Aletler"

-- Attachments
LANGUAGE["Shop_Optic"] = "Durbun"
LANGUAGE["Shop_Underbarrel"] = "Namlu alti"
LANGUAGE["Shop_Tactical"] = "Taktiksel"
LANGUAGE["Shop_Barrel"] = "Namlu"
LANGUAGE["Shop_Muzzle"] = "Agizlik"
LANGUAGE["Shop_Magazine"] = "Sarjor"
LANGUAGE["Shop_Stock"] = "Dipcik"
LANGUAGE["Shop_Ammo Type"] = "Mermi Turu"
LANGUAGE["Shop_Perk"] = "Perk"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "Sinif/Perks"
LANGUAGE["Shop_Select_Class"] = "Sinif Sec (Esyalarin Kaldirilacak)"
LANGUAGE["Shop_Show_Perks"] = "Sinif Perklerini Goster"
LANGUAGE["Shop_Hide_Perks"] = "Sinif Perklerini Gizle"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Dalga %d'den sonra acilir"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Cephane Al"
LANGUAGE["Shop_Sell_For"] = "Bu kadara sat"
LANGUAGE["Shop_Sell_All_For"] = "Hepsini bu kadara sat"
LANGUAGE["Shop_Buy_Item"] = "Esya satin al"
LANGUAGE["Shop_OWNED"] = "SAHIP"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Ikinci Mermi Satin al"
LANGUAGE["Shop_Primary_Ammo"] = "Ana Mermi"
LANGUAGE["Shop_Secondary_Ammo"] = "Ikinci Mermi"


-- Classes
LANGUAGE["Class_Survivor"] = "Hayatta Kalan"
LANGUAGE["Class_Assault"] = "Hucum"
LANGUAGE["Class_Heavy"] = "Agir"
LANGUAGE["Class_Medic"] = "Doktor"
LANGUAGE["Class_Demolition"] = "Yikim"
LANGUAGE["Class_Ghost"] = "Hayalet"
LANGUAGE["Class_Engineer"] = "Muhendis"
LANGUAGE["Class_Berserker"] = "Vahsi Savasci"
LANGUAGE["Class_Warden"] = "Gardiyan"
LANGUAGE["Class_Cremator"] = "Kremator"

-- Gadgets
LANGUAGE["Gadget_Activation"] = "T basarak aktif et."
LANGUAGE["Gadget_Cooldown"] = "Bekleme Suresi"
LANGUAGE["Gadget_Duration"] = "Sure"
LANGUAGE["Gadget_Owned_Warning"] = "Sadece 1 alet SAHIP olabilirsin!"
LANGUAGE["Gadget_Seconds"] = "saniyeler"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Sinirli ve ozel silahlar disinda tum silahlara erisimi vardir.
Silah eklentilerine sinirli erisim.]]

LANGUAGE["Class_Description_Assault"] = [[
Taaruz tufeklerine tam erisimi vardir.]]

LANGUAGE["Class_Description_Heavy"] = [[
Agir makineli ve hafif makineli tufeklere erisimi vardir.]]

LANGUAGE["Class_Description_Medic"] = [[
Cogu hafif silaha ve medikal ekipmanlara erisimi vardir.]]

LANGUAGE["Class_Description_Demolition"] = [[
Patlayici silahlara tam erisimi vardir.]]

LANGUAGE["Class_Description_Ghost"] = [[
Tum nisanci tufeklerine ve bazi hafif makinelilere erisimi vardir.
Susturuculara ve sniper durbunlerine erisimi vardir.]]

LANGUAGE["Class_Description_Engineer"] = [[
Ozel silahlara ve ekipmanlara erisimi vardir.]]

LANGUAGE["Class_Description_Berserker"] = [[
Sadece melee silahlara erisimi vardir.]]

LANGUAGE["Class_Description_Warden"] = [[
Pompalilara ve watchtowerlara tam erisimi vardir. (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Atesli silahlara erisimi vardir.]]
