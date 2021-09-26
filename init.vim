" 不与Vi 兼容
set nocompatible
" 语法高亮
syntax on
" 显示行号
set number
" 显示相对行号
set relativenumber
" 换行
set wrap
" 不在单词内部换行
set linebreak
" 即时搜索预览
set incsearch
" 编码格式
set encoding=utf-8
" 大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase
" 保持在光标上下最少行数5
set scrolloff=5
" 手工定义折叠 
" set fdm=manual
" 开启真彩色
set termguicolors
" 鼠标
set mouse=a
" 剪贴板
set clipboard=unnamed,unnamedplus
" 禁用交换文件
set noswapfile
" 自动定位上次编辑位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 换行icon
let &showbreak=" ↪  "


" set leader
let mapleader=" "
nmap <leader>s :w<CR>
nmap <leader>q :q<CR>
nmap <leader>qa :qa<CR>

" Esc
inoremap kj <esc>


" plugin
call plug#begin()
Plug 'justinmk/vim-sneak'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'preservim/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mg979/vim-visual-multi'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'alvan/vim-closetag'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'luochen1990/rainbow'
Plug 'arthurxavierx/vim-caser'
Plug 'nvim-lua/plenary.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'f-person/git-blame.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'junegunn/vim-easy-align',{'for':'python'}
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
call plug#end()


lua <<EOF
require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
EOF


" treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {"tsx"}
  },
  ensure_installed = {
    "graphql"
  },
}
EOF


" theme
colorscheme everforest
set background=dark
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg


" sneak
let g:sneak#label = 1


" telescope
nnoremap <leader>ff <cmd>Telescope find_files  hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" 预览窗口展示
lua << EOF
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { '.git/.*' },
    mappings ={
      i={
       ["<esc>"] = actions.close	
      }
    },
    layout_config = {
      horizontal = {
	preview_cutoff = 100,
	preview_width = 0.5
      },
    },
  }
}
EOF

" close tsg
let g:closetag_filenames = '*.html,*.tsx'


" rainbow
let g:rainbow_active = 1


" word motion
let g:wordmotion_prefix = '<leader>'


" explorer
:nnoremap <c-e> :CocCommand explorer<CR>



" status line
source ~/.config/nvim/status.vim

" coc
source ~/.config/nvim/coc.vim
