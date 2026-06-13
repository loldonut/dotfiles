# Hyprland

my config for hyprland

## File Structure

Folder `hyprland`, and `utils` are the base configuration and extra configurations are placed in the `extras` directory.

### `extras` directory

```
hypr/extras
├── binds.lua
└── monitors.lua
```

#### `monitors.lua`

You can put extra monitor configuration here

**Example:**

```lua
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1.2
})
```

[**Hyprland Wiki for Monitors**](https://wiki.hypr.land/Configuring/Basics/Monitors/)

#### `binds.lua`

You can put extra binds here.

[**Hyprland Wiki for Binds**](https://wiki.hypr.land/Configuring/Basics/Binds/)
