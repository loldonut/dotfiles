require("hyprland.exec")
require("hyprland.general")

require("utils")

local home = os.getenv("HOME") .. "/"
local hyprConfigPath = home .. "dotfiles/hypr/"

if not pathExists(hyprConfigPath) then
    hyprConfigPath = home .. ".config/hypr/"
end

if pathExists(hyprConfigPath .. "extras/monitors.lua") then
    require("extras.monitors")
end

if pathExists(hyprConfigPath .. "extras/binds.lua") then
    require("extras.binds")
end

require("hyprland.animations")
require("hyprland.rules")
require("hyprland.env")
require("hyprland.binds")
require("hyprland.input")
require("hyprland.devices")
