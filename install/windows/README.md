# Windows Subsystem for Linux Installation

- Install Terminal from App Store
  - Setup an Ubuntu VM with my normal user setup
  - Add the [Nightfox theme](https://github.com/EdenEast/nightfox.nvim)
    - https://github.com/EdenEast/nightfox.nvim/blob/main/extra/nightfox/windows_terminal.json
- Setup GPG:
  - WSL
    - [Create a new GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-new-gpg-key-to-your-github-account)
    - Export the GPG key:
      `gpg --armor --export-secret-keys UUID_OF_GPG_KEY > private.cert`
  - Windows
    - Copy the `private.cert` to Windows Download folder by navigating to
      `\\wsl$\Ubuntu\home\mlaursen`
    - [Install Kleopatra](https://www.gpg4win.org/)
      - Uncheck everything except for the required one and Kleopatra
    - Import the `private.cert` into Kleopatra and then certify the new
      `private.cert`
    - Increase the passphrase duration
      - `Ctrl+Shift+,` -> `GnuPG System` -> `Private Keys` -> Update all caches
        to `28800`
  - WSL
    - Edit `~/.gnupg/gpg-agent.conf`:
      ```
      default-cache-ttl 34560000
      max-cache-ttl 34560000
      pinentry-program "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe"
      ```
    - `gpg-connect-agent reloadagent /bye`
- (Optional): Additional setup for
  [Playwright/Cypress](https://wilcovanes.ch/articles/setting-up-the-cypress-gui-in-wsl2-ubuntu-for-windows-10/):

  - Install [VcXsrv Windows X Server](https://sourceforge.net/projects/vcxsrv/)
  - update `.zshrc` to include:

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
