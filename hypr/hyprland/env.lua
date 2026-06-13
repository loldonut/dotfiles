hl.env("GDK_SCALE", 1)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- Force the use of Wayland
hl.env("GDK_BACKEND", "wayland,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("AWWW_TRANSITION", "center")
