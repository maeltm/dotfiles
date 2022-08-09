local caffeine = hs.menubar.new()

local obj = {}

local on_icon = "☕️"
local off_icon = "💤"

function obj:init(modal, mod, key)

    function setCaffeineDisplay(state)
        if state then
            caffeine:setTitle(on_icon)
            hs.alert.show(on_icon)
        else
            caffeine:setTitle(off_icon)
            hs.alert.show(off_icon)
        end
    end

    function caffeineClicked()
        setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
    end

    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
    end

    modal:bind(mod, key, caffeineClicked)
end

return obj
