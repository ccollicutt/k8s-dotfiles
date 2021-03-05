# k8s-dotfile.sh

I got tired of not having all the right commands on a node for managing Kubernetes.

This will setup some commands, scripts, and PS1 for a Linux node. Only tested on Ubuntu.

## Install

```
export SCRIPT_NAME=k8s-dotfiles.sh
curl -s https://raw.githubusercontent.com/ccollicutt/k8s-dotfile/main/$SCRIPT_NAME -o $SCRIPT_NAME
bash $SCRIPT_NAME
rm $SCRIPT_NAME
source ~/.bashrc
```

## Update

```
export SCRIPT_NAME=k8s-dotfiles.sh
rm -f ~/.k8s-dotfiles/bin/$SCRIPT_NAME
curl -s https://raw.githubusercontent.com/ccollicutt/k8s-dotfile/main/$SCRIPT_NAME -o $SCRIPT_NAME
bash $SCRIPT_NAME
rm $SCRIPT_NAME
source ~/.bashrc
```

## Uninstall

```
rm -rf ~/.k8s-dotfiles
```

And remove the `source source <your user>/.k8s-dotfiles/bin/k8s-dotfiles.sh` line from `.bashrc`.


## TODO

* Self updating