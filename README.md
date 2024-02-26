# dotfiles

An attempt at automating the process of keeping my dotfiles up to date via
ansible.

## Requirements:

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

This makes use of vagrant to test out changes, and hopefully make this easier
to maintain. Run `vagrant up` and it should run all the tasks successfully. You
can then `vagrant ssh` into the VM and test out any changes.
