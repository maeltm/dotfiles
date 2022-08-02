local obj = {}

local appTable = {
    ['c'] = 'Google Chrome',
    ['n'] = 'Notes',
    ['s'] = 'Slack',
    ['`'] = 'kitty',
    ['r'] = 'Another Redis Desktop Manager',
    ['d'] = 'DBeaver',
}

function obj:init(modkey)
    local app_mod = hs.hotkey.modal.new()
    for k, v in pairs(appTable) do
        app_mod:bind({}, k, function()
            hs.application.launchOrFocus(v)
        end)
    end

    hs.hotkey.bind({}, modkey,
    function()
        app_mod:enter()
    end,
    function()
        app_mod:exit()
    end)
end

return obj
