local M = {}
local mpv_job = nil

M.current = nil

function M.play(path)
  if path == nil or path == "" then return end
  M.stop()
  M.current = vim.fn.fnamemodify(path, ":t")
  mpv_job = vim.fn.jobstart({
    "mpv", "--no-terminal", path,
  }, { on_exit = function() mpv_job = nil; M.current = nil end })
  vim.notify("♪ " .. M.current)
end

function M.play_picker()
  require("telescope.builtin").find_files({
    prompt_title = "♪ Music",
    cwd = vim.fn.expand("~/Music"),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local actions = require("telescope.actions")
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then M.play(selection.path or selection.value) end
      end)
      return true
    end,
  })
end

function M.play_url()
  local url = vim.fn.input("♪ URL: ")
  if url and #url > 0 then
    M.stop()
    mpv_job = vim.fn.jobstart({ "mpv", "--no-terminal", url },
      { on_exit = function() mpv_job = nil end })
    vim.notify("♪ playing URL")
  end
end

function M.toggle()
  if mpv_job then
    local pid = vim.fn.jobpid(mpv_job)
    if pid then
      vim.fn.system("kill -USR1 " .. pid .. " 2>/dev/null")
      vim.notify("♪ toggled")
    end
  end
end

function M.stop()
  if mpv_job then
    vim.fn.jobstop(mpv_job)
    mpv_job = nil
    vim.notify("♪ stopped")
  end
end

function M.volume_up()
  vim.fn.system("osascript -e 'set volume output volume (output volume of (get volume settings) + 5)'")
  vim.notify("♪ +5")
end

function M.volume_down()
  vim.fn.system("osascript -e 'set volume output volume (output volume of (get volume settings) - 5)'")
  vim.notify("♪ -5")
end

return M
