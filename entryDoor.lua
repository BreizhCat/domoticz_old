--[[ 
author = BreizhCat
create = 02.01.2020
update = 02.01.2020
filename = entryDoor.lua
repo   = 

description =

--]]

local __script_name__ = "entryDoor"
local __version__     = "1.0"

return {
	on = {
		devices = {
		    44, -- Porte Jardin
		    45, -- Porte Garage
			46, -- Porte d'entrée
			82, -- Dummy
		},
	},
	logging = {
	    level = domoticz.LOG_DEBUG,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
    },

	execute = function(dz, device)
	    local message = ''
	    local doorIcon = '\xF0\x9F\x9A\xAA '
	    if dz.devices(75)._state ~= 'Normal' then -- Alarm Status ?
            if device.changed then
                if device._state == 'Open' then
                    -- Previous state = Closed
                    message = doorIcon..device.name..' is opened!'
                end
                
                if device._state == 'Closed' then
                    -- Previous state = Open
                    message = doorIcon..device.name..' is closed after '..device.lastUpdate.secondsAgo..' seconds'
                end
                dz.helpers.notif_telegram(dz, message)
            end -- device.changed ?
        end -- Alarm ?
	end -- function execute
}
