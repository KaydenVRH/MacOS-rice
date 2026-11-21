-- stark.lua — Iron Man holographic colorscheme
--
-- Arc-reactor cyan on a near-black blue field, gold for numbers and highlights,
-- red reserved for errors. Holographic UI: bright cyan rules and cursors,
-- steel-blue text, gold where a HUD would put a readout.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "stark"

local c = {
  bg        = "#05090f",
  bg_dark   = "#03060a",
  bg_light  = "#0b141c",
  text      = "#cfe9f7",
  dim       = "#4a6b7c",
  accent    = "#37d8ff",   -- reactor cyan
  accent_b  = "#7debff",
  type      = "#8fb6c9",
  type_b    = "#b6d6e6",
  func      = "#e6f6ff",
  string    = "#7fa8b8",
  string_b  = "#a8cbd8",
  number    = "#a8e9ff",   -- pale cyan readout
  number_b  = "#e6f6ff",
  info      = "#4a6b7c",
  info_b    = "#6e93a6",
  error     = "#ff4d3d",   -- iron red
  error_b   = "#ff7a6e",
  selection = "#10303c",
}

local hi = vim.api.nvim_set_hl

-- ── UI ────────────────────────────────────────────────────────────
hi(0, "Normal",        { fg = c.text,      bg = c.bg })
hi(0, "NormalNC",      { fg = c.dim,  bg = c.bg_dark })
hi(0, "SignColumn",    { fg = c.text,      bg = c.bg })
hi(0, "MsgArea",       { fg = c.text,      bg = c.bg })
hi(0, "Cursor",        { fg = c.bg,      bg = c.accent })
hi(0, "CursorLine",    { bg = c.bg_light })
hi(0, "CursorLineNr",  { fg = c.accent,  bg = c.bg_light, bold = true })
hi(0, "LineNr",        { fg = c.dim,  bg = c.bg_dark })
hi(0, "FoldColumn",    { fg = c.dim,  bg = c.bg })
hi(0, "Visual",        { fg = c.text,      bg = c.selection })
hi(0, "Search",        { fg = c.bg,      bg = c.accent })
hi(0, "IncSearch",     { fg = c.bg,      bg = c.accent_b })
hi(0, "Substitute",    { fg = c.bg,      bg = c.string })
hi(0, "MatchParen",    { fg = c.type,    bg = c.bg_light, bold = true })
hi(0, "ColorColumn",   { bg = c.bg_light })
hi(0, "Whitespace",    { fg = c.bg_light })
hi(0, "NonText",       { fg = c.dim })
hi(0, "SpecialKey",    { fg = c.dim })
hi(0, "VertSplit",     { fg = c.bg_dark, bg = c.bg })
hi(0, "StatusLine",    { fg = c.text,      bg = c.bg_dark })
hi(0, "StatusLineNC",  { fg = c.dim,  bg = c.bg_dark })
hi(0, "TabLine",       { fg = c.dim,  bg = c.bg_dark })
hi(0, "TabLineSel",    { fg = c.text,      bg = c.accent, bold = true })
hi(0, "TabLineFill",   { bg = c.bg_dark })
hi(0, "Pmenu",         { fg = c.text,      bg = c.bg_light })
hi(0, "PmenuSel",      { fg = c.bg,      bg = c.accent })
hi(0, "PmenuSbar",     { bg = c.bg_light })
hi(0, "PmenuThumb",    { bg = c.dim })
hi(0, "Question",      { fg = c.type })
hi(0, "ErrorMsg",      { fg = c.error,     bold = true })
hi(0, "WarningMsg",    { fg = c.number,   bold = true })
hi(0, "ModeMsg",       { fg = c.type,    bold = true })
hi(0, "MoreMsg",       { fg = c.accent })
hi(0, "Title",         { fg = c.type,    bold = true })
hi(0, "Directory",     { fg = c.accent,  bold = true })
hi(0, "qfLineNr",      { fg = c.type })
hi(0, "qfFileName",    { fg = c.type })
hi(0, "WinSeparator",  { fg = c.bg_dark })
hi(0, "EndOfBuffer",   { fg = c.bg })

-- ── Diagnostics ────────────────────────────────────────────────────
hi(0, "DiagnosticError",         { fg = c.error })
hi(0, "DiagnosticWarn",          { fg = c.number })
hi(0, "DiagnosticInfo",          { fg = c.accent })
hi(0, "DiagnosticHint",          { fg = c.type })
hi(0, "DiagnosticUnderlineError",{ sp = c.error,    underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = c.number,  underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = c.accent, underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = c.type,   underline = true })

-- ── Syntax ─────────────────────────────────────────────────────────
hi(0, "Comment",        { fg = c.dim, italic = true })
hi(0, "Constant",       { fg = c.type })
hi(0, "String",         { fg = c.string })
hi(0, "Character",      { fg = c.string })
hi(0, "Number",         { fg = c.number })
hi(0, "Boolean",        { fg = c.accent })
hi(0, "Float",          { fg = c.number })
hi(0, "Identifier",     { fg = c.text })
hi(0, "Function",       { fg = c.func })
hi(0, "Statement",      { fg = c.accent })
hi(0, "Conditional",    { fg = c.accent })
hi(0, "Repeat",         { fg = c.accent })
hi(0, "Label",          { fg = c.type })
hi(0, "Operator",       { fg = c.type })
hi(0, "Keyword",        { fg = c.accent })
hi(0, "Exception",      { fg = c.error })
hi(0, "PreProc",        { fg = c.type })
hi(0, "Include",        { fg = c.accent })
hi(0, "Define",         { fg = c.accent })
hi(0, "Macro",          { fg = c.type })
hi(0, "PreCondit",      { fg = c.type })
hi(0, "Type",           { fg = c.type })
hi(0, "StorageClass",   { fg = c.accent })
hi(0, "Structure",      { fg = c.type })
hi(0, "Typedef",        { fg = c.type })
hi(0, "Special",        { fg = c.type })
hi(0, "SpecialChar",    { fg = c.type })
hi(0, "Tag",            { fg = c.accent })
hi(0, "Delimiter",      { fg = c.text })
hi(0, "SpecialComment", { fg = c.dim, italic = true })
hi(0, "Debug",          { fg = c.error })
hi(0, "Underlined",     { underline = true })
hi(0, "Error",          { fg = c.error, bg = c.bg_dark, bold = true })
hi(0, "Todo",           { fg = c.number, bg = c.bg_light, bold = true })

-- ── Treesitter ─────────────────────────────────────────────────────
hi(0, "@variable",              { fg = c.text })
hi(0, "@variable.builtin",      { fg = c.type })
hi(0, "@variable.parameter",    { fg = c.number })
hi(0, "@variable.member",       { fg = c.type })
hi(0, "@constant",              { fg = c.number })
hi(0, "@constant.builtin",      { fg = c.type })
hi(0, "@constant.macro",        { fg = c.type })
hi(0, "@module",                { fg = c.text })
hi(0, "@label",                 { fg = c.type })
hi(0, "@string",                { fg = c.string })
hi(0, "@string.regex",          { fg = c.error })
hi(0, "@string.escape",         { fg = c.type })
hi(0, "@string.special",        { fg = c.type })
hi(0, "@character",             { fg = c.string })
hi(0, "@character.special",     { fg = c.type })
hi(0, "@type",                  { fg = c.type })
hi(0, "@type.builtin",          { fg = c.type_b })
hi(0, "@type.definition",       { fg = c.type })
hi(0, "@attribute",             { fg = c.type })
hi(0, "@property",              { fg = c.type })
hi(0, "@field",                 { fg = c.text })
hi(0, "@constructor",           { fg = c.func })
hi(0, "@function",              { fg = c.func })
hi(0, "@function.builtin",      { fg = c.func })
hi(0, "@function.macro",        { fg = c.type })
hi(0, "@function.method",       { fg = c.func })
hi(0, "@function.method.call",  { fg = c.func })
hi(0, "@keyword",               { fg = c.accent, italic = true })
hi(0, "@keyword.operator",      { fg = c.type })
hi(0, "@keyword.return",        { fg = c.accent, italic = true })
hi(0, "@keyword.exception",     { fg = c.error })
hi(0, "@keyword.conditional",   { fg = c.accent })
hi(0, "@keyword.repeat",        { fg = c.accent })
hi(0, "@keyword.import",        { fg = c.accent })
hi(0, "@keyword.storage",       { fg = c.accent })
hi(0, "@operator",              { fg = c.type })
hi(0, "@punctuation.delimiter", { fg = c.dim })
hi(0, "@punctuation.bracket",   { fg = c.dim })
hi(0, "@punctuation.special",   { fg = c.type })
hi(0, "@comment",               { fg = c.dim, italic = true })
hi(0, "@comment.error",         { fg = c.error,    italic = true })
hi(0, "@comment.warning",       { fg = c.number,  italic = true })
hi(0, "@comment.todo",          { fg = c.number,  bold = true })
hi(0, "@comment.note",          { fg = c.accent, italic = true })
hi(0, "@markup.strong",         { bold = true })
hi(0, "@markup.italic",         { italic = true })
hi(0, "@markup.link",           { fg = c.accent, underline = true })
hi(0, "@markup.heading",        { fg = c.type,   bold = true })
hi(0, "@markup.raw",            { fg = c.string })
hi(0, "@markup.list",           { fg = c.type })
hi(0, "@diff.plus",             { fg = c.string })
hi(0, "@diff.minus",            { fg = c.error })
hi(0, "@diff.delta",            { fg = c.number })
hi(0, "@tag",                   { fg = c.accent })
hi(0, "@tag.delimiter",         { fg = c.dim })
hi(0, "@tag.attribute",         { fg = c.type })
hi(0, "@none",                  { fg = c.text })

-- ── Plugin overrides ──────────────────────────────────────────────
hi(0, "TelescopeNormal",        { fg = c.text,      bg = c.bg })
hi(0, "TelescopeBorder",        { fg = c.dim,  bg = c.bg })
hi(0, "TelescopePromptNormal",  { fg = c.text,      bg = c.bg_dark })
hi(0, "TelescopePromptBorder",  { fg = c.dim,  bg = c.bg_dark })
hi(0, "TelescopeResultsNormal", { fg = c.text,      bg = c.bg })
hi(0, "TelescopeSelection",     { fg = c.text,      bg = c.accent })
hi(0, "NeoTreeNormal",           { fg = c.dim,  bg = c.bg_dark })
hi(0, "NeoTreeNormalNC",         { fg = c.dim,  bg = c.bg_dark })
hi(0, "NeoTreeDirectoryName",    { fg = c.type })
hi(0, "NeoTreeDirectoryIcon",    { fg = c.type })
hi(0, "NeoTreeRootName",         { fg = c.type,    bold = true })
hi(0, "NeoTreeCursorLine",       { fg = c.text,      bg = c.accent })
hi(0, "NeoTreeIndentMarker",     { fg = c.dim })
hi(0, "NeoTreeGitModified",      { fg = c.dim })
hi(0, "NeoTreeGitAdded",         { fg = c.dim })
hi(0, "NeoTreeGitDeleted",       { fg = c.dim })

-- ── Noice ─────────────────────────────────────────────────────────
hi(0, "NoiceCmdlinePopup",        { fg = c.text,      bg = c.bg_light })
hi(0, "NoiceCmdlinePopupBorder",  { fg = c.dim,  bg = c.bg_light })
hi(0, "NoiceMini",                { fg = c.text,      bg = c.bg_light })
hi(0, "NoiceConfirmBorder",       { fg = c.dim })

-- ── Which‑Key ──────────────────────────────────────────────────────
hi(0, "WhichKey",                 { fg = c.type })
hi(0, "WhichKeyDesc",             { fg = c.text })
hi(0, "WhichKeySeparator",        { fg = c.dim })
hi(0, "WhichKeyGroup",            { fg = c.type })
hi(0, "WhichKeyFloat",            { bg = c.bg_dark })
hi(0, "WhichKeyBorder",           { fg = c.dim })

-- ── GitSigns ───────────────────────────────────────────────────────
hi(0, "GitSignsAdd",              { fg = c.dim })
hi(0, "GitSignsChange",           { fg = c.dim })
hi(0, "GitSignsDelete",           { fg = c.dim })

-- ── LSP / Diagnostics extras ───────────────────────────────────────
hi(0, "LspReferenceRead",         { bg = c.bg_light })
hi(0, "LspReferenceWrite",        { bg = c.bg_light })
hi(0, "LspReferenceText",         { bg = c.bg_light })
hi(0, "LspSignatureActiveParameter", { bg = c.bg_light, bold = true })
hi(0, "LspInlayHint",             { fg = c.dim,  bg = c.bg })

-- ── Completion menu (cmp) ──────────────────────────────────────────
hi(0, "CmpItemAbbr",              { fg = c.text })
hi(0, "CmpItemAbbrMatch",         { fg = c.type })
hi(0, "CmpItemAbbrMatchFuzzy",    { fg = c.type })
hi(0, "CmpItemKind",              { fg = c.accent })
hi(0, "CmpItemKindText",          { fg = c.text })
hi(0, "CmpItemKindMethod",        { fg = c.accent })
hi(0, "CmpItemKindFunction",      { fg = c.accent })
hi(0, "CmpItemKindConstructor",   { fg = c.type })
hi(0, "CmpItemKindVariable",      { fg = c.type })
hi(0, "CmpItemKindClass",         { fg = c.number })
hi(0, "CmpItemKindInterface",     { fg = c.type_b })
hi(0, "CmpItemKindModule",        { fg = c.accent })
hi(0, "CmpItemKindProperty",      { fg = c.type })
hi(0, "CmpItemKindUnit",          { fg = c.string })
hi(0, "CmpItemKindKeyword",       { fg = c.accent })
hi(0, "CmpItemKindSnippet",       { fg = c.string })
hi(0, "CmpItemKindEnum",          { fg = c.type })
hi(0, "CmpItemMenu",              { fg = c.dim })

-- ── Float windows ──────────────────────────────────────────────────
hi(0, "NormalFloat",              { fg = c.text,      bg = c.bg_light })
hi(0, "FloatBorder",              { fg = c.dim,  bg = c.bg_light })
hi(0, "FloatTitle",               { fg = c.type,    bold = true })

-- ── StatusLine ─────────────────────────────────────────────────────
hi(0, "StatusLine",               { fg = c.text,      bg = c.bg_dark })
hi(0, "StatusLineNC",             { fg = c.dim,  bg = c.bg_dark })

-- ── Folds ──────────────────────────────────────────────────────────
hi(0, "Folded",                   { fg = c.dim,  bg = c.bg_light })
hi(0, "FoldColumn",               { fg = c.dim,  bg = c.bg })

-- ── Quickfix ───────────────────────────────────────────────────────
hi(0, "QuickFixLine",             { bg = c.bg_light, bold = true })

-- ── Bufferline ─────────────────────────────────────────────────────
hi(0, "BufferLineFill",           { bg = c.bg_dark })
hi(0, "BufferLineTab",            { fg = c.dim,  bg = c.bg })
hi(0, "BufferLineTabSelected",    { fg = c.text,      bg = c.bg, bold = true })
hi(0, "BufferLineIndicatorSelected", { fg = c.type })
hi(0, "BufferLineDiagnostic",     { fg = c.dim })
hi(0, "BufferLineHintDiagnostic", { fg = c.dim })
hi(0, "BufferLineInfoDiagnostic", { fg = c.dim })
hi(0, "BufferLineWarningDiagnostic", { fg = c.dim })
hi(0, "BufferLineErrorDiagnostic",   { fg = c.dim })

-- ── ToggleTerm ─────────────────────────────────────────────────────
hi(0, "ToggleTerm1FloatNormal",   { fg = c.text })
hi(0, "ToggleTerm1FloatBorder",   { fg = c.dim })

-- ── Alpha Dashboard ────────────────────────────────────────────────
hi(0, "AlphaHeader",              { fg = c.type })
hi(0, "AlphaHeaderLabel",         { fg = c.type })
hi(0, "AlphaButtons",             { fg = c.dim })
hi(0, "AlphaShortcut",            { fg = c.type })
hi(0, "AlphaFooter",              { fg = c.dim })
