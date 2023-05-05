-- TODO: integrate context awareness with something like nvim-ts-context-commentstring
local M = {
    "numToStr/Comment.nvim",
}

function M.config()
    local status_ok, comment = pcall(require, "Comment")
    if not status_ok then
        return
    end
    comment.setup()
end

return M