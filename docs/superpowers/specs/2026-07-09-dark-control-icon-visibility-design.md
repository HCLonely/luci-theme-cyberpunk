# Dark Control Icon Visibility Design

## Goal

Improve two low-contrast controls in the Cyberpunk dark theme:

1. Make the native single-select dropdown arrow clearly visible.
2. Make the `.spinning::before` loading icon clearly visible.

Both icons use the theme cyan visual treatment selected in the browser comparison.

## Scope

- Update `less/dark.less`, which is the source stylesheet.
- Update the generated `htdocs/luci-static/cyberpunk/css/dark.css`.
- Limit the select override to single-select controls.
- Preserve the existing loading icon geometry and animation.
- Do not change markup, JavaScript, layout, or light-theme styles.

## Implementation

Single-select controls use `appearance: none` and a compact, percent-encoded cyan SVG chevron as their background image. Right padding and background positioning reserve space for the arrow without changing control height.

The loading pseudo-element keeps its existing icon and receives a combined CSS filter that maps it to cyan and retains the existing cyan drop shadow. The complete filter is declared in one rule because separate `filter` declarations replace rather than merge with each other.

## Compatibility

Include standard `appearance` and `-webkit-appearance`. The SVG is embedded as a data URI so no new asset request or package file is required. Multiple selects retain their native rendering.

## Verification

- Assert the source and generated CSS contain the single-select arrow rules.
- Assert the spinner rule contains both cyan coloration and drop shadow in one filter.
- Confirm multiple selects are excluded from the appearance override.
- Inspect the final diff for unrelated changes.
