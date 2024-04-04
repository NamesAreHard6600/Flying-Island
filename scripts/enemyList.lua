
-- create enemy list
local enemyList = easyEdit.enemyList:add("Skylance_enemy_list_id")
local rst = easyEdit.enemyList:get("rst")

enemyList.name = "Skylance"

enemyList:copy(rst)
