local mod = mod_loader.mods[modApi.currentMod]
local customAnim = mod.libs.customAnim

--waterfall name and tileset
local TILESET = "Skylance_tileset_id"
local WATERFALL = TILESET .. "_Waterfall"

----------------
-- ANIMATIONS --
----------------

-- Base waterfall
ANIMS[WATERFALL] = Animation:new{
	NumFrames = 3,
	Time = 0.19,
	Loop = true,
	Layer = LAYER_FLOOR--LAYER_BACK
}

--Perspective of the hole
ANIMS['3'..WATERFALL] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_U.png", PosX = -28, PosY = 25
}

ANIMS['2'..WATERFALL] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_L.png", PosX = -10, PosY = 25
}

ANIMS['1'..WATERFALL] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_D.png", PosX = -11, PosY = 7
}

ANIMS['0'..WATERFALL] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_R.png", PosX = -27, PosY = 7
}

local order = {3,0,1,2} -- needed to align waterfall position and sprite display order

ANIMS['3'..WATERFALL.."_edge"] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_U.png", PosX = -28+28, PosY = 25-21,Layer = LAYER_FLOOR
}

ANIMS['2'..WATERFALL.."_edge"] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_L.png", PosX = -10-28, PosY = 25-21,Layer = LAYER_FLOOR
}

ANIMS['1'..WATERFALL.."_edge"] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_D.png", PosX = -11-28, PosY = 7+21,Layer = LAYER_FRONT
}

ANIMS['0'..WATERFALL.."_edge"] = ANIMS[WATERFALL]:new{
    Image = "combat/tiles_"..TILESET.."/waterfall_R.png", PosX = -27+28, PosY = 7+21,Layer = LAYER_FRONT
}

---------------
-- FUNCTIONS --
---------------

--exception list
local function exceptionList(point)
	local mission = GetCurrentMission()
	if
		mission and mission.Incinerator and mission.Incinerator == point
	then
		return true
	else
		return false
	end
end

local function isWaterTile(point)
	return Board:GetTerrain(point) == TERRAIN_WATER and
		Board:GetTerrain(point) ~= TERRAIN_ICE and
		not Board:IsTerrain(point,TERRAIN_LAVA) and
		not Board:IsAcid(point)
end


local function waterfallTile(point)
	if not Board:IsValid(point) then
		return
	end

	for i,j in ipairs(order) do -- re-do waterfalls on tile
		customAnim:rem(point,(i-1)..WATERFALL)
		customAnim:rem(point,(i-1)..WATERFALL.."_edge") --Also remove edge
		if Board:GetTerrain(point) == TERRAIN_HOLE and not exceptionList(point) then
			local curr = point + DIR_VECTORS[j]
			if Board:IsValid(curr) and isWaterTile(curr) then
				customAnim:add(point,(i-1)..WATERFALL)
			end
		end
	end

	--Edge Waterfalls
	if isWaterTile(point) then
		if (point.x == 0) then
			customAnim:add(point,"2"..WATERFALL.."_edge")
		end
		if (point.x == 7) then
			customAnim:add(point,"0"..WATERFALL.."_edge")
		end
		if (point.y == 0) then
			customAnim:add(point,"3"..WATERFALL.."_edge")
		end
		if (point.y == 7) then
			customAnim:add(point,"1"..WATERFALL.."_edge")
		end
	end
end

local function waterfallAdjacent(point)
	for d = DIR_START, DIR_END do -- re-do waterfalls on adjacent
		local loc = point + DIR_VECTORS[d]
		waterfallTile(loc)
	end
end


local EVENT_onTerrainChanged = function(point, newTerrain, oldTerrain)
	if modApi:getCurrentTileset() == TILESET then
		if false
			or newTerrain == TERRAIN_WATER
			or newTerrain == TERRAIN_HOLE
			or oldTerrain == TERRAIN_WATER
			or oldTerrain == TERRAIN_HOLE
		then
			waterfallTile(point)
			waterfallAdjacent(point)
		end
	end
end

local EVENT_onTerrainChanged = function(point, newTerrain, oldTerrain)
	if modApi:getCurrentTileset() == TILESET then
		if false
			or newTerrain == TERRAIN_WATER
			or newTerrain == TERRAIN_HOLE
			or oldTerrain == TERRAIN_WATER
			or oldTerrain == TERRAIN_HOLE
		then
			waterfallTile(point)
			waterfallAdjacent(point)
		end
	end
end

local EVENT_onAcidLava = function(point)
	if modApi:getCurrentTileset() == TILESET then
		if Board:GetTerrain(point) == TERRAIN_WATER then
			waterfallTile(point)
			waterfallAdjacent(point)
		end
	end
end

local function HOOK_mapEntered(mission)
	for x = 0, 7 do
		for y = 0, 7 do
			local point = Point(x,y)
			waterfallTile(point)
		end
	end
end

local function HOOK_missionEnd(mission)
	for x = 0, 7 do
		for y = 0, 7 do
			local point = Point(x,y)
			waterfallTile(point)
		end
	end
end

-- for use outside of this script
function AddCustomWaterfall(point)
	if modApi:getCurrentTileset() == TILESET then
		waterfallTile(point)
	end
end

-----------
-- HOOKS --
-----------

local function EVENT_onModsLoaded()
	modApi:addTestMechEnteredHook(HOOK_mapEntered)
	modApi:addMissionStartHook(HOOK_mapEntered)
	modApi:addMissionEndHook(HOOK_missionEnd)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
BoardEvents.onTerrainChanged:subscribe(EVENT_onTerrainChanged)
BoardEvents.onAcidCreated:subscribe(EVENT_onAcidLava)
BoardEvents.onAcidRemoved:subscribe(EVENT_onAcidLava)
BoardEvents.onLavaCreated:subscribe(EVENT_onAcidLava)
BoardEvents.onLavaRemoved:subscribe(EVENT_onAcidLava)
