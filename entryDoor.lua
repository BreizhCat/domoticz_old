--[[ 
author = BreizhCat
create = 02.01.2020
update = 
filename = EntryDoor.lua
repo   = 

description =

--]]

--require("__tools__") -- Common functions
local __script_name__ = "EntryDoor"
local __version__     = "1.0"

return {
	on = {
		devices = {
			40
		},
		logging = {
		    level = domoticz.LOG_INFO,
        },
	},
	execute = function(dz, device)
	    dz.helpers.notif_telegram(dz, 'mon message')
	    dz.dump()
	end
}
