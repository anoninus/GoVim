-- Termux Clipboard Integration (async)

local function termux_copy(text)
  vim.fn.jobstart({ "termux-clipboard-set", text }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Copied!", vim.log.levels.INFO)
      else
        vim.notify("Copy failed", vim.log.levels.ERROR)
      end
    end,
  })
end

local function termux_paste(callback)
  local result = {}
  vim.fn.jobstart({ "termux-clipboard-get" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      result = data
    end,
    on_exit = function()
      local text = table.concat(result, "\n"):gsub("\n$", "")
      callback(text)
    end,
  })
end

-- <Leader>yc — Copy yank register to Termux clipboard
vim.keymap.set("n", "<leader>yc", function()
  local text = vim.fn.getreg('"')
  if text == "" then
    vim.notify("Yank register is empty", vim.log.levels.WARN)
    return
  end
  termux_copy(text)
end, { desc = "Copy yank register to Termux clipboard" })

-- <Leader>yt — Copy visual selection to Termux clipboard
vim.keymap.set("v", "<leader>yt", function()
  vim.cmd('normal! "zy')
  local text = vim.fn.getreg("z")
  termux_copy(text)
end, { desc = "Copy visual selection to Termux clipboard" })

-- <Leader>pc — Paste from Termux clipboard
vim.keymap.set("n", "<leader>pc", function()
  termux_paste(function(text)
    if text and text ~= "" then
      if text:find("\n") then
        vim.api.nvim_put(vim.split(text, "\n", { plain = true }), "c", true, true)
      else
        vim.api.nvim_put({ text }, "c", true, true)
      end
      vim.notify("Pasted!", vim.log.levels.INFO)
    else
      vim.notify("Clipboard is empty", vim.log.levels.WARN)
    end
  end)
end, { desc = "Paste from Termux clipboard" })
