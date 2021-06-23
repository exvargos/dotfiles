alias naa='vi ~/.bash_aliases; source ~/.bash_aliases'

# Misc
alias c='clear'
alias cls='clear;ls'
alias sl='ls'
function gethostip { nslookup `hostname` | grep -i address | awk -F" " '{print $2}' | awk -F# '{print $1}' | tail -n 1; }
function rmssh { sed -i $1d ~/.ssh/known_hosts; }

lias colortest='sh ~/24-bit-color.sh'
alias getyear='date +"%Y"'
alias EDITOR='vi'

alias savetmux='pushd ~/.tmux/plugins/tmux-resurrect/scripts; ./save.sh; popd'
alias restoretmux='pushd ~/.tmux/plugins/tmux-resurrect/scripts; ./restore.sh; popd'

# Cscope/Ctags
alias getfilelist='find . -type f \( -iname \*.c -o -iname \*.h -o -iname \*.py \) > cscope.files'
alias setcs='cscope -bR'
alias setct='ctags -L cscope.files --extras=+r'
# alias csb="$(getfilelist); cscope -Rbq; $(setct)"
# alias csbo="$(getfilelist); cscope -Rbq"
alias css='cscope -bR; ctags -e -R'
alias cs='cscope -d -p6'

# Other Aliases
alias configtmux='vim ~/.tmux.conf'
alias configtmuxnord='vim ~/.tmux/plugins/nord-tmux/src/nord-status-content.conf'
alias configvim='vim ~/.config/nvim/init.vim'
alias configzsh='vim ~/.zshrc'
alias configbash='vim ~/.bashrc'

alias vimdiff='nvim -d'
alias goscripts='cd ~/scripts'
alias rgc='rg -t c'
alias rgfiles='rg -l'

# Custom Compilers
alias setpkgconfig='export PKG_CONFIG_PATH=$HOME/tools/lib/pkgconfig'
alias setgcc102='export CC=`which gcc10.2.0`; export CXX=`which g++10.2.0`; echo CC:$CC; echo CXX:$CXX'
alias setgcc11='export CC=`which gcc-11.1`; export CXX=`which g++-11.1`; echo CC:$CC; echo CXX:$CXX'
alias setccclang='export CC=`which clang`; export CXX=`which clang++`; echo CC:$CC; echo CXX:$CXX'
alias setlld='export LDFLAGS=-fuse-ld=lld'
