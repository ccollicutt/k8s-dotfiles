# Testing

Create a docker image with bats.

```bash
cd bats
./build.sh 
```

Run script.

```bash
# from main level 
./tests.sh 
```

Example output:

```bash
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
* don't use raw GitHub for deploying (300 second update)
