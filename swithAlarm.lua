--[[ 
author = BreizhCat
create = 08.01.2020
update = 
filename = swithAlarm.lua
repo   = https://github.com/BreizhCat/domoticz/blob/master/swithAlarm.lua
description = Switch to bypass Alarm Screen
--]]

local __script_name__ = "swithAlarm"
local __version__     = "1.0"

return {
	on = {
		devices = { 86 }
	},
	execute = function(dz, device)
	    local message = ''
		if device._state == dz.SECURITY_ARMEDHOME then
		    message = 'Alarm: '..dz.SECURITY_ARMEDHOME
		    dz.devices(75).armHome()
	    end
	    
		if device._state == dz.SECURITY_ARMEDAWAY then
		    message = 'Alarm: '..dz.SECURITY_ARMEDAWAY
		    dz.devices(75).armAway()
	    end
	    
		if device._state == dz.SECURITY_DISARMED then
		    message = 'Alarm: '..dz.SECURITY_DISARMED
		    dz.devices(75).disarm()
	    end
	    
	    dz.log(message)
	    dz.helpers.notif_telegram(dz, message)
	end
}
