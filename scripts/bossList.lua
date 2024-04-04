
-- create boss list
local bossList = easyEdit.bossList:add("Skylance_boss_list_id")
local rst = easyEdit.bossList:get("rst")

bossList.name = "Skylance"

bossList:copy(rst)
