
-- create corporation
local corporation = easyEdit.corporation:add("Skylance_corporation_id")
corporation.Name = "Skylance Finance" --Full name of island, displays on CEO intro screen
corporation.Bark_Name = "Skylance" --Name of island used in most places like pilot barks etc.
corporation.Description = "NEEDS DESCRIPTION" -- Description of island, seen on island select screen
corporation.Color = GL_Color(18,23,27) --NEEDS COLOR?
corporation.Map = { "/music/grass/map" } --Music for island
corporation.Music = { --NEEDS MUSIC
	"/music/grass/combat_delta", 		--Relics
	"/music/sand/combat_eastwood", 		--Cataclysm
	"/music/snow/combat_new", 			--Plasmodia (AE)
	"/music/acid/combat_detritus"		--A.C.I.D.
}

-- reference the pilot id created in pilot.lua
corporation.Pilot = "Skylance_pilot_id"

----------------
-- music list --
----------------

-- OST: https://benprunty.bandcamp.com/album/into-the-breach-soundtrack
-- AE OST: https://benprunty.bandcamp.com/album/into-the-breach-advanced-edition-soundtrack

-- Archive
-- "/music/grass/map"				--Old Earth (Map)
-- "/music/grass/combat_delta"		--Relics
-- "/music/grass/combat_gamma"		--Antiquity Row
-- "/music/sand/combat_guitar"		--Old War Machines
-- "/music/grass/combat_new"		--Kai Miller (AE)

-- R.S.T.
-- "/music/sand/map"				--Red Sand (Map)
-- "/music/sand/combat_western"		--The Blast Garden
-- "/music/sand/combat_eastwood"	--Cataclysm
-- "/music/sand/combat_montage"		--Rusting Hulks
-- "/music/sand/combat_new"			--The Big One (AE)

-- Pinnacle
-- "/music/snow/map"				--Zenith
-- "/music/snow/combat_ice"			--Pinnacle Robotics
-- "/music/snow/combat_zimmer"		--Blitzkreig
-- "/music/snow/combat_train"		--Rift Riders
-- "/music/snow/combat_new"			--Plasmodia (AE)

-- Detritus
-- "/music/acid/map"				--Detritus
-- "/music/acid/combat_synth"		--The Wasteland
-- "/music/general/ominous_master"	--Reprocessing
-- "/music/acid/combat_detritus"	--A.C.I.D.
-- "/music/acid/combat_new"			--Mist Eaters(AE)


-- Game:TriggerSound()
