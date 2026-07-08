-- rainbow.lua — oscillating hue shift between blue and purple/pink
-- Toggle with :Rainbow or <leader>ur

local started = false
local tick_handle = nil
local frame = 0

-- All highlight groups from bi theme, with their original fg hex
local groups = {
  Normal       = "#d4d8ee", NormalNC     = "#5a5282", SignColumn = "#d4d8ee",
  MsgArea      = "#d4d8ee", Cursor       = "#c0a0f0", CursorLine  = nil,
  CursorLineNr = "#c0a0f0", LineNr       = "#5a5282", FoldColumn   = "#5a5282",
  Visual       = "#d4d8ee", Search       = "#c0a0f0", IncSearch    = "#d4d8ee",
  Substitute   = "#90d0c0", MatchParen   = "#c0a0f0", ColorColumn  = nil,
  Whitespace   = "#2e2852", NonText      = "#5a5282", SpecialKey   = "#5a5282",
  VertSplit    = "#0e0c1a", StatusLine   = "#d4d8ee", StatusLineNC = "#5a5282",
  TabLine      = "#5a5282", TabLineSel   = "#d4d8ee", TabLineFill  = nil,
  Pmenu        = "#d4d8ee", PmenuSel     = "#c0a0f0", PmenuSbar    = nil,
  PmenuThumb   = "#5a5282", Question     = "#c0a0f0", ErrorMsg     = "#f080c0",
  WarningMsg   = "#c0a0f0", ModeMsg      = "#c0a0f0", MoreMsg      = "#68a8f8",
  Title        = "#c0a0f0", Directory    = "#68a8f8", qfLineNr     = "#c0a0f0",
  qfFileName   = "#c0a0f0", WinSeparator = "#0e0c1a", EndOfBuffer  = "#141124",
  -- Syntax
  Comment      = "#5a5282", Constant      = "#c0a0f0", String       = "#90d0c0",
  Character    = "#90d0c0", Number        = "#f0a0d0", Boolean      = "#b080f0",
  Float        = "#f0a0d0", Identifier    = "#d4d8ee", Function     = "#68a8f8",
  Statement    = "#b080f0", Conditional   = "#b080f0", Repeat       = "#b080f0",
  Label        = "#88c8f8", Operator      = "#88c8f8", Keyword      = "#b080f0",
  Exception    = "#f080c0", PreProc       = "#c0a0f0", Include      = "#b080f0",
  Define       = "#b080f0", Macro         = "#c0a0f0", PreCondit    = "#88c8f8",
  Type         = "#88c8f8", StorageClass  = "#b080f0", Structure    = "#88c8f8",
  Typedef      = "#88c8f8", Special       = "#c0a0f0", SpecialChar  = "#c0a0f0",
  Tag          = "#b080f0", Delimiter     = "#d4d8ee", SpecialComment = "#5a5282",
  Debug        = "#f080c0", Error         = "#f080c0", Todo         = "#c0a0f0",
  -- Plugin overrides
  NeoTreeDirectoryName = "#b080f0", NeoTreeDirectoryIcon = "#b080f0",
  NeoTreeRootName      = "#b080f0", NeoTreeCursorLine    = "#d4d8ee",
  NeoTreeIndentMarker  = "#5a5282",
  TelescopeSelection   = "#d4d8ee",
  QuickFixLine         = nil,
}

-- RGB → HSL helpers
local function rgb_to_hsl(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local mx, mn = math.max(r, g, b), math.min(r, g, b)
  local h, s, l = 0, 0, (mx + mn) / 2
  if mx ~= mn then
    local d = mx - mn
    s = l > 0.5 and d / (2 - mx - mn) or d / (mx + mn)
    if mx == r then h = ((g - b) / d) % 6
    elseif mx == g then h = (b - r) / d + 2
    else h = (r - g) / d + 4 end
    h = h * 60
    if h < 0 then h = h + 360 end
  end
  return h, s, l
end

local function hsl_to_rgb(h, s, l)
  local c = (1 - math.abs(2 * l - 1)) * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = l - c / 2
  local r1, g1, b1
  if h < 60 then r1, g1, b1 = c, x, 0
  elseif h < 120 then r1, g1, b1 = x, c, 0
  elseif h < 180 then r1, g1, b1 = 0, c, x
  elseif h < 240 then r1, g1, b1 = 0, x, c
  elseif h < 300 then r1, g1, b1 = x, 0, c
  else r1, g1, b1 = c, 0, x end
  return math.floor((r1 + m) * 255 + 0.5),
         math.floor((g1 + m) * 255 + 0.5),
         math.floor((b1 + m) * 255 + 0.5)
end

local function rotate_hex(hex, deg)
  if not hex then return nil end
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)
  if not r or not g or not b then return hex end
  local h, s, l = rgb_to_hsl(r, g, b)
  if s < 0.01 then s = 0.7 end
  h = (h + deg) % 360
  local r2, g2, b2 = hsl_to_rgb(h, s, l)
  return string.format("#%02x%02x%02x", r2, g2, b2)
end

local function tick()
  if not started then return end
  frame = frame + 1
  -- oscillate between 0° and 120° (blue ↔ purple/pink)
  local offset = math.sin(frame * 0.025) * 60 + 60

  for group, hex in pairs(groups) do
    if hex then
      local new_fg = rotate_hex(hex, offset)
      if new_fg then
        pcall(vim.api.nvim_set_hl, 0, group, { fg = new_fg })
      end
    end
  end
  tick_handle = vim.defer_fn(tick, 100)
end

local function M_start()
  if started then return end
  started = true
  frame = 0
  tick_handle = vim.defer_fn(tick, 100)
  vim.notify("🌈 rainbow on")
end

local function M_stop()
  started = false
  tick_handle = nil
  vim.cmd("colorscheme bi")
  vim.notify("🌈 rainbow off")
end

local function M_toggle()
  if started then M_stop() else M_start() end
end

vim.api.nvim_create_user_command("Rainbow", M_toggle, {})

return { start = M_start, stop = M_stop, toggle = M_toggle }
