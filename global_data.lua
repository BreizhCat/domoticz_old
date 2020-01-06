--[[ 
author = BreizhCat
create = 02.01.2020
update = 
filename = global_data.lua
repo   = https://github.com/BreizhCat/domoticz/blob/master/global_data.lua
help   = https://www.domoticz.com/wiki/DzVents:_next_generation_LUA_scripting#Shared_helper_functions
description = General include with tools

--]]

return {
    helpers = {
        --[[ 
        Function notif_telegram: Shortcut to send notification to telegram
        
        @dz       : self reference to object domoticz in main function
        @message  : your message
        @priority : priority (optional)
        
        Example : domoticz.helpers.notif_telegram(..., ..., [...])
        --]]
        notif_telegram = function (dz, message, priority)
            dz.notify(message, message, priority or dz.PRIORITY_NORMAL, nil, nil, dz.NSS_TELEGRAM)
        end
    }
}
