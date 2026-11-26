#!/bin/bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$BASE_DIR/data/sinhvien.txt"

if [ ! -f "$FILE" ]; then
    echo "Khong tim thay file sinhvien.txt"
    exit 1
fi

while true
do
    echo
    echo "===== CHUONG TRINH QUAN LY SINH VIEN ====="
    echo "1. Hien thi danh sach sinh vien"
    echo "2. Tim kiem sinh vien theo ma"
    echo "3. Thong ke sinh vien dat va khong dat"
    echo "4. Tinh diem trung binh"
    echo "5. Hien thi sinh vien co diem cao nhat"
    echo "6. Sap xep sinh vien theo diem giam dan"
    echo "0. Thoat chuong trinh"
    read -p "Nhap lua chon: " choice

    case "$choice" in
        1)
            printf "%-10s %-20s %s\n" "Ma SV" "Ho ten" "Diem"
            awk -F, '{printf "%-10s %-20s %s\n",$1,$2,$3}' "$FILE"
            ;;
        2)
            read -p "Nhap ma sinh vien: " ma
            result=$(awk -F, -v m="$ma" 'tolower($1)==tolower(m)' "$FILE")
            if [ -n "$result" ]; then
                echo "$result"
            else
                echo "Khong tim thay sinh vien!"
            fi
            ;;
        3)
            awk -F, '$3>=5{dat++} $3<5{khongdat++} END {
                print "Sinh vien dat:",dat+0
                print "Sinh vien khong dat:",khongdat+0
            }' "$FILE"
            ;;
        4)
            awk -F, '{tong+=$3; dem++} END {
                if(dem>0) printf "Diem trung binh: %.2f\n",tong/dem
            }' "$FILE"
            ;;
        5)
            sort -t, -k3,3nr "$FILE" | head -n 1
            ;;
        6)
            sort -t, -k3,3nr "$FILE"
            ;;
        0)
            echo "Thoat chuong trinh!"
            break
            ;;
        *)
            echo "Lua chon khong hop le!"
            ;;
    esac
done
