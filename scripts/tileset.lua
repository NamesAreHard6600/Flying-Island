-- create tileset
local tileset = easyEdit.tileset:add("Skylance_tileset_id", "lava")

tileset.name = "NEEDS NAME" -- Name of tileset

-- appends all assets in the path relative to mod's resource path
tileset:appendAssets("img/tileset/")

-- display name of the climate in game, displays on island select screen
tileset:setClimate("NEEDS NAME")

-- percentage chance of a mission having rain
tileset:setRainChance(20)
tileset:setCrackChance(10)

-- percentage chance that a regular ground tile gets changed to the following
tileset:setEnvironmentChance{
	[TERRAIN_ACID] = 0,
	[TERRAIN_FOREST] = 0,
	[TERRAIN_SAND] = 10,
	[TERRAIN_ICE] = 0,
}

-- set custom tooltip text for various tile types
--[[
tileset:setTileTooltip{
	tile = "sand",
	title = "Volatile Silicates",
	text = "If damaged, turns into Smoke. \nUnits in Smoke cannot attack or repair."
}
tileset:setTileTooltip{
	tile = "forest",
	title = "Fungal Forest",
	text = "If damaged, lights on Fire."
}
tileset:setTileTooltip{
	tile = "forest_fire",
	title = "Fungal Fire",
	text = "Lights units on Fire. This fire was started when a Fungal Forest was damaged."
}]]
