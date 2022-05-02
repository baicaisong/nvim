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
set tabstop=2


" set leader
let mapleader=" "
nmap <leader>s :w<CR>
"nmap <leader>q :q<CR>
nmap <leader>qa :qa<CR>



" plugin
call plug#begin()
Plug 'lbrayner/vim-rzip'
Plug 'rmagatti/alternate-toggler'
Plug 'justinmk/vim-sneak'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'numToStr/Comment.nvim'
Plug 'alexghergh/nvim-tmux-navigation'
Plug 'mg979/vim-visual-multi'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'alvan/vim-closetag'
Plug 'luochen1990/rainbow'
Plug 'arthurxavierx/vim-caser'
Plug 'nvim-lua/plenary.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'f-person/git-blame.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'neoclide/jsonc.vim'
call plug#end()



lua require('Comment').setup()


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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
  ensure_installed = {
    "graphql",
		"typescript",
		"python",
		"javascript",
		"jsonc",
		"go"
  },
	indent = {
    enable = true
  }
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

" toggle false/true
nnoremap <leader>ta :ToggleAlternate<CR>


" rzip
" https://yarnpkg.com/getting-started/editor-sdks
" Decode URI encoded characters
function! DecodeURI(uri)
    return substitute(a:uri, '%\([a-fA-F0-9][a-fA-F0-9]\)', '\=nr2char("0x" . submatch(1))', "g")
endfunction

" Attempt to clear non-focused buffers with matching name
function! ClearDuplicateBuffers(uri)
    " if our filename has URI encoded characters
    if DecodeURI(a:uri) !=# a:uri
        " wipeout buffer with URI decoded name - can print error if buffer in focus
        sil! exe "bwipeout " . fnameescape(DecodeURI(a:uri))
        " change the name of the current buffer to the URI decoded name
        exe "keepalt file " . fnameescape(DecodeURI(a:uri))
        " ensure we don't have any open buffer matching non-URI decoded name
        sil! exe "bwipeout " . fnameescape(a:uri)
    endif
endfunction

function! RzipOverride()
    " Disable vim-rzip's autocommands
    autocmd! zip BufReadCmd   zipfile:*,zipfile:*/*
    exe "au! zip BufReadCmd ".g:zipPlugin_ext

    " order is important here, setup name of new buffer correctly then fallback to vim-rzip's handling
    autocmd zip BufReadCmd   zipfile:*  call ClearDuplicateBuffers(expand("<afile>"))
    autocmd zip BufReadCmd   zipfile:*  call rzip#Read(DecodeURI(expand("<afile>")), 1)

    if has("unix")
        autocmd zip BufReadCmd   zipfile:*/*  call ClearDuplicateBuffers(expand("<afile>"))
        autocmd zip BufReadCmd   zipfile:*/*  call rzip#Read(DecodeURI(expand("<afile>")), 1)
    endif

    exe "au zip BufReadCmd ".g:zipPlugin_ext."  call rzip#Browse(DecodeURI(expand('<afile>')))"
endfunction

autocmd VimEnter * call RzipOverride()


" tmux
nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>
nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>
nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>
nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>
nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>
nnoremap <silent> <C-Space> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>




