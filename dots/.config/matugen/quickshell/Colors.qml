pragma Singleton
import Quickshell
import QtQuick

Singleton {
  // TODO: Rename 'fg' and 'bg' to primary and surface respectively.
  property color fg:                       "{{ colors.primary.default.hex }}"
  property color onPrimary:                "{{ colors.on_primary.default.hex }}"
  property color primaryContainer:         "{{ colors.primary_container.default.hex }}"
  property color uponPrimaryContainer:     "{{ colors.on_primary_container.default.hex }}"
  property color inversePrimary:           "{{ colors.inverse_primary.default.hex }}"
  property color secondary:                "{{ colors.secondary.default.hex }}"
  property color uponSecondary:            "{{ colors.on_secondary.default.hex }}"
  property color onSecondaryFixed:         "{{ colors.on_secondary_fixed.default.hex }}"
  property color uponSecondaryContainer:   "{{ colors.on_secondary_container.default.hex }}"
  property color tertiary:                 "{{ colors.tertiary.default.hex }}"
  property color uponTertiary:             "{{ colors.on_tertiary.default.hex }}"
  property color uponTertiaryContainer:    "{{ colors.on_tertiary_container.default.hex }}"
  property color error:                    "{{ colors.error.default.hex }}"
  property color uponError:                "{{ colors.on_error.default.hex }}"
  property color bg:                       "{{ colors.surface.default.hex }}"
  property color uponSurface:              "{{ colors.on_surface.default.hex }}"
  property color surfaceVariant:           "{{ colors.surface_variant.default.hex }}"
  property color uponSurfaceVariant:       "{{ colors.on_surface_variant.default.hex }}"
  property color outline:                  "{{ colors.outline.default.hex }}"
  property color outlineVariant:           "{{ colors.outline_variant.default.hex }}"
  property color background:               "{{ colors.background.default.hex }}"
  property color uponBackground:           "{{ colors.on_background.default.hex }}"
  property color shadow:                   "{{ colors.shadow.default.hex }}"
  property color scrim:                    "{{ colors.scrim.default.hex }}"
}
