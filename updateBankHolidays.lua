--[[ 
author   = BreizhCat
create   = 09.01.2020
update   = 
filename = updateBankHolidays.lua
repo     = https://github.com/BreizhCat/domoticz/blob/master/updateBankHolidays.lua

description = update custom variable with list of bank holidays

--]]

local __script_name__ = "updateBankHolidays"
local __version__     = "1.0"

local _callback = 'httpBankHolidays'
return {
	on = {
		timer = { '01/01' },
		httpResponses = { _callback }
    },
	logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
    },
	execute = function(dz, trigger)
	    if trigger.isTimer or trigger.isDevice then

		    local url2Call = "https://www.kayaposoft.com/enrico/json/v2.0?action=getHolidaysForDateRange&"..
		                     "country=fra&fromDate=01-01-" .. os.date("%Y") .. "&toDate=31-12-".. os.date("%Y") ..
		                     "&region=&holidayType=public_holiday&lang=fr"
		                     
            dz.log('API Rest called to update holidays in ' .. os.date('%Y'))
            
		    dz.openURL({
		        url      = url2Call,
		        method   = 'GET',
		        callback = _callback,
		        })
		end
		
		if trigger.isHTTPResponse then
		    if trigger.ok then
		        dz.variables('bankHolidays').set(trigger.json)
	        else
	            dz.log('Issue during API rest call', dz.LOG_ERROR)
	        end
	    end
	end
}
