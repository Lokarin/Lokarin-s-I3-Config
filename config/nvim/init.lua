-- Habilita o vim-plug em Lua
vim.cmd [[
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'm4xshen/autoclose.nvim'
call plug#end()
]]

-- Comando de alinhamento para .asm
vim.api.nvim_create_user_command("AlignASM", function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Extrai comandos e argumentos
  local split_lines = {}
  local max_cmd_len = 0

  for _, line in ipairs(lines) do
    local cmd, args = line:match("^%s*(%S+)%s*(.*)")
    if cmd then
      table.insert(split_lines, {cmd = cmd, args = args})
      max_cmd_len = math.max(max_cmd_len, #cmd)
    else
      table.insert(split_lines, {cmd = "", args = line})
    end
  end

  -- Reconstroi com alinhamento
  local aligned = {}
  for _, entry in ipairs(split_lines) do
    if entry.cmd ~= "" then
      table.insert(aligned, string.format("%-" .. max_cmd_len .. "s %s", entry.cmd, entry.args))
    else
      table.insert(aligned, entry.args)
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, aligned)
end, {range = true})


-- Configurações gerais
vim.cmd [[
set nocompatible
syntax on
set encoding=utf-8
set number
set relativenumber
set wildmode=longest,list,full
set ttyfast
set lazyredraw
set termguicolors
set autoindent
set smartindent
filetype plugin indent on
]]

-- Configuração autoclose
require("autoclose").setup({
   --keys = {
   --   ["$"] = { escape = true, close = true, pair = "$$", disabled_filetypes = {} },
   --},
})

-- Configuração lualine
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  }
}

-- Configuração do indent-blankline
require("ibl").setup({
    indent = {
        char = "│",
    },
    scope = {
        enabled = true
    }
})

-- Configuração gitsigns
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

-- Transparência de fundo
vim.cmd [[
colorscheme retrobox
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
]]

-- Função para compilar C++
function _G.compile_cpp()
    -- Salva o arquivo antes de compilar
    vim.cmd('write')
    
    local outfile = vim.fn.expand('%:p:r')
    local input_file = vim.fn.expand('%:p')
    local compile_command = string.format('g++ %s -o %s', input_file, outfile)
    
    local result = vim.fn.system(compile_command)
    
    if vim.v.shell_error ~= 0 then
        print("Erro na compilação:")
        print(result)
    else
        print("Compilação bem-sucedida!")
    end
end

-- Clipboard
vim.g.clipboard = {
  name = 'xclip',
  copy = {
    ['+'] = 'xclip -selection clipboard',
    ['*'] = 'xclip -selection primary',
  },
  paste = {
    ['+'] = 'xclip -selection clipboard -o',
    ['*'] = 'xclip -selection primary -o',
  },
  cache_enabled = 1
}

-- Mapeia <leader>c para compilação de C++
vim.keymap.set('n', '<leader>c', _G.compile_cpp, { noremap = true, silent = true })

-- Copiar para área de transferência no modo visual usando <leader>y
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Configurações do COC
vim.cmd([[
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-@> coc#refresh()
]])

-- Habilita plugins para tipos de arquivo
vim.cmd('filetype plugin on')
