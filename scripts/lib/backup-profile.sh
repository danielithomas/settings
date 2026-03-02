#!/bin/bash
# Backup the current shell RC file to ~/config/<hostname>-terminal/

_lol() {
    if command -v lolcat &>/dev/null; then
        lolcat
    else
        cat
    fi
}

directoryname=$(hostname)-terminal
backup_dir="$CUST_CONFIG/$directoryname"

# Detect RC file
shell_name="$(basename "${SHELL:-/bin/bash}")"
case "$shell_name" in
    zsh)
        rc_file="$HOME/.zshrc"
        suffix="zshrc"
        ;;
    *)
        rc_file="$HOME/.bashrc"
        suffix="bashrc"
        ;;
esac

backup_file="$backup_dir/$(date +"%Y%m%d")_${suffix}.txt"

echo "Backup Terminal >>> " | _lol

if [[ -d "$backup_dir" ]]; then
    echo "  >> Directory present!" | _lol
else
    echo "  >> Folder $backup_dir not present" | _lol
    mkdir -p "$backup_dir"
    echo "  >> Folder created!" | _lol
fi

echo "  >> Backup to $backup_file" | _lol
cp "$rc_file" "$backup_file"
echo "  >> DONE!" | _lol

unset -f _lol
