#!/bin/bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="$BASE_DIR/data"
BACKUP_DIR="$BASE_DIR/backup"
LOG_FILE="$BASE_DIR/logs/backup.log"

if [ ! -d "$DATA_DIR" ]; then
    echo "Khong tim thay thu muc data"
    exit 1
fi

mkdir -p "$BACKUP_DIR"
TIME=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup_${TIME}.tar.gz"
ARCHIVE="$BACKUP_DIR/$FILENAME"

echo "Dang sao luu du lieu..."

if tar -czf "$ARCHIVE" -C "$BASE_DIR" data && tar -tzf "$ARCHIVE" > /dev/null 2>&1; then
    STATUS="THANH CONG"
    echo "Sao luu thanh cong!"
else
    STATUS="THAT BAI"
    echo "Sao luu that bai!"
    rm -f "$ARCHIVE"
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') | $FILENAME | $STATUS" >> "$LOG_FILE"
echo "DANH SACH FILE SAO LUU:"
ls -lh "$BACKUP_DIR"
