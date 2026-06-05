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
        return string.format("^(%s)$", title)
    end
}

local function parseWindowSelector(str)
    local selector, value = str:match("^([^:]+):(.*)$")
    return { selector, value }
end

local function windowRuleFloat(title, pattern, extraFields)
    local parsedTitle = parseWindowSelector(title)
    local selector = parsedTitle[1]
    local windowTitle = parsedTitle[2]

    local rule = {
        match = {
            [selector] = pattern(windowTitle),
        },
        center = true,
        float = true,
    }

    if extraFields then
        for k, v in pairs(extraFields) do
            rule[k] = v
        end
    end
    hl.window_rule(rule)
end

local floatList = {
    { "title:Open File",                  patterns.startsWith  },
    { "title:Select a File",              patterns.startsWith  },
    { "title:Choose a wallpaper",         patterns.startsWith  },
    { "title:Open Folder",                patterns.startsWith  },
    { "title:wants to save",              patterns.endsWith    },
    { "title:wants to open",              patterns.endsWith    },
    { "class:waypaper",                   patterns.startsWith  },
    { "class:libresplit",                 patterns.has,        },
    { "class:nm-connection-editor",       patterns.has,        },
    { "class:steam",                      patterns.has         },
    { "class:org.kde.dolphin",            patterns.has         },
    {
        "class:pavucontrol",
        patterns.has,
        { size = { "(monitor_w*.45)", "(monitor_h*.45)" } }
    },
    {
        "class:org.pulseaudio.pavucontrol",
        patterns.has,
        { size = { "(monitor_w*.45)", "(monitor_h*.45)" } }
    },
}

for _, value in pairs(floatList) do
    windowRuleFloat(value[1], value[2], value[3])
end
