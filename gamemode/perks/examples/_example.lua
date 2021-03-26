--PERK.ClassName = "_example" -- This will be automatically generated, but you can define it manually too
PERK.PrintName = "Default Perk"
PERK.Description = "This description will be formatted where {parameter_integer} is replaced with the value."
PERK.Ignore = true -- Set to true to not load perk.

-- A list of parameters that can be configured in the editor.
-- These will be saved alongside the class.
 = {
    --["parameter_integer"] = {type = "i", default = 1, min = 0, max = 2},
    --["parameter_float"] = {type = "f", default = 0.5, min = 0, max = 1, percent = true},
    --["parameter_boolean"] = {type = "b", default = false},
    --["parameter_string"]  = {type = "s", default = "weapon_crowbar", weapon = true},
}
--[[
Special parameters:
percent - this float will be displayed as a percent. e.g. 0.1 is shown as 10%, 1.5 as 150%.
weapon - the game will treat the string as a weapon class (showing nice name in description if possible)
]]

-- A list of hooks that will be created on load.
-- These are SHARED!
PERK.Hooks = {}