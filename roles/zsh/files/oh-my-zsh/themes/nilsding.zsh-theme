#! zsh
# nilsding theme

# features:
# - some motivation on startup from the git post-receive fox
# - path is autoshortened to ~30 characters
# - displays git status (if applicable in current folder)

function n_hostname_prompt_info() {
  # only show hostname on ssh connections
  if [[ "${SSH_CONNECTION}x" == "x" ]] return 1

  echo " on %m"
}

function n_rbenv_prompt_info() {
  type rbenv >/dev/null 2>&1 || return 1
  local rbenv_prompt
  rbenv_prompt=$(rbenv version-name 2>/dev/null | sed -e 's/ (set.*$//' -e 's/^ruby-//')
  [[ "${rbenv_prompt}x" == "x" ]] && return 1
  local rbenv_gemset
  rbenv_gemset=$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)
  if [[ "${rbenv_gemset}x" != "x" ]]; then
    rbenv_prompt="${rbenv_prompt}@${rbenv_gemset}"
  fi
  echo "${ZSH_THEME_RBENV_PROMPT_PREFIX:=(}${rbenv_prompt}${ZSH_THEME_RBENV_PROMPT_SUFFIX:=)}"
}

local width
local separator
width=$[ $COLUMNS / 3 ]
separator=""
for i in {0..$width}; do
  separator="-${separator}"
done
echo -n $fg_bold[cyan]
if type fortune >/dev/null 2>&1 && type cowsay >/dev/null 2>&1; then
  # TODO: check if the fox cow is installed
  fortune -s 50% computers 20% wisdom 10% work 20% pets | cowsay -f ~/.local/share/cows/fox.cow
fi
echo $fg_bold[red]$separator$reset_color
echo Have a lot of fun...

# prompt

# old colours:
#separator_color=$'\e[38;5;214m'
#userinfo_color=$'\e[38;5;39m'
#dirinfo_color=$'\e[38;5;79m'
#gitinfo_title_color=$'\e[38;5;077m'
#gitinfo_branch_color=$'\e[38;5;078m'
#gitinfo_dirty_color=$'\e[38;5;226m'
#rubyinfo_title_color=$'\e[38;5;160m'
#rubyinfo_current_color=$'\e[38;5;161m'

separator_color=$'\e[0;38;5;214m'
userinfo_color=$'\e[0;38;5;39m'
dirinfo_color=$'\e[0;36m'
gitinfo_title_color=$'\e[0;32m'
gitinfo_branch_color=$'\e[0;32;1m'
gitinfo_dirty_color=$'\e[36m'
rubyinfo_title_color=$'\e[0;31m'
rubyinfo_current_color=$'\e[0;31;1m'

PROMPT=$'%{$separator_color%}─[%{$reset_color%}%* %{$userinfo_color%}%n$(n_hostname_prompt_info)%{$separator_color%}:%{$dirinfo_color%}%30<...<%~%<<%{$separator_color%}]$(n_rbenv_prompt_info)$(git_prompt_info)%{$separator_color%}─%{$reset_color%}
%{$separator_color%}%(!.#.%%)%{$reset_color%} '
RPROMPT=''

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$separator_color%}─[%{$gitinfo_title_color%}git:%{$gitinfo_branch_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$separator_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$gitinfo_dirty_color%}!%{$separator_color%}"

# rbenv theming
ZSH_THEME_RBENV_PROMPT_PREFIX="%{$separator_color%}─[%{$rubyinfo_title_color%}ruby:%{$rubyinfo_current_color%}"
ZSH_THEME_RBENV_PROMPT_SUFFIX="%{$separator_color%}]"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
