"=============================================================================
" FILE: denite.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
" License: MIT license
"=============================================================================

function! denite#initialize() abort "{{{
  return denite#init#_initialize()
endfunction"}}}
function! denite#start(sources, ...) abort "{{{
  let user_context = get(a:000, 0, {})
  let buffer_name = get(user_context, 'buffer_name', 'default')

  let context = extend(denite#init#_context(), denite#init#_user_options())
  let context.custom = denite#custom#get()
  if has_key(context.custom.option, buffer_name)
    call extend(context, context.custom.option[buffer_name])
  endif
  call extend(context, user_context)

  if denite#initialize()
    return
  endif

  return has('nvim') ? _denite_start(a:sources, context)
        \            : denite#vim#_start(a:sources, context)
endfunction"}}}

function! denite#get_status_mode() abort "{{{
  return b:denite_statusline_mode
endfunction"}}}
function! denite#get_status_sources() abort "{{{
  return b:denite_statusline_sources
endfunction"}}}
function! denite#get_status_path() abort "{{{
  return b:denite_statusline_path
endfunction"}}}
function! denite#get_status_linenr() abort "{{{
  return b:denite_statusline_linenr
endfunction"}}}

" vim: foldmethod=marker
