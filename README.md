# About

Pwnbox is a Docker container with tools for binary reverse engineering and exploitation. It's primarily geared towards Capture The Flag competitions.

This is a fork to original project with some improvements, most part this code is owner by [superkojiman](https://github.com/superkojiman).

## Installation

You need run `docker build -t pwnbox .` to build container, this may take a while.  
After this:

 1. You need to have `jq` installed. See [https://stedolan.github.io/jq/](https://stedolan.github.io/jq/) for installation details.

 2. Optional: Create a ./rc directory. Your custom configuration files in $HOME go here. Eg: .gdbinit, .radare2rc, .bashrc, .vimrc, etc. The contents of rc gets copied into /root on the container.

 3. Execute `run.sh` script and pass it the name of the container. Eg: `sudo ./run.sh my_ctf`. This will create a volume for your container drop you into a `tmux` session.

 4. If you detach or quit the container, you can re-attach to it by using `sudo docker start my_ctf && ./my_ctf.sh`.

 5. You can delete the volume and container using `sudo ./my_ctf.sh delete`.

### Limitations

 1. If you need to edit anything in /proc, you must edit `run.sh` to use the `--privileged` option to `docker` instead of `--security-opt seccomp:unconfined`.
 1. The container is designed to be isolated so no directories are mounted from the host. This allows you to have multiple containers hosting files from different CTFs.

### Go forth, and CTF

```plaintext
•_•)

( •_•)>⌐■-■

(⌐■_■)
```
