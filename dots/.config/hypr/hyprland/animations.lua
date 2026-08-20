-- stylua: ignore start
hl.curve("easeInSine",        { type = "bezier", points = { {0.12, 0},    {0.39, 0}     } })
hl.curve("easeOutSine",       { type = "bezier", points = { {0.61, 1},    {0.88, 1}     } })
hl.curve("easeInOutSine",     { type = "bezier", points = { {0.37, 0},    {0.63, 1}     } })

hl.curve("easeInQuint",    { type = "bezier", points = { {0.64, 0},    {0.78, 0}     } })
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}     } })

hl.curve("easeOutQuart",   { type = "bezier", points = { {0.25, 1},    {0.5,  1}     } })

hl.curve("easeOutCubic",   { type = "bezier", points = { {0.33, 1},    {0.68,  1}    } })

hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}     } })

hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}        } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}     } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}      } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("rubber",         { type = "spring", mass = 1, stiffness = 70,      dampening = 10 } )

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })

-- hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 4.9,  bezier = "easeOutQuart" })

-- hl.curve("easy2",           { type = "spring", mass = 1, stiffness = 70, dampening = 4 })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy2", style = "popin 65%" })
-- hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 1.2,  spring = "easy2" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })

-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint",     style = "fade" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeInOutCubic",   style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "easeOutCubic",     style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 2.4,  bezier = "easeOutQuart" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 2.2,  bezier = "easeOutCubic" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4,    bezier = "easeOutQuart", style = "slidefade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2.94, bezier = "almostLinear", style = "fade" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })
