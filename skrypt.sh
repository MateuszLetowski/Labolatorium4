#!/bin/bash

# Funkcja wyświetlająca pomoc
display_help() {
    echo "Dostępne opcje:"
    echo "  -d, --date       : Wyświetla dzisiejszą datę"
    echo "  -l, --logs [N]   : Tworzy N plików logx.txt (domyślnie 100)"
    echo "  -e, --error [N]  : Tworzy N katalogów errorx/errorx.txt (domyślnie 100)"
    echo "      --init       : Klonuje repozytorium i dodaje do PATH"
    echo "  -h, --help       : Wyświetla tę pomoc"
}

# Funkcja klonująca repozytorium i dodająca do PATH
clone_repo() {
    repo_url="https://github.com/twoje_repo/twoj_projekt.git"
    git clone "$repo_url" projekt
    echo "export PATH=\"\$PATH:$(pwd)/projekt\"" >> ~/.bashrc
    source ~/.bashrc
    echo "Repozytorium sklonowane i dodane do PATH"
}

# Obsługa flagi --date / -d
if [[ "$1" == "--date" || "$1" == "-d" ]]; then
    date
    exit 0
fi

# Obsługa flagi --logs / -l
if [[ "$1" == "--logs" || "$1" == "-l" ]]; then
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

# Obsługa flagi --error / -e
if [[ "$1" == "--error" || "$1" == "-e" ]]; then
    count=100
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
        count=$2
    fi
    
    for i in $(seq 1 $count); do
        mkdir -p "error$i"
        echo "Nazwa pliku: error$i.txt" > "error$i/error$i.txt"
        echo "Nazwa skryptu: $0" >> "error$i/error$i.txt"
        echo "Data: $(date)" >> "error$i/error$i.txt"
    done
    echo "Utworzono $count katalogów error"
    exit 0
fi

# Obsługa flagi --init
if [[ "$1" == "--init" ]]; then
    clone_repo
    exit 0
fi

# Obsługa flagi --help / -h
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    display_help
    exit 0
fi

# Domyślne zachowanie
display_help