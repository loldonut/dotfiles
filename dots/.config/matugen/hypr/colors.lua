hl.config({
    general = {
        col = {
            active_border = {
                colors = {"{{ colors.inverse_primary.dark.hex }}", "{{ colors.on_secondary_fixed.dark.hex }}"},
                angle = 45
            },
            inactive_border = "{{ colors.on_secondary_fixed.dark.rgba }}",
        }
    }
})
