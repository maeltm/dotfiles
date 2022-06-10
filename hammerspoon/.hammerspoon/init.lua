require('modules.escape_bind') -- ESC for vim-user

hs.hotkey.bind({'cmd', 'ctrl'}, 'r', function() hs.reload() hs.alert.show('hammerspoon reloaded!') end)

do -- remap right alt to f13
    local FRemap = require('modules.foundation_remapping')
    local remapper = FRemap.new()
    remapper:remap('rcmd', 'f13')
    remapper:register()
end

do -- application shortcut
    local app_mod = hs.hotkey.modal.new()
    app_mod:bind({}, 'h', hs.hints.windowHints)
    app_mod:bind({}, 'c', function()
        hs.application.launchOrFocus('Google Chrome')
    end)
    app_mod:bind({}, 'n', function()
        hs.application.launchOrFocus('Notes')
    end)
    app_mod:bind({}, 's', function()
        hs.application.launchOrFocus('Slack')
    end)
    app_mod:bind({}, 't', function()
        hs.application.launchOrFocus('kitty')
    end)

    hs.hotkey.bind({}, 'F13', function() app_mod:enter() end, function() app_mod:exit() end)
end

