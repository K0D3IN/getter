#!/bin/bash
port=8084
figlet "DINLE" | lolcat
echo "Dosya alımı için $port portu dinleniyor..."
while true; do
    temp_file=$(mktemp)
    # Veriyi al ve geçici dosyaya kaydet
    nc -l -p $port > "$temp_file"
    
    # İlk satırı dosya adı olarak al
    file_name=$(head -n 1 "$temp_file")
    # Geri kalan içeriği gerçek dosyaya kaydet
    tail -n +2 "$temp_file" > "$file_name"
    echo "Dosya alındı Dosya adı: $file_name dosyanın md5'i: $(md5sum $file_name)"
    # Geçici dosyayı sil
    rm "$temp_file"
    
    echo "Dosya kaydedildi: $file_name"
done