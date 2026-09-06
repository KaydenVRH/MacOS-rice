-- sunset.lua — Sunset colorscheme
-- Duotone — blue lagoon blue + sunset yellow

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "sunset"

local c = {
  bg        = "#0e1419",
  bg_dark   = "#0a0f13",
  bg_light  = "#1a2a38",
  fg        = "#e8f0f8",
  fg_dim    = "#8ba0b0",
  red       = "#f5c842",
  green     = "#f5c842",
  amber     = "#f5c842",
  blue      = "#6ba3ff",
  purple    = "#6ba3ff",
  cyan      = "#6ba3ff",
  white     = "#f0f6fc",
  -- Bright variants
  red_b     = "#f7d56a",
  green_b   = "#f7d56a",
  amber_b   = "#f7d56a",
  blue_b    = "#8bbaff",
  purple_b  = "#8bbaff",
  cyan_b    = "#8bbaff",
  selection = "#6ba3ff",
}

local hi = vim.api.nvim_set_hl

-- ── UI ────────────────────────────────────────────────────────────
hi(0, "Normal",        { fg = c.fg,      bg = c.bg })
hi(0, "NormalNC",      { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "SignColumn",    { fg = c.fg,      bg = c.bg })
hi(0, "MsgArea",       { fg = c.fg,      bg = c.bg })
hi(0, "Cursor",        { fg = c.bg,      bg = c.amber })
hi(0, "CursorLine",    { bg = c.bg_light })
hi(0, "CursorLineNr",  { fg = c.amber,   bg = c.bg_light, bold = true })
hi(0, "LineNr",        { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "FoldColumn",    { fg = c.fg_dim,  bg = c.bg })
hi(0, "Visual",        { fg = c.fg,      bg = c.selection })
hi(0, "Search",        { fg = c.bg,      bg = c.amber })
hi(0, "IncSearch",     { fg = c.bg,      bg = c.amber_b })
hi(0, "Substitute",    { fg = c.bg,      bg = c.amber })
hi(0, "MatchParen",    { fg = c.blue,    bg = c.bg_light, bold = true })
hi(0, "ColorColumn",   { bg = c.bg_light })
hi(0, "Whitespace",    { fg = c.bg_light })
hi(0, "NonText",       { fg = c.fg_dim })
hi(0, "SpecialKey",    { fg = c.fg_dim })
hi(0, "VertSplit",     { fg = c.bg_dark, bg = c.bg })
hi(0, "StatusLine",    { fg = c.fg,      bg = c.bg_dark })
hi(0, "StatusLineNC",  { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLine",       { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLineSel",    { fg = c.fg,      bg = c.blue, bold = true })
hi(0, "TabLineFill",   { bg = c.bg_dark })
hi(0, "Pmenu",         { fg = c.fg,      bg = c.bg_light })
hi(0, "PmenuSel",      { fg = c.bg,      bg = c.blue })
hi(0, "PmenuSbar",     { bg = c.bg_light })
hi(0, "PmenuThumb",    { bg = c.fg_dim })
hi(0, "Question",      { fg = c.blue })
hi(0, "ErrorMsg",      { fg = c.amber,   bold = true })
hi(0, "WarningMsg",    { fg = c.amber,   bold = true })
hi(0, "ModeMsg",       { fg = c.blue,    bold = true })
hi(0, "MoreMsg",       { fg = c.blue })
hi(0, "Title",         { fg = c.amber,   bold = true })
hi(0, "Directory",     { fg = c.blue,    bold = true })
hi(0, "qfLineNr",      { fg = c.amber })
hi(0, "qfFileName",    { fg = c.amber })
hi(0, "WinSeparator",  { fg = c.bg_dark })
hi(0, "EndOfBuffer",   { fg = c.bg })

-- ── Diagnostics ────────────────────────────────────────────────────
hi(0, "DiagnosticError",         { fg = c.amber })
hi(0, "DiagnosticWarn",          { fg = c.amber })
hi(0, "DiagnosticInfo",          { fg = c.blue })
hi(0, "DiagnosticHint",          { fg = c.blue })
hi(0, "DiagnosticUnderlineError",{ sp = c.amber, underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = c.amber, underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = c.blue,  underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = c.blue,  underline = true })

-- ── Syntax ─────────────────────────────────────────────────────────
hi(0, "Comment",        { fg = c.fg_dim, italic = true })
hi(0, "Constant",       { fg = c.amber })
hi(0, "String",         { fg = c.amber })
hi(0, "Character",      { fg = c.amber })
hi(0, "Number",         { fg = c.amber_b })
hi(0, "Boolean",        { fg = c.amber })
hi(0, "Float",          { fg = c.amber_b })
hi(0, "Identifier",     { fg = c.fg })
hi(0, "Function",       { fg = c.blue })
hi(0, "Statement",      { fg = c.blue })
hi(0, "Conditional",    { fg = c.blue })
hi(0, "Repeat",         { fg = c.blue })
hi(0, "Label",          { fg = c.blue })
hi(0, "Operator",       { fg = c.blue })
hi(0, "Keyword",        { fg = c.blue })
hi(0, "Exception",      { fg = c.amber })
hi(0, "PreProc",        { fg = c.amber })
hi(0, "Include",        { fg = c.blue })
hi(0, "Define",         { fg = c.blue })
hi(0, "Macro",          { fg = c.amber })
hi(0, "PreCondit",      { fg = c.blue })
hi(0, "Type",           { fg = c.blue })
hi(0, "StorageClass",   { fg = c.blue })
hi(0, "Structure",      { fg = c.blue })
hi(0, "Typedef",        { fg = c.blue })
hi(0, "Special",        { fg = c.amber })
hi(0, "SpecialChar",    { fg = c.amber })
hi(0, "Tag",            { fg = c.blue })
hi(0, "Delimiter",      { fg = c.fg })
hi(0, "SpecialComment", { fg = c.fg_dim, italic = true })
hi(0, "Debug",          { fg = c.amber })
hi(0, "Underlined",     { underline = true })
hi(0, "Error",          { fg = c.amber, bg = c.bg_dark, bold = true })
hi(0, "Todo",           { fg = c.amber, bg = c.bg_light, bold = true })

-- ── Treesitter ─────────────────────────────────────────────────────
hi(0, "@variable",              { fg = c.fg })
hi(0, "@variable.builtin",      { fg = c.amber })
hi(0, "@variable.parameter",    { fg = c.amber_b })
hi(0, "@variable.member",       { fg = c.blue })
hi(0, "@constant",              { fg = c.amber_b })
hi(0, "@constant.builtin",      { fg = c.amber })
hi(0, "@constant.macro",        { fg = c.amber })
hi(0, "@module",                { fg = c.fg })
hi(0, "@label",                 { fg = c.blue })
hi(0, "@string",                { fg = c.amber })
hi(0, "@string.regex",          { fg = c.amber })
hi(0, "@string.escape",         { fg = c.amber_b })
hi(0, "@string.special",        { fg = c.amber })
hi(0, "@character",             { fg = c.amber })
hi(0, "@character.special",     { fg = c.amber })
hi(0, "@type",                  { fg = c.blue })
hi(0, "@type.builtin",          { fg = c.blue_b })
hi(0, "@type.definition",       { fg = c.blue })
hi(0, "@attribute",             { fg = c.amber })
hi(0, "@property",              { fg = c.blue })
hi(0, "@field",                 { fg = c.fg })
hi(0, "@constructor",           { fg = c.blue })
hi(0, "@function",              { fg = c.blue })
hi(0, "@function.builtin",      { fg = c.blue })
hi(0, "@function.macro",        { fg = c.amber })
hi(0, "@function.method",       { fg = c.blue })
hi(0, "@function.method.call",  { fg = c.blue })
hi(0, "@keyword",               { fg = c.blue, italic = true })
hi(0, "@keyword.operator",      { fg = c.blue })
hi(0, "@keyword.return",        { fg = c.blue, italic = true })
hi(0, "@keyword.exception",     { fg = c.amber })
hi(0, "@keyword.conditional",   { fg = c.blue })
hi(0, "@keyword.repeat",        { fg = c.blue })
hi(0, "@keyword.import",        { fg = c.blue })
hi(0, "@keyword.storage",       { fg = c.blue })
hi(0, "@operator",              { fg = c.blue })
hi(0, "@punctuation.delimiter", { fg = c.fg_dim })
hi(0, "@punctuation.bracket",   { fg = c.fg_dim })
hi(0, "@punctuation.special",   { fg = c.amber })
hi(0, "@comment",               { fg = c.fg_dim, italic = true })
hi(0, "@comment.error",         { fg = c.amber,  italic = true })
hi(0, "@comment.warning",       { fg = c.amber,  italic = true })
hi(0, "@comment.todo",          { fg = c.amber,  bold = true })
hi(0, "@comment.note",          { fg = c.blue,   italic = true })
hi(0, "@markup.strong",         { bold = true })
hi(0, "@markup.italic",         { italic = true })
hi(0, "@markup.link",           { fg = c.blue,   underline = true })
hi(0, "@markup.heading",        { fg = c.amber,  bold = true })
hi(0, "@markup.raw",            { fg = c.amber })
hi(0, "@markup.list",           { fg = c.amber })
hi(0, "@diff.plus",             { fg = c.amber })
hi(0, "@diff.minus",            { fg = c.amber })
hi(0, "@diff.delta",            { fg = c.blue })
hi(0, "@tag",                   { fg = c.blue })
hi(0, "@tag.delimiter",         { fg = c.fg_dim })
hi(0, "@tag.attribute",         { fg = c.amber })
hi(0, "@none",                  { fg = c.fg })

-- ── Plugin overrides ──────────────────────────────────────────────
hi(0, "TelescopeNormal",        { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeBorder",        { fg = c.fg_dim,  bg = c.bg })
hi(0, "TelescopePromptNormal",  { fg = c.fg,      bg = c.bg_dark })
hi(0, "TelescopePromptBorder",  { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TelescopeResultsNormal", { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeSelection",     { fg = c.fg,      bg = c.blue })
hi(0, "NeoTreeNormal",           { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeNormalNC",         { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeDirectoryName",    { fg = c.blue })
hi(0, "NeoTreeDirectoryIcon",    { fg = c.blue })
hi(0, "NeoTreeRootName",         { fg = c.blue,    bold = true })
hi(0, "NeoTreeCursorLine",       { fg = c.fg,      bg = c.amber })
hi(0, "NeoTreeIndentMarker",     { fg = c.fg_dim })
hi(0, "NeoTreeGitModified",      { fg = c.fg_dim })
hi(0, "NeoTreeGitAdded",         { fg = c.fg_dim })
hi(0, "NeoTreeGitDeleted",       { fg = c.fg_dim })

-- ── Noice ─────────────────────────────────────────────────────────
hi(0, "NoiceCmdlinePopup",        { fg = c.fg,      bg = c.bg_light })
hi(0, "NoiceCmdlinePopupBorder",  { fg = c.fg_dim,  bg = c.bg_light })
hi(0, "NoiceMini",                { fg = c.fg,      bg = c.bg_light })
hi(0, "NoiceConfirmBorder",       { fg = c.fg_dim })

-- ── Which‑Key ──────────────────────────────────────────────────────
hi(0, "WhichKey",                 { fg = c.blue })
hi(0, "WhichKeyDesc",             { fg = c.fg })
hi(0, "WhichKeySeparator",        { fg = c.fg_dim })
hi(0, "WhichKeyGroup",            { fg = c.blue })
hi(0, "WhichKeyFloat",            { bg = c.bg_dark })
hi(0, "WhichKeyBorder",           { fg = c.fg_dim })

-- ── GitSigns ───────────────────────────────────────────────────────
hi(0, "GitSignsAdd",              { fg = c.fg_dim })
hi(0, "GitSignsChange",           { fg = c.fg_dim })
hi(0, "GitSignsDelete",           { fg = c.fg_dim })

-- ── LSP / Diagnostics extras ───────────────────────────────────────
hi(0, "LspReferenceRead",         { bg = c.bg_light })
hi(0, "LspReferenceWrite",        { bg = c.bg_light })
hi(0, "LspReferenceText",         { bg = c.bg_light })
hi(0, "LspSignatureActiveParameter", { bg = c.bg_light, bold = true })
hi(0, "LspInlayHint",             { fg = c.fg_dim,  bg = c.bg })

-- ── Completion menu (cmp) ──────────────────────────────────────────
hi(0, "CmpItemAbbr",              { fg = c.fg })
hi(0, "CmpItemAbbrMatch",         { fg = c.amber })
hi(0, "CmpItemAbbrMatchFuzzy",    { fg = c.amber })
hi(0, "CmpItemKind",              { fg = c.blue })
hi(0, "CmpItemKindText",          { fg = c.fg })
hi(0, "CmpItemKindMethod",        { fg = c.blue })
hi(0, "CmpItemKindFunction",      { fg = c.blue })
hi(0, "CmpItemKindConstructor",   { fg = c.blue })
hi(0, "CmpItemKindVariable",      { fg = c.blue })
hi(0, "CmpItemKindClass",         { fg = c.amber })
hi(0, "CmpItemKindInterface",     { fg = c.blue_b })
hi(0, "CmpItemKindModule",        { fg = c.blue })
hi(0, "CmpItemKindProperty",      { fg = c.blue })
hi(0, "CmpItemKindUnit",          { fg = c.amber })
hi(0, "CmpItemKindKeyword",       { fg = c.blue })
hi(0, "CmpItemKindSnippet",       { fg = c.amber })
hi(0, "CmpItemKindEnum",          { fg = c.blue })
hi(0, "CmpItemMenu",              { fg = c.fg_dim })

-- ── Float windows ──────────────────────────────────────────────────
hi(0, "NormalFloat",              { fg = c.fg,      bg = c.bg_light })
hi(0, "FloatBorder",              { fg = c.fg_dim,  bg = c.bg_light })
hi(0, "FloatTitle",               { fg = c.amber,   bold = true })

-- ── StatusLine ─────────────────────────────────────────────────────
hi(0, "StatusLine",               { fg = c.fg,      bg = c.bg_dark })
hi(0, "StatusLineNC",             { fg = c.fg_dim,  bg = c.bg_dark })

-- ── Folds ──────────────────────────────────────────────────────────
hi(0, "Folded",                   { fg = c.fg_dim,  bg = c.bg_light })
hi(0, "FoldColumn",               { fg = c.fg_dim,  bg = c.bg })

-- ── Quickfix ───────────────────────────────────────────────────────
hi(0, "QuickFixLine",             { bg = c.bg_light, bold = true })

-- ── Bufferline ─────────────────────────────────────────────────────
hi(0, "BufferLineFill",           { bg = c.bg_dark })
hi(0, "BufferLineTab",            { fg = c.fg_dim,  bg = c.bg })
hi(0, "BufferLineTabSelected",    { fg = c.fg,      bg = c.bg, bold = true })
hi(0, "BufferLineIndicatorSelected", { fg = c.amber })
hi(0, "BufferLineDiagnostic",     { fg = c.fg_dim })
hi(0, "BufferLineHintDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineInfoDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineWarningDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineErrorDiagnostic",   { fg = c.fg_dim })

-- ── ToggleTerm ─────────────────────────────────────────────────────
hi(0, "ToggleTerm1FloatNormal",   { fg = c.fg })
hi(0, "ToggleTerm1FloatBorder",   { fg = c.fg_dim })

-- ── Alpha Dashboard ────────────────────────────────────────────────
hi(0, "AlphaHeader",              { fg = c.amber })
hi(0, "AlphaHeaderLabel",         { fg = c.amber })
hi(0, "AlphaButtons",             { fg = c.fg_dim })
hi(0, "AlphaShortcut",            { fg = c.amber })
hi(0, "AlphaFooter",              { fg = c.fg_dim })
