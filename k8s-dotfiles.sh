#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOT_DIR="$HOME/.k8s-dotfiles"
BIN_DIR="$DOT_DIR/bin"

#
# install into ~/.bashrc
#

if ! grep -q "^source $BIN_DIR/k8s-dotfiles.sh$" ~/.bashrc; then 
  echo "source $BIN_DIR/k8s-dotfiles.sh" >> ~/.bashrc
fi

#
# Setup ~/bin
#

if [[ ! -d $BIN_DIR ]]; then 
  mkdir -p $BIN_DIR
fi

# add to path...

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  PATH="${PATH:+"$PATH:"}$BIN_DIR"
fi

#
# Useful binaries and scripts
# 

if [[ ! -f $BIN_DIR/k8s-dotfiles.sh ]]; then 
  if cp $SCRIPT_DIR/k8s-dotfiles.sh $BIN_DIR/; then
    echo "INFO: Copied $SCRIPT_DIR/k8s-dotfiles.sh to $BIN_DIR/k8s-dotfiles.sh"
  else 
    echo "ERROR: failed to copy to bindir"
    exit 1
  fi
fi

if [[ ! -f $BIN_DIR/kubectx ]]; then 
  pushd /tmp > /dev/null
    wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_x86_64.tar.gz
    tar zxvf kubectx_v0.9.3_linux_x86_64.tar.gz
    mv kubectx $BIN_DIR/
  popd
fi 

if [[ ! -f $BIN_DIR/kubens ]]; then 
  pushd /tmp > /dev/null
    wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_x86_64.tar.gz
    tar zxvf kubens_v0.9.3_linux_x86_64.tar.gz
    mv kubens $BIN_DIR/
  popd
fi 

if [[ ! -f $BIN_DIR/kube-ps1.sh ]]; then 
  pushd $BIN_DIR > /dev/null
    wget https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh
  popd 
fi
  
#
# kubectx and kubens alias and bash completion
#

alias kc=kubectx
alias kn=kubens

_kube_contexts()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl config get-contexts --output='name')" -- $curr_arg ) );
}

complete -F _kube_contexts kubectx kctx kc

_kube_namespaces()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}')" -- $curr_arg ) );
}

complete -F _kube_namespaces kubens kns kn

#
# kubeps1
#

source $BIN_DIR/kube-ps1.sh
PS1='[\u@\h \W $(kube_ps1)]>\n\$ '

#
# kubernetes aliases
#

alias k='kubectl'
alias kdp='kubectl describe pod'
alias krh='kubectl run --help | more'
alias ugh='kubectl get --help | more'
alias c='clear'
alias kd='kubectl describe pod'
alias ke='kubectl explain'
alias kf='kubectl create -f'
alias kg='kubectl get pods --show-labels'
alias kr='kubectl replace -f'
alias kh='kubectl --help | more'
alias krh='kubectl run --help | more'
alias ks='kubectl get namespaces'
alias l='ls -lrt'
alias ll='vi ls -rt | tail -1'
alias kga='k get pod --all-namespaces'
alias kgaa='kubectl get all --show-labels'