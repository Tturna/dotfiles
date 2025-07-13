vim.g.mapleader = " "
-- vim.keymap.set("n", "<C-p>", vim.cmd.Ex)
vim.keymap.set("n", "<C-p>", vim.cmd.Oil)

--[[
-- Move selected lines up or down. This works using the move command.
-- Because this requires visual mode, the selected lines are the input range to the move command.
-- The target line to put the selected lines under is referred to with '>+1 and '<-2.
-- '< means the first line or character of the selection, '> is the last. +1 means the next line.
--
-- <CR> basically hits enter to apply the command. gv selects the previous selection. = formats the selection.
--]]
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- remap the jump key. This is used to jump to a marker set with "m[a-zA-Z]", e.g. ma (marker a) or mz (marker z).
vim.keymap.set("n", "<leader>m", "`")

-- cool navigation
vim.keymap.set("i", "kj", "<Esc>A")
vim.keymap.set("n", "W", "$")
vim.keymap.set("v", "W", "$")
vim.keymap.set("n", "Q", "^")
vim.keymap.set("v", "Q", "^")
-- jump to next/prev lowercase mark
vim.keymap.set("n", "<leader>m<Right>", "]`")
vim.keymap.set("n", "<leader>m<Left>", "[`")
-- jump to previous edit
vim.keymap.set("n", "<leader>e", "`.")
-- change to previous file
vim.keymap.set("n", "<leader>q", "<C-^>")

vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- convenient block marking
vim.keymap.set("v", "iS", "i\"")
vim.keymap.set("v", "is", "i'")
vim.keymap.set("v", "iT", "it'")
vim.keymap.set("v", "it", "i['")
vim.keymap.set("o", "iS", "i\"")
vim.keymap.set("o", "is", "i'")
vim.keymap.set("o", "iT", "it'")
vim.keymap.set("o", "it", "i['")

-- next/prev occurrence of word
vim.keymap.set("n", "!", "*")
vim.keymap.set("n", "?", "#")

-- system clipboard operations
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")

-- select all
vim.keymap.set("n", "<leader>a", "gg^vG$")

-- better line joining
vim.keymap.set("n", "J", "J^")

-- nop
vim.keymap.set("n", "<C-f>", "<Nop>")
vim.keymap.set("n", "<C-z>", "<Nop>")

-- Autocmd to apply mappings only in Netrw buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    -- Check if the 't' key mapping exists before deleting it
    local has_mapping = vim.fn.maparg("t", "n") ~= ""
    if has_mapping then
      vim.api.nvim_buf_del_keymap(0, "n", "t")
    end
  end,
})

-- custom logic
local utils = require("tturna.custom_logic.utils")
vim.keymap.set("n", "<leader>f", utils.Easy_f_forward)

-- there might be more keymappings in plugin lua files
