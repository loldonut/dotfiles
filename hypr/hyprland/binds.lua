local default = require("..defaults")

local mainMod = "SUPER"

local function bindMod(key, action, flags)
    local bindModKey = string.format("%s + %s", mainMod, key)
    if flags then
        hl.bind(bindModKey, action, flags)
    else
        hl.bind(bindModKey, action)
    end
end

local function bindShiftMod(key, action, flags)
    local bindModKey = string.format("SHIFT + %s", key)
    bindMod(bindModKey, action, flags)
end

local exec_cmd = hl.dsp.exec_cmd

bindMod("Q", exec_cmd(default.terminal))
bindMod("M", exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
bindMod("E", exec_cmd(default.fileManager))
bindMod("R", exec_cmd(default.menu))
bindMod("P", exec_cmd("pavucontrol"))
bindMod("B", exec_cmd(default.bluetoothManager))
bindMod("C", hl.dsp.window.close())
bindMod("V", hl.dsp.window.float({ action = "toggle" }))

bindShiftMod("P", exec_cmd("pavucontrol"))

-- Screenshotting
hl.bind("PRINT",      exec_cmd("hyprshot -m output"))
bindMod("PRINT",      exec_cmd("hyprshot -m window"))
bindShiftMod("PRINT", exec_cmd("hyprshot -m region"))

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
bindMod("G", function ()
    hl.dsp.pass({
        window = "class:^(libresplit)$"
    })
    hl.dsp.pass({
        window = "class:^(libresplit)$"
    })

    hl.dsp.send_shortcut({
        key = "G",
        window = "title:^(Left 4 Dead 2)$"
    })
end)

bindShiftMod("F1", function ()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        hl.notification.create({
            text = "Gamemode [OFF]",
            color ="rgb(d20f39)",
            icon = 1,
            duration = 3000
        })
        return
    end

    hl.notification.create({
        text = "Gamemode [ON]",
        color ="rgb(40a02b)",
        icon = 1,
        duration = 3000
    })

    hl.config({
        general = {
            gaps_in = 0, gaps_out = 0, -- Disable gaps
            border_size = 0,
        },

        animations = {
            enabled = false, -- Disable animations
        },

        -- Disable blur, shadow and window rounding
        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    })
end)

for i = 1, 10 do
    local key = i % 10
    bindMod(key,      hl.dsp.focus({ workspace = i }))
    bindShiftMod(key, hl.dsp.window.move({ workspace = i }))
end

bindMod("S",      hl.dsp.workspace.toggle_special("magic"))
bindShiftMod("S", hl.dsp.window.move({ workspace = "special:magic" }))

bindMod("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bindMod("mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

bindMod("mouse:272", hl.dsp.window.drag(), { mouse = true })
bindMod("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
