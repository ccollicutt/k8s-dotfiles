#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "check_for_commands should return 0" {
  source install.sh
  run check_for_commands
  assert_success
}

@test "check_bin_dir should return 0" {
  source install.sh
  run create_bin_dir
  assert_success 
}

@test "install_binaries should return 0" {
  source install.sh
  run install_binaries
  assert_success
}

@test "install_k8sdotfile should return 0" {
  source install.sh
  run install_k8sdotfile
  assert_success
}

@test "install_into_bashrc should return 0" {
  source install.sh
  run install_into_bashrc
  assert_success
}

@test "k8sdotfilerc should exist in bin dir" {
  assert [ -e "$HOME/.k8s-dotfiles/bin/k8sdotfilesrc" ]
}

@test "k8sdotfilesrc should be sourced in users .bashrc" {
  run grep k8sdotfilesrc $HOME/.bashrc 
  assert_success
}

@test "check if kubectl exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/kubectl" ]
}
@test "check if kubectx exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/kubectx" ]
}

@test "check if kubens exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/kubens" ]
}

@test "check if helm exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/helm" ]
}

@test "check if kustomize exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/kustomize" ]
}

@test "check if powerline-go exists and is executable" {
  assert [ -x "$HOME/.k8s-dotfiles/bin/powerline-go" ]
}



@test "check_for_commands should fail if no wget" {
  source install.sh
  rm -f /usr/bin/wget 
  run check_for_commands
  assert_failure
}

@test "z.sh should exist in bin dir" {
  assert [ -e "$HOME/.k8s-dotfiles/bin/z.sh" ]
}

@test "konfig should exist in bin dir" {
  assert [ -e "$HOME/.k8s-dotfiles/bin/konfig" ]
}

@test "check if path is set after sourcing k8sdotfilerc" {
  source $HOME/.bashrc
  echo $PATH | grep "\.k8s-dotfiles\/bin"
}