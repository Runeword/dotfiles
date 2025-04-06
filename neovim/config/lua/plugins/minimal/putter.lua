local vim = vim

return {
  enabled = true,

  -- 'Runeword/putter.nvim',

  dir = vim.fn.stdpath('config') .. '/lua/myplugins/putter.nvim',

  config = function()
    vim.keymap.set({ 'n', 'x', }, 'gp', require('putter').putLinewiseAfter)
    vim.keymap.set({ 'n', 'x', }, 'gP', require('putter').putLinewiseBefore)

    vim.keymap.set({ 'n', 'x', }, 'p', require('putter').putCharwiseAfter)
    vim.keymap.set({ 'n', 'x', }, 'P', require('putter').putCharwiseBefore)

    -- vim.keymap.set({ 'n', 'x', }, 'p', require('putter').putWordwise())
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
  end,
}
