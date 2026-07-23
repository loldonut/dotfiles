function bindMod(key, action, flags)
    local bindModKey = string.format("%s + %s", mainMod, key)
    if flags then
        hl.bind(bindModKey, action, flags)
    else
        hl.bind(bindModKey, action)
    end
end

function bindShiftMod(key, action, flags)
    local bindModKey = string.format("SHIFT + %s", key)
    bindMod(bindModKey, action, flags)
end

exec_cmd = hl.dsp.exec_cmd
