-- mission Mission_Skylance_Leaping_Minimal

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
--local worldConstants = mod.libs.worldConstants

local tiles = {{Point(2,2),Point(2,5),Point(5,5),Point(5,2)},{Point(2,5),Point(5,5),Point(5,2),Point(2,2)}}

Mission_Skylance_Leaping_Minimal = Mission_Infinite:new {
  Name = "Leaping Tiles",
  Environment = "Env_Leaping_Minimal",
  MovingTiles = tiles,
}

function Mission_Skylance_Leaping_Minimal:StartMission()
  for i, point in ipairs(self.MovingTiles[1]) do
    Board:ClearSpace(point)
    Board:SetCustomTile(point,"moving_tile.png")
    --Block spawns
  end
end

Env_Leaping_Minimal = Environment:new{
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
function Env_Leaping_Minimal:MarkBoard()
  if self.Ready then
    local otherPos = self.Position%2+1
    local combatIcon = self.Position == 1 and "advanced/combat/tile_icon/tile_wind_up.png" or "advanced/combat/tile_icon/tile_wind_down.png"
    for i, point in ipairs(self.MovingTiles[self.Position]) do
      local point2 = self.MovingTiles[otherPos][i]
      --if Board:GetTerrain(point) == TERRAIN_ROAD and Board:GetTerrain(point2) == TERRAIN_HOLE then
      --Board:MarkSpaceImage(point, combatIcon, GL_Color(255,226,88,0.75))
      Board:MarkSpaceImage(point2, "combat/tile_icon/tile_airstrike.png", GL_Color(255,226,88,0.75))
      --end
    end
  end
end

function Env_Leaping_Minimal:IsEffect() return self.Ready end

function Env_Leaping_Minimal:Plan()
  self.Ready = true
  return false
end

function Env_Leaping_Minimal:ApplyEffect()
  local currPos = self.Position
  local newPos = self.Position%2+1
  self.Ready = false

  Skylance_leapingTiles:move_tiles(self.MovingTiles[currPos],self.MovingTiles[newPos])

  self.Position = newPos
  return false
end
