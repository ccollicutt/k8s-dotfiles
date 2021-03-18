#!/usr/bin/env bash

set -o errexit 

# ensure required commands are avaiable
function check_for_commands(){
  if ! command -v wget &> /dev/null
  then
      echo "ERROR: need wget"
      exit 1
  fi
}

function check_os_version(){
  if ! command -v lsb_release &> /dev/null; then
    echo "ERROR: lsb_release not found"
    echo "INFO: only tested on ubuntu bionic and focal"
    exit 1
  fi

  OS_VERSION=$(lsb_release -c -s | tr -d '\n')
  if [[ "$OS_VERSION" != "focal" && "$OS_VERSION" != "bionic" ]]; then
    echo "ERROR: only tested on ubuntu bionic and focal"
    exit 1
  fi
}

# fix popd/push
pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd > /dev/null
}

# ensure k8sdotfilesrc is sourced in ~/.bashrc
function install_into_bashrc(){
  if ! grep -q "^source $BIN_DIR/k8sdotfilesrc$" ~/.bashrc; then 
    echo "source $BIN_DIR/k8sdotfilesrc" >> ~/.bashrc
  fi
}

# create the bin dir that we put our useful binaries in 
function create_bin_dir() {
  if [[ ! -d "$BIN_DIR" ]]; then 
    mkdir -p "$BIN_DIR"
  fi
}

# install k7sdotfilesrc file 
function install_k8sdotfile(){
  if [[ ! -f "$BIN_DIR"/k8sdotfilesrc ]]; then 
    if cp "$SCRIPT_DIR"/k8sdotfilesrc "$BIN_DIR"/; then
      echo "INFO: Copied $SCRIPT_DIR/k8sdotfilesrc to $BIN_DIR/k8sdotfilesrc"
    else 
      echo "ERROR: failed to copy to bindir"
      exit 1
    fi
  fi
}

# install useful binaries, like helm, into the $BIN_DIR
function install_binaries(){


  if [[ ! -f "$BIN_DIR"/powerline-go ]]; then 
    pushd "$BIN_DIR" || exit 1
      wget -q "https://dl.k8s.io/release/v1.20.4/bin/linux/amd64/kubectl"
      chmod 755 kubectl
    popd || exit 1
  fi

  if [[ ! -f "$BIN_DIR"/kubectx ]]; then 
    pushd "$TMP_DIR" || exit 1
      wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_x86_64.tar.gz
      tar zxf kubectx_v0.9.3_linux_x86_64.tar.gz
      mv kubectx "$BIN_DIR"/
    popd || exit 1
  fi 

  if [[ ! -f "$BIN_DIR"/kubens ]]; then 
    pushd "$TMP_DIR" || exit 1
      wget -q https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_x86_64.tar.gz
      tar zxf kubens_v0.9.3_linux_x86_64.tar.gz
      mv kubens "$BIN_DIR"/
    popd || exit 1
  fi 

  if [[ ! -f "$BIN_DIR"/kube-ps1.sh ]]; then 
    pushd "$BIN_DIR" || exit 1
      wget -q https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh
    popd || exit 1
  fi

  if [[ ! -f "$BIN_DIR"/helm ]]; then 
    pushd "$TMP_DIR" || exit 1
      HELM_FILE=helm-v3.5.3-linux-amd64.tar.gz
      wget -q "https://get.helm.sh/$HELM_FILE"
      tar zxf "$HELM_FILE"
      mv linux-amd64/helm "$BIN_DIR"/
    popd || exit 1
  fi

  if [[ ! -f "$BIN_DIR"/kustomize ]]; then 
    pushd "$TMP_DIR" || exit 1
      wget -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.0.5/kustomize_v4.0.5_linux_amd64.tar.gz
      tar zxf kustomize_v4.0.5_linux_amd64.tar.gz
      mv kustomize "$BIN_DIR"/
    popd || exit 1
  fi

  if [[ ! -f "$BIN_DIR"/powerline-go ]]; then 
    pushd "$BIN_DIR" || exit 1
      wget -q https://github.com/justjanne/powerline-go/releases/download/v1.21.0/powerline-go-linux-amd64 \
        -O powerline-go
      chmod 755 powerline-go
    popd || exit 1
  fi
}

function install_packages(){
  # install powerline fonts
  if ! dpkg -l fonts-powerline > /dev/null; then
    if [[ $EUID -ne 0 ]]; then
      sudo apt update
      sudo apt install -y fonts-powerline
    else
      # is root
      apt update
      apt install -y fonts-powerline
    fi
  fi
}

function cleanup_tmp(){
  rm -rf "$TMP_DIR"
}
trap cleanup_tmp EXIT

# 
# main
#

run_main() {
  check_os_version
  check_for_commands
  create_bin_dir
  install_binaries
  install_packages
  install_k8sdotfile
  install_into_bashrc
}

# 
# vars 
# 

readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly DOT_DIR="$HOME/.k8s-dotfiles"
readonly BIN_DIR="$DOT_DIR/bin"
# tmpdir
readonly TMP_DIR=$(mktemp -d -t k8s-dotfiles-XXXXXXXXXX)

# Only run main if running from scripts not testing with bats
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  run_main
fi