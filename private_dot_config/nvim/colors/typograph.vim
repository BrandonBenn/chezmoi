hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "typograph"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi NonText ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
    hi Comment ctermbg=NONE ctermfg=NONE cterm=italic guibg=NONE guifg=#808080 gui=italic
    hi Constant ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
    hi Error ctermbg=15 ctermfg=9 cterm=reverse guibg=#ffffff guifg=#ff0000 gui=reverse
    hi Identifier ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi PreProc ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Special ctermbg=NONE ctermfg=NONE cterm=italic guibg=NONE guifg=NONE gui=italic
    hi Statement ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
    hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
    hi Type ctermbg=NONE ctermfg=NONE cterm=bold,italic guibg=NONE guifg=NONE gui=bold,italic
    hi Underlined ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
    hi StatusLine ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
    hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
    hi StatusLineTerm ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
    hi StatusLineTermNC ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
    hi VertSplit ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi TabLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi TabLineFill ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=NONE
    hi TabLineSel ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
    hi Title ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi CursorLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi LineNr ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#808080 gui=NONE 
    hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=bold
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Visual ctermbg=NONE ctermfg=darkcyan cterm=reverse,bold guibg=NONE guifg=darkcyan gui=reverse,bold
    hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Pmenu ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi PmenuSbar ctermbg=NONE ctermfg=NONE cterm=NONE guibg=#666666 guifg=NONE gui=bold gui=reverse
    hi PmenuSel ctermbg=NONE ctermfg=NONE cterm=reverse,bold guibg=NONE guifg=darkcyan gui=reverse,bold
    hi PmenuThumb ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi FoldColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Folded ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi WildMenu ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi DiffAdd ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi DiffChange ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi DiffDelete ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi DiffText ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi IncSearch ctermbg=10 ctermfg=0 cterm=NONE guibg=#00ff00 guifg=#000000 gui=NONE
    hi Search ctermbg=11 ctermfg=0 cterm=NONE guibg=#fff2be guifg=#000000 gui=NONE
    hi Directory ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
    hi MatchParen ctermbg=NONE ctermfg=green cterm=reverse guibg=NONE guifg=green gui=reverse
    hi SpellBad ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#ff0000
    hi SpellCap ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#0000ff
    hi SpellLocal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#ff00ff
    hi SpellRare ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#00ffff
    hi ColorColumn ctermbg=darkred ctermfg=NONE cterm=NONE guibg=darkred guifg=NONE gui=NONE
    hi SignColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi MoreMsg ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#ff00ff gui=NONE
    hi Question ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi WarningMsg ctermbg=NONE ctermfg=9 cterm=NONE guibg=NONE guifg=#ff0000 gui=NONE
    hi Cursor ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi CursorColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Conceal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi ToolbarLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi ToolbarButton ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi debugPC ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi debugBreakpoint ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi WinSeparator guibg=NONE
elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=NONE ctermfg=NONE cterm=NONE
    hi NonText ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Comment ctermbg=NONE ctermfg=NONE cterm=italic
    hi Constant ctermbg=NONE ctermfg=NONE cterm=bold
    hi Error ctermbg=white ctermfg=red cterm=reverse
    hi Identifier ctermbg=NONE ctermfg=NONE cterm=bold
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
    hi PreProc ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Special ctermbg=NONE ctermfg=NONE cterm=italic
    hi Statement ctermbg=NONE ctermfg=NONE cterm=bold
    hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse
    hi Type ctermbg=NONE ctermfg=NONE cterm=bold,italic
    hi Underlined ctermbg=NONE ctermfg=NONE cterm=underline
    hi StatusLine ctermbg=NONE ctermfg=NONE cterm=reverse
    hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=underline
    hi StatusLineTerm ctermbg=NONE ctermfg=NONE cterm=reverse
    hi StatusLineTermNC ctermbg=NONE ctermfg=NONE cterm=underline
    hi VertSplit ctermbg=NONE ctermfg=NONE cterm=NONE
    hi TabLine ctermbg=NONE ctermfg=NONE cterm=NONE
    hi TabLineFill ctermbg=NONE ctermfg=NONE cterm=NONE
    hi TabLineSel ctermbg=NONE ctermfg=NONE cterm=reverse
    hi Title ctermbg=NONE ctermfg=NONE cterm=NONE
    hi CursorLine ctermbg=NONE ctermfg=NONE cterm=NONE
    hi LineNr ctermbg=NONE ctermfg=NONE cterm=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Visual ctermbg=NONE ctermfg=darkcyan cterm=reverse,bold
    hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Pmenu ctermbg=NONE ctermfg=NONE cterm=NONE
    hi PmenuSbar ctermbg=#666666 ctermfg=NONE cterm=reverse
    hi PmenuSel ctermbg=NONE ctermfg=darkcyan cterm=reverse,bold
    hi PmenuThumb ctermbg=NONE ctermfg=NONE cterm=NONE
    hi FoldColumn ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Folded ctermbg=NONE ctermfg=NONE cterm=NONE
    hi WildMenu ctermbg=NONE ctermfg=NONE cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=NONE cterm=NONE
    hi DiffAdd ctermbg=NONE ctermfg=NONE cterm=NONE
    hi DiffChange ctermbg=NONE ctermfg=NONE cterm=NONE
    hi DiffDelete ctermbg=NONE ctermfg=NONE cterm=NONE
    hi DiffText ctermbg=NONE ctermfg=NONE cterm=NONE
    hi IncSearch ctermbg=green ctermfg=black cterm=NONE
    hi Search ctermbg=yellow ctermfg=black cterm=NONE
    hi Directory ctermbg=NONE ctermfg=NONE cterm=bold
    hi MatchParen ctermbg=NONE ctermfg=green cterm=reverse
    hi SpellBad ctermbg=NONE ctermfg=NONE cterm=NONE
    hi SpellCap ctermbg=NONE ctermfg=NONE cterm=NONE
    hi SpellLocal ctermbg=NONE ctermfg=NONE cterm=NONE
    hi SpellRare ctermbg=NONE ctermfg=NONE cterm=NONE
    hi ColorColumn ctermbg=darkred ctermfg=NONE cterm=NONE
    hi SignColumn ctermbg=NONE ctermfg=NONE cterm=NONE
    hi ModeMsg ctermbg=NONE ctermfg=green cterm=NONE
    hi MoreMsg ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Question ctermbg=NONE ctermfg=NONE cterm=NONE
    hi WarningMsg ctermbg=NONE ctermfg=red cterm=NONE
    hi Cursor ctermbg=NONE ctermfg=NONE cterm=NONE
    hi CursorColumn ctermbg=NONE ctermfg=NONE cterm=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=NONE cterm=NONE
    hi Conceal ctermbg=NONE ctermfg=NONE cterm=NONE
    hi ToolbarLine ctermbg=NONE ctermfg=NONE cterm=NONE
    hi ToolbarButton ctermbg=NONE ctermfg=NONE cterm=NONE
    hi debugPC ctermbg=NONE ctermfg=NONE cterm=NONE
    hi debugBreakpoint ctermbg=NONE ctermfg=NONE cterm=NONE
    hi WinSeparator ctermbg=NONE
endif

highlight CopilotSuggestion guifg=#555555 ctermfg=8

highlight NotifyERRORBorder guifg=#8A1F1F
highlight NotifyWARNBorder guifg=#79491D
highlight NotifyINFOBorder guifg=#4F6752
highlight NotifyDEBUGBorder guifg=#8B8B8B
highlight NotifyTRACEBorder guifg=#4F3552
highlight NotifyERRORIcon guifg=#dc322f
highlight NotifyWARNIcon guifg=#F79000
highlight NotifyINFOIcon guifg=#A9FF68
highlight NotifyDEBUGIcon guifg=#8B8B8B
highlight NotifyTRACEIcon guifg=#D484FF
highlight NotifyERRORTitle guifg=8
highlight NotifyWARNTitle guifg=8
highlight NotifyINFOTitle guifg=8
highlight NotifyDEBUGTitle guifg=8
highlight NotifyTRACETitle guifg=8
highlight link NotifyERRORBody Normal
highlight link NotifyWARNBody Normal
highlight link NotifyINFOBody Normal
highlight link NotifyDEBUGBody Normal
highlight link NotifyTRACEBody Normal

hi link EndOfBuffer NonText
hi link String Normal
hi link Number Constant
hi link ErrorMsg Error
hi link CursorIM Cursor
hi link Terminal Normal

hi def NeogitDiffAddHighlight guibg=NONE guifg=#859900
hi def NeogitDiffDeleteHighlight guibg=NONE guifg=#dc322f
hi def NeogitDiffContextHighlight guibg=NONE guifg=#b2b2b2
hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

let g:terminal_ansi_colors = [
        \ '#000000',
        \ '#800000',
        \ '#008000',
        \ '#808000',
        \ '#000080',
        \ '#800080',
        \ '#008080',
        \ '#c0c0c0',
        \ '#808080',
        \ '#ff0000',
        \ '#00ff00',
        \ '#ffff00',
        \ '#0000ff',
        \ '#ff00ff',
        \ '#00ffff',
        \ '#ffffff',
        \ ]

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set fillchars+=vert:???
