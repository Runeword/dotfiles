local vim = vim

return {
  -- 'Runeword/putter.nvim',
  dir = '/home/charles/Documents/dev/putter.nvim',

  config = function()
    vim.keymap.set({ 'n', 'x', }, 'gp', require('putter').putLinewise(']p`]'))
    vim.keymap.set({ 'n', 'x', }, 'gP', require('putter').putLinewise(']P`]'))

    vim.keymap.set({ 'n', 'x', }, 'P', require('putter').putCharwise('P'))
    vim.keymap.set({ 'n', 'x', }, 'p', require('putter').putWordwise())
    -- vim.keymap.set({ 'n', 'x', }, 'p', require('putter').putCharwise('p'))

    -- vim.keymap.set({ 'n', 'x', }, 'gp', require('putter').putCharwisePrefix('p'))
    -- vim.keymap.set({ 'n', 'x', }, 'gP', require('putter').putCharwiseSuffix('P'))

    -- vim.keymap.set({ 'n', 'x', }, 'gsp', require('putter').putCharwiseSurround('p'))
    -- vim.keymap.set({ 'n', 'x', }, 'gsP', require('putter').putCharwiseSurround('P'))

    -- vim.keymap.set({ "n", "x" }, "x", require("putter").snapToLineEnd('"_x'))
    -- vim.keymap.set({ "n", "x" }, "p", require("putter").jumpToLineEnd(require("putter").putCharwise('p')))
    -- vim.keymap.set({ "n", "x" }, "gp", require("putter").putCharwisePrefix('geep'))
    -- vim.keymap.set({ "n", "x" }, "gP", require("putter").putCharwiseSuffix('gewP'))
    -- vim.keymap.set({ "n", "x" }, "gsp", require("putter").putCharwiseSurround('geep'))
    -- vim.keymap.set({ "n", "x" }, "gsP", require("putter").putCharwiseSurround('gewP'))

    -- vim.keymap.set("n", "<leader><Tab>", require("putter").addBuffersToQfList)
    -- vim.keymap.set("n", "<C-down>", require("putter").cycleNextLocItem, silent)
    -- vim.keymap.set("n", "<C-up>", require("putter").cyclePrevLocItem, silent)
    -- vim.keymap.set("n", "<C-q>", "&buftype is# 'quickfix' ? ':try | cclose | catch | q! | catch | endtry<CR>' : ':q!<CR>'", expr)

    -- vim.keymap.set("n", "t", require("putter").__dot_repeat('p'))

    -- local counter = 0
    --
    -- function _G.__dot_repeat(motion) -- 4.
    --     if motion == nil then
    --         vim.o.operatorfunc = "v:lua.require('putter').snapToLineEnd('_x')()"
    --         return "g@$" -- 2.
    --     end
    --
    --     -- print("counter:", counter, "motion:", motion)
    --     counter = counter + 1
    -- end
    --
    -- vim.keymap.set("n", "ga", _G.__dot_repeat, expr)

    -- -- stylua: ignore
  end,
}
