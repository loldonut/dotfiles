require("hyprland.exec")
require("hyprland.general")

local home = os.getenv("HOME") .. "/"
local hyprConfigPath = home .. "dotfiles/hypr/"

local function pathExists(path)
    local file = io.open(path, "r")
    if file == nil then
        return false
    else
        io.close(file)
        return true
    end
end

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
