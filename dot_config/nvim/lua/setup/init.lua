local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.o
local map = vim.keymap.set
local call = vim.call
local api = vim.api

-------------------- chaoren/vim-wordmotion
-- local function wordmotion()
--   g.wordmotion_nomap = 1
-- end

-------------------- norcalli/nvim-colorizer.lua
local function colorizer()
  require('colorizer').setup()
end

-------------------- machakann/vim-highlightedyank
local function highlightedyank()
  g.highlightedyank_highlight_duration = 100
end

-------------------- ahmedkhalf/project.nvim
local function project()
  require('project_nvim').setup()
end

-------------------- nacro90/numb.nvim
local function numb()
  require('numb').setup()
end

-------------------- gbprod/stay-in-place.nvim
local function stayinplace()
  require('stay-in-place').setup()
end

-------------------- cshuaimin/ssr.nvim
local function ssr()
  require('ssr').setup {
    min_width = 50,
    min_height = 5,
    keymaps = {
      close = 'q',
      next_match = 'n',
      prev_match = 'N',
      replace_all = '<C-CR>',
    },
  }
end

-------------------- kylechui/nvim-surround
local function surround()
  require('nvim-surround').setup({
    keymaps = {
      insert = false,
      insert_line = false,
      normal_line = false,
      normal_cur_line = false,
      visual_line = false,
      normal_cur = 'ySS',
      normal = 'yS',
      delete = 'dS',
      change = 'cS',
      visual = 'S',
    },
  })
end

-------------------- numToStr/Comment.nvim
local function comment()
  require('Comment').setup()
end

-------------------- gelguy/wilder.nvim
local function wilder()
  local wilder = require('wilder')

  wilder.setup({
    modes = { ':', },
    -- modes = { ':', '/', '?' },
    next_key = '<Tab>',
    previous_key = '<S-Tab>',
  })

  wilder.set_option('pipeline', {
    wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
        set_pcre2_pattern = 0,
      }),
      wilder.python_search_pipeline({
        pattern = 'fuzzy',
      })
    ),
  })

  -- wilder.set_option('noselect', 0)

  wilder.set_option('renderer', wilder.popupmenu_renderer({
    pumblend = 25,
    left = { ' ', wilder.popupmenu_devicons(), },
    right = { ' ', wilder.popupmenu_scrollbar(), },
    highlighter = {
      wilder.lua_pcre2_highlighter(),
      wilder.lua_fzy_highlighter(),
    },
    highlights = {
      accent = wilder.make_hl('WilderAccent', 'Pmenu',
        { { a = 1, }, { a = 1, }, { foreground = '#ff4d97', }, }),
    },
  }))
end


-------------------- ray-x/starry.nvim
local function starry()
  -- autocommand will have no effect on previously sourced colorschemes
  -- so it must be added before any colorscheme is sourced
  require('autocmd').bufferline()
  require('autocmd').sj()
  require('autocmd').matchup()

  g.starry_bold = false
  g.starry_italic_comments = false
  g.starry_italic_string = false
  g.starry_italic_keywords = true
  g.starry_italic_functions = false
  g.starry_italic_variables = false
  g.starry_contrast = false
  g.starry_borders = false
  g.starry_disable_background = true
  g.starry_style_fix = true
  g.starry_darker_contrast = false
  g.starry_deep_black = false
  g.starry_set_hl = false
  g.starry_daylight_switch = false

  require('starry').setup({
    disable = {
      term_colors = true,
    },
  })

  cmd('colorscheme moonlight')
end

-------------------- woosaaahh/sj.nvim
local function sj()
  require('sj').setup({
    auto_jump = false,
    forward_search = true,
    highlights_timeout = 0,
    max_pattern_length = 0,
    pattern_type = 'vim',
    preserve_highlights = true,
    prompt_prefix = '',
    relative_labels = false,
    search_scope = 'visible_lines',
    separator = '',
    update_search_register = false,
    use_last_pattern = false,
    use_overlay = false,
    wrap_jumps = o.wrapscan,
    labels = {
      "'", ',', 'p', 'y', 'a', 'o', 'e', 'u', 'i', 'd', 'h', 't',
      'n', 's', 'f', 'g', 'c', 'r', 'l', ';', 'q', 'j', 'k', 'x', 'b',
      'm', 'w', 'v', 'z',
    },
    keymaps = {
      cancel = '<Esc>',
      validate = '<Tab>',
      prev_match = '<S-Enter>',
      next_match = '<Enter>',
      prev_pattern = '<C-p>',
      next_pattern = '<C-n>',
      delete_prev_char = '<BS>',
      delete_prev_word = '<C-w>',
      delete_pattern = '<C-u>',
      restore_pattern = '<A-BS>',
      send_to_qflist = '<A-q>',
    },
  })
end

-------------------- kosayoda/nvim-lightbulb
local function lightbulb()
  fn.sign_define('LightBulbSign', { text = '⚡', })
end

-------------------- ibhagwan/fzf-lua
local function fzf()
  local actions = require('fzf-lua.actions')

  require('fzf-lua').setup({
    winopts = {
      fullscreen = true,
      border = 'none',
      preview = {
        layout = 'horizontal',
        horizontal = 'up:70%',
        title = false,
        delay = 0,
        scrollchars = { '▎', '', },
      },
    },
    keymap = {
      builtin = {},
      fzf = {
        -- 	-- ["tab"] = "down",
        -- 	-- ["btab"] = "up",
        ['ctrl-e'] = 'preview-page-down',
        ['ctrl-u'] = 'preview-page-up',
      },
    },
    actions = {
      files = {
        ['default'] = actions.file_edit,
      },
      buffers = {
        ['default'] = actions.buf_edit,
      },
    },
  })
end


-------------------- is0n/fm-nvim
local function fm()
  require('fm-nvim').setup({
    edit_cmd = 'edit',
    ui = {
      default = 'float',
      float = {
        border = 'none',
        float_hl = 'Normal',
        border_hl = 'FloatBorder',
        blend = 0,
        height = 999,
        width = 999,
      },
      split = {
        direction = 'topleft',
        size = 24,
      },
    },
    cmds = {
      vifm_cmd = 'vifm',
    },
    mappings = {
      -- vert_split = "<C-v>",
      -- horz_split = "<C-h>",
      -- tabedit = "<C-t>",
      -- edit = "<C-e>",
      -- ESC = "<ESC>",
    },
  })
end

-------------------- lewis6991/gitsigns.nvim
local function gitsigns()
  require('gitsigns').setup({
    current_line_blame_opts = {
      delay = 0,
    },
    on_attach = require('mappings').gitsigns,
    signs = {
      add = {
        hl = 'GitSignsAdd',
        text = '+',
        numhl = 'GitSignsAddNr',
        linehl = 'GitSignsAddLn',
      },
      change = {
        hl = 'GitSignsChange',
        text = '~',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
      delete = {
        hl = 'GitSignsDelete',
        text = '_',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      topdelete = {
        hl = 'GitSignsDelete',
        text = '‾',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      changedelete = {
        hl = 'GitSignsChange',
        text = '~',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
    },
  })
end

-------------------- echasnovski/mini.nvim#miniindentscope
local function indentscope()
  local scope = require('mini.indentscope')
  scope.setup({
    draw = {
      delay = 0,
      animation = scope.gen_animation.none(),
    },
    mappings = {
      object_scope = 'ii',
      object_scope_with_border = 'ai',
      goto_top = '',
      goto_bottom = '',
      -- goto_top = "<S-CR>",
      -- goto_bottom = "<CR>",
    },
    options = {
      border = 'both',
      indent_at_cursor = true,
      try_as_border = true,
    },
    symbol = '▏',
  })
end

-------------------- echasnovski/mini.nvim#miniai
local function ai()
  local gen_spec = require('mini.ai').gen_spec
  require('mini.ai').setup({
    custom_textobjects = {
      f = false,
      a = gen_spec.argument({ brackets = { '%b()', '%b{}', '%b[]', }, }),
      -- a = gen_spec.argument({ brackets = { '%b()' } }),
      -- o = gen_spec.argument({ brackets = { '%b{}' } }),
      -- e = gen_spec.argument({ brackets = { '%b[]' } }),
      -- A = gen_spec.pair('(', ')', { type = 'balanced' }),
      -- O = gen_spec.pair('{', '}', { type = 'balanced' }),
      -- E = gen_spec.pair('[', ']', { type = 'balanced' }),
      -- Q = gen_spec.pair('`', '`', { type = 'balanced' }),
    },
    mappings = {
      around = 'a',
      inside = 'i',
      around_next = 'an',
      inside_next = 'in',
      around_last = 'ao',
      inside_last = 'io',
      goto_left = '',
      goto_right = '',
    },
    n_lines = 100,
    search_method = 'cover_or_nearest',
    -- search_method = 'cover_or_next',
  })
end

-------------------- nvim-treesitter/nvim-treesitter
local function treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = { enable = true, },
    indent = { enable = true, },
    autopairs = { enable = true, }, -- windwp/nvim-autopairs
    autotag = { enable = true, },   -- windwp/nvim-ts-autotag
    matchup = {
      -- andymass/vim-matchup
      enable = true,
      disable_virtual_text = true,
    },
    rainbow = {
      -- p00f/nvim-ts-rainbow
      enable = false,
      max_file_lines = nil,
      colors = {
        '#FF0048',
        '#B800FF',
        '#FAFF00',
      },
    },
    textobjects = {
      -- nvim-treesitter/nvim-treesitter-textobjects
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['f'] = '@function.outer',
          ['af'] = '@function.inner',
          ['if'] = '@function.inner',
          ['F'] = '@call.outer',
          ['aF'] = '@call.outer',
          ['iF'] = '@call.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        -- goto_next_start = {
        --   [")"] = "@parameter.inner",
        -- },
        -- goto_previous_start = {
        --   ["("] = "@parameter.inner",
        -- },
      },
    },

    -- nvim-treesitter/playground
    -- playground = {
    -- 	enable = true,
    -- 	disable = {},
    -- 	updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    -- 	persist_queries = false, -- Whether the query persists across vim sessions
    -- 	keybindings = {
    -- 		toggle_query_editor = "o",
    -- 		toggle_hl_groups = "i",
    -- 		toggle_injected_languages = "t",
    -- 		toggle_anonymous_nodes = "a",
    -- 		toggle_language_display = "I",
    -- 		focus_language = "f",
    -- 		unfocus_language = "F",
    -- 		update = "R",
    -- 		goto_node = "<cr>",
    -- 		show_help = "?",
    -- 	},
    -- },
  })
end

-------------------- weilbith/nvim-code-action-menu
local function codeactionmenu()
  g.code_action_menu_show_details = false
  g.code_action_menu_show_diff = true
end

-------------------- D4KU/vim-textobj-chainmember
local function textobjchainmember()
  g.textobj_chainmember_no_default_key_mappings = 1
end

-------------------- gbprod/cutlass.nvim
local function cutlass()
  require('cutlass').setup({
    cut_key = 'm',
    override_del = true,
    exclude = { 'ns', 'nS', },
  })
end

-------------------- jonatan-branting/nvim-better-n
local function bettern()
  require('better-n').setup {
    callbacks = {},
    mappings = {
      ['F'] = { previous = 'n', next = '<s-n>', },
      ['T'] = { previous = 'n', next = '<s-n>', },
    },
  }
end

-------------------- windwp/nvim-autopairs
local function autopairs()
  local remap = vim.api.nvim_set_keymap
  local npairs = require('nvim-autopairs')

  npairs.setup({
    map_bs = true,
    map_cr = false,
    check_ts = true,
    ignored_next_char = '[%w%.]',
    -- fast_wrap = {
    --   map = "<C-h>",
    --   chars = { "{", "[", "(", '"', "'" },
    --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    --   offset = 0,
    --   end_key = "s",
    --   keys = "aoeuhtns",
    --   check_comma = true,
    --   highlight = "Search",
    --   highlight_grey = "Comment",
    -- },
  })

  -- skip it, if you use another global object
  _G.MUtils = {}

  MUtils.CR = function()
    if fn.pumvisible() ~= 0 then
      if fn.complete_info({ 'selected', }).selected ~= -1 then
        return npairs.esc('<c-y>')
      else
        return npairs.esc('<c-e>') .. npairs.autopairs_cr()
      end
    else
      return npairs.autopairs_cr()
    end
  end
  remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true, })

  MUtils.BS = function()
    if fn.pumvisible() ~= 0 and fn.complete_info({ 'mode', }).mode == 'eval' then
      return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
      return npairs.autopairs_bs()
    end
  end
  remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true, })
end

-------------------- monaqa/dial.nvim
local function dial()
  local augend = require('dial.augend')
  require('dial.config').augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.decimal_int,
      augend.date.alias['%Y/%m/%d'],
      augend.semver.alias.semver,
      augend.constant.alias.bool,
      augend.constant.new({
        elements = { 'let', 'const', },
      }),
      augend.constant.new({
        elements = { '&&', '||', },
        word = false,
        cyclic = true,
      }),
    },
  })
end

-------------------- williamboman/mason.nvim
local function mason()
  require('mason').setup({ ui = { border = 'single', }, })
end

-------------------- williamboman/mason-lspconfig.nvim
local function masonlspconfig()
  require('mason-lspconfig').setup({
    ensure_installed = {
      -- 'tsserver',
      -- 'eslint',
      -- 'sumneko_lua',
      -- 'yamlls',
      -- 'vuels',
      -- 'bashls',
      -- -- 'volar',
    },
    automatic_installation = false,
  })
end

local function lspprogress()
  require('lsp-progress').setup({
    spinner = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', },
    spin_update_time = 200,
    decay = 1000,
    event = 'LspProgressStatusUpdated',
    event_update_time_limit = 100,
    max_size = -1,
    series_format = function(title, message, percentage, done)
      local builder = {}
      local has_title = false
      local has_message = false
      if title and title ~= '' then
        table.insert(builder, title)
        has_title = true
      end
      if message and message ~= '' then
        table.insert(builder, message)
        has_message = true
      end
      if percentage and (has_title or has_message) then
        table.insert(builder, string.format('(%.0f%%%%)', percentage))
      end
      if done and (has_title or has_message) then
        table.insert(builder, '- done')
      end
      return table.concat(builder, ' ')
    end,
    -- Format client message.
    -- `[null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`.
    client_format = function(client_name, spinner, series_messages)
      return #series_messages > 0
          and ('[' .. client_name .. '] ' .. spinner .. ' ' .. table.concat(
            series_messages,
            ', '
          ))
          or nil
    end,
    -- Format (final) message.
    -- ` LSP [null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`
    format = function(client_messages)
      local sign = 'LSP'
      return #client_messages > 0
          and (sign .. ' ' .. table.concat(client_messages, ' '))
          or sign
    end,
    debug = false,
    console_log = true,
    file_log = false,
    file_log_name = 'lsp-progress.log',
  })
end

-------------------- ggandor/leap.nvim
-- local function leap()
--   require('leap').setup {
--     highlight_unlabeled = false,
--     safe_labels = {},
--     case_sensitive = false,
--     labels = { 'a', 'o', 'e', 'u', 'h', 't', 's', "'", ',', '.', 'p', 'g', 'g', 'c', 'r', 'l', ';', 'q', 'j', 'k', 'm',
--       'w', 'v', 'z' },
--   }
-- end

-------------------- ms-jpq/coq_nvim
local function coq()
  g.coq_settings = {
    auto_start = 'shut-up',
    weights = {
      prefix_matches = 3,
      proximity = 0,
      recency = 0,
    },
    completion = {
      always = true,
      replace_prefix_threshold = 3,
      replace_suffix_threshold = 2,
      smart = true,
      skip_after = { '{', '}', '[', ']', ' ', },
    },
    match = {
      fuzzy_cutoff = 0.6,
      exact_matches = 2,
    },
    display = {
      preview = {
        positions = { east = 1, north = 2, south = 3, west = 4, },
        x_max_len = 100,
        border = 'single',
      },
      icons = { mode = 'none', },
      pum = {
        kind_context = { '   ', '', },
        source_context = { '', '', },
        fast_close = true,
      },
      ghost_text = { enabled = false, },
    },
    keymap = {
      recommended = false,
      pre_select = true,
      manual_complete = '',
      ['repeat'] = '',
      bigger_preview = '',
      jump_to_mark = '<c-Enter>',
      eval_snips = '',
      manual_complete_insertion_only = false,
    },
    clients = {
      snippets = {
        weight_adjust = 2,
        short_name = 'snip',
      },
      tree_sitter = {
        short_name = 'tree',
      },
      lsp = {
        short_name = 'lsp',
      },
      paths = {
        short_name = 'path',
      },
      tmux = {
        short_name = 'tmux',
      },
      buffers = {
        short_name = 'buff',
      },
    },
  }
end

-------------------- smjonas/live-command.nvim
local function livecommand()
  require('live-command').setup {
    commands = {
      Norm = { cmd = 'norm', },
    },
  }
end

-------------------- echasnovski/mini.align
local function align()
  require('mini.align').setup()
end

return {
  colorizer = colorizer,
  project = project,
  numb = numb,
  fm = fm,
  fzf = fzf,
  gitsigns = gitsigns,
  indentscope = indentscope,
  bufferline = bufferline,
  cutlass = cutlass,
  comment = comment,
  treesitter = treesitter,
  ai = ai,
  bettern = bettern,
  autopairs = autopairs,
  coq = coq,
  dial = dial,
  livecommand = livecommand,
  stayinplace = stayinplace,
  lightbulb = lightbulb,
  codeactionmenu = codeactionmenu,
  mason = mason,
  masonlspconfig = masonlspconfig,
  wilder = wilder,
  ssr = ssr,
  sniprun = sniprun,
  sj = sj,
  highlightedyank = highlightedyank,
  surround = surround,
  tablemode = tablemode,
  varioustextobjs = varioustextobjs,
  printer = printer,
  textobjchainmember = textobjchainmember,
  starry = starry,
  align = align,
  nullls = nullls,
  lspprogress = lspprogress,
  matchup = matchup,
  midnight = midnight,
}
