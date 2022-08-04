-- Status Mapping
-- Please use the variable names instead of the values!

if SERVER then
util.AddNetworkString("Horde_SyncActivePerk")
end

HORDE.Status_CanBuy = 0

HORDE.Status_AntimatterShield = 1
HORDE.Status_Displacer = 2
HORDE.Status_Void_Cascade = 3
HORDE.Status_Devour = 4
HORDE.Status_Quickstep = 5
HORDE.Status_Hunter_Mark = 6
HORDE.Status_Hallowed_Bolt = 7
HORDE.Status_Floating_Chaos = 8
HORDE.Status_Smokescreen = 9
HORDE.Status_Flare = 10
HORDE.Status_Negative_Burst = 11
HORDE.Status_Gravity_Vacuum = 12

HORDE.Status_Tactical_Mode = 13
HORDE.Status_Camoflague = 14
HORDE.Status_Frenzy_Mode = 15

HORDE.Status_Minion = 16
HORDE.Status_Adrenaline = 17
HORDE.Status_Headhunter = 18
HORDE.Status_Deadeye = 19
HORDE.Status_Intensity = 20
HORDE.Status_Neuron_Stabilizer = 21
HORDE.Status_Phalanx = 22
HORDE.Status_Brutality = 23
HORDE.Status_Nether_Star = 24
HORDE.Status_Nether_Mine = 25

HORDE.Status_Fortify = 26
HORDE.Status_Berserk = 27
HORDE.Status_Haste = 28
HORDE.Status_ArmorRegen = 29
HORDE.Status_HealthRegen = 30
HORDE.Status_Quickdraw = 31
HORDE.Status_WardenAura = 32
HORDE.Status_EntropyShield = 33
HORDE.Status_Foresight = 34
HORDE.Status_Nine_Lives = 35
HORDE.Status_Smokescreen_Effect = 36
HORDE.Status_Unwavering_Guard = 37

HORDE.Status_Armor_Survivor = 51
HORDE.Status_Armor_Assault = 52
HORDE.Status_Armor_Heavy = 53
HORDE.Status_Armor_Demolition = 54
HORDE.Status_Armor_Ghost = 55
HORDE.Status_Armor_Medic = 56
HORDE.Status_Armor_Engineer = 57
HORDE.Status_Armor_Warden = 58
HORDE.Status_Armor_Cremator = 59
HORDE.Status_Armor_Berserker = 60

HORDE.Status_ExpDisabled = 61
HORDE.Status_Bleeding = 62
HORDE.Status_Ignite = 63
HORDE.Status_Frostbite = 64
HORDE.Status_Shock = 65
HORDE.Status_Break = 66
HORDE.Status_Decay = 67
HORDE.Status_Necrosis = 68
HORDE.Status_Psychosis = 69
HORDE.Status_Stun = 70
HORDE.Status_Freeze = 71

HORDE.Status_Icon = {}
HORDE.Status_Icon[HORDE.Status_Camoflague] = "materials/status/camoflague.png"
HORDE.Status_Icon[HORDE.Status_Adrenaline] = "materials/status/adrenaline.png"
HORDE.Status_Icon[HORDE.Status_Headhunter] = "materials/perks/headhunter.png"
HORDE.Status_Icon[HORDE.Status_Deadeye] = "materials/perks/gunslinger/deadeye.png"
HORDE.Status_Icon[HORDE.Status_Intensity] = "materials/perks/artificer/intensity.png"
HORDE.Status_Icon[HORDE.Status_Fortify] = "materials/perks/fortify.png"
HORDE.Status_Icon[HORDE.Status_Berserk] = "materials/perks/berserk.png"
HORDE.Status_Icon[HORDE.Status_Haste] = "materials/perks/haste.png"
HORDE.Status_Icon[HORDE.Status_ArmorRegen] = "materials/status/armorregen.png"
HORDE.Status_Icon[HORDE.Status_HealthRegen] = "materials/status/healthregen.png"
HORDE.Status_Icon[HORDE.Status_Minion] = "materials/status/minion.png"
HORDE.Status_Icon[HORDE.Status_Phalanx] = "materials/perks/phalanx.png"
HORDE.Status_Icon[HORDE.Status_Brutality] = "materials/perks/psycho/brutality.png"
HORDE.Status_Icon[HORDE.Status_Nether_Star] = "materials/perks/warlock/nether_star.png"
HORDE.Status_Icon[HORDE.Status_Nether_Mine] = "materials/perks/warlock/nether_mine.png"

HORDE.Status_Icon[HORDE.Status_Quickdraw] = "materials/perks/gunslinger/quickdraw.png"
HORDE.Status_Icon[HORDE.Status_WardenAura] = "materials/warden.png"
HORDE.Status_Icon[HORDE.Status_EntropyShield] = "materials/perks/entropy_shield.png"
HORDE.Status_Icon[HORDE.Status_AntimatterShield] = "materials/perks/antimatter_shield.png"
HORDE.Status_Icon[HORDE.Status_Displacer] = "materials/perks/displacer.png"
HORDE.Status_Icon[HORDE.Status_Void_Cascade] = "materials/perks/necromancer/void_cascade.png"
HORDE.Status_Icon[HORDE.Status_Devour] = "materials/perks/necromancer/necromastery.png"
HORDE.Status_Icon[HORDE.Status_Quickstep] = "materials/abilities/quickstep.png"
HORDE.Status_Icon[HORDE.Status_Foresight] = "materials/perks/samurai/foresight.png"
HORDE.Status_Icon[HORDE.Status_Hunter_Mark] = "materials/status/hunter_mark.png"
HORDE.Status_Icon[HORDE.Status_Nine_Lives] = "materials/perks/gunslinger/nine_lives.png"
HORDE.Status_Icon[HORDE.Status_Tactical_Mode] = "materials/status/tactical_mode.png"
HORDE.Status_Icon[HORDE.Status_Neuron_Stabilizer] = "materials/perks/specops/neuron_stabilizer.png"
HORDE.Status_Icon[HORDE.Status_Hallowed_Bolt] = "materials/perks/artificer/hallowed_bolt.png"
HORDE.Status_Icon[HORDE.Status_Floating_Chaos] = "materials/perks/artificer/floating_chaos.png"
HORDE.Status_Icon[HORDE.Status_Smokescreen] = "materials/perks/specops/smokescreen.png"
HORDE.Status_Icon[HORDE.Status_Flare] = "materials/perks/specops/flare.png"
HORDE.Status_Icon[HORDE.Status_Negative_Burst] = "materials/perks/warlock/negative_burst.png"
HORDE.Status_Icon[HORDE.Status_Gravity_Vacuum] = "materials/perks/warlock/gravity_vacuum.png"
HORDE.Status_Icon[HORDE.Status_Smokescreen_Effect] = "materials/status/evasion.png"

HORDE.Status_Icon[HORDE.Status_Unwavering_Guard] = "materials/perks/unwavering_guard.png"
HORDE.Status_Icon[HORDE.Status_CanBuy] = "materials/status/canbuy.png"
HORDE.Status_Icon[HORDE.Status_ExpDisabled] = "materials/status/exp_disabled.png"

HORDE.Status_Icon[HORDE.Status_Armor_Survivor] = "items/armor_survivor.png"
HORDE.Status_Icon[HORDE.Status_Armor_Assault] = "items/armor_assault.png"
HORDE.Status_Icon[HORDE.Status_Armor_Heavy] = "items/armor_heavy.png"
HORDE.Status_Icon[HORDE.Status_Armor_Demolition] = "items/armor_demolition.png"
HORDE.Status_Icon[HORDE.Status_Armor_Ghost] = "items/armor_ghost.png"
HORDE.Status_Icon[HORDE.Status_Armor_Medic] = "items/armor_medic.png"
HORDE.Status_Icon[HORDE.Status_Armor_Engineer] = "items/armor_engineer.png"
HORDE.Status_Icon[HORDE.Status_Armor_Warden] = "items/armor_warden.png"
HORDE.Status_Icon[HORDE.Status_Armor_Cremator] = "items/armor_cremator.png"
HORDE.Status_Icon[HORDE.Status_Armor_Berserker] = "items/armor_berserker.png"

HORDE.Status_Icon[HORDE.Status_Bleeding] = "materials/status/bleeding.png"
HORDE.Status_Icon[HORDE.Status_Ignite] = "materials/status/ignite.png"
HORDE.Status_Icon[HORDE.Status_Frostbite] = "materials/status/frostbite.png"
HORDE.Status_Icon[HORDE.Status_Shock] = "materials/status/shock.png"
HORDE.Status_Icon[HORDE.Status_Break] = "materials/status/break.png"
HORDE.Status_Icon[HORDE.Status_Decay] = "materials/status/decay.png"
HORDE.Status_Icon[HORDE.Status_Necrosis] = "materials/status/necrosis.png"
HORDE.Status_Icon[HORDE.Status_Psychosis] = "materials/status/psychosis.png"

HORDE.Status_Buildup_Sounds = {}
HORDE.Status_Buildup_Sounds[HORDE.Status_Bleeding] = "horde/status/bleeding_buildup.ogg"
--HORDE.Status_Buildup_Sounds[HORDE.Status_Ignite] = "player/general/flesh_burn.wav"
HORDE.Status_Buildup_Sounds[HORDE.Status_Frostbite] = "horde/status/frostbite_buildup.ogg"
HORDE.Status_Buildup_Sounds[HORDE.Status_Shock] = "weapons/stunstick/stunstick_fleshhit2.wav"
HORDE.Status_Buildup_Sounds[HORDE.Status_Break] = "ambient/levels/canals/toxic_slime_sizzle1.wav"

HORDE.Status_Trigger_Sounds = {}
HORDE.Status_Trigger_Sounds[HORDE.Status_Bleeding] = "horde/status/bleeding_trigger.ogg"
--HORDE.Status_Trigger_Sounds[HORDE.Status_Ignite] = "ambient/fire/fire_small1.wav"
HORDE.Status_Trigger_Sounds[HORDE.Status_Frostbite] = "horde/status/frostbite_trigger.ogg"
HORDE.Status_Trigger_Sounds[HORDE.Status_Shock] = "horde/status/shock_trigger.ogg"
HORDE.Status_Trigger_Sounds[HORDE.Status_Break] = "horde/status/break_trigger.ogg"

function HORDE:IsStatusStackable(status)
    if status >= HORDE.Status_Minion and status <= HORDE.Status_Nether_Mine then return true end
    return false
end

function HORDE:IsDebuff(status)
    return status > HORDE.Status_ExpDisabled
end

function HORDE:IsSkillStatus(status)
    return status >= HORDE.Status_AntimatterShield and status <= HORDE.Status_Gravity_Vacuum
end

function HORDE:IsStackableSkillStatus(status)
    if status == HORDE.Status_Quickstep then return true end
end