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

translate.AddLanguage("en", "English")

-- Game Info
LANGUAGE["Game_Ready"] = "Ready"
LANGUAGE["Game_Not Ready"] = "Not Ready"
LANGUAGE["Game_Players_Ready_X"] = "Players Ready: %s"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Next wave starts in %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "NORMAL"
LANGUAGE["Game_Difficulty_HARD"] = "HARD"
LANGUAGE["Game_Difficulty_REALISM"] = "REALISM"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "NIGHTMARE"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "APOCALYPSE"
LANGUAGE["Game_Enemies"] = "Enemies"
LANGUAGE["Game_HintBottomReady"] = "F2 - Info/Config, F3 - Shop/Perk, F4 - Ready"
LANGUAGE["Game_HintBottom"] = "F2 - Info/Config, F3 - Shop/Perk, V - Drop $"
LANGUAGE["Game_Result_VICTORY"] = "VICTORY"
LANGUAGE["Game_Result_DEFEAT"] = "DEFEAT"
LANGUAGE["Game_Result_Change Map"] = "Change Map"
LANGUAGE["Game_Wave_Has_Started"] = "Wave %d has started!"
LANGUAGE["Game_Wave_Completed"] = "Wave Completed!"
LANGUAGE["Game_Remaining_Time_X"] = "Remaining Time: %s"
LANGUAGE["Game_Vote_Map"] = "Vote Map"
LANGUAGE["Game_Game_Summary"] = "Game Summary"
LANGUAGE["Game_Most_Damage_Dealt"] = "Most Damage Dealt"
LANGUAGE["Game_X_Damage"] = "%s Damage"
LANGUAGE["Game_Most_Damage_Taken"] = "Most Damage Taken"
LANGUAGE["Game_X_Damage_Taken"] = "%s Damage Taken"
LANGUAGE["Game_Most_Kills"] = "Most Kills"
LANGUAGE["Game_X_Kills"] = "%s Kills"
LANGUAGE["Game_Elite_Killer"] = "Elite Killer"
LANGUAGE["Game_X_Elite_Kills"] = "%s Elite Kills"
LANGUAGE["Game_SharpShooter"] = "SharpShooter"
LANGUAGE["Game_X_Headshots"] = "%s Headshots"
LANGUAGE["Game_Most_Heal"] = "Team Healer"
LANGUAGE["Game_X_Healed"] = "%s Healed"
LANGUAGE["Game_X_Healed_You"] = "%s healed you."
LANGUAGE["Game_Most_Valuable_Player"] = "MVP"
LANGUAGE["Game_X_MVP_Kills_X_MVP_Damage"] = "%s Kills, %s Damage (%s%)"
LANGUAGE["Game_Tip_X"] = "Tip: %s"
LANGUAGE["Game_Spectating"] = "Spectating"
LANGUAGE["Game_Wave_Status_Boss"] = "|%s|:%s  BOSS"
LANGUAGE["Game_Wave_Status_Regular"] = "|%s|: %s  Enemies: %s"
LANGUAGE["Game_Result_Summary_Panel"] = "%s! %s - %s"
LANGUAGE["Game_Result_Wave"] = "%s! Wave: %s"


-- Ranks
LANGUAGE["Rank_Novice"] = "Novice"
LANGUAGE["Rank_Amateur"] = "Amateur"
LANGUAGE["Rank_Skilled"] = "Skilled"
LANGUAGE["Rank_Professional"] = "Professional"
LANGUAGE["Rank_Expert"] = "Expert"
LANGUAGE["Rank_Champion"] = "Champion"
LANGUAGE["Rank_Master"] = "Master"
LANGUAGE["Rank_Not_Met"] = "Rank Requirement(s) Not Met"


-- Scoreboard
LANGUAGE["Scoreboard Info Name"] = "Name"
LANGUAGE["Scoreboard Info Class"] = "Class"
LANGUAGE["Scoreboard Info Gadget"] = "Gadget"
LANGUAGE["Scoreboard Info Money"] = "Money"
LANGUAGE["Scoreboard Info Kill"] = "Kill"
LANGUAGE["Scoreboard Info Death"] = "Death"
LANGUAGE["Scoreboard Info Ping"] = "Ping"
LANGUAGE["Scoreboard Map Info"] = "Horde - %s - %s"


-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "Class"
LANGUAGE["Shop_Cash"] = "Cash"
LANGUAGE["Shop_Weight"] = "Weight"
LANGUAGE["Shop_Melee"] = "Melee"
LANGUAGE["Shop_Pistol"] = "Pistol"
LANGUAGE["Shop_Shotgun"] = "Shotgun"
LANGUAGE["Shop_SMG"] = "SMG"
LANGUAGE["Shop_Rifle"] = "Rifle"
LANGUAGE["Shop_MG"] = "MG"
LANGUAGE["Shop_Explosive"] = "Explosive"
LANGUAGE["Shop_Special"] = "Special"
LANGUAGE["Shop_Equipment"] = "Equipment"
LANGUAGE["Shop_Attachment"] = "Attachment"
LANGUAGE["Shop_Gadget"] = "Gadget"

-- Attachments
LANGUAGE["Shop_Optic"] = "Optic"
LANGUAGE["Shop_Underbarrel"] = "Underbarrel"
LANGUAGE["Shop_Tactical"] = "Tactical"
LANGUAGE["Shop_Barrel"] = "Barrel"
LANGUAGE["Shop_Muzzle"] = "Muzzle"
LANGUAGE["Shop_Magazine"] = "Magazine"
LANGUAGE["Shop_Stock"] = "Stock"
LANGUAGE["Shop_Ammo Type"] = "Ammo Type"
LANGUAGE["Shop_Perk"] = "Perk"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "Class/Perks"
LANGUAGE["Shop_Select_Class"] = "Select Class (Your Items Will Be Removed)"
LANGUAGE["Shop_Show_Perks"] = "Show Class Perks"
LANGUAGE["Shop_Hide_Perks"] = "Hide Class Perks"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Unlocks After Wave %d"
LANGUAGE["Shop_Buy_Ammo_Clip_One"] = "Buy Ammo Clip x 1 (%s$)"
LANGUAGE["Shop_Buy_Ammo_Clip_Ten"] = "Buy Ammo Clip x 10 (%s$)"
LANGUAGE["Shop_Sell_For"] = "Sell For %s$"
LANGUAGE["Shop_Sell_All_For"] = "Sell All For %s$"
LANGUAGE["Shop_Buy_Item"] = "Buy Item"
LANGUAGE["Shop_Buy_Item_Limit"] = "Buy Item %s/%s"
LANGUAGE["Shop_OWNED"] = "OWNED"
LANGUAGE["Shop_Ownedd"] = "Owned"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Buy Secondary Ammo"
LANGUAGE["Shop_Primary_Ammo"] = "Primary Ammo"
LANGUAGE["Shop_Secondary_Ammo"] = "Secondary Ammo"
LANGUAGE["Shop_Client_Dead"] = "You are dead."
LANGUAGE["Shop_Not_Enough_Cash_Or_Carrying_Many"] = "Not Enough Money or Carrying Capacity!"
LANGUAGE["Shop_Weapon_Damage_Type"] = "Damage Type: "
LANGUAGE["Shop_No_Infusion_Selected"] = "No infusion selected."
LANGUAGE["Shop_Weapon_Infusion_None"] = "Infusion: None"
LANGUAGE["Shop_Weapon_Infusion_X"] = "Infusion: %s"
LANGUAGE["Shop_Apply_Weapon_X_Infusion_To_Weapon"] = "Apply %s infusion to %s (%d$)"
LANGUAGE["Shop_Weapon_INFUSED"] = "INFUSED"
LANGUAGE["Shop_Weapon_Infusedd"] = "Infused"
LANGUAGE["Shop_Weapon_Remove_Infusion"] = "Remove Infusion"
LANGUAGE["Shop_Not_Enough_Money_For_Infusion"] = "Not enough money (Need %s$)"
LANGUAGE["Shop_Change_Subclass"] = "Change Subclass"
LANGUAGE["Shop_Change_Subclass_Confirmation_Dialogue"] = "Change Subclass?"
LANGUAGE["Shop_Change_Subclass_Confirmation_Dialogue_Title"] = "Change Subclass"
LANGUAGE["Shop_Confirmation_Dialogue_Yes"] = "Yes"
LANGUAGE["Shop_Confirmation_Dialogue_No"] = "No"
LANGUAGE["Shop_Unlock_Subclass_Confirmation_Dialogue"] = "Unlock?"
LANGUAGE["Shop_Unlock_Subclass_Confirmation_Dialogue_Title"] = "Unlock Subclass"
LANGUAGE["Shop_Change_Class_Confirmation_Dialogue"] = "Changing class will remove all your items!"
LANGUAGE["Shop_Change_Class_Confirmation_Dialogue_Title"] = "Change Class"
LANGUAGE["Shop_Perk_No_Name"] = "Unnamed Perk"
LANGUAGE["Shop_Subclass_No_Name"] = "Unnamed Subclass"
LANGUAGE["Shop_Sell_Item_Confirmation_Dialogue"] = "Sell Item?!"
LANGUAGE["Shop_Sell_Item_Confirmation_Dialogue_Title"] = "Sell"

-- Main Menu
LANGUAGE["Main_Menu_Category_Stats"] = "Stats"
LANGUAGE["Main_Menu_Category_Achievements"] = "Achievements"
LANGUAGE["Main_Menu_Category_Mechanics"] = "Mechanics"

LANGUAGE["Stats_Menu_Basic"] = "Basic"
LANGUAGE["Stats_Menu_Speed"] = "Speed:"
LANGUAGE["Stats_Menu_Health"] = "Health:"
LANGUAGE["Stats_Menu_Armor"] = "Armor:"
LANGUAGE["Stats_Menu_Evasion"] = "Evasion:"
LANGUAGE["Stats_Menu_Block"] = "Block:"
LANGUAGE["Stats_Menu_Perks"] = "Perks"
LANGUAGE["Stats_Menu_Physical_Resistances"] = "Physical Resistances"
LANGUAGE["Stats_Menu_Bullet_Resistance"] = "Ballistic Resistance:"
LANGUAGE["Stats_Menu_Knife_Resistance"] = "Slash Resistance:"
LANGUAGE["Stats_Menu_Crowbar_Resistance"] = "Blunt Resistance:"
LANGUAGE["Stats_Menu_Environment_Resistance"] = "Other:"
LANGUAGE["Stats_Menu_Special_Resistances"] = "Special Resistances"
LANGUAGE["Stats_Menu_Fire_Resistance"] = "Fire Resistance:"
LANGUAGE["Stats_Menu_Cold_Resistance"] = "Cold Resistance:"
LANGUAGE["Stats_Menu_Lightning_Resistance"] = "Lightning Resistance:"
LANGUAGE["Stats_Menu_Poison_Resistance"] = "Poison Resistance:"
LANGUAGE["Stats_Menu_Explode_Resistance"] = "Blast Resistance:"
LANGUAGE["Stats_Menu_Status_Effects"] = "Status Effects"
LANGUAGE["Stats_Menu_Bleeding_Immunity"] = "Bleeding Immunity:"
LANGUAGE["Stats_Menu_Fire_Immunity"] = "Ignite Immunity:"
LANGUAGE["Stats_Menu_Frost_Immunity"] = "Frostbite Immunity:"
LANGUAGE["Stats_Menu_Shock_Immunity"] = "Shock Immunity:"
LANGUAGE["Stats_Menu_Armor_Break_Immunity"] = "Break Immunity:"
--LANGUAGE["Stats_Menu_Sanity_Immunity"] = "Psychosis Immunity:"
LANGUAGE["Stats_Menu_Status_Effect_Immunity_NO"] = "NO"
LANGUAGE["Stats_Menu_Status_Effect_Immunity_YES"] = "YES"

LANGUAGE["Achievements_Menu_Info"] = 'Complete maps on 10 waves to earn achievements!'
LANGUAGE["Achievements_Menu_Info_Text"] = [[
        *Notes: Achievements are disabled in sandbox mode.
        
        To achieve the special Horde Completion achievement, you need:
          - Default Config Enabled
          - Default Settings:
            - Base Start Money <= 1000
            - Base Round bonus <= 500
            - Base Walk Speed <= 180
            - Base Run Speed <= 220]]
LANGUAGE["Achievement_X_Map_X_Completion_Title"] = "%s: %s"
LANGUAGE["Achievement_Completion_Title_Normal Completion"] = "Normal Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on NORMAL difficulty."] = "Complete 10 waves on NORMAL difficulty."
LANGUAGE["Achievement_Completion_Title_Hard Completion"] = "Hard Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on HARD difficulty."] = "Complete 10 waves on HARD difficulty."
LANGUAGE["Achievement_Completion_Title_Realism Completion"] = "Realism Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on REALISM difficulty."] = "Complete 10 waves on REALISM difficulty."
LANGUAGE["Achievement_Completion_Title_Nightmare Completion"] = "Nightmare Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on NIGHTMARE difficulty."] = "Complete 10 waves on NIGHTMARE difficulty."
LANGUAGE["Achievement_Completion_Title_Apocalypse Completion"] = "Apocalypse Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on APOCALYPSE difficulty."] = "Complete 10 waves on APOCALYPSE difficulty."
LANGUAGE["Achievement_Completion_Title_Coop Completion"] = "Coop Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves with at least 4 players."] = "Complete 10 waves with at least 4 players."
LANGUAGE["Achievement_Completion_Title_Horde Completion"] = "Horde Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on NIGHTMARE difficulty with default config and settings."] = "Complete 10 waves on NIGHTMARE difficulty with default config and settings."
LANGUAGE["Achievement_Completion_Title_Hardcore Completion"] = "Hardcore Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on APOCALYPSE difficulty with default config and settings."] = "Complete 10 waves on APOCALYPSE difficulty with default config and settings."
LANGUAGE["Achievement_Completion_Title_Coop Horde Completion"] = "Coop Horde Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on NIGHTMARE difficulty with at least 4 players, default config and settings."] = "Complete 10 waves on NIGHTMARE difficulty with at least 4 players, default config and settings."
LANGUAGE["Achievement_Completion_Title_Hardcore Coop Completion"] = "Hardcore Coop Completion"
LANGUAGE["Achievement_Completion_Complete 10 waves on APOCALYPSE difficulty with at least 4 players, default config and settings."] = "Complete 10 waves on APOCALYPSE difficulty with at least 4 players, default config and settings."
LANGUAGE["Achievement_Completion_Title_Endless Wave 20"] = "Endless Wave 20"
LANGUAGE["Achievement_Completion_Complete 20 waves on Endless mode."] = "Complete 20 waves on Endless mode."
LANGUAGE["Achievement_Completion_Title_Endless Wave 30"] = "Endless Wave 30"
LANGUAGE["Achievement_Completion_Complete 30 waves on Endless mode."] = "Complete 30 waves on Endless mode."

LANGUAGE["Mechanics_Subcategory_Latest_Update"] = "Latest Update"
LANGUAGE["Mechanics_Subcategory_Damage_Types"] = "Damage Types"
LANGUAGE["Mechanics_Subcategory_Debuff_Status_Effects"] = "Debuff Status Effects"
LANGUAGE["Mechanics_Subcategory_Enemies"] = "Enemies"
LANGUAGE["Mechanics_Subcategory_Donate_Money"] = "Donate $"
LANGUAGE["Mechanics_Latest_X_Update"] = "Update %s"
LANGUAGE["Mechanics_Damage_Types"] = "Damage Types"
LANGUAGE["Mechanics_Damage_Type_Bullet"] = "Ballistic:"
LANGUAGE["Mechanics_Damage_Type_Knife"] = "Slash:"
LANGUAGE["Mechanics_Damage_Type_Crowbar"] = "Blunt:"
LANGUAGE["Mechanics_Damage_Type_Environment"] = "Other Physical Damage:"
LANGUAGE["Mechanics_Damage_Type_Fire"] = "Fire:"
LANGUAGE["Mechanics_Damage_Type_Fire_Description"] = "Increases Ignite buildup. DMG_BURN, DMG_SLOWBURN, DMG_PLASMA."
LANGUAGE["Mechanics_Damage_Type_Cold"] = "Cold:"
LANGUAGE["Mechanics_Damage_Type_Cold_Description"] = "Increases Frostbite buildup. DMG_REMOVENORAGDOLL."
LANGUAGE["Mechanics_Damage_Type_Lightning"] = "Lightning:"
LANGUAGE["Mechanics_Damage_Type_Lightning_Description"] = "Increases Shock buildup. DMG_SHOCK, DMG_ENERGYBEAM."
LANGUAGE["Mechanics_Damage_Type_Poison"] = "Poison:"
LANGUAGE["Mechanics_Damage_Type_Poison_Description"] = "Increases Break buildup. DMG_NERVEGAS, DMG_ACID, DMG_POISON, DMG_PARALYZE."
LANGUAGE["Mechanics_Damage_Type_Blast"] = "Blast:"
LANGUAGE["Mechanics_Debuff_Status"] = "Debuff Status"
LANGUAGE["Mechanics_Debuff_Status_Bleed"] = "Bleed:"
LANGUAGE["Mechanics_Debuff_Status_Bleed_Description"] = "Buildup from certain enemies and mutations. When inflicted, removes health over time."
LANGUAGE["Mechanics_Debuff_Status_Fire"] = "Ignite:"
LANGUAGE["Mechanics_Debuff_Status_Fire_Description"] = "Buildup from Fire damage. When inflicted, deals Fire damage over time."
LANGUAGE["Mechanics_Debuff_Status_Frost"] = "Frostbite:"
LANGUAGE["Mechanics_Debuff_Status_Frost_Description"] = "Buildup from Cold damage. When inflicted, reduces movement speed by 40/45/50/50/55%."
LANGUAGE["Mechanics_Debuff_Status_Shock"] = "Shock:"
LANGUAGE["Mechanics_Debuff_Status_Shock_Description"] = "Buildup from Lightning damage. When inflicted, causes player to receive 15/20/25/25/30% more damage."
LANGUAGE["Mechanics_Debuff_Status_Armor_Break"] = "Break:"
LANGUAGE["Mechanics_Debuff_Status_Armor_Break_Description"] = "Buildup from Poison damage. When inflicted, removes 80/85/90/90/95% of player health that is recovered slowly."
LANGUAGE["Mechanics_Debuff_Status_Decay"] = "Decay:"
LANGUAGE["Mechanics_Debuff_Status_Decay_Description"] = "Buildup from Decay mutation. When inflicted, prevents healing."
LANGUAGE["Mechanics_Debuff_Status_Necrosis"] = "Necrosis:"
LANGUAGE["Mechanics_Debuff_Status_Necrosis_Description"] = "Buildup from Blight enemies. When inflicted, causes instant death."
LANGUAGE["Mechanics_Regular_Enemies"] = "Regular Enemies"
LANGUAGE["Mechanics_Regular_Enemy_Walker"] = "Walker"
LANGUAGE["Mechanics_Regular_Enemy_Walker_Description"] = "Slow moving zombies that come in hordes."
LANGUAGE["Mechanics_Regular_Enemy_Sprinter"] = "Sprinter"
LANGUAGE["Mechanics_Regular_Enemy_Sprinter_Description"] = "Zombies with moderate speed that come in hordes."
LANGUAGE["Mechanics_Regular_Enemy_Clawler"] = "Crawler"
LANGUAGE["Mechanics_Regular_Enemy_Clawler_Description"] = "Zombies with fast speed that come in hordes that are easy to dispose of."
LANGUAGE["Mechanics_Regular_Enemy_Fast_Poison_Zombie_Zombine"] = "Fast Zombie/Poison Zombie/Zombine"
LANGUAGE["Mechanics_Regular_Enemy_Fast_Poison_Zombie_Zombine_Description"] = "Zombies that roam around City-17."
LANGUAGE["Mechanics_Regular_Enemy_Charred_Zombine"] = "Charred Zombine"
LANGUAGE["Mechanics_Regular_Enemy_Charred_Zombine_Description"] = "Zombine convered in flames that are more suicidal."
LANGUAGE["Mechanics_Elite_Enemies"] = "Elite Enemies"
LANGUAGE["Mechanics_Elite_Enemy_Exploder"] = "Exploder"
LANGUAGE["Mechanics_Elite_Enemy_Exploder_Description"] = "Explodes on death, dealing Poison damage. Does not explode when decapitated. Weak to headshots."
LANGUAGE["Mechanics_Elite_Enemy_Vomitter"] = "Vomitter"
LANGUAGE["Mechanics_Elite_Enemy_Vomitter_Description"] = "Ranged attackers that spits flesh at enemies. Inflicts Bleeding."
LANGUAGE["Mechanics_Elite_Enemy_Scorcher"] = "Scorcher"
LANGUAGE["Mechanics_Elite_Enemy_Scorcher_Description"] = "Vomitters covered in flames. Spits burning flesh that deal Fire damage."
LANGUAGE["Mechanics_Elite_Enemy_Screecher"] = "Screecher"
LANGUAGE["Mechanics_Elite_Enemy_Screecher_Description"] = "Emits screaming shockwaves when approached. Deals Lightning damage."
LANGUAGE["Mechanics_Elite_Enemy_Blight"] = "Blight"
LANGUAGE["Mechanics_Elite_Enemy_Blight_Description"] = "Explodes on death or when shot in the torso, inflicting Necrosis status. Weak to headshots."
LANGUAGE["Mechanics_Elite_Enemy_Weeper"] = "Weeper"
LANGUAGE["Mechanics_Elite_Enemy_Weeper_Description"] = "Emits growling shockwaves when approached. Deals Cold damage."
LANGUAGE["Mechanics_Elite_Enemy_Hulk"] = "Hulk"
LANGUAGE["Mechanics_Elite_Enemy_Hulk_Description"] = "Extremely dangerous enemy with high health. Rages when health drops below 50%."
LANGUAGE["Mechanics_Elite_Enemy_Yeti"] = "Yeti"
LANGUAGE["Mechanics_Elite_Enemy_Yeti_Description"] = "Hulks that are experimented with dangerous mutations."
LANGUAGE["Mechanics_Elite_Enemy_Lesion"] = "Lesion"
LANGUAGE["Mechanics_Elite_Enemy_Lesion_Description"] = "Extremely dangerous enemy with high health and agility. Rages periodically or when provoked."
LANGUAGE["Mechanics_Bosses"] = "Bosses"
LANGUAGE["Mechanics_Boss_Alpha_Gonome"] = "Alpha Gonome"
LANGUAGE["Mechanics_Boss_Alpha_Gonome_Description1"] = "An aged gonome that gained increased endurance and power."
LANGUAGE["Mechanics_Boss_Alpha_Gonome_Description2"] = "Corruption Aura: Inflicts Bleeding to players nearby."
LANGUAGE["Mechanics_Boss_Alpha_Gonome_Description3"] = "Claw Attack: Deals Slashing damage. Inflicts Bleeding."
LANGUAGE["Mechanics_Boss_Alpha_Gonome_Description4"] = "Acid Throw: Ranged attack that deals Poison damage."
LANGUAGE["Mechanics_Boss_Alpha_Gonome_Description5"] = "Frenzy (Phase 2): Passively increases movement speed and action speed."
LANGUAGE["Mechanics_Boss_Gamma_Gonome"] = "Gamma Gonome"
LANGUAGE["Mechanics_Boss_Gamma_Gonome_Description1"] = "A gonome infused with cryo-engine that provides minor camouflage."
LANGUAGE["Mechanics_Boss_Gamma_Gonome_Description2"] = "Claw Attack: Deals Slashing damage. Inflicts Frostbite."
LANGUAGE["Mechanics_Boss_Gamma_Gonome_Description3"] = "Icicle Throw: Ranged attack that deals Cold damage."
LANGUAGE["Mechanics_Boss_Gamma_Gonome_Description4"] = "Icestorm (Phase 2): Creates a large icestorm near itself, dealing massive Cold damage to nearby units."
LANGUAGE["Mechanics_Boss_Wallace_Breen"] = "Subject: Wallace Breen"
LANGUAGE["Mechanics_Boss_Wallace_Breen_Description1"] = "A gonome infused with a human subject to increase brain capabilities for accuracy."
LANGUAGE["Mechanics_Boss_Wallace_Breen_Description2"] = "Claw Attack: Deals Slashing damage."
LANGUAGE["Mechanics_Boss_Wallace_Breen_Description3"] = "Particle Cannon: An accurate ranged cannon that deals massive Physical and Blast damage. Inflicts Decay."
LANGUAGE["Mechanics_Boss_Wallace_Breen_Description4"] = "Particle Cannon (Phase 2): Generates continuous explosions post detonation."
LANGUAGE["Mechanics_Boss_Wallace_Breen_Description5"] = "Shockwave: Generates a shockwave when it received certain amount of damage. Inflicts Bleeding, Shock and Decay."
LANGUAGE["Mechanics_Boss_Xen_Destroyer"] = "Xen Destroyer Unit"
LANGUAGE["Mechanics_Boss_Xen_Destroyer_Description1"] = "Experimental unit made from Xen Gargantua. Dropping heavy armor and focuses on offense capabilities."
LANGUAGE["Mechanics_Boss_Xen_Destroyer_Description2"] = "Slam Attack: Deals Blunt damage."
LANGUAGE["Mechanics_Boss_Xen_Destroyer_Description3"] = "Fumethrower: Creates streams of dark flame that deals Fire damage and inflicts Necrosis."
LANGUAGE["Mechanics_Boss_Xen_Destroyer_Description4"] = "Earthshatter: Stomps the ground and generates a huge tracing shockwave torwards the target. Deals Physical damage."
LANGUAGE["Mechanics_Boss_Xen_Destroyer_Description5"] = "Energy Blast (Phase 2): Accumulates energy over time, indicated by its red light. When full, blinds players and blasts the area with Physical damage."
LANGUAGE["Mechanics_Boss_Xen_Psychic"] = "Xen Psychic Unit"
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description1"] = "Experimental unit made from Xen Kingpin. Has enhanced psychic and physical capabilities."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description2"] = "Claw Attack: Deals Slashing damage."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description3"] = "Lightning Beam: Projects a lightning beam, dealing heavy Lightning damage in an area."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description4"] = "Lightning Beam (Phase 2): The lightning explosion leaves behind ground flames that last for a long time."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description5"] = "Lightning Orb: Creates homing lightning orbs that follow players. Explodes after delay on contact, dealing Lightning damage."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description6"] = "Melee Mode (Phase 2): Greatly increases speed and focuses on Melee attacks."
LANGUAGE["Mechanics_Boss_Xen_Psychic_Description7"] = "Psionic Shield (Phase 2): Active in Melee Mode only. When the shield is active, reduces damage taken by 50%."

-- Configuration Menu
LANGUAGE["Configuration_Menu_Title"] = "Configuration Menu"
LANGUAGE["Configuration_Menu_Item_Configuration"] = "Item Config"
LANGUAGE["Configuration_Menu_Enemy_Configuration"] = "Enemy Config"
LANGUAGE["Configuration_Menu_Class_Configuration"] = "Class Config"
LANGUAGE["Configuration_Menu_Map_Configuration"] = "Map Config"
LANGUAGE["Configuration_Menu_Player_Information"] = "Player Info"

LANGUAGE["Item_Configuration_Title"] = "Horde Item Configuration"
LANGUAGE["Enemy_Configuration_Title"] = "Horde Enemy Configuration"
LANGUAGE["Class_Configuration_Title"] = "Horde Class Configuration"
LANGUAGE["Map_Configuration_Title"] = "Horde Map Configuration"

-- Notifications
LANGUAGE["Notification_Changed_Class_To_X"] = "You changed class to %s"
LANGUAGE["Notification_X_Subclass_Changed_To_X"] = "%s subclass changed to %s"
LANGUAGE["Notification_Subclass_X_Already_Unlocked"] = "Subclass %s is already unlocked!"
LANGUAGE["Notification_You_Unlocked_X_Subclass"] = "You unlocked %s subclass."
LANGUAGE["Notification_Enemy_Config_Validation_Failed"] = "Enemy config file validation failed! Please update your file or delete it."
LANGUAGE["Notification_Item_Config_Validation_Failed"] = "Item config file validation failed! Please update your file or delete it."
LANGUAGE["Notification_You_Do_Not_Have_Access_To_This_Command"] = "You do not have access to this command."
LANGUAGE["Notification_You_Cant_Get_Ready_When_You_Are_Dead"] = "You can't get ready when you are dead!"
LANGUAGE["Notification_Shop_Has_Been_Disabled"] = "Shop has been disabled."
LANGUAGE["Notification_You_Cannot_Shop_After_A_Wave_Has_Started"] = "You cannot shop after a wave has started."
LANGUAGE["Notification_You_Cannot_Open_Config_After_A_Game_Has_Started"] = "You cannot open config after a game has started."
LANGUAGE["Notification_Command_Only_Availaable_In_Sandbox_Mode"] = "Command only available in sandbox mode."
LANGUAGE["Notification_You_Bought_X"] = "You bought %s."
LANGUAGE["Notification_You_Cant_Sell_This"] = "You can't sell this."
LANGUAGE["Notification_You_Cannot_Change_Class_After_A_Wave_Has_Started"] = "You cannot change class after a wave has started."
LANGUAGE["Notification_You_Cannot_Change_Class_More_Than_Once_Per_Wave"] = "You cannot change class more than once per wave."
LANGUAGE["Notification_Subclass_X_Is_Not_Unlocked_On_This_Server"] = "Subclass %s is not unlocked on this server."
LANGUAGE["Notification_You_Dont_Have_This_Weapon"] = "You don't have this weapon!"
LANGUAGE["Notification_You_Dealth_X_Damage_To_X"] = "You dealt %d damage to %s"
LANGUAGE["Notification_You_Dealth_X_X_Damage_To_X"] = "You dealt %d %s damage to %s"
LANGUAGE["Notification_You_Received_X_Damage_From_X"] = "You received %d damage from %s"
LANGUAGE["Notification_You_Received_X_X_Damage_From_X"] = "You received %d %s damage from %s"
LANGUAGE["Notification_Current_Enemy_List_Is_Empty"] = "Current enemy list is empty!"
LANGUAGE["Notification_Enemies_List_Is_Empty_Error"] = "Enemies list is empty. Config the enemy list or no enemies will spawn."
LANGUAGE["Notification_No_Enemy_Config_Set_For_Wave_Error"] = "No enemy config set for this wave. Falling back to previous wave settings."
LANGUAGE["Notification_Wave_Completed"] = "Wave Completed!"
LANGUAGE["Notification_Tier_X_Perks_Have_Been_Unlocked"] = "Tier %s perks have been unlocked!"
LANGUAGE["Notification_Map_Has_No_Navmesh"] = "Map has no info nodes! NPCs will not spawn."
LANGUAGE["Notification_All_Players_Are_Dead"] = "All players are dead!"
LANGUAGE["Notification_All_Players_Wants_To_Change_Map"] = "All players want to change map! Initiating map vote..."
LANGUAGE["Notification_X_Wants_To_Change_Map_X_Players"] = "%s wants to change the map. (%s/%s)"
LANGUAGE["Notification_You_Will_Respawn_Next_Wave"] = "You will respawn next wave."
LANGUAGE["Notification_You_Are_Dead_You_Will_Respawn_Next_Wave"] = "You are dead. You will respawn next wave."
LANGUAGE["Notification_HORDE.Status_Bleeding"] = "You are inflicted by Bleeding.\nYour health is removed over time."
LANGUAGE["Notification_HORDE.Status_Ignite"] = "You are inflicted by Ignite.\nYou take Fire damage over time."
LANGUAGE["Notification_HORDE.Status_Frostbite"] = "You are inflicted by Frostbite.\nYour movement speed is reduced."
LANGUAGE["Notification_HORDE.Status_Shock"] = "You are inflicted by Shock.\nYou take increased damage from all sources."
LANGUAGE["Notification_HORDE.Status_Break"] = "You are inflicted by Break.\nYour health is reduced drastically and will recover slowly."
LANGUAGE["Notification_HORDE.Status_Decay"] = "You are inflicted by Decay.\nYou cannot heal."
LANGUAGE["Notification_HORDE.Status_Psychosis"] = "Y'ai 'ng'ngah, Yog-Sothoth h'ee - l'geb f'ai throdog uaaah."
LANGUAGE["Notification_HORDE.Status_Necrosis"] = "You are killed by Necrosis."

-- Damage Types
LANGUAGE["Damage_Type_Other Physical"] = "Other Physical"
LANGUAGE["Damage_Type_Ballistic"] = "Ballistic"
LANGUAGE["Damage_Type_Blunt"] = "Blunt"
LANGUAGE["Damage_Type_Slashing"] = "Slashing"
LANGUAGE["Damage_Type_Fire"] = "Fire"
LANGUAGE["Damage_Type_Cold"] = "Cold"
LANGUAGE["Damage_Type_Lightning"] = "Lightning"
LANGUAGE["Damage_Type_Poison"] = "Poison"
LANGUAGE["Damage_Type_Blast"] = "Blast"

-- Chat Messages
--LANGUAGE["Chat_Message_Help_Notice"] = "Use '!help' to see special commands!" -- Translations is not working for this string.
LANGUAGE["Chat_Message_Help_Ready"] = "'!ready' - Get ready"
LANGUAGE["Chat_Message_Help_Shop"] = "'!shop' - Open shop"
LANGUAGE["Chat_Message_Help_Drop"] = "'!drop' - Drop weapon"
LANGUAGE["Chat_Message_Help_Throw_Money"] = "'!throwmoney' - Drop 50$"
LANGUAGE["Chat_Message_Help_Change_Map"] = "'!rtv' -Initiate a map change vote"
LANGUAGE["Chat_Message_Game_Started"] = "Game has already started!"
LANGUAGE["Chat_Message_Stopping_Game"] = "Stopping game..."


-- Classes
LANGUAGE["Class_Survivor"] = "Survivor"
LANGUAGE["Class_Assault"] = "Assault"
LANGUAGE["Class_Heavy"] = "Heavy"
LANGUAGE["Class_Medic"] = "Medic"
LANGUAGE["Class_Demolition"] = "Demolition"
LANGUAGE["Class_Ghost"] = "Ghost"
LANGUAGE["Class_Engineer"] = "Engineer"
LANGUAGE["Class_Berserker"] = "Berserker"
LANGUAGE["Class_Warden"] = "Warden"
LANGUAGE["Class_Cremator"] = "Cremator"

-- Subclasses
LANGUAGE["Subclass_Title_Survivor"] = LANGUAGE["Class_Survivor"]
LANGUAGE["Subclass_Title_Assault"] = LANGUAGE["Class_Assault"]
LANGUAGE["Subclass_Title_Heavy"] = LANGUAGE["Class_Heavy"]
LANGUAGE["Subclass_Title_Medic"] = LANGUAGE["Class_Medic"]
LANGUAGE["Subclass_Title_Demolition"] = LANGUAGE["Class_Demolition"]
LANGUAGE["Subclass_Title_Ghost"] = LANGUAGE["Class_Ghost"]
LANGUAGE["Subclass_Title_Engineer"] = LANGUAGE["Class_Engineer"]
LANGUAGE["Subclass_Title_Berserker"] = LANGUAGE["Class_Berserker"]
LANGUAGE["Subclass_Title_Warden"] = LANGUAGE["Class_Warden"]
LANGUAGE["Subclass_Title_Cremator"] = LANGUAGE["Class_Cremator"]

-- Subclasses Extra
LANGUAGE["Subclass_Title_Psycho"] = "Psycho"
LANGUAGE["Subclass_Title_SpecOps"] = "SpecOps"
LANGUAGE["Subclass_Title_Warlock"] = "Warlock"
LANGUAGE["Subclass_Title_Gunslinger"] = "Gunslinger"
LANGUAGE["Subclass_Title_Necromancer"] = "Necromancer"
LANGUAGE["Subclass_Title_Samurai"] = "Samurai"
LANGUAGE["Subclass_Title_Artificer"] = "Artificer"

-- Disabled Subclasses Extra
LANGUAGE["Subclass_Title_Chemist"] = "Chemist"
LANGUAGE["Subclass_Title_Golem"] = "Golem"

-- Gadgets
LANGUAGE["Gadget_Activation"] = "Press T to activate."
LANGUAGE["Gadget_Cooldown"] = "Cooldown"
LANGUAGE["Gadget_Duration"] = "Duration"
LANGUAGE["Gadget_Owned_Warning"] = "Only 1 Gadget can be OWNED!"
LANGUAGE["Gadget_Seconds"] = "seconds"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Has access to all weapons except for exclusive and special weapons.
Limited access to attachments.]]

LANGUAGE["Class_Description_Assault"] = [[
Has full access to assault rifles.]]

LANGUAGE["Class_Description_Heavy"] = [[
Has full access to machine guns and high weight weapons.]]

LANGUAGE["Class_Description_Medic"] = [[
Has acesss to most light weapons and medical tools.]]

LANGUAGE["Class_Description_Demolition"] = [[
Has full access to explosive weapons.]]

LANGUAGE["Class_Description_Ghost"] = [[
Has access to sniper rifles and selected light weapons.
Has access to suppressors and sniper scopes.]]

LANGUAGE["Class_Description_Engineer"] = [[
Has access to special weapons and equipment.]]

LANGUAGE["Class_Description_Berserker"] = [[
Only has access to melee weapons.]]

LANGUAGE["Class_Description_Warden"] = [[
Has full access to shotguns and watchtowers (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Has access to heat-based weaponry.]]

-- Default Subclass Descriptions
LANGUAGE["Subclass_Description_Survivor"] = [[
Survivor main class.]]

LANGUAGE["Subclass_Description_Assault"] = [[
Assault main class.]]

LANGUAGE["Subclass_Description_Heavy"] = [[
Heavy main class.]]

LANGUAGE["Subclass_Description_Medic"] = [[
Medic main class.]]

LANGUAGE["Subclass_Description_Demolition"] = [[
Demolition main class.]]

LANGUAGE["Subclass_Description_Ghost"] =  [[
Ghost main class.]]

LANGUAGE["Subclass_Description_Engineer"] = [[
Default.
Specializes in minions.]]

LANGUAGE["Subclass_Description_Berserker"] = [[
Berserker main class.]]

LANGUAGE["Subclass_Description_Warden"] = [[
Warden main class.]]

LANGUAGE["Subclass_Description_Cremator"] = [[
Cremator main class.]]

-- Default Subclass Extra Descriptions
LANGUAGE["Subclass_Description_Psycho"] = [[
Survivor subclass.
Hybrid fighter focused on critical hits.]]

LANGUAGE["Subclass_Description_SpecOps"] = [[
Assault subclass.
Plays around a unique mode switch mechanic.]]

LANGUAGE["Subclass_Description_Warlock"] = [[
Demolition subclass.
Physical damage caster that focuses on area control.]]

LANGUAGE["Subclass_Description_Gunslinger"] = [[
Ghost subclass.
Specializes in pistols and marks.]]

LANGUAGE["Subclass_Description_Necromancer"] = [[
Engineer subclass.
Specializes in cold damage and spectre minions.]]

LANGUAGE["Subclass_Description_Necromancer"] = [[
Engineer subclass.
Specializes in cold damage and spectre minions.]]

LANGUAGE["Subclass_Description_Samurai"] = [[
Berserker subclass.
Specializes in timed strikes and Bleeding damage.]]

LANGUAGE["Subclass_Description_Artificer"] = [[
Cremator subclass.
Fire/lightning damage caster.]]

-- Default Disabled Subclasses Extra Descriptions
LANGUAGE["Subclass_Description_Chemist"] = [[
Medic subclass.
Focuses on dealing Poison damage.]]

LANGUAGE["Subclass_Description_Golem"] = [[
Heavy subclass.
A fucking meatball that punches people.]]

-- Default Base Perks
LANGUAGE["Perk_Title_Survivor Base"] = [[Survivor Base]]
LANGUAGE["Perk_survivor_base"] = [[
The Survivor class can be played into any class to fill in missing roles for the team.
Complexity: EASY

No bonus.]]

LANGUAGE["Perk_Title_Assault Base"] = [[Assault Base]]
LANGUAGE["Perk_assault_base"] = [[
The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.
Complexity: EASY

{1} increased movement speed. ({2} per level, up to {3}).

Gain Adrenaline when you kill an enemy.
Adrenaline increases damage and speed by {4}.]]

LANGUAGE["Perk_Title_Heavy Base"] = [[Heavy Base]]
LANGUAGE["Perk_heavy_base"] = [[
The Heavy class is a tank class that provides strong suppression firepower.
Complexity: EASY

Regenerate {1} armor per second.
Regenerate up to {2} armor. ({3} + {4} per level, up to {5})]]

LANGUAGE["Perk_Title_Medic Base"] = [[Medic Base]]
LANGUAGE["Perk_medic_base"] = [[
The Medic class is a durable support class that focuses on healing and buffing teammates.
Complexity: MEDIUM

Amplifies healing by {1}. ({2} per level, up to {3}).

Regenerate {4} health per second.]]

LANGUAGE["Perk_Title_Demolition Base"] = [[Demolition Base]]
LANGUAGE["Perk_demolition_base"] = [[
The Demolition class is a crowd-control class that can also provide high single target damage.
Complexity: MEDIUM

{1} increased Blast damage resistance. ({2} + {3} per level, up to {4}).

Regenerate {5} frag grenade every {6} seconds, if you do not have one.]]

LANGUAGE["Perk_Title_Ghost Base"] = [[Ghost Base]]
LANGUAGE["Perk_ghost_base"] = [[
The Ghost class is focused on taking down boss enemies using Camoflague.
Complexity: HIGH

{1} more headshot damage. ({2} per level, up to {3}).

Crouch to activate Camoflague, granting {4} evasion.
Attacking or Running REMOVES Camoflague.]]

LANGUAGE["Perk_Title_Engineer Base"] = [[Engineer Base]]
LANGUAGE["Perk_engineer_base"] = [[
The Engineer class is a minion-centered class that deals damage through minions.
Complexity: MEDIUM

{1} increased minion damage. ({2} per level, up to {3}).

Turrets have {4} base health and deals {5} base damage.]]

LANGUAGE["Perk_Title_Berserker Base"] = [[Berserker Base]]
LANGUAGE["Perk_berserker_base"] = [[
The Berserker class is a melee-centered class that can be played both offensively and defensively.
Complexity: HIGH

{1} increased Slashing and Blunt damage. ({2} per level, up to {3}).
{4} increased Global damage resistance. ({5} per level, up to {6}).

Aerial Parry: Jump to reduce Physical damage taken by {7}.]]

LANGUAGE["Perk_Title_Warden Base"] = [[Warden Base]]
LANGUAGE["Perk_warden_base"] = [[
The Warden is a support class that uses aura effects and structures to buff teammates.
Complexity: MEDIUM

{1} increased Warden Aura radius. ({2} per level, up to {3}).

Players near you are affected by Warden Aura.
Warden Aura blocks {4} damage.]]

LANGUAGE["Perk_Title_Cremator Base"] = [[Cremator Base]]
LANGUAGE["Perk_cremator_base"] = [[
The Cremator builds its offense and defense around Fire damage.
Complexity: EASY

{1} increased Fire damage resistance. ({2} + {3} per level, up to {4}).

Attacks have {5} chance to Ignite enemies.
Ignite base duration is {6} and deals damage over time based on hit damage.
Fire damage has {7} Ignite chance.]]

-- Subclass Default Base Perks
LANGUAGE["Perk_Title_Psycho Base"] = [[Psycho Base]]
LANGUAGE["Perk_psycho_base"] = [[
{1} chance to deal a Critical Hit. ({2} + {3} per level, up to {4}).
You deal 50% more damage on Critical Hit.

Press F to enter Frenzy Mode, replacing your flashlight.
Lose 1 health every 0.2 seconds in Frenzy Mode, down to 1.
{5} increased Critical Strike chance in Frenzy Mode.
{6} increased health recovery in Frenzy Mode.]]

LANGUAGE["Perk_Title_SpecOps Base"] = [[SpecOps Base]]
LANGUAGE["Perk_specops_base"] = [[
Press F to enter Tactical Mode, replacing your flashlight.
You have Nightvision during Tactical Mode.
Cannot run during Tactical Mode.
50% reduced movement speed during Tactical Mode.

{1} increased movement speed during Tactical Mode. ({2} per level, up to {3})
{1} increased headshot damage during Tactical Mode. ({2} per level, up to {3})]]

LANGUAGE["Perk_Title_Warlock Base"] = [[Warlock Base]]
LANGUAGE["Perk_warlock_base"] = [[
COMPLEXITY: HIGH

{1} increased maximum energy. ({2} per level, up to {3}).

Equipped with Astral Relic. Upgradable through shop.
LMB: Astral Pulsar (10 Energy)
Releases a homing object that attaches to enemies and deals Physical damage over time.
You can have at most 2 active Astral Pulsars.
HOLD LMB to detonate all active Astral Pulsars.

RMB: Astral Remnant (5 Energy)
Plants energy bodies that explode when enemies are nearby, dealing Physical damage.
You can plant at most 5 active Astral Remnants.
HOLD RMB to charge and refresh duration of all active Astral Remnants.]]

LANGUAGE["Perk_Title_Gunslinger Base"] = [[Gunslinger Base]]
LANGUAGE["Perk_gunslinger_base"] = [[
{1} increased Pistol damage. ({2} per level, up to {3}).

Press SHIFT+E to apply Hunter's Mark on an enemy.
Hunter's Mark lasts for 5 seconds.
You can apply 1 Hunter's Mark at a time.

Gains access to all Pistols.]]

LANGUAGE["Perk_Title_Necromancer Base"] = [[Necromancer Base]]
LANGUAGE["Perk_necromancer_base"] = [[
COMPLEXITY: MEDIUM

Inflicts Frostbite buildup by {1} of base Cold damage. ({2} + {3} per level, up to {4}).
{5} increased Cold damage resistance. ({6} per level, up to {7}).

Equipped with Void Projector. Upgradable through shop.

LMB: Void Spear (5/10/20 Energy)
Releases a projectile that deals Cold damage and applies Frostbite buildup.
HOLD LMB for different effects.

RMB: Raise Spectre (40 Energy)
Conjures a Spectre minion.
The Spectre minion deals Physical damage and applies Frostbite buildup.
HOLD RMB to recall Spectres to your side.]]

LANGUAGE["Perk_Title_Samurai Base"] = [[Samurai Base]]
LANGUAGE["Perk_samurai_base"] =
[[COMPLEXITY: HIGH
    
Inflicts Bleeding buildup by {1} of base Melee damage. ({2} + {3} per level, up to {4}).
{5} increased Global damage resistance. ({6} per level, up to {7}).

SHIFT+E to activate Quickstep.
Dashes torwards the input direction.
100% increased evasion during Quickstep.]]

LANGUAGE["Perk_Title_Artificer Base"] = [[Artificer Base]]
LANGUAGE["Perk_artificer_base"] = [[
COMPLEXITY: MEDIUM

Inflicts Shock buildup by {1} of base Lightning damage. ({2} per level, up to {3}).
{1} increased Fire and Lightning damage. ({2} per level, up to {3}).

Equipped with Solar Seal. Upgradable through shop.
LMB: Solar Orb (5/10/20 Energy)
Releases a projectile that deals splashing Fire damage.
HOLD LMB for different effects.

RMB: Solar Storm (5/10/20 Energy)
Strikes at the target, dealing Lightning damage and applies Shock buildup.
HOLD RMB for different effects.]]

-- Disabled Subclass Default Base Perks
LANGUAGE["Perk_Title_Chemist Base"] = [[Chemist Base]]
LANGUAGE["Perk_chemist_base"] = [[
Complexity: MEDIUM

Convert 100% of your Ballistic damage into Poison damage.
Inflicts Break buildup by {1} of base Poison damage. ({2} + {3} per level, up to {4}).
{4} increased Poison damage resistance. ({5} + {6} per level, up to {7}).]]

LANGUAGE["Perk_Title_Golem Base"] = [[Golem Base]]
LANGUAGE["Perk_golem_base"] = [[
{1} increased maximum health. ({2} per level, up to {3}).

Gain Hypertrophy when you kill an enemy.
Hypertrophy reduces Physical damage taken by {4}.
Hypertrophy provdes 1 health regen per second.

Equipped with Fists.

LMB: Punch (0/10 Energy)
Hold for a charged punch.

RMB: Force Shield (1 Energy per tick)
Hold to activate a force shield that negates damage taken.
Damage taken is depleted as energy instead.]]

LANGUAGE["Perk_Title_Striker Base"] = [[Striker Base]]
LANGUAGE["Perk_striker_base"] = [[
The Striker class manipulates space to its advantage.
Complexity: HIGH

{1} increased Blink distance.

SHIFT+E to activate Blink.
Teleports to the target location.
The blink range extends greatly if the target is a Watchtower.]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[Survival]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[Improvise]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[Defense]]
LANGUAGE["Perk_Title_Survivor_Tier_4"] = [[Inspired Learning]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[Maneuverability]]
LANGUAGE["Perk_Title_assault_ambush"] = [[Ambush]]
LANGUAGE["Perk_assault_ambush"] = [[
{1} increased headshot damage.]]

LANGUAGE["Perk_Title_assault_charge"] = [[Charge]]
LANGUAGE["Perk_assault_charge"] = [[
Adds {1} maximum Adrenaline stacks.
(Each Adrenaline stack increases damage and speed by {2}.)]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[Adaptability]]
LANGUAGE["Perk_Title_assault_drain"] = [[Drain]]
LANGUAGE["Perk_assault_drain"] = [[
{1} increased headshot damage when on full health.
Recover {2} health for each enemy you killed.]]

LANGUAGE["Perk_Title_assault_overclock"] = [[Overclock]]
LANGUAGE["Perk_assault_overclock"] = [[
Adds {1} maximum Adrenaline stacks.]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[Aggression]]

LANGUAGE["Perk_Title_assault_cardiac_resonance"] = [[Cardiac Resonance]]
LANGUAGE["Perk_assault_cardiac_resonance"] = [[
Every time you kill an enemy,
Players near you also gain {1} Adrenaline, up to {2}.
Adds {3} maximum Adrenaline stacks.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[Cardiac Overload]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
Adrenaline duration increased by {1}.
Adds {2} maximum Adrenaline stacks.]]

LANGUAGE["Perk_Title_Assault_Tier_4"] = [[Conditioning]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[Heightened Reflex]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
{1} increased headshot damage.
{2} increased global damage resistance on full health.]]

LANGUAGE["Perk_Title_assault_merciless_assault"] = [[Merciless Assault]]
LANGUAGE["Perk_assault_merciless_assault"] = [[
{1} chance to add 1 Adrenaline stack on headshot.
Adds {2} maximum Adrenaline stacks.]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[Suppression]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[Sticky Compound]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
Enemies you hit with Ballistic damage are Hindered.
Hindered enemies deal {1} reduced damage.]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[Crude Casing]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
Enemies you hit with Ballistic damage are Weakened.
Weakened enemies receive {1} increased damage.]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[Backup]]
LANGUAGE["Perk_Title_heavy_repair_catalyst"] = [[Repair Catalyst]]
LANGUAGE["Perk_heavy_repair_catalyst"] = [[
Adds {1} to maximum armor regeneration.]]

LANGUAGE["Perk_Title_heavy_floating_carrier"] = [[Floating Carrier]]
LANGUAGE["Perk_heavy_floating_carrier"] = [[
Adds 5 to maximum weight.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[Armor Protection]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[Liquid Armor]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
While you have at least {1} armor:
  {2} less Physical damage taken.]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[Reactive Armor]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
While you have at least {1} armor:
  Immune to Fire and Blast damage.]]

LANGUAGE["Perk_Title_Heavy_Tier_4"] = [[Technology]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[Nanomachine]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
{1} increased armor regeneration rate.]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[Ballistic Shock]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
Debuffs you apply have {1} increased effect.
Debuffs you apply have {2} increased duration.]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[Medicine]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[Antibiotics]]
LANGUAGE["Perk_medic_antibiotics"] = [[
Your healing is amplified by {1}.]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[Painkillers]]
LANGUAGE["Perk_medic_painkillers"] = [[
You can overheal player's health by {1}.]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[Bio-Engineering]]
LANGUAGE["Perk_Title_medic_berserk"] = [[Berserk]]
LANGUAGE["Perk_medic_berserk"] = [[
Players you heal have Berserk for {1} seconds.
{2} increased damage while you have Berserk.]]

LANGUAGE["Perk_Title_medic_fortify"] = [[Fortify]]
LANGUAGE["Perk_medic_fortify"] = [[
Players you heal have Fortify for {1} seconds.
{2} less damage taken while you have Fortify.]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[Enhancement]]
LANGUAGE["Perk_Title_medic_purify"] = [[Purify]]
LANGUAGE["Perk_medic_purify"] = [[
Your healing directly decreases buildup for Bleeding, Break and Stun.]]

LANGUAGE["Perk_Title_medic_haste"] = [[Haste]]
LANGUAGE["Perk_medic_haste"] = [[
Players you heal have Haste for {1} seconds.
{2} increased movement speed while you have Haste.]]

LANGUAGE["Perk_Title_Medic_Tier_4"] = [[Natural Selection]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[Cellular Implosion]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
Enemies you killed have {1} chance to generate a healing cloud.]]

LANGUAGE["Perk_Title_medic_xcele"] = [[Accelerated Healing Factor]]
LANGUAGE["Perk_medic_xcele"] = [[
Buffs you apply are {1} more effective.
Buffs you apply have {2} increased duration.]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[Grenade]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[Impact Grenade]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
{1} increased Grenade damage on impact.
Grenades explode on impact.
Impact explosions increases Stun buildup.]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[Cluster Grenade]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
Grenades and SLAMs spawn {1} mini-nades on detonation.
Mini-nades do {2} less damage.]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[Weaponry]]
LANGUAGE["Perk_Title_demolition_direct_hit"] = [[Direct Hit]]
LANGUAGE["Perk_demolition_direct_hit"] = [[
{1} increased Blast damage against enemies close to explosions.]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[Seismic Wave]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
Explosive projectiles create an extra delayed explosion.
Delayed explosion deals {1} explosion damage as Physical damage.]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[Approach]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[Fragmentation]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
{1} increased Blast damage.]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[Knockout]]
LANGUAGE["Perk_demolition_knockout"] = [[
Blast damage increases Stun buildup.
Enemies affected by Stun is paralyzed for {1} seconds.
Stun cooldown is {2} seconds.]]

LANGUAGE["Perk_Title_Demolition_Tier_4"] = [[Destruction]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[Pressurized Warhead]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
{1} increased Blast damage against elites.
Explosions deal {2} to {3} of enemies' current health as extra Blast damage.]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[Chain Reaction]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
Enemies you kill have {1} chance to explode,
dealing {2} of their max health as Blast damage.]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[Tactics]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[Headhunter]]
LANGUAGE["Perk_ghost_headhunter"] = [[
Headshot damage stacks up to 5 times.
Each stack increases 8% headshot damage.]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[Sniper]]
LANGUAGE["Perk_ghost_sniper"] = [[
25% increased Ballistic damage while crouching.]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[Reposition]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[Phase Walk]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
Running does not cancel Camoflague.
{1} increased movement speed when you have Camoflague.
Adds {2} evasion when you have Camoflague.]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[Ghost Veil]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
Attacking does not cancel Camoflague.
{1} increased walk speed when you have Camoflague.
{2} increased Ballistic damage when you have Camoflague.]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[Trajectory]]
LANGUAGE["Perk_Title_ghost_brain_snap"] = [[Brain Snap]]
LANGUAGE["Perk_ghost_brain_snap"] = [[
Headshots increases Frostbite buildup based on weapon damage.
Enemies affected by Frostbite has drastically reduced action speed for {1} seconds.
Frostbite cooldown is {2} seconds.]]

LANGUAGE["Perk_Title_ghost_kinetic_impact"] = [[Kinetic Impact]]
LANGUAGE["Perk_ghost_ghost_kinetic_impact"] = [[
Increases Ballistic damage based on distance.
Increases {1} damage for each {2} units.
Increase caps at {3}.]]

LANGUAGE["Perk_Title_Ghost_Tier_4"] = [[Disposal]]
LANGUAGE["Perk_Title_ghost_coup"] = [[Coup De Grace]]
LANGUAGE["Perk_ghost_coup"] = [[
Instantly kills enemies with less than 20% health.]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[Decapitate]]
LANGUAGE["Perk_ghost_decapitate"] = [[
When you have Camoflague:
  {1} increased Ballistic damage.
  {2} increased headshot damage against elites.]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[Craftsmanship]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[Tinkerer]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
{1} more minion health.]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[Pioneer]]
LANGUAGE["Perk_engineer_pioneer"] = [[
{1} increased minion damage.]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[Core]]
LANGUAGE["Perk_Title_engineer_fusion"] = [[Fusion]]
LANGUAGE["Perk_engineer_fusion"] = [[
Minions regenerate {1} health per second.
{2} increased minion damage while minion is on full health.]]

LANGUAGE["Perk_Title_engineer_metabolism"] = [[Metabolism]]
LANGUAGE["Perk_engineer_metabolism"] = [[
Minions leech {1} of damage dealt, up to {2} hp per hit.
{3} increased minion damage while leeching.]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[Manipulation]]
LANGUAGE["Perk_Title_engineer_antimatter_shield"] = [[Anti-Matter Shield]]
LANGUAGE["Perk_engineer_antimatter_shield"] = [[
Press Shift+E to deploy a shield on a targeted minion.
The shield absorbs damage up to {1} of the minion's health.
Shield explodes on depletion and has a cooldown of {2} seconds.]]

LANGUAGE["Perk_Title_engineer_displacer"] = [[Displacer]]
LANGUAGE["Perk_engineer_displacer"] = [[
Press SHIFT+E to teleport a targeted minion to your side.
Recover {1} of the teleported minion's health.
Displacer has a cooldown of {2} seconds.]]

LANGUAGE["Perk_Title_Engineer_Tier_4"] = [[Experimental]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[Symbiosis]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
{1} more minion health.
{2} less damage taken for each minion alive.]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[Kamikaze]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
Minions deal {1} of their max health as Blast damage on death.]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[Fundamentals]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[Breathing Technique]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
Regenerate {1} health per second.
Immune to Poison damage.]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[Bloodlust]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
Leech {1} of melee damage dealt, up to {2} hp per hit.
Immune to Bleeding.]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[Technique]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[Bushido]]
LANGUAGE["Perk_berserker_bushido"] = [[
Melee headshots increases Stun buildup.
{2} increased movement speed.]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[Savagery]]
LANGUAGE["Perk_berserker_savagery"] = [[
{1} increased Melee damage.
{2} increased maximum health.]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[Parry]]
LANGUAGE["Perk_Title_berserker_graceful_guard"] = [[Graceful Guard]]
LANGUAGE["Perk_berserker_graceful_guard"] = [[
On successful Aerial Parry:
  - Removes all debuff and debuff buildups.
  - Recover {1} health.]]

LANGUAGE["Perk_Title_berserker_unwavering_guard"] = [[Unwavering Guard]]
LANGUAGE["Perk_berserker_unwavering_guard"] = [[
On successful Aerial Parry:
  - {1} increased Physical damage for {3} seconds.
  - {2} less damage taken for {3} seconds.]]

LANGUAGE["Perk_Title_Berserker_Tier_4"] = [[Combat Arts]]
LANGUAGE["Perk_Title_berserker_phalanx"] = [[Phalanx]]
LANGUAGE["Perk_berserker_phalanx"] = [[
Gain 1 Phalanx stack every 2 seconds, up to {1}.
Each stack increases {2} Physical damage resistance and {3} melee damage.
Lose stacks when you attack.]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[Rip and Tear]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
{1} more melee damage.
Your melee attack can splash.
Splash damage is {2} of your melee damage.]]

-- Default Perks: Warden
LANGUAGE["Perk_Title_Warden_Tier_1"] = [[Sustain]]
LANGUAGE["Perk_Title_warden_bulwark"] = [[Bulwark]]
LANGUAGE["Perk_warden_bulwark"] = [[
Watchtowers generate 1 armor battery every {1} seconds.]]

LANGUAGE["Perk_Title_warden_vitality"] = [[Vitality]]
LANGUAGE["Perk_warden_vitality"] = [[
Aura provides {1} health regeneration per second.]]

LANGUAGE["Perk_Title_Warden_Tier_2"] = [[Resource Utilization]]
LANGUAGE["Perk_Title_warden_restock"] = [[Quick Restock]]
LANGUAGE["Perk_warden_restock"] = [[
Watchtowers restock cooldown decreased by {1}.]]

LANGUAGE["Perk_Title_warden_energize"] = [[Energize]]
LANGUAGE["Perk_warden_energize"] = [[
Aura adds {1} base damage to attacks.]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[Escort]]
LANGUAGE["Perk_Title_warden_rejection_pulse"] = [[Rejection Pulse]]
LANGUAGE["Perk_warden_rejection_pulse"] = [[
Watchtowers generate a shockwave every {1} seconds.
Shockwave deals {2} Lightning damage.]]

LANGUAGE["Perk_Title_warden_inoculation"] = [[Inoculation]]
LANGUAGE["Perk_warden_inoculation"] = [[
Aura reduces {1} buildups taken from Ignite, Shock and Frostbite.]]

LANGUAGE["Perk_Title_Warden_Tier_4"] = [[Coverage]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[Deus Ex Machina]]
LANGUAGE["Perk_warden_ex_machina"] = [[
Watchtowers have Warden Aura.]]

LANGUAGE["Perk_Title_warden_resonance_cascade"] = [[Resonance Cascade]]
LANGUAGE["Perk_warden_resonance_cascade"] = [[
Aura effect increased by {1}.
Aura radius increased by {2}.]]

-- Default Perks: Cremator
LANGUAGE["Perk_Title_Cremator_Tier_1"] = [[Chemicals]]
LANGUAGE["Perk_Title_cremator_methane"] = [[Methane]]
LANGUAGE["Perk_cremator_methane"] = [[
{1} increased Fire damage against Ignited enemies.]]

LANGUAGE["Perk_Title_cremator_napalm"] = [[Napalm]]
LANGUAGE["Perk_cremator_napalm"] = [[
{1} increased Ignite duration.]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[Energy Absorption]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[Positron Array]]
LANGUAGE["Perk_cremator_positron_array"] = [[
Immune to Fire damage.
Absorb {1} of Fire damage taken as health.]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[Entropy Shield]]
LANGUAGE["Perk_cremator_entropy_shield"] = [[
Gain a shield that negates damage taken from enemies.
Shield explodes on hit and recharges after {1} seconds.
Explosion deals {2} Fire damage.]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[Heat Manipulation]]
LANGUAGE["Perk_Title_cremator_hyperthermia"] = [[Hyperthermia]]
LANGUAGE["Perk_cremator_hyperthermia"] = [[
Increase Fire damage based on enemy proximity to you.
Increase caps at {1}.]]

LANGUAGE["Perk_Title_cremator_ionization"] = [[Ionization]]
LANGUAGE["Perk_cremator_ionization"] = [[
{1} increased Ignite damage.
Fire damage ignores enemy Fire resistance.]]

LANGUAGE["Perk_Title_Cremator_Tier_4"] = [[Energy Discharge]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[Firestorm]]
LANGUAGE["Perk_cremator_firestorm"] = [[
Fire damage increases Burst buildup in enemies.
Creates an explosion when Burst buildup is full.
Explosion deals {1} Blast damage.]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[Incineration]]
LANGUAGE["Perk_cremator_incineration"] = [[
{1} increased Ignite damage.]]

-- Default Subclass Perks: Psycho
LANGUAGE["Perk_Title_Psycho_Tier_1"] = [[Violence]]
LANGUAGE["Perk_Title_psycho_ferocity"] = [[Ferocity]]
LANGUAGE["Perk_psycho_ferocity"] = [[
Adds {1} Critical Hit chance.
Adds {2} Melee Critical Hit chance.]]
LANGUAGE["Perk_Title_psycho_savor"] = [[Savor]]
LANGUAGE["Perk_psycho_savor"] = [[
{1} increased Critical Hit damage.
Leech {2} of damage dealt when you land a Melee Critical Hit.
Leech caps at 10 health per hit.]]

LANGUAGE["Perk_Title_Psycho_Tier_2"] = [[Sadism]]
LANGUAGE["Perk_Title_psycho_bloodbath"] = [[Bloodbath]]
LANGUAGE["Perk_psycho_bloodbath"] = [[
Adds {1} Critical Hit chance.
Leech 1 health on Critical Hit.]]
LANGUAGE["Perk_Title_psycho_disembowel"] = [[Disembowel]]
LANGUAGE["Perk_psycho_disembowel"] = [[
{1} increased Critical Hit damage.
Melee attacks remove Nemesis mutation from enemies.]]

LANGUAGE["Perk_Title_Psycho_Tier_3"] = [[Fatality]]
LANGUAGE["Perk_Title_psycho_skewering"] = [[Skewering]]
LANGUAGE["Perk_psycho_skewering"] = [[
Enemies you hit with headshots are Skewered.
Players have +{1} Critical Hit chance when they hit Skewered enemies.]]
LANGUAGE["Perk_Title_psycho_brutality"] = [[Brutality]]
LANGUAGE["Perk_psycho_brutality"] = [[
Gain Brutality by hitting enemy with Melee attacks, up to 5 stacks.
Each Brutality stack adds {1} Critical Hit chance.
Each Brutality stack increases {2} Critical Hit damage.]]

LANGUAGE["Perk_Title_Psycho_Tier_4"] = [[Psychosis]]
LANGUAGE["Perk_Title_psycho_grudge"] = [[Grudge]]
LANGUAGE["Perk_psycho_grudge"] = [[
{1} increased Critical Hit chance per {2} health missing.
{3} increased movement speed per {4} health missing, up to {5}.]]
LANGUAGE["Perk_Title_psycho_grudge"] = [[Bestial Wrath]]
LANGUAGE["Perk_psycho_grudge"] = [[
{1} increased Critical Hit damage.
Deals splashing melee damage in Frenzy Mode.
Recover 1 health for each enemy killed in Frenzy Mode.]]

-- Default Subclass Perks: SpecOps
LANGUAGE["Perk_Title_SpecOps_Tier_1"] = [[Utility]]
LANGUAGE["Perk_Title_specops_smokescreen"] = [[Smokescreen]]
LANGUAGE["Perk_specops_smokescreen"] = [[
Press Shift+E to deploy a smokescreen.
{1} increased evasion for players affected smokescreen.
Effect lasts for {2} seconds.]]
LANGUAGE["Perk_Title_specops_flare"] = [[Flare]]
LANGUAGE["Perk_specops_flare"] = [[
Press Shift+E to deploy a flare.
Flare provides lighting and attracts enemies.
Flare lasts for 3 seconds.]]

LANGUAGE["Perk_Title_SpecOps_Tier_2"] = [[Engage]]
LANGUAGE["Perk_Title_specops_tactical_visor"] = [[Tactical Visor]]
LANGUAGE["Perk_specops_tactical_visor"] = [[
While in Tactical Mode:
  {1} increased Ballistic damage.
  {2} increased damage to limbs.]]
LANGUAGE["Perk_Title_specops_neuron_stabilizer"] = [[SpecOps Base]]
LANGUAGE["Perk_specops_neuron_stabilizer"] = [[
Press F to enter Tactical Mode, replacing your flashlight.
You have Nightvision during Tactical Mode.
Cannot run during Tactical Mode.
50% reduced movement speed during Tactical Mode.

{1} increased movement speed during Tactical Mode. ({2} per level, up to {3})
{1} increased headshot damage during Tactical Mode. ({2} per level, up to {3})]]

LANGUAGE["Perk_Title_SpecOps_Tier_3"] = [[Protection]]
LANGUAGE["Perk_Title_specops_biotic_mask"] = [[Biotic Mask]]
LANGUAGE["Perk_specops_biotic_mask"] = [[
While in Tactical Mode:
  Recover 2% health per second.
  {1} reduced Bleeding, Break and Necrosis buildups.]]
LANGUAGE["Perk_Title_specops_adaptive_coating"] = [[Adaptive Coating]]
LANGUAGE["Perk_specops_adaptive_coating"] = [[
While in Tactical Mode:
  {1} increased Global damage resistance.
  {2} reduced Fire, Cold and Lightning damage taken.]]

LANGUAGE["Perk_Title_SpecOps_Tier_4"] = [[Sunset]]
LANGUAGE["Perk_Title_specops_night_stalker"] = [[Night Stalker]]
LANGUAGE["Perk_specops_night_stalker"] = [[
While in Tactical Mode:
  {1} increased movement speed.
  {2} increased headshot damage.]]
LANGUAGE["Perk_Title_specops_peace_walker"] = [[Peace Walker]]
LANGUAGE["Perk_specops_peace_walker"] = [[
{1} reduced Smokescreen/Flare cooldown.
While in Tactical Mode:
  {2} increased Ballistic damage.]]
  
-- Default Subclass Perks: Warlock
LANGUAGE["Perk_Title_Warlock_Tier_1"] = [[Transfigure]]
LANGUAGE["Perk_Title_warlock_celestial_bond"] = [[Celestial Bond]]
LANGUAGE["Perk_warlock_celestial_bond"] = 
[[+{1} to maximum active Astral Pulsars.
Allows you to attach Astral Pulsar on targeted players.
Astral Pulsar deals area of effect damage while attached to a player.]]
LANGUAGE["Perk_Title_warlock_coalesce"] = [[Coalesce]]
LANGUAGE["Perk_warlock_coalesce"] =
[[+{1} to maximum active Astral Remnants.
Allows you to target Astral Pulsar on Astral Remnants.
Targeted Astral Remnant attaches to Astral Pulsar on contact.]]

LANGUAGE["Perk_Title_Warlock_Tier_2"] = [[Channelling]]
LANGUAGE["Perk_Title_warlock_magnetar"] = [[Magnetar]]
LANGUAGE["Perk_warlock_magnetar"] =
[[+{1} to maximum active Astral Pulsars.
Extends Astral Pulsar lifetime when it attaches to an enemy.]]
LANGUAGE["Perk_Title_warlock_nucleosynthesis"] = [[Nucleosynthesis]]
LANGUAGE["Perk_warlock_nucleosynthesis"] =
[[{1} increased maximum energy.
Recover {2} energy you used as health.]]

LANGUAGE["Perk_Title_Warlock_Tier_3"] = [[Vectorize]]
LANGUAGE["Perk_Title_warlock_gravity_vacuum"] = [[Gravity Vacuum]]
LANGUAGE["Perk_warlock_gravity_vacuum"] =
[[Unlocks Gravity Vacuum for Nether Relic ({1} energy, R button).
Attracts all active Astral Pulsars to the target.
Attracts nearby Astral Remnants to the target.]]
LANGUAGE["Perk_Title_warlock_negative_burst"] = [[Negative Burst]]
LANGUAGE["Perk_warlock_negative_burst"] =
[[Unlocks Negative Burst for Nether Relic ({1} energy, R button).
Deals Physical damage and knockback around you based on missing energy.
Recover {2} energy for each enemy killed by Negative Burst.]]

LANGUAGE["Perk_Title_Warlock_Tier_4"] = [[Annihilation]]
LANGUAGE["Perk_Title_warlock_starscourge"] = [[Starscourge]]
LANGUAGE["Perk_warlock_starscourge"] =
[[+{1} to maximum active Astral Pulsars.
Causes your first Astral Pulsar to have infinite duration.
{2} more Astral Pulsar damage while attached to elite enemies.]]
LANGUAGE["Perk_Title_warlock_dirac_sea"] = [[Dirac Sea]]
LANGUAGE["Perk_warlock_dirac_sea"] =
[[{1} increased maximum energy.
Removes explosion damage falloff for Astral Pulsar and Astral Remnants.
Charged Astral Remnants leave behind uncharged Astral Remnants on explosion.]]

-- Default Subclass Perks: Gunslinger
LANGUAGE["Perk_Title_Gunslinger_Tier_1"] = [[Precision]]
LANGUAGE["Perk_Title_gunslinger_deadeye"] = [[Deadeye]]
LANGUAGE["Perk_gunslinger_deadeye"] = [[Headshot increases Deadeye stacks up to {1} times.
Each stack increases {2} damage with Pistols.]]
LANGUAGE["Perk_Title_gunslinger_bounty_hunter"] = [[Bounty Hunter]]
LANGUAGE["Perk_gunslinger_bounty_hunter"] = [[
Enemies killed under Hunter's Mark drop extra cash.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_2"] = [[Gunfight]]
LANGUAGE["Perk_Title_gunslinger_quickdraw"] = [[Quickdraw]]
LANGUAGE["Perk_gunslinger_quickdraw"] = [[
Gain the Quickdraw status while switching weapon.
{1} increased Pistol damage and evasion during Quickdraw status.
Quickdraw effect lasts for {2} seconds.]]
LANGUAGE["Perk_Title_gunslinger_puncture"] = [[Puncture]]
LANGUAGE["Perk_gunslinger_puncture"] = [[
{1} increased Hunter's Mark range.
Enemies under Hunter's Mark take {2} increased damage.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_3"] = [[Outlaw]]
LANGUAGE["Perk_Title_gunslinger_maverick"] = [[Maverick]]
LANGUAGE["Perk_gunslinger_maverick"] = [[
While holding a Pistol weapon:
  {1} increased movement speed.
  {2} increased evasion.]]
LANGUAGE["Perk_Title_gunslinger_poach"] = [[Poach]]
LANGUAGE["Perk_gunslinger_poach"] = [[
Enemies killed under Hunter's Mark restore health to nearby players.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_4"] = [[Ultimatum]]
LANGUAGE["Perk_Title_gunslinger_nine_lives"] = [[Nine Lives]]
LANGUAGE["Perk_gunslinger_nine_lives"] = [[
Once per turn, gain Nine Lives for {1} seconds when your health depletes.
Nine Lives refills your health and provides invulnerability.
Nine Lives provides {2} increased damage.]]
LANGUAGE["Perk_Title_gunslinger_bladerunner"] = [[Bladerunner]]
LANGUAGE["Perk_gunslinger_bladerunner"] = [[
{1} increased Hunter's Mark duration.
Enemies under Hunter's Mark take {2} more headshot damage.
{3} reduced damage taken from enemies with Hunter's Mark.]]

-- Default Subclass Perks: Necromancer
LANGUAGE["Perk_Title_Necromancer_Tier_1"] = [[Initialization]]
LANGUAGE["Perk_Title_necromancer_void_sphere"] = [[Void Sphere]]
LANGUAGE["Perk_necromancer_void_sphere"] =
[[Void Spear always deal splashing damage.
Increases Void Spear splash damage.]]
LANGUAGE["Perk_Title_necromancer_hollow_essence"] = [[Hollow Essence]]
LANGUAGE["Perk_necromancer_hollow_essence"] =
[[+{1} to maximum Spectres alive.
{2} reduced Raise Spectre cost.]]

LANGUAGE["Perk_Title_Necromancer_Tier_2"] = [[Recovery]]
LANGUAGE["Perk_Title_necromancer_void_siphon"] = [[Void Siphon]]
LANGUAGE["Perk_necromancer_void_siphon"] =
[[Hitting enemies with Void Spear restores energy.
Increases Void Spear damage according to remaining energy, up to {1}.]]
LANGUAGE["Perk_Title_necromancer_superfluidity"] = [[Superfluidity]]
LANGUAGE["Perk_necromancer_superfluidity"] =
[[20% increased Frostbite buildup.
Void Projector recovers energy while inactive.]]

LANGUAGE["Perk_Title_Necromancer_Tier_3"] = [[Annihilation]]
LANGUAGE["Perk_Title_necromancer_void_field"] = [[Void Field]]
LANGUAGE["Perk_necromancer_void_field"] =
[[Void Spear applies extra Frostbite buildup.
Increases Void Spear damage by its travelling distance.]]
LANGUAGE["Perk_Title_necromancer_abyssal_might"] = [[Abyssal Might]]
LANGUAGE["Perk_necromancer_abyssal_might"] =
[[+{1} to maximum Spectres alive.
Spectres gain access to Abyssal Roar.]]

LANGUAGE["Perk_Title_Necromancer_Tier_4"] = [[Mastery]]
LANGUAGE["Perk_Title_necromancer_beacon_of_void"] = [[Beacon of Void]]
LANGUAGE["Perk_necromancer_beacon_of_void"] =
[[Cold damage ignores enemy Cold damage resistance.
Unlocks Void Cascade for Void Projector ({1} energy, R button).
Perk bonuses to Void Spear also apply to Void Cascade.]]
LANGUAGE["Perk_Title_necromancer_necromastery"] = [[Necromastery]]
LANGUAGE["Perk_necromancer_necromastery"] =
[[+{1} to maximum Spectres alive.
Unlocks the Devour skill for Void Projector (R button).
Instantly kills a targeted non-elite enemy and spawn a Spectre.]]

-- Default Subclass Perks: Samurai
LANGUAGE["Perk_Title_Samurai_Tier_1"] = [[Technique]]
LANGUAGE["Perk_Title_samurai_focus_slash"] = [[Focus Slash]]
LANGUAGE["Perk_samurai_focus_slash"] =
[[Adds 1 charge to Quickstep.
{1} increased Melee damage during Quickstep.]]
LANGUAGE["Perk_Title_samurai_flesh_bloom"] = [[Flesh Bloom]]
LANGUAGE["Perk_samurai_flesh_bloom"] =
[[Melee damage applies Bleeding buildup in an area.]]

LANGUAGE["Perk_Title_Samurai_Tier_2"] = [[Overwhelm]]
LANGUAGE["Perk_Title_samurai_demon_stomp"] = [[Demon Stomp]]
LANGUAGE["Perk_samurai_demon_stomp"] =
[[Adds 1 charge to Quickstep.
Activating Quickstep releases a shockwave that deals {1} Physical damage.
Recover {2} health for each enemy hit by the shockwave.]]
LANGUAGE["Perk_Title_samurai_exsanguinate"] = [[Exsanguinate]]
LANGUAGE["Perk_samurai_exsanguinate"] =
[[20% increased Bleeding buildup.
Recover health neary Bleeding enemies.
Immune to Bleeding.]]

LANGUAGE["Perk_Title_Samurai_Tier_3"] = [[Mind]]
LANGUAGE["Perk_Title_samurai_foresight"] = [[Foresight]]
LANGUAGE["Perk_samurai_foresight"] =
[[Adds {1} charge to Quickstep.
Gain Foresight, negating Physical damage taken on hit.
Foresight expires on hit and reflects damage taken.]]
LANGUAGE["Perk_Title_samurai_resolution"] = [[Resolution]]
LANGUAGE["Perk_samurai_resolution"] =
[[Reduces your total weight to 7.
{1} more Melee damage.
+3 damage block.]]

LANGUAGE["Perk_Title_Samurai_Tier_4"] = [[Art of War]]
LANGUAGE["Perk_Title_samurai_blade_dance"] = [[Blade Dance]]
LANGUAGE["Perk_samurai_blade_dance"] =
[[Adds 1 charge to Quickstep.
Killing enemies adds 2 Quickstep charges.
Extends effect duration of Quickstep.]]
LANGUAGE["Perk_Title_samurai_demon_strike"] = [[Demon Strike]]
LANGUAGE["Perk_samurai_demon_strike"] =
[[{1} increased Bleeding buildup.
{2} increased Melee damage against Bleeding enemies.
Leech {3} Melee damage dealt during Quickstep.]]

-- Default Subclass Perks: Artificer
LANGUAGE["Perk_Title_Artificer_Tier_1"] = [[Inner Strength]]
LANGUAGE["Perk_Title_artificer_warmth"] = [[Warmth]]
LANGUAGE["Perk_artificer_warmth"] =
[[Charged Solar Orbs heal players.]]
LANGUAGE["Perk_Title_artificer_purge"] = [[Purge]]
LANGUAGE["Perk_artificer_purge"] =
[[{1} increased Shock buildup.
{2} increased headshot damage.]]

LANGUAGE["Perk_Title_Artificer_Tier_2"] = [[Recuperate]]
LANGUAGE["Perk_Title_artificer_solar_guard"] = [[Solar Guard]]
LANGUAGE["Perk_artificer_solar_guard"] =
[[{1} increased Solar Seal energy regeneration.
Uses energy to reduce damage taken, up to {2}.
Damage reduction is based on remaining energy.]]
LANGUAGE["Perk_Title_artificer_intensity"] = [[Intensity]]
LANGUAGE["Perk_artificer_intensity"] =
[[Gain Intensity for each enemy you kill, up to {1} stacks.
Each stack increases energy regeneration by {2}
Each stack reduces skill cooldown by {3}.]]

LANGUAGE["Perk_Title_Artificer_Tier_3"] = [[Codex]]
LANGUAGE["Perk_Title_artificer_floating_chaos"] = [[Floating Chaos]]
LANGUAGE["Perk_artificer_floating_chaos"] =
[[Unlocks Floating Chaos for Solar Seal ({1} energy, R button).
Spawns a floating orb that echoes your spells.]]
LANGUAGE["Perk_Title_artificer_hallowed_bolt"] = [[Hallowed Bolt]]
LANGUAGE["Perk_artificer_hallowed_bolt"] =
[[Unlocks Hallowed Bolt for Solar Seal ({1} energy, R button).
Strikes the ground from above, dealing heavy Lightning damage in an area.
Recover health after killing an enemy with Hallowed Bolt.]]

LANGUAGE["Perk_Title_Artificer_Tier_4"] = [[Ascension]]
LANGUAGE["Perk_Title_artificer_godslayer"] = [[Godslayer]]
LANGUAGE["Perk_artificer_godslayer"] =
[[Fire damage ignores enemy Fire damage resistance.
Solar Orb has {1} increased damage and gains an extra charge stage.
Solar Storm can leave behind ground flames.]]
LANGUAGE["Perk_Title_artificer_draconic_reckoning"] = [[Draconic Reckoning]]
LANGUAGE["Perk_artificer_draconic_reckoning"] =
[[Lightning damage ignores enemy Lightning damage resistance.
Solar Orb has Lightning damage area of effect.
Solar Storm has {1} increased damage and gains an extra charge stage.]]

-- Default Disabled Subclass Perks: Chemist
LANGUAGE["Perk_Title_Chemist_Tier_1"] = [[Inner Strength]]
LANGUAGE["Perk_Title_chemist_erosion"] = [[Erosion]]
LANGUAGE["Perk_chemist_erosion"] =
[[Increase Break buildup over time on enemies you hit with Poison damage.
The increase stops when Break triggers.]]
LANGUAGE["Perk_Title_chemist_contagion"] = [[Contagion]]
LANGUAGE["Perk_chemist_contagion"] = [[Generates an explosion when Break triggers.
The explosion deals Poison damage over time.]]

LANGUAGE["Perk_Title_Chemist_Tier_2"] = [[Recuperate]]
LANGUAGE["Perk_Title_chemist_cleansing"] = [[Cleansing]]
LANGUAGE["Perk_chemist_cleansing"] = [[Players you heal have Cleansing for {1} seconds.
{2} increased Poison damage resistance while you have Cleansing.
{3} reduced Break buildup taken while you have Cleansing.]]
LANGUAGE["Perk_Title_chemist_poison_weapon"] = [[Poison Weapon]]
LANGUAGE["Perk_chemist_poison_weapon"] = [[Players you heal have Poison Weapon for {1} seconds.
Adds extra Poison damage to Physical damage while you have Poison Weapon.
Only applies to direct Physical attacks.]]

LANGUAGE["Perk_Title_Chemist_Tier_3"] = [[Inner Strength]]
LANGUAGE["Perk_Title_chemist_mustard_gas"] = [[Mustard Gas]]
LANGUAGE["Perk_chemist_mustard_gas"] = [[Press SHIFT+E to release Mustard Gas.
Mustard Gas deals Poison damage over time.]]
LANGUAGE["Perk_Title_chemist_sarin_mist"] = [[Sarin Mist]]
LANGUAGE["Perk_chemist_sarin_mist"] = [[Press SHIFT+E to release a sarin mist.
Sarin Mist increases Break buildup over time.]]

LANGUAGE["Perk_Title_Chemist_Tier_4"] = [[Ascension]]
LANGUAGE["Perk_Title_chemist_beacon_of_agony"] = [[Beacon of Agnoy]]
LANGUAGE["Perk_chemist_beacon_of_agony"] = [[{1} increased Poison damage.
Poison damage ignores enemy Poison damage resistance.]]
LANGUAGE["Perk_Title_chemist_disintegrate"] = [[Disintegrate]]
LANGUAGE["Perk_chemist_disintegrate"] = [[{1} increased Poison damage.
Poison damage ignores enemy Poison damage resistance.]]

-- Default Disabled Subclass Perks: Golem
LANGUAGE["Perk_Title_Golem_Tier_1"] = [[Synthesis]]
LANGUAGE["Perk_Title_golem_biojet"] = [[Bio-Jet]]
LANGUAGE["Perk_golem_biojet"] =
[[25% increased maximum health.
Charged punch on surfaces can launch you in air.]]
LANGUAGE["Perk_Title_golem_photosynthesis"] = [[Photosynthesis]]
LANGUAGE["Perk_golem_photosynthesis"] =
[[Adds {1} maximum Hypertrophy stacks.
Holding Force Shield recovers health.
Recovers 2 health every 1 second held.]]

LANGUAGE["Perk_Title_Golem_Tier_2"] = [[Mesocycle]]
LANGUAGE["Perk_Title_golem_biofusion"] = [[Biofusion]]
LANGUAGE["Perk_golem_biofusion"] =
[[25% increased maximum health.
25% chance to drio a gib from enemy on Melee hit.
Each gib restores 5% health.]]
LANGUAGE["Perk_Title_golem_amalgam"] = [[Amalgam]]
LANGUAGE["Perk_golem_amalgam"] =
[[Adds {1} maximum Hypertrophy stacks.
{1} chance to add 1 Hypertrophy stack on Melee headshot.]]

LANGUAGE["Perk_Title_Golem_Tier_3"] = [[Proliferation]]
LANGUAGE["Perk_Title_golem_meatshield"] = [[Meatshield]]
LANGUAGE["Perk_golem_meatshield"] =
[[25% increased maximum health. 
Drops gibs around you when you are hit.]]
LANGUAGE["Perk_Title_golem_cell_graft"] = [[Cell Graft]]
LANGUAGE["Perk_golem_cell_graft"] =
[[Adds {1} maximum Hypertrophy stacks.
Every time you kill an enemy, Players near you also gain {1} Hypertrophy, up to {2}.\n]]

LANGUAGE["Perk_Title_Golem_Tier_4"] = [[Multiply]]
LANGUAGE["Perk_Title_golem_bioimmortality"] = [[Bio-Immortality]]
LANGUAGE["Perk_golem_bioimmortality"] =
[[25% increased maximum health.
75% less debuff buildups taken.]]
LANGUAGE["Perk_Title_golem_trauma_loop"] = [[Trauma Loop]]
LANGUAGE["Perk_golem_trauma_loop"] =
[[Adds {1} maximum Hypertrophy stacks.
Melee attacks has a chance to spawn gibs around the target.
Each gib restores 5 health.]]

-- Default Disabled Subclass Perks: Striker
LANGUAGE["Perk_Title_striker_frostblink"] = [[Frostblink]]
LANGUAGE["Perk_striker_frostblink"] =
[[Releases an ice explosion after Blink.
The ice explosion deals {1} Cold damage in an area.]]
LANGUAGE["Perk_Title_striker_stormcharge"] = [[Stormcharge]]
LANGUAGE["Perk_striker_stormcharge"] =
[[Gain Stormcharge effect for {1} second after Blink.
{2} increased damage while you have Stormcharge.
Convert {3} of your damage to Lightning damage while you have Stormcharge.]]

-- Default Hidden Class Perks: Survivor
LANGUAGE["Perk_Title_survivor_power_up"] = [[Power Up]]
LANGUAGE["Perk_striker_frostblink"] = [[Allows you to upgrade Half-life 2 weapons.]]

-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[Stunstick]]
LANGUAGE["Item_Desc_Stunstick"] = [[
Electric baton.
]]

LANGUAGE["Item_Crowbar"] = [[Crowbar]]
LANGUAGE["Item_Desc_Crowbar"] = [[
A rusty crowbar.
]]

LANGUAGE["Item_Combat Knife"] = [[Combat Knife]]
LANGUAGE["Item_Desc_Combat Knife"] = [[
A reliable bayonet.
RMB to deal a heavy slash.
]]

LANGUAGE["Item_Katana"] = [[Katana]]
LANGUAGE["Item_Desc_Katana"] = [[
Ninja sword.
Long attack range and fast attack speed.
]]

LANGUAGE["Item_Bat"] = [[Bat]]
LANGUAGE["Item_Desc_Bat"] = [[
Sturdy baseball bat.
Hits like a truck.
]]


LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
Combine standard sidearm.
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Colt python magnum pistol.
Used by Black Mesa security guards.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
Semi-automatic pistols manufactured in Austrian.
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Universelle Selbstladepistole.
A semi-automatic pistol developed in Germany by H&K.
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
Does huge amounts of ballistic damage.
]]


LANGUAGE["Item_SSG08 Medic SR"] = [[SSG08 Medic SR]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
A medic sniper rifle that shoots healing darts.
Damages enemies and heals players.
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


LANGUAGE["Item_Frag Grenade"] = [[Frag Grenade]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
A standard frag grenade.
Good for crowd control.
]]

LANGUAGE["Item_DamageResistance RPG"] = [[Resistance RPG]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
Laser-guided rocket propulsion device.
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
Anti-tank rocket launcher developed by Soviet Union.
]]

LANGUAGE["Item_SLAM"] = [[SLAM]]
LANGUAGE["Item_Desc_SLAM"] = [[
Selectable Lightweight Attack Munition.
RMB to detonate. Attach to wall to active laser mode.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Incendiary Grenade]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Generates a pool of fire after some delay.
Sets everything on fire within its effect.
]]

LANGUAGE["Item_Molotov"] = [[Molotov]]
LANGUAGE["Item_Desc_Molotov"] = [[
Generates a pool of fire on impact.
Sets everything on fire within its effect.
]]

LANGUAGE["Item_Incendiary Launcher"] = [[Incendiary Launcher]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
Incendiary Grenade Launcher.
Shoots incendiary grenades the erupt into flames on impact.
]]


LANGUAGE["Item_Heat Crossbow"] = [[Heat Crossbow]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
Improvised sniper weapon.
Shoots scorching rebars.
]]

LANGUAGE["Item_Turret"] = [[Turret]]
LANGUAGE["Item_Desc_Turret"] = [[
Combine Overwatch turret.
Used to guard chocke points and vital areas.
]]

LANGUAGE["Item_Medic Grenade"] = [[Medic Grenade]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
A grenade that releases contiuous bursts of detoxication clouds.
Heals players and damages enemies.
]]

LANGUAGE["Item_Throwing Knives"] = [[Throwing Knives]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
Ranged throwing knives.
Thrown blades are retrievable.
]]

LANGUAGE["Item_Watchtower"] = [[Watchtower]]
LANGUAGE["Item_Desc_Watchtower"] = [[
A watchtower that provides resupply.
Generates 1 ammobox every 30 seconds.
(Entity Class: horde_watchtower)
]]

LANGUAGE["Item_M2 Flamethrower"] = [[M2 Flamethrower]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
M2-2 Flamethrower.
An American man-portable backpack flamethrower.
]]


LANGUAGE["Item_Medkit"] = [[Medkit]]
LANGUAGE["Item_Desc_Medkit"] = [[
Rechargeble medkit.
RMB to self-heal, LMB to heal others.
]]

LANGUAGE["Item_Health Vial"] = [[Health Vial]]
LANGUAGE["Item_Desc_Health Vial"] = [[
A capsule filled with sticky green liquid.
Heals instantly when picked up.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Kevlar Armor Battery]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Armor battery.
Each one provides 15 armor. Personal use only.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[Full Kevlar Armor]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Full kevlar armor set.
Fills up 100% of your armor bar.
]]

LANGUAGE["Item_Watchtower MKII"] = [[Watchtower MKII]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
A watchtower that provides resupply.
Generates 1 health vial every 30 seconds.
(Entity Class: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[Watchtower MKIII]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
A watchtower that deters enemies.
Shocks 1 nearby enemy every 1 second.
Does 80 Lightning damage.
(Entity Class: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[Tau Cannon]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
A device that uses electromagnetism to ionize particles.
Hold RMB to charge and release a powerful shot.
Deals more damage as you charge.
Device explodes if you overcharge.
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1 Medic PDW]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
A modified version of MP7A1 for medical purposes.

Press B or ZOOM to fire healing darts.
Healing dart recharges every 1 second.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[Vector Medic PDW]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
KRISS Vector Gen I equipped with a medical dart launcher.
Uses an unconventional blowback system that results in its high firerate.

Press B or ZOOM to fire healing darts.
Healing dart recharges every 1.5 seconds.
]]

LANGUAGE["Item_Chainsaw"] = [[Chainsaw]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Brrrrrrrrrrrrrrrr.

Hold RMB to saw through enemies.
]]

LANGUAGE["Item_Mjollnir"] = [[Mjollner]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
A warhammer embued with electric energy.

Press RMB to charge the weapon.
Charged Mjollnir creates a lightning explosion on impact.
]]

LANGUAGE["Item_Double Barrel"] = [[Double Barrel]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
Double Barrel Shotgun.
Devastating power at close range.
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

LANGUAGE["Item_Manhack"] = [[Manhack]]
LANGUAGE["Item_Desc_Manhack"] = [[
Manhack that regenerates on death.
Manhack deals its health as damage to enemies.
Manhack dies on impact.
]]

LANGUAGE["Item_Vortigaunt"] = [[Vortigaunt]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
Xen Vortigaunts that can conjure concentrated shock energy blasts.
The energy blasts have long range and deal splash damage.
]]

LANGUAGE["Item_Combat Bot"] = [[Combat Bot]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
A resilient humanoid robot designed to engage enemies head-on.
Uses powerful melee attacks and ranged boulder attacks.
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
LANGUAGE["Gadget_gadget_blast_plating"] = [[Blast Plating]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
20% increased Blast damage resistance.
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[Shock Plating]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
20% increased Lightning damage resistance.
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[Heat Plating]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
20% increased Fire damage resistance.
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[Detoxifier]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
20% increased Poison damage resistance.
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[Diamond Plating]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
15% increased Physical damage resistance.
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Corporate Mindset]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Set goals. Have a ten year plan. Invest. Wake up Early. CEO Mindset."

Greatly increases skull tokens drop chance.
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_vitality_booster"] = [[Vitality Booster]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
+25 to maximum health.
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[Damage Booster]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
25% increased Global damage.
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[IV Injection]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
Recover 25 health.
]]

LANGUAGE["Gadget_gadget_cortex"] = [[Cortex]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
For each enemy near you, gain 1 Adrenaline stack.
Elite enemies grant 2 stacks.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[Neuro Amplifier]]
LANGUAGE["Gadget_Desc_neuro_amplifier"] = [[
Adrenaline also increases 6% evasion.
]]

LANGUAGE["Gadget_ouroboros"] = [[Ouroboros]]
LANGUAGE["Gadget_Desc_ouroboros"] = [[
Ouroboros nervous system assistant.
Removes body regulations to increase combat capabilities.

When you have more than 50% health, you lose 1 health per second.
When you have less than 50% health, you gain 2 health per second.
For each 1% health missing, increase your damage by 0.8%.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[Energy Shield]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
Temporarily gain 25 armor.
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[Hardening Injection]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
Movespeed reduced by 50%.
25% increased Global damage resistance.
25% increased Physical damage resistance.
]]

LANGUAGE["Gadget_exoskeleton"] = [[Exoskeleton]]
LANGUAGE["Gadget_Desc_exoskeleton"] = [[
Using the active ability activates a short boost.

You cannot run.
Passively provides 20% increased Global damage resistance.
]]

LANGUAGE["Gadget_t_virus"] = [[T-Virus]]
LANGUAGE["Gadget_Desc_t_virus"] = [[
Converts your armor to health.
Cannot convert pass 250% health.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[Life Diffuser]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
Triggers a pulse that heals nearby players.
Heals 20 health.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[Projectile Launcher (Heal)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
Shoots a chemical projectile.
Projectile deals 75 Poison damage.
Projectile heals 25 health to nearby players.
]]

LANGUAGE["Gadget_healing_beam"] = [[Healing Beam]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Connects a healing beam between the user and target.
If the target is an enemy, leeches health from the target.
If the target is an ally, restores health to the ally.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[Optical Camouflage]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
Grants Camouflage for 5 seconds.
50% increased evasion during Camouflage.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[Projectile Launcher (Ballistic)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
Shoots a ballistic projectile.
Projectile deals 150 Ballistic damage.
Stuns enemy on hit.
]]

LANGUAGE["Gadget_death_mark"] = [[Death Mark]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
Places a mark on the targeted enemy.
Marked enemy takes 15% more damage.
Marked enemy explodes on death, dealing damage based on its health.
The mark lasts for 10 seconds.
You can only mark 1 enemy at a time.
]]

LANGUAGE["Gadget_gunslinger"] = [[Gunslinger]]
LANGUAGE["Gadget_Desc_gadget_gunslinger"] = [[
25% more Pistol damage.
25% more Pistol headshot damage.
]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[Proximity Defense]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
Triggers an explosion that Stuns nearby enemies.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[Projectile Launcher (Blast)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
Shoots an explosive projectile.
Projectile deals 100 Blast damage.
Generates 3 extra explosions after a short delay.
]]

LANGUAGE["Gadget_nitrous_propellor"] = [[Nitrous Propellor]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Propells you forward and upward with a chemical explosion.
]]

LANGUAGE["Gadget_ied"] = [[IED]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Drops an Improvised Explosive Device on the ground.
IED explodes when an enemy comes in range.
You have 5 IED charges.
IED recharges after detonation.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_displacer"] = [[Displacer]]
LANGUAGE["Gadget_Desc_gadget_displacer"] = [[
Instantly moves the targeted minion to your side.
]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[Turret Pack]]
LANGUAGE["Gadget_Desc_gadget_turret_pack"] = [[
Deploys a temporary turret.
Turret has 50% less health.
Turret is destroyed when duration expires.
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[E-Parasite]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
Projects an E-Parasite capsule that infects enemies on contact.
E-Parasite counts as a minion.
E-Parasite deals continuous damage to enemies.
You leech health from damage dealt by E-Parasite.
Enemies killed while infected by E-Parasite explode on death.
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_berserk_armor"] = [[Berserker Armor]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
25% increased damage.
25% increased Global damage resistance.
25% increased move speed.
]]

LANGUAGE["Gadget_gadget_flash"] = [[Flash]]
LANGUAGE["Gadget_Desc_flash"] = [[
Dashes forward, dealing 100 Slashing damage to all enemies on the path.
Provides a short invincibility frame.
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[Aerial Guard]]
LANGUAGE["Gadget_Desc_aerial_guard"] = [[
While in air, take 65% less Physical damage.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[Hemocannon]]
LANGUAGE["Gadget_Desc_hemocannon"] = [[
Shoots a projectile at the cost of 10 health.
The projectile travels for a short distance and explodes.
The explosion deals 100 Slashing damage.
Has a maximum of 5 charges.
Recharges after 5 seconds.
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[Solar Array]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
Drops an armor battery.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[Projectile Launcher (Shock)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
Shoots a magnetic projectile that pierces enemies.
Generates a shockwave each time the projectile hits an enemy.
Shockwave deals 125 Lightning damage.
]]

LANGUAGE["Gadget_watchtower_pack"] = [[Watchtower Pack]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
Deploys an extra watchtower.
]]

LANGUAGE["Gadget_shock_nova"] = [[Shock Nova]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
Warden Aura rapidly generates a series of shockwaves.
Each shockwave deals 50 Lightning damage.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[Butane Can]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
Drops a Butane Can that explodes on physical impact.
Explosion deals 375 Fire damage.
Only 1 Butane Can can be spawned at a time.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[Projectile Launcher (Fire)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
Shoots a flaming projectile.
Ignites all enemies caught in the explosion.
Deals 20 base Ignite damage.
]]

LANGUAGE["Gadget_barbeque"] = [[Barbeque]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Ignited enemies killed by you drop edible gibs.
Each gib restores 5 health.
]]

-- Infusion
LANGUAGE["Infusion_None"] = "None"
LANGUAGE["Infusion_Desc_None"] = "No effect."

LANGUAGE["Infusion_Hemo"] = "Hemo"
LANGUAGE["Infusion_Desc_Hemo"] = [[
Convert 75% weapon damage into Slashing damage.

Weapon deals only Slashing damage.

Weapon damage increases Bleeding buildup. 
]]

LANGUAGE["Infusion_Concussive"] = "Concussive"
LANGUAGE["Infusion_Desc_Concussive"] = [[
Convert 75% weapon damage into Blunt damage.

Weapon deals only Blunt damage.

Weapon damage increases Stun buildup. 
]]

LANGUAGE["Infusion_Septic"] = "Septic"
LANGUAGE["Infusion_Desc_Septic"] = [[
Convert 75% weapon damage into Poison damage.

Weapon deals only Poison damage.

Weapon damage increases Break buildup. 
]]

LANGUAGE["Infusion_Flaming"] = "Flaming"
LANGUAGE["Infusion_Desc_Flaming"] = [[
Convert 75% weapon damage into Fire damage.

Weapon deals only Fire damage.

Weapon ignites enemies on hit.
]]

LANGUAGE["Infusion_Arctic"] = "Arctic"
LANGUAGE["Infusion_Desc_Arctic"] = [[
Convert 75% weapon damage into Cold damage.

Weapon deals only Cold damage.

Weapon damage increases Frostbite buildup. 
]]

LANGUAGE["Infusion_Galvanizing"] = "Galvanizing"
LANGUAGE["Infusion_Desc_Galvanizing"] = [[
Convert 75% weapon damage into Lightning damage.

Weapon deals only Lightning damage.

Weapon damage increases Shock buildup. 
]]

LANGUAGE["Infusion_Quality"] = "Quality"
LANGUAGE["Infusion_Desc_Quality"] = [[
20% increased weapon damage.

Weapon damage is unaffected by perks or gadgets.
]]

LANGUAGE["Infusion_Impaling"] = "Impaling"
LANGUAGE["Infusion_Desc_Impaling"] = [[
25% increased weapon headshot damage.

25% less weapon non-headshot damage.
]]

LANGUAGE["Infusion_Rejuvenating"] = "Rejuvenating"
LANGUAGE["Infusion_Desc_Rejuvenating"] = [[
Amplifies weapon healing/leeching by 25%.

25% less weapon damage.
]]

LANGUAGE["Infusion_Quicksilver"] = "Quicksilver"
LANGUAGE["Infusion_Desc_Quicksilver"] = [[
Increases/decreases weapon damage based on player's available weight.

<= 15% weight -> 30% damage increase
<= 30% weight -> 25% damage increase 
<= 40% weight -> 15% damage increase 
>40% weight -> 25% damage decrease
]]

LANGUAGE["Infusion_Siphoning"] = "Siphoning"
LANGUAGE["Infusion_Desc_Siphoning"] = [[
+1 health when you kill enemy.

25% less weapon damage.
]]

LANGUAGE["Infusion_Titanium"] = "Titanium"
LANGUAGE["Infusion_Desc_Titanium"] = [[
Reduces player damage taken based on weapon weight.

Decrease 1% damage taken for every 1 weight on the weapon.

25% less weapon damage.
]]

LANGUAGE["Infusion_Chrono"] = "Chrono"
LANGUAGE["Infusion_Desc_Chrono"] = [[
Increases weapon damage the longer the weapon is being held by the user.

6% damage increase per wave held by the user.
Increase caps at 50%.

20% decreased weapon damage.
]]

-- Tips
LANGUAGE["Tip_An elite enemy's health scales with player counts."] = "An elite enemy's health scales with player counts."
LANGUAGE["Tip_Share money with your teammates by pressing V."] = "Share money with your teammates by pressing V."
LANGUAGE["Tip_Perks are unlocked as waves progress."] = "Perks are unlocked as waves progress."
LANGUAGE["Tip_Your weapons are dropped upon death."] = "Your weapons are dropped upon death."
LANGUAGE["Tip_You can only change class once per wave."] = "You can only change class once per wave."
LANGUAGE["Tip_Remember to refill ammo."] = "Remember to refill ammo."
LANGUAGE["Tip_Mutated enemies have special particle effects."] = "Mutated enemies have special particle effects."
LANGUAGE["Tip_Headshot deals 2x base damage."] = "Headshot deals 2x base damage."
LANGUAGE["Tip_Buy a Medkit to heal yourself."] = "Buy a Medkit to heal yourself."
LANGUAGE["Tip_Buy Armor for extra protection."] = "Buy Armor for extra protection."
LANGUAGE["Tip_Medic Grenade damages enemies and heals players."] = "Medic Grenade damages enemies and heals players."
LANGUAGE["Tip_Barret AMR has the highest single-shot damage."] = "Barret AMR has the highest single-shot damage."
LANGUAGE["Tip_Some Heavy Machine Guns can overheat."] = "Some Heavy Machine Guns can overheat."
LANGUAGE["Tip_RPG-7 has a large blast radius."] = "RPG-7 has a large blast radius."
LANGUAGE["Tip_LAW has higher damage than RPG, but a smaller blast radius."] = "LAW has higher damage than RPG, but a smaller blast radius."
LANGUAGE["Tip_Turrets can be used to distract enemies."] = "Turrets can be used to distract enemies."
LANGUAGE["Tip_SSG08 Medic Rifle can heal teammates from afar."] = "SSG08 Medic Rifle can heal teammates from afar."
LANGUAGE["Tip_Stun Grenade can paralyze enemies for a short time."] = "Stun Grenade can paralyze enemies for a short time."
LANGUAGE["Tip_Exploder's head has little health."] = "Exploder's head has little health."
LANGUAGE["Tip_Exploders do not explode when killed on headshots."] = "Exploders do not explode when killed on headshots."
LANGUAGE["Tip_Bosses have increased headshot resistance."] = "Bosses have increased headshot resistance."
LANGUAGE["Tip_Some enemies have additional mutations."] = "Some enemies have additional mutations."
LANGUAGE["Tip_Screecher's shockwave deals Lightning damage."] = "Screecher's shockwave deals Lightning damage."
LANGUAGE["Tip_Screecher's shockwave increases Shock buildup."] = "Screecher's shockwave increases Shock buildup."
LANGUAGE["Tip_Weeper's shockwave deals Cold damage."] = "Weeper's shockwave deals Cold damage."
LANGUAGE["Tip_Weeper's shockwave increases Frostbite buildup."] = "Weeper's shockwave increases Frostbite buildup."
LANGUAGE["Tip_Yeti's frost cloud deals Cold damage."] = "Yeti's frost cloud deals Cold damage."
LANGUAGE["Tip_Yetis releases frost clouds when on half health."] = "Yetis releases frost clouds when on half health."
LANGUAGE["Tip_Hulks will enter a rage when on half health."] = "Hulks will enter a rage when on half health."
LANGUAGE["Tip_Zombines will self-destruct on low health."] = "Zombines will self-destruct on low health."
LANGUAGE["Tip_Vomitter's spit deals Slashing damage."] = "Vomitter's spit deals Slashing damage."
LANGUAGE["Tip_Vomitter's spit increases Bleeding buildup."] = "Vomitter's spit increases Bleeding buildup."
LANGUAGE["Tip_Burning enemies can increase Ignite buildup when they hit you."] = "Burning enemies can increase Ignite buildup when they hit you."
LANGUAGE["Tip_Lesions will calm down after striking a player."] = "Lesions will calm down after striking a player."
LANGUAGE["Tip_Lesions will enrage when provoked."] = "Lesions will enrage when provoked."
LANGUAGE["Tip_Lesions will enrage when left alone for too long."] = "Lesions will enrage when left alone for too long."
LANGUAGE["Tip_Poison Headcrabs increase Break buildup based on your health."] = "Poison Headcrabs increase Break buildup based on your health."
LANGUAGE["Tip_ASSAULT is specialized in auto-rifles."] = "ASSAULT is specialized in auto-rifles."
LANGUAGE["Tip_ADRENALINE increases speed and damage per stack."] = "ADRENALINE increases speed and damage per stack."
LANGUAGE["Tip_HEAVY is specialized in heavy machine guns."] = "HEAVY is specialized in heavy machine guns."
LANGUAGE["Tip_HEAVY regenerates armor automatically."] = "HEAVY regenerates armor automatically."
LANGUAGE["Tip_GHOST is specialized in sniper rifles."] = "GHOST is specialized in sniper rifles."
LANGUAGE["Tip_GHOST can deal huge amounts of headshot damage."] = "GHOST can deal huge amounts of headshot damage."
LANGUAGE["Tip_CAMOUFLAGE grants various benefits while active."] = "CAMOUFLAGE grants various benefits while active."
LANGUAGE["Tip_DEMOLITION is specialized in explosives."] = "DEMOLITION is specialized in explosives."
LANGUAGE["Tip_DEMOLITION has innate Blast damage resistance."] = "DEMOLITION has innate Blast damage resistance."
LANGUAGE["Tip_BERSERKER is specialized in close-quarter combat."] = "BERSERKER is specialized in close-quarter combat."
LANGUAGE["Tip_BERSERKER has increased damage resistance."] = "BERSERKER has increased damage resistance."
LANGUAGE["Tip_ENGINEER is specialized in minions."] = "ENGINEER is specialized in minions."
LANGUAGE["Tip_MEDIC is specialized in healing and buffing players."] = "MEDIC is specialized in healing and buffing players."
LANGUAGE["Tip_MEDIC regenerates health automatically."] = "MEDIC regenerates health automatically."
LANGUAGE["Tip_CREMATOR is specialized in manipulating Fire damage."] = "CREMATOR is specialized in manipulating Fire damage."
LANGUAGE["Tip_CREMATOR has innate Fire damage resistance."] = "CREMATOR has innate Fire damage resistance."
LANGUAGE["Tip_WARDEN is specialized in buff auras and watchtowers."] = "WARDEN is specialized in buff auras and watchtowers."
LANGUAGE["Tip_WARDEN's aura affects nearby players"] = "WARDEN's aura affects nearby players"
LANGUAGE["Tip_SURVIVOR perks are a combination of other classes."] = "SURVIVOR perks are a combination of other classes."
LANGUAGE["Tip_SURVIVOR has the largest weapon pool."] = "SURVIVOR has the largest weapon pool."
LANGUAGE["Tip_Choose your Perks depending on the situation."] = "Choose your Perks depending on the situation."
LANGUAGE["Tip_Fire damage increases Ignite buildup."] = "Fire damage increases Ignite buildup."
LANGUAGE["Tip_Ignite effect causes players to receive Fire damage over time."] = "Ignite effect causes players to receive Fire damage over time."
LANGUAGE["Tip_Cold damage increases Frosbite buildup."] = "Cold damage increases Frosbite buildup."
LANGUAGE["Tip_Frostbite effect reduces players' movement speed."] = "Frostbite effect reduces players' movement speed."
LANGUAGE["Tip_Lightning damage increases Shock buildup."] = "Lightning damage increases Shock buildup."
LANGUAGE["Tip_Shock effect increases damage taken by players."] = "Shock effect increases damage taken by players."
LANGUAGE["Tip_Poison damage increases Break buildup."] = "Poison damage increases Break buildup."
LANGUAGE["Tip_Break effect removes players' health that will recover in time."] = "Break effect removes players' health that will recover in time."
LANGUAGE["Tip_Certain enemies and mutations can increase your Bleeding buildup."] = "Certain enemies and mutations can increase your Bleeding buildup."
LANGUAGE["Tip_Bleeding effect removes player health over time."] = "Bleeding effect removes player health over time."
LANGUAGE["Tip_Certain enemies and mutations can increase your Decay buildup."] = "Certain enemies and mutations can increase your Decay buildup."
LANGUAGE["Tip_Decay effect blocks health recovery."] = "Decay effect blocks health recovery."