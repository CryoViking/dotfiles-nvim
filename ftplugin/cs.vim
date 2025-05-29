" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1
let b:undo_ftplugin = "setlocal tabstop< softtabstop< shiftwidth<"

setlocal tabstop=2
setlocal softtabstop=0
setlocal shiftwidth=2
setlocal expandtab
