
-- initialize mod
local mod = {
	id = "Skylance",
	name = "Skylance",
	description = "NEEDS DESCRIPTION",
	icon = "scripts/icon.png",
	version = "0.0.1",
	dependencies = {
		modApiExt = "1.18",
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
}

function mod:init()
	self.libs = {}
	self.libs.modApiExt = modapiext
	self.libs.weaponPreview = require(self.scriptPath.."libs/weaponPreview")
	self.libs.customAnim = require(mod.scriptPath.."libs/customAnim")
	self.libs.worldConstants = require(mod.scriptPath.."libs/worldConstants")
	Skylance_leapingTiles = require(self.scriptPath.."libs/leapingTiles") --Needs to be global for script purposes

	require(mod.scriptPath.."libs/boardEvents")

	require(self.scriptPath.."island")
	require(self.scriptPath.."ceo/ceo")
	require(self.scriptPath.."corporation/pilot")
	require(self.scriptPath.."corporation/corporation")
	require(self.scriptPath.."tileset")
	require(self.scriptPath.."bossList")
	require(self.scriptPath.."enemyList")
	require(self.scriptPath.."structures")
	require(self.scriptPath.."structureList")
	require(self.scriptPath.."island_composite")
	require(self.scriptPath.."background") --Background needs to be before waterfall so it goes under the waterfalls
	--require(self.scriptPath.."waterfall")
	require(self.scriptPath.."extra_dialog")
	require(self.scriptPath.."leapingTiles")

	self.missions = require(self.scriptPath.."missions/init")
	self.missions:init(self)
end

function mod:load(options, version)

end

function mod:metadata()
	modApi:addGenerationOption(
		"Nautilus_CaveBackground",
		"Cave Background",
		"Check to turn on the cave background in each mission. Requires a restart.",
		{ enabled = true } --Change default later
	)
end

return mod
