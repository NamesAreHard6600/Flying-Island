
local this = {}
local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local path = mod.scriptPath.."missions/"

local function file_exists(name)
	local f = io.open(name, "r")
	if f then io.close(f) return true else return false end
end

local HIGH_THREAT = true
local LOW_THREAT = false

local BASE_MISSIONS = {
  {"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
	{"Train", HIGH_THREAT}, -- We have our own train, comment out when added
  {"Trapped", LOW_THREAT},
	{"Survive", LOW_THREAT},
}

local Nautilus_Missions = {
  {"Leaping_Control",LOW_THREAT},
	{"Leaping_Scramble",LOW_THREAT},
	{"Leaping_Minimal",LOW_THREAT},
}

function this:init(mod)
  -- create mission list
  local missionList = easyEdit.missionList:add("Skylance_mission_list_id")
  missionList.name = "Skylance"

  for _, table in ipairs(BASE_MISSIONS) do
    local name = "Mission_"..table[1]
    local threat = table[2]
    missionList:addMission(name, threat)
  end

  for _, table in ipairs(Nautilus_Missions) do
    local name = table[1]
    local mission_name = "Mission_Skylance_"..name
    local threat = table[2]
    require(path..string.lower(name))
    missionList:addMission(mission_name, threat)
  end

	require(path.."missionImages")
	require(path.."text")
end

return this
