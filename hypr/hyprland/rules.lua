hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false
    },
    no_focus = true
})

local patterns = {
    startsWith = function (title)
        return string.format("^(%s)(.*)$", title)
    end,
    endsWith = function (title)
        return string.format("^(.*)(%s)$", title)
    end,
    has = function (title)
        return string.format("^(%s)", title)
    end
}

local function windowRuleFloat(title, pattern)
    hl.window_rule({
        match = {
            title = pattern(title),
            class = pattern(title),
        },
        center = true,
        float = true,
    })
end

local floatList = {
    { "Open File", patterns.startsWith },
    { "Select a File", patterns.startsWith },
    { "Choose a wallpaper", patterns.startsWith },
    { "Open Folder", patterns.startsWith },
    { "wants to save", patterns.endsWith },
    { "wants to open", patterns.endsWith },
    { "wants to open", patterns.endsWith },
    { "pavucontrol", patterns.has },
    { "org.pulseaudio.pavucontrol", patterns.has },
    { "nm-connection-editor", patterns.has },
}

for _, value in pairs(floatList) do
    windowRuleFloat(value[1], value[2])
end
