# dotfiles

This repo is for setting up my general dotfiles and vim config for Mac and
CentOS. The first time setup can be automated with:

```sh
$ bash <(curl -s https://raw.githubusercontent.com/mlaursen/dotfiles/master/init.sh)
```

> Note: Check out
> [Methods of Signing with GPG](https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e)

## Useful things

### Find all unique occurences with grep

```sh
grep -r --only-matching -h -E '{{REGEX}}' {{DIRECTORY}} | sort --unique
```

Example:

```sh
grep -r --only-matching -h -E '<([A-z]+Icon).* />' "react-md/packages/*/src" | sort unique
```

## CentOS Setup

I can never remember how this goes, so I decided to document this process. Mac
is a bit easier since I can just use [homebrew] for everything, but CentOS/\*nix
is a bit more difficult since it's something I have to do manually.

### Download an ISO

Download an ISO from the [CentOS download] page and start up a VM using this
ISO. Go through the installation process making sure to:

- update the Network configuration to auto-connect to eth0 so that I don't need
  to manually reconnect each time the VM is resumed.
- update the Network Preferences to be the current timezone and use network to
  determine
- choose the GNOME Desktop installation and don't check any other feature

### Creating an Admin User

Since this is normally a private VM, I can just keep the root password and my
`mlaursen` user's password empty and ensure that `mlaursen` is an administrator.

If I want to be more secure, I can add a password to both but I'll just need to
make sure to login and update `mlaursen` to be able to use sudo without the
password each time with:

```sh
$ sudo visudo
```

```diff
 ## Same thing without a password
 # %wheel        ALL=(ALL)       NOPASSWD: ALL
+mlaursen        ALL=(ALL)       NOPASSWD: ALL
```

### Setting up the dev environment

First thing is update packages and install git:

```sh
# the git in centos 7 is 1.8.x and crashes for minpac...
$ sudo yum remove git*
$ sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
$ sudo yum -y install git2u-all

$ sudo yum update -y
$ sudo yum install \
    the_silver_searcher \
    gcc \
    gcc-c++ \
    cmake \
    ncurses \
    ncurses-devel \
    ruby \
    ruby-devel \
    lua \
    lua-devel \
    ctags \
    python \
    python-devel \
    python3 \
    python3-devel \
    tcl-devel \
    perl \
    perl-devel \
    perl-ExtUtils-ParseXS \
    perl-ExtUtils-CBuilder \
    perl-ExtUtils-Embed \
    -y
```

Next install chrome:

```sh
$ wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
$ sudo yum install google-chrome-stable_current_x86_64.rpm
```

Finally, the `init.sh` should be able to take care of the rest.

[homebrew]: https://brew.sh/
[centos download]: https://www.centos.org/download/
