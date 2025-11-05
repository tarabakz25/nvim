-- Bun-first Live Server integration
-- Provides :BunServerStart[ {dir}] and :BunServerStop

local function has_bun()
  return vim.fn.executable("bun") == 1
end

local term_obj = nil

local function ensure_toggleterm()
  local ok, tt = pcall(require, "toggleterm.terminal")
  if not ok then return nil end
  return tt
end

local function start_bun_server(dir)
  dir = dir and dir ~= "" and dir or vim.loop.cwd()
  if not has_bun() then
    vim.notify("bun が見つかりません。vim-live-server にフォールバックします。", vim.log.levels.WARN)
    pcall(vim.cmd, "LiveServerStart")
    return
  end

  local cmd = string.format("bunx --bun live-server %s", vim.fn.fnameescape(dir))

  local TT = ensure_toggleterm()
  if TT then
    if term_obj == nil then
      term_obj = TT.Terminal:new({
        cmd = cmd,
        hidden = true,
        direction = "float",
        float_opts = { border = "rounded" },
        on_open = function(term)
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
        end,
      })
    else
      term_obj.cmd = cmd
    end
    term_obj:toggle()
    return
  end

  -- Fallback: plain terminal split
  vim.cmd("botright split new")
  local buf = vim.api.nvim_get_current_buf()
  vim.fn.termopen(cmd)
  vim.api.nvim_buf_set_option(buf, "buflisted", false)
end

local function stop_bun_server()
  local TT = ensure_toggleterm()
  if TT and term_obj then
    -- try graceful shutdown
    if term_obj.shutdown then
      pcall(function() term_obj:shutdown() end)
    else
      pcall(function()
        if term_obj.job_id then vim.fn.jobstop(term_obj.job_id) end
        term_obj:close()
      end)
    end
    term_obj = nil
    return
  end
  -- If vim-live-server is running, also try to stop it
  pcall(vim.cmd, "LiveServerStop")
end

vim.api.nvim_create_user_command("BunServerStart", function(opts)
  start_bun_server(opts.args)
end, { nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("BunServerStop", function()
  stop_bun_server()
end, {})

