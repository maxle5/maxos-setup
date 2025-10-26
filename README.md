# MaxOS Setup

This repo contains a set of scripts to quickly install my preferred software and dotfile configurations on a fresh **CachyOS** installation.

## 🚀 Features

- Installs my essential programs.
- Copies over dotfiles.
- Applies basic system tweaks and configurations.

## 🛠️ Requirements

- Fresh **CachyOS** installation (with no desktop environment).
- Sudo privileges.

## 🏁 Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/maxle5/maxos.git
    cd maxos
    ```

2. Run the installation script:

    ```bash
    chmod +x run.sh
    ./run.sh
    ```

3. Reboot your system:

    ```bash
    sudo reboot
    ```
## 📝 Files Breakdown

- **`run.sh`**: Main installation entrypoint script; also used for updates.
- **`migrations/`**: Setup scripts that will only run once.
- **`dotfiles/`**: Configuration files that will be copied.
