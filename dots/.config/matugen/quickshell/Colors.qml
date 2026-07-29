pragma Singleton
import Quickshell
import QtQuick

Singleton {
  // TODO: Rename 'fg' and 'bg' to primary and surface respectively.
  property string fg:                     "{{ colors.primary.default.hex }}"
  property string onPrimary:              "{{ colors.on_primary.default.hex }}"
  property string primaryContainer:       "{{ colors.primary_container.default.hex }}"
  property string onPrimaryContainer:     "{{ colors.on_primary_container.default.hex }}"
  property string inversePrimary:         "{{ colors.inverse_primary.default.hex }}"
  property string secondary:              "{{ colors.secondary.default.hex }}"
  property string onSecondary:            "{{ colors.on_secondary.default.hex }}"
  property string onSecondaryFixed:       "{{ colors.on_secondary_fixed.default.hex }}"
  property string onSecondaryContainer:   "{{ colors.on_secondary_container.default.hex }}"
  property string tertiary:               "{{ colors.tertiary.default.hex }}"
  property string onTertiary:             "{{ colors.on_tertiary.default.hex }}"
  property string onTertiaryContainer:    "{{ colors.on_tertiary_container.default.hex }}"
  property string error:                  "{{ colors.error.default.hex }}"
  property string on_error:               "{{ colors.on_error.default.hex }}"
  property string bg:                     "{{ colors.surface.default.hex }}"
  property string onSurface:              "{{ colors.on_surface.default.hex }}"
  property string surfaceVariant:         "{{ colors.surface_variant.default.hex }}"
  property string onSurfaceVariant:       "{{ colors.on_surface_variant.default.hex }}"
  property string outline:                "{{ colors.outline.default.hex }}"
  property string outlineVariant:         "{{ colors.outline_variant.default.hex }}"
  property string background:             "{{ colors.background.default.hex }}"
  property string onBackground:           "{{ colors.on_background.default.hex }}"
  property string shadow:                 "{{ colors.shadow.default.hex }}"
  property string scrim:                  "{{ colors.scrim.default.hex }}"
}
