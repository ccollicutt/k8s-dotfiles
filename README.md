# k8s-dotfiles.sh

[![Run Bats tests](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml) [![Super-Linter](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml)

I often need useful Kubernetes utilties and aliases. The `install.sh` script will setup some commands, scripts, and a PS1 via `~/.k8s-dotfiles/`. Sourcing the rc file will be added to `~/.bashrc`.

## Install

```bash
git clone https://github.com/ccollicutt/k8s-dotfiles
cd k8s-dotfiles
./install.sh
```

## Run from Docker

Build the image:

```bash
./build-docker-images.sh
```

It will output a docker run command to use the docker image just built to mount ~/.kube into the container and have the utilities available without having to install it locally.

## Testing

See [testing readme](tests/README.md).

## TODO

* Self updating
* version script
* version ps1 download
* don't use raw github for deploying (300 second update)
