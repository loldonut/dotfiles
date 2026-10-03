function bind(key, action, flags)
    if flags then
        hl.bind(key, action, flags)
    else
        hl.bind(key, action)
    end
end

function bind_mod(key, action, flags)
    local bindModKey = string.format("%s + %s", mainMod, key)
    if flags then
        bind(bindModKey, action, flags)
    else
        bind(bindModKey, action)
    end
end

function bind_shift_mod(key, action, flags)
    local bindModKey = string.format("SHIFT + %s", key)
    bind_mod(bindModKey, action, flags)
end

exec_cmd = hl.dsp.exec_cmd
global_dsp = hl.dsp.global
