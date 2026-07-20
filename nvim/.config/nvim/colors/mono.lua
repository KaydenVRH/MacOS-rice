-- mono.lua — Monochrome colorscheme
-- Clean grayscale, dark background, preserves transparency

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "mono"

local c = {
  bg        = "#1a1a1a",
  bg_dark   = "#111111",
  bg_light  = "#303030",
  fg        = "#e0e0e0",
  fg_dim    = "#606060",
  accent    = "#d0d0d0",
  mid       = "#a0a0a0",
  bright    = "#f0f0f0",
  dim       = "#808080",
  muted     = "#505050",
  selection = "#404040",
}

local hi = vim.api.nvim_set_hl

-- ── UI ────────────────────────────────────────────────────────────
hi(0, "Normal",        { fg = c.fg,      bg = c.bg })
hi(0, "NormalNC",      { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "SignColumn",    { fg = c.fg,      bg = c.bg })
hi(0, "MsgArea",       { fg = c.fg,      bg = c.bg })
hi(0, "Cursor",        { fg = c.bg,      bg = c.accent })
hi(0, "CursorLine",    { bg = c.bg_light })
hi(0, "CursorLineNr",  { fg = c.accent,  bg = c.bg_light, bold = true })
hi(0, "LineNr",        { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "FoldColumn",    { fg = c.fg_dim,  bg = c.bg })
hi(0, "Visual",        { fg = c.fg,      bg = c.selection })
hi(0, "Search",        { fg = c.bg,      bg = c.accent })
hi(0, "IncSearch",     { fg = c.bg,      bg = c.bright })
hi(0, "Substitute",    { fg = c.bg,      bg = c.mid })
hi(0, "MatchParen",    { fg = c.accent,  bg = c.bg_light, bold = true })
hi(0, "ColorColumn",   { bg = c.bg_light })
hi(0, "Whitespace",    { fg = c.bg_light })
hi(0, "NonText",       { fg = c.fg_dim })
hi(0, "SpecialKey",    { fg = c.fg_dim })
hi(0, "VertSplit",     { fg = c.bg_dark, bg = c.bg })
hi(0, "StatusLine",    { fg = c.fg,      bg = c.bg_dark })
hi(0, "StatusLineNC",  { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLine",       { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLineSel",    { fg = c.fg,      bg = c.accent, bold = true })
hi(0, "TabLineFill",   { bg = c.bg_dark })
hi(0, "Pmenu",         { fg = c.fg,      bg = c.bg_light })
hi(0, "PmenuSel",      { fg = c.bg,      bg = c.accent })
hi(0, "PmenuSbar",     { bg = c.bg_light })
hi(0, "PmenuThumb",    { bg = c.fg_dim })
hi(0, "Question",      { fg = c.accent })
hi(0, "ErrorMsg",      { fg = c.mid,     bold = true })
hi(0, "WarningMsg",    { fg = c.accent,  bold = true })
hi(0, "ModeMsg",       { fg = c.accent,  bold = true })
hi(0, "MoreMsg",       { fg = c.dim })
hi(0, "Title",         { fg = c.accent,  bold = true })
hi(0, "Directory",     { fg = c.dim,     bold = true })
hi(0, "qfLineNr",      { fg = c.accent })
hi(0, "qfFileName",    { fg = c.accent })
hi(0, "WinSeparator",  { fg = c.bg_dark })
hi(0, "EndOfBuffer",   { fg = c.bg })

-- ── Diagnostics ────────────────────────────────────────────────────
hi(0, "DiagnosticError",         { fg = c.mid })
hi(0, "DiagnosticWarn",          { fg = c.accent })
hi(0, "DiagnosticInfo",          { fg = c.dim })
hi(0, "DiagnosticHint",          { fg = c.fg_dim })
hi(0, "DiagnosticUnderlineError",{ sp = c.mid,   underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = c.accent, underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = c.dim,   underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = c.fg_dim, underline = true })

-- ── Syntax ─────────────────────────────────────────────────────────
hi(0, "Comment",        { fg = c.fg_dim, italic = true })
hi(0, "Constant",       { fg = c.accent })
hi(0, "String",         { fg = c.mid })
hi(0, "Character",      { fg = c.mid })
hi(0, "Number",         { fg = c.bright })
hi(0, "Boolean",        { fg = c.accent })
hi(0, "Float",          { fg = c.bright })
hi(0, "Identifier",     { fg = c.fg })
hi(0, "Function",       { fg = c.dim })
hi(0, "Statement",      { fg = c.accent })
hi(0, "Conditional",    { fg = c.accent })
hi(0, "Repeat",         { fg = c.accent })
hi(0, "Label",          { fg = c.fg_dim })
hi(0, "Operator",       { fg = c.fg_dim })
hi(0, "Keyword",        { fg = c.accent })
hi(0, "Exception",      { fg = c.mid })
hi(0, "PreProc",        { fg = c.accent })
hi(0, "Include",        { fg = c.accent })
hi(0, "Define",         { fg = c.accent })
hi(0, "Macro",          { fg = c.accent })
hi(0, "PreCondit",      { fg = c.fg_dim })
hi(0, "Type",           { fg = c.fg_dim })
hi(0, "StorageClass",   { fg = c.accent })
hi(0, "Structure",      { fg = c.fg_dim })
hi(0, "Typedef",        { fg = c.fg_dim })
hi(0, "Special",        { fg = c.accent })
hi(0, "SpecialChar",    { fg = c.accent })
hi(0, "Tag",            { fg = c.accent })
hi(0, "Delimiter",      { fg = c.fg })
hi(0, "SpecialComment", { fg = c.fg_dim, italic = true })
hi(0, "Debug",          { fg = c.mid })
hi(0, "Underlined",     { underline = true })
hi(0, "Error",          { fg = c.mid, bg = c.bg_dark, bold = true })
hi(0, "Todo",           { fg = c.accent, bg = c.bg_light, bold = true })

-- ── Treesitter ─────────────────────────────────────────────────────
hi(0, "@variable",              { fg = c.fg })
hi(0, "@variable.builtin",      { fg = c.accent })
hi(0, "@variable.parameter",    { fg = c.bright })
hi(0, "@variable.member",       { fg = c.fg_dim })
hi(0, "@constant",              { fg = c.bright })
hi(0, "@constant.builtin",      { fg = c.accent })
hi(0, "@constant.macro",        { fg = c.accent })
hi(0, "@module",                { fg = c.fg })
hi(0, "@label",                 { fg = c.fg_dim })
hi(0, "@string",                { fg = c.mid })
hi(0, "@string.regex",          { fg = c.mid })
hi(0, "@string.escape",         { fg = c.accent })
hi(0, "@string.special",        { fg = c.accent })
hi(0, "@character",             { fg = c.mid })
hi(0, "@character.special",     { fg = c.accent })
hi(0, "@type",                  { fg = c.fg_dim })
hi(0, "@type.builtin",          { fg = c.dim })
hi(0, "@type.definition",       { fg = c.fg_dim })
hi(0, "@attribute",             { fg = c.accent })
hi(0, "@property",              { fg = c.fg_dim })
hi(0, "@field",                 { fg = c.fg })
hi(0, "@constructor",           { fg = c.dim })
hi(0, "@function",              { fg = c.dim })
hi(0, "@function.builtin",      { fg = c.accent })
hi(0, "@function.macro",        { fg = c.accent })
hi(0, "@function.method",       { fg = c.dim })
hi(0, "@function.method.call",  { fg = c.dim })
hi(0, "@keyword",               { fg = c.accent, italic = true })
hi(0, "@keyword.operator",      { fg = c.fg_dim })
hi(0, "@keyword.return",        { fg = c.accent, italic = true })
hi(0, "@keyword.exception",     { fg = c.mid })
hi(0, "@keyword.conditional",   { fg = c.accent })
hi(0, "@keyword.repeat",        { fg = c.accent })
hi(0, "@keyword.import",        { fg = c.accent })
hi(0, "@keyword.storage",       { fg = c.accent })
hi(0, "@operator",              { fg = c.fg_dim })
hi(0, "@punctuation.delimiter", { fg = c.fg_dim })
hi(0, "@punctuation.bracket",   { fg = c.fg_dim })
hi(0, "@punctuation.special",   { fg = c.accent })
hi(0, "@comment",               { fg = c.fg_dim, italic = true })
hi(0, "@comment.error",         { fg = c.mid,    italic = true })
hi(0, "@comment.warning",       { fg = c.accent, italic = true })
hi(0, "@comment.todo",          { fg = c.accent, bold = true })
hi(0, "@comment.note",          { fg = c.dim,    italic = true })
hi(0, "@markup.strong",         { bold = true })
hi(0, "@markup.italic",         { italic = true })
hi(0, "@markup.link",           { fg = c.dim, underline = true })
hi(0, "@markup.heading",        { fg = c.accent, bold = true })
hi(0, "@markup.raw",            { fg = c.mid })
hi(0, "@markup.list",           { fg = c.accent })
hi(0, "@diff.plus",             { fg = c.mid })
hi(0, "@diff.minus",            { fg = c.mid })
hi(0, "@diff.delta",            { fg = c.accent })
hi(0, "@tag",                   { fg = c.accent })
hi(0, "@tag.delimiter",         { fg = c.fg_dim })
hi(0, "@tag.attribute",         { fg = c.accent })
hi(0, "@none",                  { fg = c.fg })

-- ── Plugin overrides ──────────────────────────────────────────────
hi(0, "TelescopeNormal",        { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeBorder",        { fg = c.fg_dim,  bg = c.bg })
hi(0, "TelescopePromptNormal",  { fg = c.fg,      bg = c.bg_dark })
hi(0, "TelescopePromptBorder",  { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TelescopeResultsNormal", { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeSelection",     { fg = c.fg,      bg = c.accent })
hi(0, "NeoTreeNormal",           { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeNormalNC",         { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeDirectoryName",    { fg = c.accent })
hi(0, "NeoTreeDirectoryIcon",    { fg = c.accent })
hi(0, "NeoTreeRootName",         { fg = c.accent,  bold = true })
hi(0, "NeoTreeCursorLine",       { fg = c.fg,      bg = c.accent })
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
hi(0, "WhichKey",                 { fg = c.accent })
hi(0, "WhichKeyDesc",             { fg = c.fg })
hi(0, "WhichKeySeparator",        { fg = c.fg_dim })
hi(0, "WhichKeyGroup",            { fg = c.accent })
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
hi(0, "CmpItemAbbrMatch",         { fg = c.accent })
hi(0, "CmpItemAbbrMatchFuzzy",    { fg = c.accent })
hi(0, "CmpItemKind",              { fg = c.accent })
hi(0, "CmpItemKindText",          { fg = c.fg })
hi(0, "CmpItemKindMethod",        { fg = c.dim })
hi(0, "CmpItemKindFunction",      { fg = c.dim })
hi(0, "CmpItemKindConstructor",   { fg = c.accent })
hi(0, "CmpItemKindVariable",      { fg = c.fg_dim })
hi(0, "CmpItemKindClass",         { fg = c.bright })
hi(0, "CmpItemKindInterface",     { fg = c.dim })
hi(0, "CmpItemKindModule",        { fg = c.accent })
hi(0, "CmpItemKindProperty",      { fg = c.fg_dim })
hi(0, "CmpItemKindUnit",          { fg = c.mid })
hi(0, "CmpItemKindKeyword",       { fg = c.accent })
hi(0, "CmpItemKindSnippet",       { fg = c.mid })
hi(0, "CmpItemKindEnum",          { fg = c.accent })
hi(0, "CmpItemMenu",              { fg = c.fg_dim })

-- ── Float windows ──────────────────────────────────────────────────
hi(0, "NormalFloat",              { fg = c.fg,      bg = c.bg_light })
hi(0, "FloatBorder",              { fg = c.fg_dim,  bg = c.bg_light })
hi(0, "FloatTitle",               { fg = c.accent,  bold = true })

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
hi(0, "BufferLineIndicatorSelected",  { fg = c.accent })
hi(0, "BufferLineDiagnostic",     { fg = c.fg_dim })
hi(0, "BufferLineHintDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineInfoDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineWarningDiagnostic", { fg = c.fg_dim })
hi(0, "BufferLineErrorDiagnostic",   { fg = c.fg_dim })

-- ── ToggleTerm ─────────────────────────────────────────────────────
hi(0, "ToggleTerm1FloatNormal",   { fg = c.fg })
hi(0, "ToggleTerm1FloatBorder",   { fg = c.fg_dim })

-- ── Alpha Dashboard ────────────────────────────────────────────────
hi(0, "AlphaHeader",              { fg = c.accent })
hi(0, "AlphaHeaderLabel",         { fg = c.accent })
hi(0, "AlphaButtons",             { fg = c.fg_dim })
hi(0, "AlphaShortcut",            { fg = c.accent })
hi(0, "AlphaFooter",              { fg = c.fg_dim })
