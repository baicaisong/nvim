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
set fdm=manual
" 开启真彩色
set termguicolors
" 鼠标
set mouse=a
" 剪贴板
set clipboard=unnamed,unnamedplus
" 禁用交换文件
set noswapfile


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
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mg979/vim-visual-multi'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'arthurxavierx/vim-caser'
Plug 'nvim-lua/plenary.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'f-person/git-blame.nvim'
call plug#end()


" theme
colorscheme everforest
set background=dark
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg


" sneak
let g:sneak#label = 1


" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" 预览窗口展示
lua << EOF
require('telescope').setup{
  defaults = {
    layout_config = {
      horizontal = {
	preview_cutoff = 100,
	preview_width = 50
      },
    },
  }
}
EOF

" COC
let g:coc_global_extensions = ['coc-json','coc-python','coc-tsserver','coc-vimlsp','coc-html','coc-css','coc-snippets','coc-explorer','coc-prettier','coc-translator']

set updatetime=100
set shortmess+=c
set signcolumn=number

" tab切换选项
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 调用补全
inoremap <silent><expr> <c-space> coc#refresh()

" 回车确认选项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 代码报错跳转
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>+ <Plug>(coc-diagnostic-next)

" 定义跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)


" 定义查看
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 高亮同一变量
autocmd CursorHold * silent call CocActionAsync('highlight')

" 变量重命名
nmap <leader>rn <Plug>(coc-rename)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <leader>fo :Fold<cr> 
nnoremap <leader>o :OR<cr> 


" coc-explorer
nnoremap <space>e :CocCommand explorer<CR>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc-translator
nnoremap tr :CocCommand translator.popup<CR>


" close tsg
let g:closetag_filenames = '*.html,*.tsx'

" indent
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进


" rainbow
let g:rainbow_active = 1

" word motion
let g:wordmotion_prefix = ','


" word motion
let g:wordmotion_prefix = '<leader>'


" explorer
:nnoremap <c-e> :CocCommand explorer<CR>

