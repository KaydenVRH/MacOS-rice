-- rainbow.lua — oscillating brightness shift
-- Toggle with :Rainbow or <leader>ur

local started = false
local tick_handle = nil
local frame = 0

-- All highlight groups from mono theme, with their original fg hex
local groups = {
  Normal       = "#e0e0e0", NormalNC     = "#606060", SignColumn = "#e0e0e0",
  MsgArea      = "#e0e0e0", Cursor       = "#d0d0d0", CursorLine  = nil,
  CursorLineNr = "#d0d0d0", LineNr       = "#606060", FoldColumn   = "#606060",
  Visual       = "#e0e0e0", Search       = "#d0d0d0", IncSearch    = "#e0e0e0",
  Substitute   = "#a0a0a0", MatchParen   = "#d0d0d0", ColorColumn  = nil,
  Whitespace   = "#303030", NonText      = "#606060", SpecialKey   = "#606060",
  VertSplit    = "#111111", StatusLine   = "#e0e0e0", StatusLineNC = "#606060",
  TabLine      = "#606060", TabLineSel   = "#e0e0e0", TabLineFill  = nil,
  Pmenu        = "#e0e0e0", PmenuSel     = "#d0d0d0", PmenuSbar    = nil,
  PmenuThumb   = "#606060", Question     = "#d0d0d0", ErrorMsg     = "#a0a0a0",
  WarningMsg   = "#d0d0d0", ModeMsg      = "#d0d0d0", MoreMsg      = "#808080",
  Title        = "#d0d0d0", Directory    = "#808080", qfLineNr     = "#d0d0d0",
  qfFileName   = "#d0d0d0", WinSeparator = "#111111", EndOfBuffer  = "#1a1a1a",
  -- Syntax
  Comment      = "#606060", Constant      = "#d0d0d0", String       = "#a0a0a0",
  Character    = "#a0a0a0", Number        = "#f0f0f0", Boolean      = "#d0d0d0",
  Float        = "#f0f0f0", Identifier    = "#e0e0e0", Function     = "#808080",
  Statement    = "#d0d0d0", Conditional   = "#d0d0d0", Repeat       = "#d0d0d0",
  Label        = "#606060", Operator      = "#606060", Keyword      = "#d0d0d0",
  Exception    = "#a0a0a0", PreProc       = "#d0d0d0", Include      = "#d0d0d0",
  Define       = "#d0d0d0", Macro         = "#d0d0d0", PreCondit    = "#606060",
  Type         = "#606060", StorageClass  = "#d0d0d0", Structure    = "#606060",
  Typedef      = "#606060", Special       = "#d0d0d0", SpecialChar  = "#d0d0d0",
  Tag          = "#d0d0d0", Delimiter     = "#e0e0e0", SpecialComment = "#606060",
  Debug        = "#a0a0a0", Error         = "#a0a0a0", Todo         = "#d0d0d0",
  -- Plugin overrides
  NeoTreeDirectoryName = "#d0d0d0", NeoTreeDirectoryIcon = "#d0d0d0",
  NeoTreeRootName      = "#d0d0d0", NeoTreeCursorLine    = "#e0e0e0",
  NeoTreeIndentMarker  = "#606060",
  TelescopeSelection   = "#e0e0e0",
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
  vim.cmd("colorscheme mono")
  vim.notify("🌈 rainbow off")
end

local function M_toggle()
  if started then M_stop() else M_start() end
end

vim.api.nvim_create_user_command("Rainbow", M_toggle, {})

return { start = M_start, stop = M_stop, toggle = M_toggle }
