#!/bin/bash
port=8084
figlet "DINLE" | lolcat
echo "Dosya alımı için $port portu dinleniyor..."

while true; do
    # Gelen veriyi doğrudan işlemek için FIFO (named pipe) kullan
    fifo_file=$(mktemp -u)
    mkfifo "$fifo_file"
    
    # Netcat ile gelen veriyi FIFO'ya yönlendir
    nc -l -p $port > "$fifo_file" &
    nc_pid=$!

    # FIFO'dan ilk satırı dosya adı olarak oku
    read -r file_name < "$fifo_file"

    # Geri kalan veriyi doğrudan dosyaya yaz
    cat > "$file_name" < "$fifo_file"

    # Netcat işlemini sonlandır
    wait $nc_pid

    # FIFO dosyasını temizle
    rm "$fifo_file"

    echo "Dosya kaydedildi: $file_name"
done
