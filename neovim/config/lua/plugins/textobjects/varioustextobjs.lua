local vim = vim

return {
	'chrisgrieser/nvim-various-textobjs',

	enabled = true,

	config = function()
		require('various-textobjs').setup({ keymaps = { useDefaults = false, }, })

		vim.keymap.set({ 'o', }, 'd',
			function() require('various-textobjs').diagnostic() end)
		vim.keymap.set({ 'o', 'x', }, 'id',
			function() require('various-textobjs').diagnostic() end)
		vim.keymap.set({ 'o', 'x', }, 'ad',
			function() require('various-textobjs').diagnostic() end)
		vim.keymap.set({ 'o', 'x', }, 'ak',
			function() require('various-textobjs').key('outer') end)
		vim.keymap.set({ 'o', 'x', }, 'ik',
			function() require('various-textobjs').key('inner') end)
		vim.keymap.set({ 'o', 'x', }, 'av',
			function() require('various-textobjs').value('outer') end)
		vim.keymap.set({ 'o', 'x', }, 'iv',
			function() require('various-textobjs').value('inner') end)
		vim.keymap.set({ 'o', 'x', }, 'aw',
			function() require('various-textobjs').subword('outer') end)
		vim.keymap.set({ 'o', 'x', }, 'iw',
			function() require('various-textobjs').subword('inner') end)
		vim.keymap.set({ 'o', 'x', }, 'ax',
			function() require('various-textobjs').number('outer') end)
		vim.keymap.set({ 'o', 'x', }, 'ix',
			function() require('various-textobjs').number('inner') end)
		vim.keymap.set({ 'o', 'x', }, 'ag',
			function() require('various-textobjs').entireBuffer() end)
		vim.keymap.set({ 'o', 'x', }, 'ig',
			function() require('various-textobjs').entireBuffer() end)

		-- vim.keymap.set({ 'o', }, 'v', 'iv', { remap = true, })
		-- vim.keymap.set({ 'o', }, 'k', 'ik', { remap = true, })

		-- vim.keymap.set({ 'o', 'x', }, 'aw',
		--   function() require('various-textobjs').subword(false) end)
	end,
}
