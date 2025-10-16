# dotfiles

An attempt at automating the process of keeping my dotfiles up to date via
ansible.

## Requirements:

- pip
- ansible

I'm working on making this so that the playbook will install all the
dependencies, but as this is ansible, you'll have to at least get this repo
(whether you pull it via git or use a local unzipped copy of it) existing
somewhere. I've been using `~/.config/${USER}/dotfiles` as my local version of
it and that seems to work well.

## Usage

`ansible-playbook install_dotfiles.yml --ask-become-pass`

Some tasks require sudo, thus the `--ask-become-pass` above

## Testing

There are two options for testing this out: vagrant or docker. The docker
option allows for quickly and easily testing out changes which would affect
a CLI-only environment. If you need to test out something in a graphical
environment, you'll need to use vagrant. It's just too difficult to try to use
docker as a graphical environment, and loading the vagrant environment takes
a bit longer to initialize.

To test via docker, build the image using the `Containerfile`, and start the
image from that. Once you're in the container, you can simply run
`ansible-playbook install_dotfiles.yml` and you'll be on your way. You can even
test something more involved, like neovim's automatic setup. Sometimes, ansible
will complain about being unable to use sudo. Usually, you can resolve it
simply by running `sudo date` and then trying the ansible command again.

To test via vagrant, run `vagrant up` and it should run all the tasks
successfully. You can then `vagrant ssh` into the VM and test out any changes.

To test tasks specific to graphical environments, run `vagrant up
--no-provision`. This will start the normal vagrant box, but without doing any
of the ansible provisioning. Then, log into the vagrant box with `vagrant ssh`
and run the following:

```sh
# install dnf updates first
sudo dnf -y upgrade
# install pip
sudo dnf -y install python3-pip
# install pip and ansible as user
pip install --user --upgrade pip ansible
# install gnome
sudo dnf -y install @gnome-desktop
# change the default target so that it will start a graphical login screen.
sudo systemctl set-default graphical.target
```
> [!NOTE]
> It will be worthwhile to use Virtual Machine Manager to log into the virtual
machine with Gnome once, just so that the directories are set up as a normal
graphical environment would be.

The virtual machine should have the dotfiles directory accessible inside the VM
at `/vagrant`, so testing the dotfiles run should now be as simple as (just
like normal, even from `vagrant ssh`):

```sh
cd /vagrant
ansible-playbook install_dotfiles.yml
```

> [!NOTE]
> It's likely the case that the resulting virtual machine might not be too
useable. It's probably pretty strangled as it's just intended as a minimal
virtual machine, but at the very least, you'll be able to test that the tools
get installed and that the configurations are all in the correct spots.
