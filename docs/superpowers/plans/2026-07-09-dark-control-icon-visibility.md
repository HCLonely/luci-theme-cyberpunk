# Dark Control Icon Visibility Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make single-select arrows and loading icons clearly visible in the Cyberpunk dark theme using the selected cyan treatment.

**Architecture:** Add the maintainable rules to `less/dark.less`, then mirror them into the shipped compressed `dark.css`. Verification uses direct CSS assertions because this theme has no automated browser test suite or package-managed LESS build.

**Tech Stack:** LESS/CSS, embedded SVG data URI, PowerShell assertions

---

### Task 1: Add regression assertions

**Files:**
- Test: command-line assertions against `less/dark.less`

- [ ] **Step 1: Run the failing select-arrow assertion**

```powershell
$css = Get-Content -Raw less/dark.less
if ($css -notmatch 'select:not\(\[multiple="multiple"\]\).*appearance:\s*none' -or
    $css -notmatch 'background-image:\s*url\("data:image/svg\+xml') {
    throw 'Single-select cyan arrow rule is missing'
}
```

Expected: FAIL with `Single-select cyan arrow rule is missing`.

- [ ] **Step 2: Run the failing spinner assertion**

```powershell
$css = Get-Content -Raw less/dark.less
if ($css -notmatch '\.spinning::before[\s\S]*brightness\(0\)[\s\S]*drop-shadow') {
    throw 'Combined cyan spinner filter is missing'
}
```

Expected: FAIL with `Combined cyan spinner filter is missing`.

### Task 2: Implement the source LESS rules

**Files:**
- Modify: `less/dark.less`

- [ ] **Step 1: Add the single-select arrow rule**

Append a focused dark-theme rule:

```less
select:not([multiple="multiple"]) {
    -webkit-appearance: none;
    appearance: none;
    padding-right: 2.5rem !important;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='9' viewBox='0 0 14 9'%3E%3Cpath fill='none' stroke='%2300d4ff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' d='m1 1 6 6 6-6'/%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right .8rem center !important;
    background-size: .875rem .5625rem !important;
}
```

- [ ] **Step 2: Replace the spinner filter**

Use one combined filter so coloration and glow are both retained:

```less
.spinning::before,
.main > .loading > span::before {
    filter: brightness(0) saturate(100%) invert(68%) sepia(97%) saturate(1887%) hue-rotate(143deg) brightness(101%) contrast(101%) drop-shadow(0 0 8px rgba(0, 212, 255, .6));
}
```

- [ ] **Step 3: Run both assertions**

Run the two PowerShell assertions from Task 1.

Expected: both exit successfully with no output.

### Task 3: Update the shipped CSS and verify

**Files:**
- Modify: `htdocs/luci-static/cyberpunk/css/dark.css`

- [ ] **Step 1: Mirror the source rules into compressed CSS**

Add the equivalent minified single-select and spinner rules to the generated stylesheet, preserving the same selectors and declarations as `less/dark.less`.

- [ ] **Step 2: Verify source and shipped CSS**

```powershell
$files = 'less/dark.less', 'htdocs/luci-static/cyberpunk/css/dark.css'
foreach ($file in $files) {
    $css = Get-Content -Raw $file
    if ($css -notmatch 'select:not\(\[multiple="multiple"\]\)[^{]*\{[^}]*appearance:\s*none' -or
        $css -notmatch 'background-image:\s*url\("data:image/svg\+xml' -or
        $css -notmatch '\.spinning::before[\s\S]*brightness\(0\)[\s\S]*drop-shadow') {
        throw "Visibility rule missing from $file"
    }
}
```

Expected: exit successfully with no output.

- [ ] **Step 3: Check formatting and scope**

```powershell
git diff --check
git diff -- less/dark.less htdocs/luci-static/cyberpunk/css/dark.css
```

Expected: no whitespace errors; diff contains only the two visibility fixes.

- [ ] **Step 4: Commit**

```powershell
git add less/dark.less htdocs/luci-static/cyberpunk/css/dark.css
git commit -m "fix: improve dark control icon visibility"
```
