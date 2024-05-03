#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll="ls -al"
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export PATH=$PATH:/opt/cuda/bin  # This is where the nvcc binary lives

alias ros2="python3 ~/workspace/git-repos/system-config/helperscripts/dockerhop/dockerhop/ros2.py"  # Run ros2 container script
alias ros2build="python3 ~/workspace/git-repos/system-config/helperscripts/dockerhop/dockerhop/build.py"  # Run ros2 container script

# Rust related things
export PATH=$PATH:~/.cargo/bin  # This is where installed cargo packages live
export RUST_BACKTRACE=1  # Show back trace
alias cargo="RUSTC_WRAPPER=sccache cargo"  # use sccache when running cargo
alias dunder_dotfiles='/usr/bin/git --git-dir=/home/dunderscore/.cfg/ --work-tree=/home/dunderscore'
