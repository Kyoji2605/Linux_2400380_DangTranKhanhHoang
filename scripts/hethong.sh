#!/bin/bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_FILE="$BASE_DIR/logs/hethong.log"
exec > >(tee "$LOG_FILE") 2>&1

echo "========== THONG TIN HE THONG =========="
echo "Nguoi dung: $(whoami)"
echo "Ten may tinh: $(hostname)"
echo "Ngay gio: $(date)"
echo "Linux Kernel: $(uname -r)"
echo
echo "========== DUNG LUONG RAM =========="
free -h
echo
echo "========== DUNG LUONG O DIA =========="
df -h
echo
echo "========== KIEM TRA MANG =========="
if ping -c 1 -W 2 google.com.vn > /dev/null 2>&1; then
    echo "Co ket noi mang"
else
    echo "Khong xac nhan duoc ket noi mang"
fi
echo
echo "Da ghi ket qua vao logs/hethong.log"
