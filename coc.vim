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

