--Simply used as a test for leaping tiles, not meant for mission use
-- mission Mission_Skylance_Leaping_Enviornment_Testing

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
--local worldConstants = mod.libs.worldConstants
local leapingTiles = mod.libs.leapingTiles

local tiles = {{Point(5,5),Point(4,5),Point(5,4),Point(6,5),Point(5,6)},{Point(5,2),Point(4,2),Point(5,1),Point(6,2),Point(5,3)}}

Mission_Skylance_Leaping_Enviornment_Testing = Mission_Infinite:new {
  Name = "Leaping Tiles",
  Environment = "Env_Leaping_Tiles",
  MovingTiles = tiles,
}

function Mission_Skylance_Leaping_Enviornment_Testing:StartMission()
  for x=4,7 do
    for y=0,7 do
      local point = Point(x,y)
      if not list_contains(self.MovingTiles[1],point) then
        Board:ClearSpace(point)
        Board:SetTerrain(point,TERRAIN_HOLE)
      end
    end
  end
  for i, point in ipairs(self.MovingTiles[1]) do
    --Board:ClearSpace(point)
    Board:SetTerrain(point,TERRAIN_ROAD)
    Board:SetCustomTile(point,"moving_tile.png")
  end
end

Env_Leaping_Tiles = Environment:new{
  Name = "Leaping Tiles",
  Text = "Magic tiles are leaping around the island.", --Descriptive
  CombatName = "LEAPING TILES",
  StratText = "LEAPING TILES",
  CombatIcon = "advanced/combat/tile_icon/tile_wind_up.png",
  Position = 1,
  MovingTiles = tiles,
  Ready = false,
  Pawn = "NAH_Leaping_Tile",
  CustomTile = "moving_tile.png",
}

--TODO:
--DESCRIPTION of tiles
function Env_Leaping_Tiles:MarkBoard()
  if self.Ready then
    local otherPos = self.Position%2+1
    local combatIcon = self.Position == 1 and "advanced/combat/tile_icon/tile_wind_up.png" or "advanced/combat/tile_icon/tile_wind_down.png"
    for i, point in ipairs(self.MovingTiles[self.Position]) do
      local point2 = self.MovingTiles[otherPos][i]
      if Board:GetTerrain(point) == TERRAIN_ROAD or Board:GetTerrain(point) == TERRAIN_BUILDING and Board:GetTerrain(point2) == TERRAIN_HOLE then
        Board:MarkSpaceImage(point, combatIcon, GL_Color(255,226,88,0.75))
        Board:MarkSpaceImage(point2, "combat/tile_icon/tile_airstrike.png", GL_Color(255,226,88,0.75))
      end
    end
  end
end

function Env_Leaping_Tiles:IsEffect() return self.Ready end

function Env_Leaping_Tiles:Plan()
  self.Ready = true
  return false
end

function Env_Leaping_Tiles:ApplyEffect()
  local currPos = self.Position
  local newPos = self.Position%2+1
  self.Ready = false

  Skylance_leapingTiles:move_tiles(self.MovingTiles[currPos],self.MovingTiles[newPos])

  self.Position = newPos
  return false
end
