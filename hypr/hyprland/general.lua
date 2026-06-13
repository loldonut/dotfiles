hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 8,

        border_size = 2,

        -- col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg # default
        -- col.active_border = rgb(82aaff) rgb(222436) 45deg
        -- col = {
        --     active_border = {
        --         colors = {"rgb(232A2E)", "rgb(D3C6AA)"},
        --         angle = 60
        --     },
        --     inactive_border = "rgba(595959aa)",
        -- },
        col = {
            active_border = {
                colors = {"rgb(82aaff)", "rgb(222436)"},
                angle = 45
            },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 1,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 2,
            vibrancy = 0.1696,
        }
    }
})

hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        key_press_enables_dpms   = true,
        swallow_regex = "^(alacritty|Alacritty|kitty)$",
    }
})

hl.config({
    dwindle = {
        -- pseudotile = true -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true -- You probably want this
    }
})

hl.config({
    master = {
        new_status = "master"
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
