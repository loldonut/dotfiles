require("..defaults")

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    hl.exec_cmd("iio-hyprland")
    hl.exec_cmd(terminal, { workspace = "1" })
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("qs -c dotshell")

    -- Clipboard Manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("hyprctl setcursor capitaine-cursors 32")

    -- Authentication Agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    hl.exec_cmd("hyprpaper & swaybg & waypaper --restore")
end)
