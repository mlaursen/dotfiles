# dotfiles

This repo is for setting up my general dotfiles and vim config for Mac and
CentOS. The first time setup can be automated with:

```sh
$ bash <(curl -s https://raw.githubusercontent.com/mlaursen/dotfiles/master/init.sh)
```

> Note: Check out
> [Methods of Signing with GPG](https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e)

## GraphQL

```sh
yarn global add graphql-language-service-cli
```

## WSL GPG Setup

- Install Terminal Preview from the App Store
  - This might not be required the next time I have to setup WSL. At the time of
    writing this, the Terminal Preview allows for custom fonts and colors which
    is required for me
- Install Ubuntu from the App Store
- Setup the Ubuntu VM with user and stuffs
- [Create a new GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-new-gpg-key-to-your-github-account)
- Export the GPG key:
  `gpg --armor --export-secret-keys UUID_OF_GPG_KEY > private.cert`
- Copy the `private.cert` to Windows Download folder by navigating to
  `\\wsl$\Ubuntu\home\mlaursen`
- https://www.gpg4win.org/
- download + install (can uncheck everything except the required one and
  Kleopatra)
- Import the `private.cert` in Kleopatra
- Once imported, certify the cert.
- Increase Passphrase duration to 8 hours:
  - `Ctrl+Shift+,` -> `GnuPG System` -> `Private Keys` -> Update all caches to
    `28800`
- Back in Ubuntu VM, edit `~/.gnupg/gpg-agent.conf` to include
  `pinentry-program "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe"`
- `gpg-connect-agent reloadagent /bye`
- this should allow the new gui to handle the passphrase for GPG

## WSL Cypress Setup

> Reference:
> https://wilcovanes.ch/articles/setting-up-the-cypress-gui-in-wsl2-ubuntu-for-windows-10/

- install [VcXsrv Windows X Server](https://sourceforge.net/projects/vcxsrv/)
- update `.zshrc` to include

  ```sh
  # set DISPLAY variable to the IP automatically assigned to WSL2
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

  # might need this as well to start dbus daemon
  # sudo /etc/init.d/dbus start &> /dev/null
  ```

- start X Server (`xLaunch`)
  - use default options for display settings
  - disable access control in client startup settings
  - allow **both** private and public networks when the Windows security popup
    appears

## Useful things

### Find all unique occurrences with grep

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
