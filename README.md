# k8s-dotfiles

[![Run Bats tests](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/run.yaml) [![Super-Linter](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml/badge.svg)](https://github.com/ccollicutt/k8s-dotfiles/actions/workflows/superlinter.yaml)

I often need useful Kubernetes utilties and aliases installed into a node. The `install.sh` script will setup some commands, scripts, and a PS1 via `~/.k8s-dotfiles/`. Sourcing the rc file will be added to `~/.bashrc`. Note that this will reset your shell prompt.

## Install

Just run a few commands to install.

![install](/img/example-install.svg)

Run these commands.

```bash
git clone https://github.com/ccollicutt/k8s-dotfiles
cd k8s-dotfiles
./install.sh
source ~/.bashrc
```

At this point your shell should be configured by `k8s-dotfiles` and you can remove the repository.

```bash
rm -rf k8s-dotfiles
```

## Upgrade

Backup your existing .k8sdotfiles if you want (though nothing is permanent):

```
mv ~/.k8s-dotfiles/ ~/.k8s-dotfiles.bak
```

And run the install.

If you're happy, remove the backup.

```
rm -rf ~/.k8s-dotfiles.bak
```

## Run from Docker

Build the image:

```bash
./build-docker-images.sh
```

It will output a docker run command to use the docker image just built to mount ~/.kube into the container and have the utilities available without having to install it locally. Or you could use this to test it out.

## Uninstall

* Edit ~/.bashrc and remove the source line

```bash
rm -rf ~/.k8s-dotfiles
```

## Testing

See [testing readme](tests/README.md).
