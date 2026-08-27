require("..utils")
require("..utils.binds")

local qsIpc = "qs -c dotshell ipc call "

-- stylua: ignore start

bindMod("Q", exec_cmd(terminal),                         { description = "Launch terminal"                     })
bindMod("E", exec_cmd(fileManager),                      { description = "Launch file explorer"                })
bindMod("R", exec_cmd(menu),                             { description = "Launch rofi"                         })
bindMod("B", exec_cmd(browser),                          { description = "Launch browser",                     })
bindMod("C", hl.dsp.window.close(),                      { description = "Close focused window"                })
bindMod("V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating on focused window"   })
bindMod("F", hl.dsp.window.fullscreen(),                 { description = "Toggle fullscreen on focused window" })

bindShiftMod("B",  exec_cmd(bluetoothManager),            { description = "Launch bluetooth manager"     })
bindShiftMod("P",  exec_cmd("pavucontrol"),               { description = "Launch pavucontrol"           })
bindShiftMod("F1", toggleAnimations,                      { description = "Toggle compositor animations" })

-- Quickshell IPC Binds
bindMod("P",      exec_cmd(qsIpc .. "mpris toggle"),         { description = "Open Mpris Player"        })
bindMod("N",      global_dsp("quickshell:notifCenter"),      { description = "Open Notification Center" })
bindShiftMod("W", global_dsp("quickshell:wallpapers"),       { description = "Open Wallpaper Picker"    })
bindShiftMod("M", global_dsp("quickshell:lock"),             { description = "Locks the session"        })

-- Screenshotting
bind(        "PRINT", exec_cmd("grim - | swappy -f -"),               { description = "Screenshot the whole screen" })
bindMod(     "PRINT", exec_cmd("hyprshot -m window"),                 { description = "Screenshot a window"         })
bindShiftMod("PRINT", exec_cmd('grim -g "$(slurp)" - | swappy -f -'), { description = "Screenshot a region"         })

-- Special Workspaces
bindMod("S",      hl.dsp.workspace.toggle_special("magic"),            { description = "Toggle special workspace"                 })
bindShiftMod("S", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move focused window to speical workspace" })

bindMod("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bindMod("mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

bindMod("mouse:272",  hl.dsp.window.drag(),   { mouse = true })
bindMod("mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- stylua: ignore end

bindShiftMod(
    "ESCAPE",
    exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
    { description = "Kill active Hyprland session" }
)

bindShiftMod(
    "R",
    exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"),
    { description = "Open Clipboard History with Rofi" }
)

for i = 1, 10 do
    local key = i % 10
    bindMod(key, hl.dsp.focus({ workspace = i }))
    bindShiftMod(key, hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
-- stylua: ignore start
bind("XF86MonBrightnessUp",   global_dsp("quickshell:brightnessUp"),   { locked = true, repeating = true })
bind("XF86MonBrightnessDown", global_dsp("quickshell:brightnessDown"), { locked = true, repeating = true })

-- Requires playerctl
bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
-- stylua: ignore end
