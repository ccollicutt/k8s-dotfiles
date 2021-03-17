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

See [testing readme[](tests/README.md).

## TODO

* Self updating
* version script
* version ps1 download
* don't use raw github for deploying (300 second update)