#!/usr/bin/env bash

set -uo pipefail

FAILED=0

pause() {
    echo
    read -n1 -rsp "Press any key to close this window…"
    echo
}

echo "========================================"
echo " Arch Linux System Update"
echo "========================================"
echo
echo "This will update:"
echo "  • Arch Linux packages (pacman)"
echo "  • AUR packages (yay / paru)"
echo "  • Flatpak packages"
echo "  • Chromium Widevine (if Chromium updates)"
echo

read -rp "Do you want to start the system update? [y/N] " confirm
case "$confirm" in
    [yY]|[yY][eE][sS]) ;;
    *)
        echo
        echo "Update cancelled."
        pause
        exit 0
        ;;
esac

# Ensure we are not root
if [[ $EUID -eq 0 ]]; then
    echo "❌ Do not run this script as root."
    pause
    exit 1
fi

# Ensure sudo is available
if ! sudo -v; then
    echo "❌ This script requires sudo privileges."
    pause
    exit 1
fi

# ---------------------------
# Step 0: Detect Chromium version before updates
# ---------------------------
chromium_pre=""
if command -v chromium &>/dev/null; then
    chromium_pre=$(chromium --version 2>/dev/null | awk '{print $2}')
fi

# ---------------------------
# Step 1: Update pacman packages
# ---------------------------
echo "📦 Updating pacman packages..."
if ! sudo pacman -Syu --noconfirm --needed; then
    echo "❌ pacman update failed."
    FAILED=1
fi

# ---------------------------
# Step 2: Update AUR packages
# ---------------------------
if command -v yay &>/dev/null; then
    if ! yay --version &>/dev/null; then
        echo "⚠️  yay is broken (likely due to pacman update). Rebuild manually."
        FAILED=1
    else
        echo
        echo "📦 Updating AUR packages with yay..."
        if ! yay -Syu --noconfirm --needed; then
            echo "❌ AUR update failed."
            FAILED=1
        fi
    fi
elif command -v paru &>/dev/null; then
    echo
    echo "📦 Updating AUR packages with paru..."
    if ! paru -Syu; then
        echo "❌ AUR update failed."
        FAILED=1
    fi
else
    echo
    echo "⚠️  No AUR helper found. Skipping AUR updates."
fi

# ---------------------------
# Step 3: Update Flatpak packages
# ---------------------------
if command -v flatpak &>/dev/null; then
    echo
    echo "📦 Updating Flatpak packages..."
    if ! flatpak update --noninteractive; then
        echo "❌ Flatpak update failed."
        FAILED=1
    fi
else
    echo
    echo "⚠️  Flatpak not installed. Skipping Flatpak updates."
fi

# ---------------------------
# Step 4: Detect Chromium version after updates
# ---------------------------
chromium_post=""
if command -v chromium &>/dev/null; then
    chromium_post=$(chromium --version 2>/dev/null | awk '{print $2}')
fi

# ---------------------------
# Step 5: Update Widevine if Chromium updated
# ---------------------------
if [[ -n "$chromium_pre" && -n "$chromium_post" && "$chromium_pre" != "$chromium_post" ]]; then
    echo
    echo "Chromium version changed from $chromium_pre → $chromium_post."
    read -rp "Do you want to update Widevine to match the new version? [y/N] " widevine_confirm
    case "$widevine_confirm" in
        [yY]|[yY][eE][sS])
            echo "=== Updating Widevine ==="
            workdir="/tmp/chromium_widevine"
            widevine_dest="/usr/lib/chromium/WidevineCdm"

            # Cleanup
            rm -rf "$workdir" || true
            mkdir -p "$workdir"
            pushd "$workdir" >/dev/null || true

            # Download Chrome .deb matching Chromium version
            deb_file="google-chrome-stable_${chromium_post}-1_amd64.deb"
            url="https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/$deb_file"
            echo "Downloading Chrome package for Widevine: $url"
            if ! wget -c "$url"; then
                echo "❌ Failed to download Chrome package."
                FAILED=1
            else
                # Extract .deb
                rm -rf unpack_deb || true
                if ! ar x "$deb_file"; then
                    echo "❌ Failed to extract .deb archive."
                    FAILED=1
                else
                    mkdir -p unpack_deb
                    if ! tar -xf data.tar.xz -C unpack_deb; then
                        echo "❌ Failed to extract data.tar.xz."
                        FAILED=1
                    else
                        widevine_src="unpack_deb/opt/google/chrome/WidevineCdm"
                        if [[ ! -d "$widevine_src" ]]; then
                            echo "❌ WidevineCdm directory not found in package."
                            FAILED=1
                        else
                            # Remove old Widevine if it exists
                            if [[ -d "$widevine_dest" ]]; then
                                echo "Removing old Widevine..."
                                if ! sudo rm -rf "$widevine_dest"; then
                                    echo "❌ Failed to remove old Widevine."
                                    FAILED=1
                                fi
                            fi
                            # Move new Widevine in place
                            if ! sudo mv "$widevine_src" "$widevine_dest"; then
                                echo "❌ Failed to install new Widevine."
                                FAILED=1
                            else
                                # Change ownership to root
                                if ! sudo chown -R root:root "$widevine_dest"; then
                                    echo "❌ Failed to set ownership for Widevine."
                                    FAILED=1
                                else
                                    echo "✅ Widevine updated successfully."
                                fi
                            fi
                        fi
                    fi
                fi
            fi
            popd >/dev/null || true
            ;;
        *)
            echo "Skipped Widevine update."
            ;;
    esac
fi

# ---------------------------
# Step 6: Final status
# ---------------------------
echo
echo "========================================"

if [[ "$FAILED" -eq 0 ]]; then
    echo "✅ System update completed successfully."
else
    echo "❌ System update completed with errors."
    echo "   Please review the output above."
fi

echo "========================================"

pause

exit "$FAILED"
