# k8s-dotfiles.sh

[![Run Bats tests](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml) [![Super-Linter](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml)

I got tired of not having all the right commands on a node for managing Kubernetes.

This will setup some commands, scripts, and PS1 in `~/.k8s-dotfiles/`. Sourcing the script will be added to `~/.bashrc`.

## Install

```bash
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
