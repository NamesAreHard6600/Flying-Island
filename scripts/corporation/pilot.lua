
local path = GetParentPath(...)
local pilot_dialog = require(path.."pilot_dialog")

local mod = modApi:getCurrentMod()
local resourcePath = mod.resourcePath

-- add pilot images
modApi:appendAsset("img/portraits/npcs/Skylance.png", resourcePath.."img/corp/pilot.png")
modApi:appendAsset("img/portraits/npcs/Skylance_2.png", resourcePath.."img/corp/pilot_2.png")
modApi:appendAsset("img/portraits/npcs/Skylance_blink.png", resourcePath.."img/corp/pilot_blink.png")

-- create personality
local personality = CreatePilotPersonality("Skylance_Pilot_Label")
personality:AddDialogTable(pilot_dialog)

-- add our personality to the global personality table
Personality["Skylance_pilot_personality_id"] = personality

-- create pilot
-- reference the personality we created
-- reference the pilot images we added
CreatePilot{
	Id = "Skylance_pilot_id",
	Personality = "Skylance_pilot_personality_id",
	Rarity = 0,
	Cost = 1,
	Portrait = "npcs/Skylance",
	Voice = "/voice/rust", --NEEDS VOICE
}

modApi:addPilotDrop{id = "Skylance_pilot_id", recruit = true }
