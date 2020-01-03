--[[ 
author = BreizhCat
create = 02.01.2020
update = 
filename = global_data.lua
repo   = 
help   = https://www.domoticz.com/wiki/DzVents:_next_generation_LUA_scripting#Shared_helper_functions
description = General include with tools

--]]

return {
    helpers = {
        --[[ 
        function notif_telegram
        shortcut to send notification to telegram
            @dz       : self reference to object domoticz in main function
            @message  : your message
            @priority : priority (optional)
        --]]
        notif_telegram = function (dz, message, priority)
            dz.notify(message, message, priority or dz.PRIORITY_NORMAL, nil, nil, dz.NSS_TELEGRAM)
        end
    }
}
