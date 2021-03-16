#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOT_DIR="$HOME/.k8s-dotfiles"
BIN_DIR="$DOT_DIR/bin"

#
# check for commands
#

if ! command -v wget &> /dev/null
then
    echo "ERROR: need wget"
    exit 1
fi

#
# install into ~/.bashrc
#

if ! grep -q "^source $BIN_DIR/k8s-dotfiles.sh$" ~/.bashrc; then 
  echo "source $BIN_DIR/k8s-dotfiles.sh" >> ~/.bashrc
fi

#
# Setup ~/bin
#

if [[ ! -d "$BIN_DIR" ]]; then 
  mkdir -p "$BIN_DIR"
fi

# add to path...

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  PATH="${PATH:+"$PATH:"}$BIN_DIR"
fi

#
# Useful binaries and scripts
# 

if [[ ! -f "$BIN_DIR"/k8s-dotfiles.sh ]]; then 
  if cp "$SCRIPT_DIR"/k8s-dotfiles.sh "$BIN_DIR"/; then
    echo "INFO: Copied $SCRIPT_DIR/k8s-dotfiles.sh to $BIN_DIR/k8s-dotfiles.sh"
  else 
    echo "ERROR: failed to copy to bindir"
    exit 1
  fi
fi

if [[ ! -f "$BIN_DIR"/kubectx ]]; then 
  pushd /tmp > /dev/null || exit
    wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_x86_64.tar.gz
    tar zxf kubectx_v0.9.3_linux_x86_64.tar.gz
    mv kubectx "$BIN_DIR"/
  popd || exit
fi 

if [[ ! -f "$BIN_DIR"/kubens ]]; then 
  pushd /tmp > /dev/null || exit
    wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_x86_64.tar.gz
    tar zxf kubens_v0.9.3_linux_x86_64.tar.gz
    mv kubens "$BIN_DIR"/
  popd || exit
fi 

if [[ ! -f "$BIN_DIR"/kube-ps1.sh ]]; then 
  pushd "$BIN_DIR" > /dev/null || exit
    wget -q https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh
  popd || exit 
fi

if [[ ! -f "$BIN_DIR"/helm ]]; then 
  pushd /tmp > /dev/null || exit
    HELM_FILE=helm-v3.5.3-linux-amd64.tar.gz
    wget -q "https://get.helm.sh/$HELM_FILE"
    tar zxf "$HELM_FILE"
    mv linux-amd64/helm "$BIN_DIR"/
    # cleanup
    rm -rf /tmp/linux-amd64
    rm -f "/tmp/$HELM_FILE"
  popd || exit 
fi

if [[ ! -f "$BIN_DIR"/kustomize ]]; then 
  pushd /tmp > /dev/null || exit
    wget -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.0.5/kustomize_v4.0.5_linux_amd64.tar.gz
    tar zxf kustomize_v4.0.5_linux_amd64.tar.gz
    mv kustomize "$BIN_DIR"/
    # cleanup a bit
    rm -f /tmp/kustomize_v4.0.5_linux_amd64.tar.gz
  popd || exit 
fi

if [[ ! -f "$BIN_DIR"/powerline-go ]]; then 
  pushd "$BIN_DIR" > /dev/null || exit
    wget -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.0.5/kustomize_v4.0.5_linux_amd64.tar.gz \
      -O powerline-go
    chmod 755 powerline-go

    # install powerline fonts
    sudo apt-get install fonts-powerline 
  popd || exit 
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
  # shellcheck disable=SC2207
  # shellcheck disable=SC2086
  COMPREPLY=( $(compgen -W "- $(kubectl config get-contexts --output='name')" -- $curr_arg ) );
}

complete -F _kube_contexts kubectx kctx kc

_kube_namespaces()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  # shellcheck disable=SC2207
  # shellcheck disable=SC2086
  COMPREPLY=( $(compgen -W "- $(kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}')" -- $curr_arg ) );
}

complete -F _kube_namespaces kubens kns kn

#
# kubeps1
#

# The source should work, but doesn't. Perhaps b/c running in a docker container?
# shellcheck disable=SC1091
# shellcheck source=/home/runner/.k8s-dotfiles/bin/kube-ps1.sh
# source "$BIN_DIR"/kube-ps1.sh
# PS1='[\u@\h \W $(kube_ps1)]>\n\$ '

#
# powerline-go
# 

function _update_ps1() {
    PS1="$($BIN_DIR/powerline-go -error $? -jobs $(jobs -p | wc -l))"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.
    
    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "$BIN_DIR/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#
# kubernetes aliases
#

# real get all...
alias kall='kubectl api-resources --verbs list --namespaced -o name | xargs -n1 kubectl get --show-kind --ignore-not-found'

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
