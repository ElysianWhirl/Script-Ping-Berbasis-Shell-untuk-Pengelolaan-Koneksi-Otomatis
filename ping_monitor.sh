#!/bin/ash

# Fungsi untuk mengaktifkan mode pesawat
enable_airplane_mode() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Mengaktifkan mode pesawat..."
    adb shell cmd connectivity airplane-mode enable
    adb shell settings put global airplane_mode_on 1
    adb shell am broadcast -a android.intent.action.AIRPLANE_MODE
}

# Fungsi untuk menonaktifkan mode pesawat
disable_airplane_mode() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Menonaktifkan mode pesawat..."
    adb shell cmd connectivity airplane-mode disable
    adb shell settings put global airplane_mode_on 0
    adb shell am broadcast -a android.intent.action.AIRPLANE_MODE
}

# Alamat host yang ingin Anda ping
HOST1="alamat_host_anda"
HOST2="alamat_host_anda"
HOST3="alamat_host_anda"
HOST4="alamat_host_anda"

# Inisialisasi variabel untuk status kegagalan masing-masing host
failed_count_HOST1=0
failed_count_HOST2=0
failed_count_HOST3=0
failed_count_HOST4=0

# Batas kegagalan berturut-turut sebelum mengaktifkan mode pesawat
pingfail=3

# Waktu tunggu (detik) sebelum mengaktifkan mode pesawat setelah semua host tidak dapat dijangkau
WAIT_TIME=3

# Loop untuk melakukan ping dan mengaktifkan/menonaktifkan mode pesawat
while true; do
    # Ping ke HOST1
    PING_RESULT=$(ping -c 1 $HOST1 2>&1)
    if echo "$PING_RESULT" | grep "time=" > /dev/null; then
        # Host 1 dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST1 dapat dijangkau."
        failed_count_HOST1=0  # Reset hitungan kegagalan jika host berhasil dijangkau
    else
        # Host 1 tidak dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST1 tidak dapat dijangkau."
        failed_count_HOST1=$((failed_count_HOST1 + 1))  # Tingkatkan hitungan kegagalan
    fi

    # Ping ke HOST2
    PING_RESULT=$(ping -c 1 $HOST2 2>&1)
    if echo "$PING_RESULT" | grep "time=" > /dev/null; then
        # Host 2 dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST2 dapat dijangkau."
        failed_count_HOST2=0  # Reset hitungan kegagalan jika host berhasil dijangkau
    else
        # Host 2 tidak dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST2 tidak dapat dijangkau."
        failed_count_HOST2=$((failed_count_HOST2 + 1))  # Tingkatkan hitungan kegagalan
    fi

    # Ping ke HOST3
    PING_RESULT=$(ping -c 1 $HOST3 2>&1)
    if echo "$PING_RESULT" | grep "time=" > /dev/null; then
        # Host 3 dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST3 dapat dijangkau."
        failed_count_HOST3=0  # Reset hitungan kegagalan jika host berhasil dijangkau
    else
        # Host 3 tidak dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST3 tidak dapat dijangkau."
        failed_count_HOST3=$((failed_count_HOST3 + 1))  # Tingkatkan hitungan kegagalan
    fi

    # Ping ke HOST4
    PING_RESULT=$(ping -c 1 $HOST4 2>&1)
    if echo "$PING_RESULT" | grep "time=" > /dev/null; then
        # Host 4 dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST4 dapat dijangkau."
        failed_count_HOST4=0  # Reset hitungan kegagalan jika host berhasil dijangkau
    else
        # Host 4 tidak dapat dijangkau
        echo "$(date +"%Y-%m-%d %H:%M:%S") - $HOST4 tidak dapat dijangkau."
        failed_count_HOST4=$((failed_count_HOST4 + 1))  # Tingkatkan hitungan kegagalan
    fi

    # Cek jika semua host tidak dapat dijangkau
    if [ $failed_count_HOST1 -ge $pingfail ] && [ $failed_count_HOST2 -ge $pingfail ] && [ $failed_count_HOST3 -ge $pingfail ] && [ $failed_count_HOST4 -ge $pingfail ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Semua host tidak dapat dijangkau. Mengaktifkan mode pesawat..."
        enable_airplane_mode
        sleep $WAIT_TIME
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Menonaktifkan mode pesawat kembali..."
        disable_airplane_mode
        # Reset hitungan kegagalan untuk semua host setelah mengaktifkan mode pesawat
        failed_count_HOST1=0
        failed_count_HOST2=0
        failed_count_HOST3=0
        failed_count_HOST4=0
    fi

    sleep 5  # Tunggu sebelum memeriksa koneksi lagi
done
