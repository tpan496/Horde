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
LANGUAGE["Game_Players_Ready"] = "Players Ready"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Next wave starts in %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "NORMAL"
LANGUAGE["Game_Difficulty_HARD"] = "HARD"
LANGUAGE["Game_Difficulty_REALISM"] = "REALISM"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "NIGHTMARE"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "APOCALYPSE"
LANGUAGE["Game_Enemies"] = "Enemies"
LANGUAGE["Game_HintBottomReady"] = "F3 - Shop/Perk, F4 - Ready"
LANGUAGE["Game_HintBottom"] = "F3 - Shop/Perk, V - Drop $"
LANGUAGE["Game_Result_VICTORY"] = "VICTORY"
LANGUAGE["Game_Result_DEFEAT"] = "DEFEAT"
LANGUAGE["Game_Result_Change Map"] = "Change Map"
LANGUAGE["Game_Wave"] = "Wave"
LANGUAGE["Game_Wave_Has_Started"] = "Wave %d has started"
LANGUAGE["Game_Wave_Completed"] = "Wave Completed"
LANGUAGE["Game_Remaining_Time"] = "Remaining Time"
LANGUAGE["Game_Vote_Map"] = "Vote Map"
LANGUAGE["Game_Game_Summary"] = "Game Summary"
LANGUAGE["Game_Most_Damage_Dealt"] = "Most Damage Dealt"
LANGUAGE["Game_Damage"] = "Damage"
LANGUAGE["Game_Most_Damage_Taken"] = "Most Damage Taken"
LANGUAGE["Game_Damage_Taken"] = "Damage Taken"
LANGUAGE["Game_Most_Kills"] = "Most Kills"
LANGUAGE["Game_Kills"] = "Kills"
LANGUAGE["Game_Elite_Killer"] = "Elite Killer"
LANGUAGE["Game_Elite_Kills"] = "Elite Kills"
LANGUAGE["Game_SharpShooter"] = "SharpShooter"
LANGUAGE["Game_Headshots"] = "Headshots"
LANGUAGE["Game_Most_Heal"] = "Most Heal"
LANGUAGE["Game_Healed"] = "Healed"
LANGUAGE["Game_Healed_You"] = "healed you"


-- Ranks
LANGUAGE["Rank_Novice"] = "Novice"
LANGUAGE["Rank_Amateur"] = "Amateur"
LANGUAGE["Rank_Skilled"] = "Skilled"
LANGUAGE["Rank_Professional"] = "Professional"
LANGUAGE["Rank_Expert"] = "Expert"
LANGUAGE["Rank_Champion"] = "Champion"
LANGUAGE["Rank_Master"] = "Master"


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
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Buy Ammo Clip"
LANGUAGE["Shop_Sell_For"] = "Sell For"
LANGUAGE["Shop_Sell_All_For"] = "Sell All For"
LANGUAGE["Shop_Buy_Item"] = "Buy Item"
LANGUAGE["Shop_OWNED"] = "OWNED"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Buy Secondary Ammo"
LANGUAGE["Shop_Primary_Ammo"] = "Primary Ammo"
LANGUAGE["Shop_Secondary_Ammo"] = "Secondary Ammo"


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


-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
The Survivor class can be played into any class to fill in missing roles for the team.
Complexity: EASY

No bonus.]]

LANGUAGE["Perk_assault_base"] = [[
The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.
Complexity: EASY

{1} increased movement speed.
Gain Adrenaline when you kill an enemy.
Adrenaline increases damage and speed by {2}.]]

LANGUAGE["Perk_heavy_base"] = [[
The Heavy class is a tank class that provides strong suppression firepower.
Complexity: EASY

Adds {1} to maximum carrying capacity.
Regenerate {2} armor per second.
Regenerate up to {3} armor.]]

LANGUAGE["Perk_medic_base"] = [[
The Medic class is a durable support class that focuses on healing and buffing teammates.
Complexity: MEDIUM

Regenerate {1} health per second.]]

LANGUAGE["Perk_demolition_base"] = [[
The Demolition class is a crowd-control class that can also provide high single target damage.
Complexity: MEDIUM

{1} increased Blast damage resistance.
Regenerate {2} frag grenade every {3} seconds, if you do not have one.]]

LANGUAGE["Perk_ghost_base"] = [[
The Ghost class is focused on taking down boss enemies using Camoflague.
Complexity: HIGH

{1} more headshot damage.
Crouch to activate Camoflague, granting {2} evasion.
Attacking or Running REMOVES Camoflague.]]

LANGUAGE["Perk_engineer_base"] = [[
The Engineer class is a minion-centered class that deals damage through minions.
Complexity: MEDIUM

{1} increased minion health and damage.
Turrets have {2} base health and deals {3} base damage.]]

LANGUAGE["Perk_berserker_base"] = [[
The Berserker class is a melee-centered class that can be played both offensively and defensively.
Complexity: HIGH

{1} increased Global damage resistance.
{2} increased Poison damage resistance.]]

LANGUAGE["Perk_warden_base"] = [[
The Warden is a support class that uses aura effects and structures to buff teammates.
Complexity: MEDIUM

Players near you are affected by Warden Aura.
Warden Aura blocks {1} damage.]]

LANGUAGE["Perk_cremator_base"] = [[
The Cremator builds its offense and defense around Fire damage.
Complexity: EASY

{1} increased Fire damage resistance.
Attacks have {2} chance to Ignite enemies.

Ignite base duration is {3} and deals damage over time based on hit damage.
Fire damage has {5} Ignite chance.]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[Survival]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[Improvise]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[Inspired Learning]]

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
Adrenaline duration increased by {1}.
Adds {2} maximum Adrenaline stacks.]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[Conditioning]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[Heightened Reflex]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
{1} increased headshot damage.
{2} increased global damage resistance on full health.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[Cardiac Overload]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
{1} chance to add 1 Adrenaline stack on headshot.
Adds {2} maximum Adrenaline stacks.]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[Suppression]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[Sticky Compound]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
Enemies you hit with Ballistic damage are Slowed.
Slowed enemies have {1} reduced action speed.]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[Crude Casing]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
Enemies you hit with Ballistic damage are Weakened.
Weakened enemies deal {1} reduced damage.
Weakened enemies receive {2} increased damage.]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[Armor Protection]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[Liquid Armor]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
While you have at least {1} armor:
  {2} increasaed Physical damage resistance.]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[Reactive Armor]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
While you have at least {1} armor:
  Immune to Poison, Fire and Blast damage.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[Technology]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[Nanomachine]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
{1} increased armor regeneration rate.
You can now regenerate up to {2} armor.]]

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
{2} increased damage and speed while you have Berserk.]]

LANGUAGE["Perk_Title_medic_fortify"] = [[Fortify]]
LANGUAGE["Perk_medic_fortify"] = [[
Players you heal have Fortify for {1} seconds.
{2} less damage taken while you have Fortify.]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[Natural Selection]]
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
{1} increased Blast damage.
{2} increased Grenade damage.]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[Cluster Grenade]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
Grenades and SLAMs spawn {1} mini-nades on detonation.
Mini-nades do {2} less damage.]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[Approach]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[Fragmentation]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
{1} increased Blast damage against enemies on full health.]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[Knockout]]
LANGUAGE["Perk_demolition_knockout"] = [[
Blast damage builds up stun power.
Stuns enemy for {1} seconds when power reaches {2}.
Stun cooldown is {3} seconds.]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[Destruction]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[Pressurized Warhead]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
{1} increased Blast damage against elites.
Explosions deal {2} of enemies' current health as extra Blast damage.]]

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
25% increased movement speed when you have Camoflague.]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[Ghost Veil]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
Attacking does not cancel Camoflague.
100% increased Camoflague activation speed.]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[Disposal]]
LANGUAGE["Perk_Title_ghost_coup"] = [[Coup De Grace]]
LANGUAGE["Perk_ghost_coup"] = [[
Instantly kills enemies with less than 20% health.]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[Decapitate]]
LANGUAGE["Perk_ghost_decapitate"] = [[
When you have Camoflague:
  25% increased Ballistic damage.
  50% increased headshot damage against elites.]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[Craftsmanship]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[Tinkerer]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
{1} more minion health.]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[Pioneer]]
LANGUAGE["Perk_engineer_pioneer"] = [[
{1} increased minion damage.]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[Archetype]]
LANGUAGE["Perk_Title_engineer_golem"] = [[Golem]]
LANGUAGE["Perk_engineer_golem"] = [[
Minions regenerate {1} health per second.
Minion attacks have increased knockback.]]

LANGUAGE["Perk_Title_engineer_spectre"] = [[Spectre]]
LANGUAGE["Perk_engineer_spectre"] = [[
Minions leech {1} of damage dealt.
{2} more minion damage.]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[Experimental]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[Symbiosis]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
Minions have {1} more health on spawn.
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
Leech {1} of melee damage done.
Leech is capped at {2} hp per hit.]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[Technique]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[Bushido]]
LANGUAGE["Perk_berserker_bushido"] = [[
{1} increased Slashing damage.
{2} increased movement speed.]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[Savagery]]
LANGUAGE["Perk_berserker_savagery"] = [[
{1} increased Blunt damage.
{2} increased maximum health.]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[Combat Arts]]
LANGUAGE["Perk_Title_berserker_mindeye"] = [[Mind's Eye]]
LANGUAGE["Perk_berserker_mindeye"] = [[
Each melee attack increases Mind's Eye stack by 1, up to {1}.
Each stack increases {2} evasion and {3} melee damage.
Loses all stacks when you are hit or exceeded max stack.]]

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

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[Coverage]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[Deus Ex Machina]]
LANGUAGE["Perk_warden_ex_machina"] = [[
Watchtowers have Warden Aura.
Watchtowers generate a shockwave every {1} seconds.
Shockwave deals {2} Shock damage.]]

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
{1} increased Ignite radius.
{2} increased Ignite duration.]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[Energy Absorption]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[Positron Array]]
LANGUAGE["Perk_cremator_positron_array"] = [[
Immune to Fire damage.
Absorb {1} of Fire damage taken as health.]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[Entropy Shield]]
LANGUAGE["Perk_cremator_entropy_shield"] = [[
Gain a shield that negates damage taken.
Shield explodes on hit and recharges after {1} seconds.
Explosion deals {2} Fire damage.]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[Energy Discharge]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[Firestorm]]
LANGUAGE["Perk_cremator_firestorm"] = [[
Fire damage builds up Burst power in enemies.
Creates an explosion when Burst power reaches {1}.
Explosion deals {2} Blast damage.]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[Incineration]]
LANGUAGE["Perk_cremator_incineration"] = [[
{1} increased Ignite damage.
{2} increased Ignite chance.]]


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

LANGUAGE["Item_Resistance RPG"] = [[Resistance RPG]]
LANGUAGE["Item_Desc_Resistance RPG"] = [[
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
A watchtower that deters enemies.\nShocks 1 nearby enemy every 1 second.
Does 100 shock damage.
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