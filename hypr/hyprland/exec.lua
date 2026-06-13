require("..defaults")

hl.on("hyprland.start", function ()
    hl.exec_cmd(terminal, { workspace = "1" })
    hl.exec_cmd("swaync")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("wayle panel start")

    hl.exec_cmd("hyprctl setcursor capitaine-cursors 32")

    -- Authentication Agents
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- hl.exec_cmd("/usr/lib/pam_kwallet_init")

    hl.exec_cmd("hyprpaper & swaybg & waypaper --restore")
end)
