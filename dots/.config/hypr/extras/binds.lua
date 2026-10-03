require("..utils.binds")

-- Touchpad/Trackpad
bind_mod("T", function()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = false,
    })
end)
bind_shift_mod("T", function()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = true,
    })
end)

-- LibreSplit and L4D2 binds

local lsClass = "class:^(org.libresplit.LibreSplit)$"

bind_mod("F5", function()
    hl.dispatch(hl.dsp.send_shortcut({
        state = "down",
        mods = "",
        key = "F5",
        window = lsClass,
    }))
end, { repeating = false })
bind_mod("G", function()
    -- For some reason 'hl.dsp.send_shortcut' and 'hl.dsp.pass' does not work
    -- and this is the work around
    hl.dispatch(hl.dsp.send_shortcut({
        state = "down",
        mods = "",
        key = "G",
        window = lsClass,
    }))
    hl.dispatch(hl.dsp.send_shortcut({
        state = "up",
        mods = "",
        key = "G",
        window = lsClass,
    }))

    hl.dispatch(hl.dsp.send_key_state({
        state = "down",
        mods = "",
        key = "G",
        window = "title:^(Left 4 Dead 2)$",
    }))
end, { repeating = false })

bind_mod("X", hl.dsp.exec_cmd("pkill -9 xhair-overlay || xhair-overlay"))
