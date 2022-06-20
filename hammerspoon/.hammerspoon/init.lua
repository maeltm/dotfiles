require('modules.escape_bind') -- ESC for vim-user

hs.hotkey.bind({'cmd', 'ctrl'}, 'r', function() hs.reload() hs.alert.show('hammerspoon reloaded!') end)

do -- remap right cmd, alt
    local FRemap = require('modules.foundation_remapping')
    local remapper = FRemap.new()
    remapper:remap('rcmd', 'f13')
    remapper:remap('ralt', 'f14')
    remapper:register()
end

require('modules.shortcut'):init('f13')

do -- application shortcut
    local app_mod = hs.hotkey.modal.new()
    require('modules.caffein'):init(app_mod, {}, 'q')

    hs.hotkey.bind({}, 'F14', function() app_mod:enter() end, function() app_mod:exit() end)
end

