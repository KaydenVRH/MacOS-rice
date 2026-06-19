-- amber.lua — Kayden's Amber Amethyst colorscheme
-- Deep purple bg + amber/gold accents

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "amber"

local c = {
  bg        = "#1e1a2e",
  bg_dark   = "#181528",
  bg_light  = "#2a2440",
  fg        = "#e2e8f0",
  fg_dim    = "#8880a0",
  red       = "#ef4444",
  green     = "#34d399",
  amber     = "#fbbf24",
  blue      = "#818cf8",
  purple    = "#a855f7",
  cyan      = "#22d3ee",
  white     = "#f8fafc",
  -- Bright variants
  red_b     = "#f87171",
  green_b   = "#6ee7b7",
  amber_b   = "#fde68a",
  blue_b    = "#a5b4fc",
  purple_b  = "#c084fc",
  cyan_b    = "#67e8f9",
  selection = "#a855f7",
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
hi(0, "Substitute",    { fg = c.bg,      bg = c.green })
hi(0, "MatchParen",    { fg = c.amber,   bg = c.bg_light, bold = true })
hi(0, "ColorColumn",   { bg = c.bg_light })
hi(0, "Whitespace",    { fg = c.bg_light })
hi(0, "NonText",       { fg = c.fg_dim })
hi(0, "SpecialKey",    { fg = c.fg_dim })
hi(0, "VertSplit",     { fg = c.bg_dark, bg = c.bg })
hi(0, "StatusLine",    { fg = c.fg,      bg = c.bg_dark })
hi(0, "StatusLineNC",  { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLine",       { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "TabLineSel",    { fg = c.amber,   bg = c.purple, bold = true })
hi(0, "TabLineFill",   { bg = c.bg_dark })
hi(0, "Pmenu",         { fg = c.fg,      bg = c.bg_light })
hi(0, "PmenuSel",      { fg = c.bg,      bg = c.amber })
hi(0, "PmenuSbar",     { bg = c.bg_light })
hi(0, "PmenuThumb",    { bg = c.fg_dim })
hi(0, "Question",      { fg = c.amber })
hi(0, "ErrorMsg",      { fg = c.red,     bold = true })
hi(0, "WarningMsg",    { fg = c.amber,   bold = true })
hi(0, "ModeMsg",       { fg = c.amber,   bold = true })
hi(0, "MoreMsg",       { fg = c.blue })
hi(0, "Title",         { fg = c.amber,   bold = true })
hi(0, "Directory",     { fg = c.blue,    bold = true })
hi(0, "qfLineNr",      { fg = c.amber })
hi(0, "qfFileName",    { fg = c.amber })
hi(0, "WinSeparator",  { fg = c.bg_dark })
hi(0, "EndOfBuffer",   { fg = c.bg })

-- ── Diagnostics ────────────────────────────────────────────────────
hi(0, "DiagnosticError",         { fg = c.red })
hi(0, "DiagnosticWarn",          { fg = c.amber })
hi(0, "DiagnosticInfo",          { fg = c.blue })
hi(0, "DiagnosticHint",          { fg = c.cyan })
hi(0, "DiagnosticUnderlineError",{ sp = c.red,   underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = c.amber, underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = c.blue,  underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = c.cyan,  underline = true })

-- ── Syntax ─────────────────────────────────────────────────────────
hi(0, "Comment",        { fg = c.fg_dim, italic = true })
hi(0, "Constant",       { fg = c.amber })
hi(0, "String",         { fg = c.green })
hi(0, "Character",      { fg = c.green })
hi(0, "Number",         { fg = c.amber_b })
hi(0, "Boolean",        { fg = c.purple })
hi(0, "Float",          { fg = c.amber_b })
hi(0, "Identifier",     { fg = c.fg })
hi(0, "Function",       { fg = c.blue })
hi(0, "Statement",      { fg = c.purple })
hi(0, "Conditional",    { fg = c.purple })
hi(0, "Repeat",         { fg = c.purple })
hi(0, "Label",          { fg = c.cyan })
hi(0, "Operator",       { fg = c.cyan })
hi(0, "Keyword",        { fg = c.purple })
hi(0, "Exception",      { fg = c.red })
hi(0, "PreProc",        { fg = c.amber })
hi(0, "Include",        { fg = c.purple })
hi(0, "Define",         { fg = c.purple })
hi(0, "Macro",          { fg = c.amber })
hi(0, "PreCondit",      { fg = c.cyan })
hi(0, "Type",           { fg = c.cyan })
hi(0, "StorageClass",   { fg = c.purple })
hi(0, "Structure",      { fg = c.cyan })
hi(0, "Typedef",        { fg = c.cyan })
hi(0, "Special",        { fg = c.amber })
hi(0, "SpecialChar",    { fg = c.amber })
hi(0, "Tag",            { fg = c.purple })
hi(0, "Delimiter",      { fg = c.fg })
hi(0, "SpecialComment", { fg = c.fg_dim, italic = true })
hi(0, "Debug",          { fg = c.red })
hi(0, "Underlined",     { underline = true })
hi(0, "Error",          { fg = c.red, bg = c.bg_dark, bold = true })
hi(0, "Todo",           { fg = c.amber, bg = c.bg_light, bold = true })

-- ── Treesitter (override for richer highlights) ───────────────────
hi(0, "@variable",              { fg = c.fg })
hi(0, "@variable.builtin",      { fg = c.amber })
hi(0, "@variable.parameter",    { fg = c.amber_b })
hi(0, "@variable.member",       { fg = c.cyan })
hi(0, "@constant",              { fg = c.amber_b })
hi(0, "@constant.builtin",      { fg = c.amber })
hi(0, "@constant.macro",        { fg = c.amber })
hi(0, "@module",                { fg = c.fg })
hi(0, "@label",                 { fg = c.cyan })
hi(0, "@string",                { fg = c.green })
hi(0, "@string.regex",          { fg = c.red })
hi(0, "@string.escape",         { fg = c.amber })
hi(0, "@string.special",        { fg = c.amber })
hi(0, "@character",             { fg = c.green })
hi(0, "@character.special",     { fg = c.amber })
hi(0, "@type",                  { fg = c.cyan })
hi(0, "@type.builtin",          { fg = c.cyan_b })
hi(0, "@type.definition",       { fg = c.cyan })
hi(0, "@attribute",             { fg = c.amber })
hi(0, "@property",              { fg = c.cyan })
hi(0, "@field",                 { fg = c.fg })
hi(0, "@constructor",           { fg = c.blue })
hi(0, "@function",              { fg = c.blue })
hi(0, "@function.builtin",      { fg = c.purple })
hi(0, "@function.macro",        { fg = c.amber })
hi(0, "@function.method",       { fg = c.blue })
hi(0, "@function.method.call",  { fg = c.blue })
hi(0, "@keyword",               { fg = c.purple, italic = true })
hi(0, "@keyword.operator",      { fg = c.cyan })
hi(0, "@keyword.return",        { fg = c.purple, italic = true })
hi(0, "@keyword.exception",     { fg = c.red })
hi(0, "@keyword.conditional",   { fg = c.purple })
hi(0, "@keyword.repeat",        { fg = c.purple })
hi(0, "@keyword.import",        { fg = c.purple })
hi(0, "@keyword.storage",       { fg = c.purple })
hi(0, "@operator",              { fg = c.cyan })
hi(0, "@punctuation.delimiter", { fg = c.fg_dim })
hi(0, "@punctuation.bracket",   { fg = c.fg_dim })
hi(0, "@punctuation.special",   { fg = c.amber })
hi(0, "@comment",               { fg = c.fg_dim, italic = true })
hi(0, "@comment.error",         { fg = c.red,    italic = true })
hi(0, "@comment.warning",       { fg = c.amber,  italic = true })
hi(0, "@comment.todo",          { fg = c.amber,  bold = true })
hi(0, "@comment.note",          { fg = c.blue,   italic = true })
hi(0, "@markup.strong",         { bold = true })
hi(0, "@markup.italic",         { italic = true })
hi(0, "@markup.link",           { fg = c.blue,  underline = true })
hi(0, "@markup.heading",        { fg = c.amber, bold = true })
hi(0, "@markup.raw",            { fg = c.green })
hi(0, "@markup.list",           { fg = c.amber })
hi(0, "@diff.plus",             { fg = c.green })
hi(0, "@diff.minus",            { fg = c.red })
hi(0, "@diff.delta",            { fg = c.amber })
hi(0, "@tag",                   { fg = c.purple })
hi(0, "@tag.delimiter",         { fg = c.fg_dim })
hi(0, "@tag.attribute",         { fg = c.amber })
hi(0, "@none",                  { fg = c.fg })

-- ── Plugin overrides ───────────────────────────────────────────────
hi(0, "TelescopeNormal",        { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeBorder",        { fg = c.purple,  bg = c.bg })
hi(0, "TelescopePromptNormal",  { fg = c.fg,      bg = c.bg_dark })
hi(0, "TelescopePromptBorder",  { fg = c.amber,   bg = c.bg_dark })
hi(0, "TelescopeResultsNormal", { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeSelection",     { fg = c.fg,      bg = c.purple })
hi(0, "NeoTreeNormal",           { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeNormalNC",         { fg = c.fg_dim,  bg = c.bg_dark })
hi(0, "NeoTreeDirectoryName",    { fg = c.blue })
hi(0, "NeoTreeDirectoryIcon",    { fg = c.blue })
hi(0, "NeoTreeRootName",         { fg = c.purple,  bold = true })
hi(0, "NeoTreeIndentMarker",     { fg = c.fg_dim })
hi(0, "NeoTreeGitModified",      { fg = c.amber })
hi(0, "NeoTreeGitAdded",         { fg = c.green })
hi(0, "NeoTreeGitDeleted",       { fg = c.red })
