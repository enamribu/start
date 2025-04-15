#!/bin/bash
# === AUTO WINDOWS INSTALLER (GZ VERSION) ===
# ⚠️ WARNING: This will erase your VPS disk entirely!

set -e

# === CONFIGURATION ===
IMAGE_URL="https://download1478.mediafire.com/jpvqbde0t4ggRXis2dIDgnGVxNegFxYnr5OrhNzMmAv5DMvj5nOJ8qki7DXFKHtPNTqhDXXdrSvITUQ9mf64ft9aCfSHF7Uc7Lk0fAaPEBYVgmQkcOGoEcgo32q9tHvlEfXySwnFFapFBSt8kdsahgZhXLlGCllQJ4UShYSTgEQ/8utv0r73o6hcpxf/windows2019.gz"  # GANTI dengan link file .gz kamu
IMG_PATH="/root/windows.gz"

# === DETECT TARGET DISK ===
echo "[*] Detecting disk..."
DISK=$(lsblk -ndo NAME,TYPE | grep disk | head -n1 | awk '{print "/dev/"$1}')
echo "[+] Target disk: $DISK"

# === USER CONFIRMATION ===
echo "⚠️  WARNING: This will ERASE all data on $DISK!"
read -p "Type YES to continue: " CONFIRM
if [[ "$CONFIRM" != "YES" ]]; then
  echo "[-] Aborted."
  exit 1
fi

# === INSTALL TOOLS IF NEEDED ===
apt update && apt install -y gzip wget

# === DOWNLOAD COMPRESSED IMAGE ===
echo "[*] Downloading compressed image..."
wget -O "$IMG_PATH" "$IMAGE_URL"

# === DECOMPRESS & WRITE TO DISK ===
echo "[*] Writing image to $DISK (on-the-fly decompress)..."
gzip -dc "$IMG_PATH" | dd of="$DISK" bs=4M status=progress conv=fsync

# === FINISH ===
echo "[+] Done! Rebooting into Windows..."
sync
reboot
