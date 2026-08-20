function pathExists(path)
    local file = io.open(path, "r")
    if file == nil then
        return false
    else
        io.close(file)
        return true
    end
end

function toggleAnimations()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        hl.notification.create({
            text = "Gamemode [OFF]",
            color = "rgb(d20f39)",
            icon = 1,
            duration = 3000,
        })
        return
    end

    hl.notification.create({
        text = "Gamemode [ON]",
        color = "rgb(40a02b)",
        icon = 1,
        duration = 3000,
    })

    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0, -- Disable gaps
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
        },
    })
end
