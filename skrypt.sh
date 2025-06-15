#!/bin/bash

# Funkcja wyświetlająca pomoc
display_help() {
    echo "Dostępne opcje:"
    echo "  --date       : Wyświetla dzisiejszą datę"
    echo "  --logs       : Tworzy 100 plików logx.txt"
    echo "  --logs <N>   : Tworzy N plików logx.txt"
    echo "  --help       : Wyświetla tę pomoc"
}

# Obsługa flagi --date
if [[ "$1" == "--date" ]]; then
    date
    exit 0
fi

# Obsługa flagi --logs
if [[ "$1" == "--logs" ]]; then
    count=100
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
        count=$2
    fi
    
    for i in $(seq 1 $count); do
        echo "Nazwa pliku: log$i.txt" > "log$i.txt"
        echo "Nazwa skryptu: $0" >> "log$i.txt"
        echo "Data: $(date)" >> "log$i.txt"
    done
    echo "Utworzono $count plików log"
    exit 0
fi

# Obsługa flagi --help
if [[ "$1" == "--help" ]]; then
    display_help
    exit 0
fi

# Domyślne zachowanie (gdy brak flagi)
display_help