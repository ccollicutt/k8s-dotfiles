# k8s-dotfile.sh

I got tired of not having all the right commands on a node for managing Kubernetes.

This will setup some commands, scripts, and PS1 in `~/.k8s-dotfiles/`. Sourcing the script will be added to `~/.bashrc`.

## Install

```bash
export SCRIPT_NAME=k8s-dotfiles.sh
curl -s https://raw.githubusercontent.com/ccollicutt/k8s-dotfile/main/$SCRIPT_NAME -o $SCRIPT_NAME
bash $SCRIPT_NAME
rm $SCRIPT_NAME
source ~/.bashrc
```

Once it's installed, your shell would look somehting like this:

```bash
[root@k8s-cluster-1 ~ (⎈ |kubernetes-admin@kubernetes:kube-system)]
# 
```

And tools like `kubens` and `kubectx` will be availble.

```bash
[root@k8s-cluster-1 ~ (⎈ |kubernetes-admin@kubernetes:kube-system)]
# which kubectx
/root/.k8s-dotfiles/bin/kubectx
```

And there will be a bunch of aliases.

```bash
[root@k8s-cluster-1 ~ (⎈ |kubernetes-admin@kubernetes:kube-system)]
# alias | grep "alias k" | head -3
alias k='kubectl'
alias kc='kubectx'
alias kd='kubectl describe pod'
```

## Update

```bash
export SCRIPT_NAME=k8s-dotfiles.sh
rm -f ~/.k8s-dotfiles/bin/$SCRIPT_NAME
curl -s https://raw.githubusercontent.com/ccollicutt/k8s-dotfile/main/$SCRIPT_NAME -o $SCRIPT_NAME
bash $SCRIPT_NAME
rm $SCRIPT_NAME
source ~/.bashrc
```

## Uninstall

```bash
rm -rf ~/.k8s-dotfiles
```

And remove the `source source <your user>/.k8s-dotfiles/bin/k8s-dotfiles.sh` line from `.bashrc`.


## TODO

* Self updating
* version script
* version ps1 download