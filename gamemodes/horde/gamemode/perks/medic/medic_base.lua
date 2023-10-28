PERK.PrintName = "Medic Base"
PERK.Description = [[
The Medic class is a durable support class that focuses on healing and buffing teammates.
Complexity: MEDIUM

Amplifies healing by {1}. ({2} per level, up to {3}).

Regenerate {4} health per second.]]
PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Medic},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 0.01, percent = true},
}

PERK.Hooks = {}

local healthColorCache = {}

local function getHealthColor( health )
    local cached = healthColorCache[health]
    if cached then return cached end

    local hue = math.Clamp(( health / 100 ) * 120, 0, 175)
    local color = HSVToColor( hue, 1, 1 )
    healthColorCache[health] = color
    return color
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "medic_base" then
        ply:Horde_SetHealthRegenPercentage(0.01)
    end
    if perk == "medic_base" then
        hook.Add("PreDrawHalos", "MedicHealthOutlines", function()
            for _, user in ipairs(player.GetAll()) do
                local HealthPoints = user:Health()
                if HealthPoints > 0 and HealthPoints < user:GetMaxHealth() then
                    halo.Add({user}, getHealthColor(HealthPoints), 2, 2, 1, true, false)
                end
            end
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if perk == "medic_base" then
        if SERVER then
            ply:Horde_SetHealthRegenPercentage(0)
        else
            hook.Remove("PreDrawHalos", "MedicHealthOutlines")
        end
    end
end

PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_base") then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * healer:Horde_GetPerkLevelBonus("medic_base"))
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("medic_base", 1 + math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Medic)))
    end
end
