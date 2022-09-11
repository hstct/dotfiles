#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

MY_PGP_KEY_ID="18F47F5FD9300B51"

dotfiles_dir="$(
  cd "$(dirname "$0")"
  pwd
)"
cd "$dotfiles_dir"

link() {
  orig_file="$dotfiles_dir/$1"
  if [ -n "$2" ]; then
    dest_file="$HOME/$2"
  else
    dest_file="$HOME/$1"
  fi

  mkdir -p "$(dirname "$orig_file")"
  mkdir -p "$(dirname "$dest_file")"

  rm -rf "$dest_file"
  ln -s "$orig_file" "$dest_file"
  echo "$dest_file -> $orig_file"
}

is_chroot() {
  ! cmp -s /proc/1/mountinfo /proc/self/mountinfo
}

systemctl_enable_start() {
  echo "systemctl --user enable --now "$1""
  systemctl --user enable --now "$1"
}

echo "==========================="
echo "Setting up user dotfiles..."
echo "==========================="

link ".gnupg/gpg.conf" ".gnupg/gpg.conf"
link ".gnupg/gpg-agent.conf"
link ".ignore"
link ".magic"
link ".p10k.zsh"
link ".p10k.zsh" ".p10k-ascii-8color.zsh"
link ".p10k.zsh" ".p10k-8color.zsh"
link ".zprofile"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

link ".config/bat"
link ".config/chromium-flags.conf"
link ".config/environment.d"
link ".config/flashfocus"
link ".config/git/config" ".config/git/config"
link ".config/git/common"
link ".config/git/ignore"
link ".config/git/home"
link ".config/git/work"
link ".config/gtk-3.0"
link ".config/htop"
link ".config/imapnotify/personal.conf"
link ".config/imapnotify/work.conf"
link ".config/khal"
link ".config/khard"
link ".config/kitty"
link ".config/lazygit/config.yml"
link ".config/mbsync"
link ".config/mimeapps.list"
link ".config/mpv"
link ".config/msmtp"
link ".config/neomutt/colors"
link ".config/neomutt/mailcap"
link ".config/neomutt/neomuttrc"
link ".config/neomutt/signature"
link ".config/networkmanager-dmenu"
link ".config/newsboat"
link ".config/notmuch"
link ".config/nvim"
link ".config/pacman"
link ".config/pgcli/config"
link ".config/pylint"
link ".config/qalculate/qalc.cfg"
link ".config/qalculate/qalculate-gtk.cfg"
link ".config/qutebrowser"
link ".config/repoctl"
link ".config/sclirc"
link ".config/stylua"
link ".config/swappy"
link ".config/sway"
link ".config/swaylock"
link ".config/swaync"
link ".config/systemd/user/backup-packages.service"
link ".config/systemd/user/backup-packages.timer"
link ".config/systemd/user/battery-low-notify.service"
link ".config/systemd/user/mbsync.service"
link ".config/systemd/user/mbsync.timer"
link ".config/systemd/user/nm-applet.service"
link ".config/systemd/user/polkit-gnome.service"
link ".config/systemd/user/qutebrowser-update-useragent.service"
link ".config/systemd/user/qutebrowser-update-useragent.timer"
link ".config/systemd/user/sway-autoname-workspaces.service"
link ".config/systemd/user/sway-inactive-window-transparency.service"
link ".config/systemd/user/sway-session.target"
link ".config/systemd/user/swayr.service"
link ".config/systemd/user/systembus-notify.service"
link ".config/systemd/user/udiskie.service"
link ".config/systemd/user/waybar.service"
link ".config/systemd/user/waybar-updates.service"
link ".config/systemd/user/waybar-updates.timer"
link ".config/systemd/user/wl-clipboard-manager.service"
link ".config/systemd/user/wlsunset.service"
link ".config/tmux"
link ".config/transmission/settings.json"
link ".config/tridactyl"
link ".config/udiskie"
link ".config/USBGuard"
link ".config/vimiv"
link ".config/waybar"
link ".config/weechat"
link ".config/wldash"
link ".config/wofi"
link ".config/xdg-desktop-portal-wlr"
link ".config/xplr"
link ".config/yt-dlp"
link ".config/zathura"

link ".local/bin"
link ".local/share/applications"
link ".local/share/qutebrowser/greasemonkey"

if is_chroot; then
  echo >&2 "=== Running in chroot, skipping user services..."
else
  echo ""
  echo "================================="
  echo "Enabling and starting services..."
  echo "================================="

  systemctl --user daemon-reload
  systemctl_enable_start "backup-packages.timer"
  systemctl_enable_start "battery-low-notify.service"
  systemctl_enable_start "flashfocus.service"
  systemctl_enable_start "nm-applet.service"
  systemctl_enable_start "swaync.service"
  systemctl_enable_start "polkit-gnome.service"
  systemctl_enable_start "qutebrowser-update-useragent.timer"
  systemctl_enable_start "sway-autoname-workspaces.service"
  systemctl_enable_start "sway-inactive-window-transparency.service"
  systemctl_enable_start "swayr.service"
  systemctl_enable_start "systembus-notify.service"
  systemctl_enable_start "systemd-tmpfiles-setup.service"
  systemctl_enable_start "udiskie.service"
  systemctl_enable_start "waybar.service"
  systemctl_enable_start "waybar-updates.timer"
  systemctl_enable_start "wl-clipboard-manager.service"
  systemctl_enable_start "wlsunset.service"
  systemctl_enable_start "wluma.service"
  # systemctl_enable_start "yubikey-touch-detector.socket"

  if [[ $HOSTNAME == home-* ]]; then
    if [ -d "$HOME/.mail" ]; then
      systemctl_enable_start "mbsync.timer"
      systemctl_enable_start "goimapnotify@elmcat.service"
    else
      echo >&2 -e "
            === Mail is not configured, skipping...
            === Consult \$MBSYNC_CONFIG for initial setup, and then sync everything using:
            === while ! mbsync -c "\$MBSYNC_CONFIG" -a; do echo 'restarting...'; done
            "
    fi
  fi
fi

echo ""
echo "======================================="
echo "Finishing various user configuration..."
echo "======================================="

echo "Configuring MIME types"
file --compile --magic-file "$HOME/.magic"

if ! gpg -k | grep "$MY_PGP_KEY_ID" >/dev/null; then
  echo "Importing my public PGP key"
  curl -s https://hostc.at/pgp_keys.asc | gpg --import
  echo "5\ny\n" | gpg --command-fd 0 --no-tty --batch --edit-key "$MY_PGP_KEY_ID" trust
  curl -s https://hostc.at/pgp_keys.asc | pacman-key -a -
  pacman-key --lsign "$MY_PGP_KEY_ID"
fi

find "$HOME/.gnupg" -type f -not -path "*#*" -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;

# if is_chroot; then
#     echo >&2 "=== Running in chroot, skipping YubiKey configuration..."
# else
#     if [ ! "$HOME/.config/Yubico/u2f_keys" ]; then
#         echo "Configuring YubiKey for passwordless sudo (touch it now)"
#         mkdir -p "$HOME/config/Yubico"
#         pamu2fcfg -uelmcat > "$HOME/.config/Yubico/u2f_keys"
#     fi
# fi

if [ -d "$HOME/.password-store" ]; then
  echo "Configuring automatic git push for pass"
  echo -e "#!/bin/sh\n\npass git push" >"$HOME/.password-store/.git/hooks/post-commit"
  chmod +x "$HOME/.password-store/.git/hooks/post-commit"
else
  echo >&2 "=== Password store is not configured yet, skipping..."
fi

if is_chroot; then
  echo >&2 "=== Running in chroot, skipping GTK file chooser dialog configuration..."
else
  echo "Configuring GTK file chooser dialog"
  gsettings set org.gtk.Settings.FileChooser sort-directories-first true
fi

echo "Ignoring further changes to often changing config"
git update-index --assume-unchanged ".config/transmission/settings.json"

echo "Configure repo-local git settings"
git config user.email "code@elmc.at"
git config user.signingkey "18F47F5FD9300B51"
git config commit.gpgsign true
git remote set-url origin "git@github.com:hstct/dotfiles.git"
