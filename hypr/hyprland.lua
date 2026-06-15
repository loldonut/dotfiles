require("hyprland.exec")
require("hyprland.general")

require("utils")

local home = os.getenv("HOME") .. "/"
local hyprConfigPath = home .. "dotfiles/hypr"

local extras = {
    "monitors",
    "binds",
    "devices"
}

if not pathExists(hyprConfigPath) then
    hyprConfigPath = home .. ".config/hypr"
end

for _, name in ipairs(extras) do
    local path = string.format("%s/extras/%s.lua", hyprConfigPath, name)
    if pathExists(path) then
        require("extras." .. name)
    end
end

require("hyprland.colors")
require("hyprland.animations")
require("hyprland.rules")
require("hyprland.env")
require("hyprland.binds")
require("hyprland.input")
