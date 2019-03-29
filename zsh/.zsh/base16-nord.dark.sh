#!/bin/sh
# Base16 Nord - Shell color setup script

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="2E/34/40" # Base 00 - Black
color01="B6/6A/72" # Base 0B - Red
color02="88/C0/D0" # Base 08 - blue
color03="5E/81/AC" # Base 0A - Darker blue
color04="63/B3/FF" # Base 0D - Deep Blue
color05="96/b6/81" # Base 0E - Green
color06="D0/87/70" # Base 0C - Orangy Red
color07="E5/E9/F0" # Base 05 - White
color08="7D/7D/6A" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="8F/BC/BB" # Base 07 - Bright White
color16="81/A1/C1" # Base 09
color17="B4/8E/AD" # Base 0F - Pinky
color18="3B/42/52" # Base 01
color19="43/4C/5E" # Base 02
color20="D8/DE/E9" # Base 04
color21="EC/EF/F4" # Base 06
color_foreground="E5/E9/F0" # Base 05
# color_background="11/11/11" # Base 00

# Commented out because it works in tmux without the special case
# and it makes tmux make a system beep on every new pane or window
# if [ -n "$TMUX" ]; then
#   # tell tmux to pass the escape sequences through
#   # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
#   printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
#   printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
#   printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
# elif [ "${TERM%%-*}" = "screen" ]; then
#   # GNU screen (screen, screen-256color, screen-256color-bce)
#   printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
#   printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
#   printf_template_custom="\033P\033]%s%s\007\033\\"
# else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
# fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg c0c5ce # forground
  printf $printf_template_custom Ph 2b303b # background
  printf $printf_template_custom Pi c0c5ce # bold color
  printf $printf_template_custom Pj 4f5b66 # selection color
  printf $printf_template_custom Pk c0c5ce # selected text color
  printf $printf_template_custom Pl c0c5ce # cursor
  printf $printf_template_custom Pm 2b303b # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_var 12 $color_cursor
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor
