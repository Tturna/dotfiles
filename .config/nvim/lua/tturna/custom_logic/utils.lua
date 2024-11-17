local utils = {}

--[[
-- This function is basically the f motion but case insensitive.
-- It would be cool if this was super smart:
-- - It would find the target char before AND after the cursor and
-- - highlight them. If only one side has a match, auto-jump to it.
-- - If there are highlighted matches, keys like <Left> and <Right>
-- - would jump to the highlighted match and highlight the next ones.
--
-- This sounds like a plugin all of a sudden.
--]]
function utils.Easy_f_forward()
    local current_line = string.lower(vim.api.nvim_get_current_line())
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local cursor_row = cursor_pos[1]
    local cursor_col = cursor_pos[2]

    print("Waiting for Easy F target (forward)...")
    local got_target, target = pcall(function ()
        return string.lower(vim.fn.getcharstr())
    end)

    if (not got_target or target == "") then
        return
    end

    local first_match = string.find(current_line, target, cursor_col + 2)

    if (first_match == nil) then
        print("No valid Easy F target found")
        return
    end

    print(string.format("Easy F target found at column: %i", first_match))
    vim.api.nvim_win_set_cursor(0, {cursor_row, first_match - 1})
end

return utils
