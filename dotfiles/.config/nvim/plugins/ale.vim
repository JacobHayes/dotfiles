let g:ale_fix_on_save = 1

let s:py_fixers = []
if $PY_DISABLE_ISORT != "1"
  call add(s:py_fixers, 'isort')
endif
if $PY_DISABLE_BLACK != "1"
  call add(s:py_fixers, 'black')
endif
let g:ale_fixers = { 'json': ['jq', ], 'python': s:py_fixers, }

if !empty($PYLINTRC)
  let g:ale_python_pylint_options='--rcfile ' . $PYLINTRC
endif

let g:ale_echo_msg_format='[%linter%] %code% %s'
let g:ale_go_gometalinter_options = '--tests' " Include tests in linting
let g:ale_lint_on_enter = 0 " Disable linting on opening file so don't have to close loc when just glancing at files
let g:ale_lint_on_insert_leave = 0 " Reduce spin (and dup runs) since I save often anyway
let g:ale_lint_on_text_changed = 'never' " Reduce spin (and dup runs) since I save often anyway
let g:ale_linters = {'go': ['gometalinter'], 'python': ['pylint', 'flake8', ], } " By default, ALE will run all for files not defined here
let g:ale_list_window_size = 3 " Only show a handful of error lines
let g:ale_open_list = 1 " Popup with errors by default
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_use_global_executables = 1 " Only run global executables

" Disable auto-detection of virtualenvironments
let g:ale_virtualenv_dir_names = []
" Environment variable ${VIRTUAL_ENV} is always used
