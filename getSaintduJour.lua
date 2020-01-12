--[[ 
author   = BreizhCat
create   = 12.01.2020
update   = 
filename = getSaintduJour.lua
repo     = https://github.com/BreizhCat/domoticz/blob/master/getSaintduJour.lua

description = Récupérer le Saint du Jour via l'API du Site Fête du Jour
Merci au site Fete du Jour pour l'API (fetedujour.fr)
--]]

local __script_name__ = "getSaintduJour"
local __version__     = "1.0"

local _callback = 'getSaintduJour'
return {
	on = {
	    devices = { 40 },
		timer      = { 'at 2:45' },
		httpResponses = { _callback }
    },
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
	execute = function(dz, trigger)
	    local url2Call = "https://fetedujour.fr/api/v2/<votre_cle>/json-normal"
		
		if trigger.isTimer or trigger.isDevice then
		    dz.log('Appel REST')
		    dz.openURL({
		            url      = url2Call,
		            method   = 'GET',
		            callback = _callback,
		        })
	    end
	    
	    if trigger.isHTTPResponse then
	        dz.log('Retour appel REST')
	        if trigger.ok then
	            local jsonSaint = dz.utils.toJSON(trigger.json)
	            dz.log(jsonSaint)
	            dz.devices(87).updateText(trigger.json.name)
            end
        end
	end
}
