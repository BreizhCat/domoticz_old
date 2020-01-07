--[[ 
author   = BreizhCat
create   = 02.01.2020
update   = 07.01.2020
filename = entryDoor.lua
repo     = https://github.com/BreizhCat/domoticz/blob/master/entryDoor.lua 

description = When the alarm is set on, the notification is send to telegram 

--]]

local __script_name__ = "entryDoor"
local __version__     = "1.1"

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
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
    },

	execute = function(dz, device)
	    local function sendStatusNotification(device, group)
            local message = ''
	        local doorIcon = '\xF0\x9F\x9A\xAA '
	        local device_found = false
	        
	        for i, id in ipairs(group) do
	            if id == device.id then
	                device_found = true
                end
	        end
	        
	        if device_found then
    	        if device._state == 'Open' then
                    -- Previous state = Closed
                    message = doorIcon..device.name..' is opened!'
                end
                    
                if device._state == 'Closed' then
                    -- Previous state = Open
                    message = doorIcon..device.name..' is closed after '..device.lastUpdate.secondsAgo..' seconds'
                end
                dz.helpers.notif_telegram(dz, message) 
            end
	    end
	    
	    local alarm_status = {}
	   
	    -- Device group
	    local device_away = { 44, 45, 46, 82 }
	    local device_home = { 44, 46, 82 }
	    local device_none = { 82 }
	    
	    alarm_status.AWAY    = 'Arm Away'
	    alarm_status.AT_HOME = 'Arm Home'
	    alarm_status.NONE    = 'Normal'
	    
        if device.changed then
            local isAlarmed = dz.devices(75)._state

            if isAlarmed == alarm_status.NONE then
                sendStatusNotification(device, device_none)
            end
            
            if isAlarmed == alarm_status.AWAY then
                sendStatusNotification(device, device_away)
            end
        
            if isAlarmed == alarm_status.AT_HOME then
                sendStatusNotification(device, device_home)    
            end
        end -- device.changed ?
        
	end -- function execute
}
