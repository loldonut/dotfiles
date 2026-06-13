require("..hyprland.binds")

-- Touchpad/Trackpad
bindMod("T", function ()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = false
    })
end)
bindShiftMod("T", function ()
    hl.device({
        name = "synps/2-synaptics-touchpad",
        enabled = true
    })
end)

-- LibreSplit and L4D2 binds
bindMod("F5", hl.dsp.pass({ window = "class:^(libresplit)$" }))
bindMod("G", function ()
    -- For some reason 'hl.dsp.send_shortcut' and 'hl.dsp.pass' does not work
    -- and this is the work around
    hl.dispatch(hl.dsp.send_key_state({
        state = "down",
        mods = mainMod,
        key = "G",
        window = "class:^(libresplit)$"
    }))
    hl.dispatch(hl.dsp.send_key_state({
        state = "down",
        mods = mainMod,
        key = "G",
        window = "class:^(libresplit)$"
    }))

    hl.dispatch(hl.dsp.send_key_state({
        state = "down",
        mods = "",
        key = "G",
        window = "title:^(Left 4 Dead 2)$"
    }))
end)
