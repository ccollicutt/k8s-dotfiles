# k8s-dotfiles.sh

I got tired of not having all the right commands on a node for managing Kubernetes.

This will setup some commands, scripts, and PS1 in `~/.k8s-dotfiles/`. Sourcing the script will be added to `~/.bashrc`.

## Install

```
git clone https://github.com/ccollicutt/k8s-dotfiles
cd k8s-dotfiles
./install.sh
```

## Testing 

Create a docker image with bats.

```
cd bats
./build.sh 
```

Run scripts.

```
# from main level 
./tests.sh 
```

Example output:

```
$ ./test.sh 
1..12
ok 1 check_for_commands should return 0
ok 2 check_bin_dir should return 0
ok 3 install_binaries should return 0
ok 4 install_k8sdotfile should return 0
ok 5 install_into_bashrc should return 0
ok 6 k8sdotfilerc should exist in home directory
ok 7 k8sdotfilesrc should be sourced in users .bashrc
ok 8 check if kubectx exists and is executable
ok 9 check if kubens exists and is executable
ok 10 check if helm exists and is executable
ok 11 check if kustomize exists and is executable
ok 12 check if powerline-go exists and is executable
```

## TODO

* Self updating
* version script
* version ps1 download
* don't use raw github for deploying (300 second update)