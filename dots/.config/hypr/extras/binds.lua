require("..utils.binds")

-- Touchpad/Trackpad
bindMod("T", function()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = false,
    })
end)
bindShiftMod("T", function()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = true,
    })
end)

-- LibreSplit and L4D2 binds

local lsClass = "class:^(org.libresplit.LibreSplit)$"

bindMod("F5", function()
    hl.dispatch(hl.dsp.send_shortcut({
        state = "down",
        mods = "",
        key = "F5",
        window = lsClass,
    }))
end, { repeating = false })
bindMod("G", function()
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
