function bind(key, action, flags)
    if flags then
        hl.bind(key, action, flags)
    else
        hl.bind(key, action)
    end
end

function bindMod(key, action, flags)
    local bindModKey = string.format("%s + %s", mainMod, key)
    if flags then
        bind(bindModKey, action, flags)
    else
        bind(bindModKey, action)
    end
end

function bindShiftMod(key, action, flags)
    local bindModKey = string.format("SHIFT + %s", key)
    bindMod(bindModKey, action, flags)
end

exec_cmd = hl.dsp.exec_cmd
global_dsp = hl.dsp.global
