#!/bin/bash
# Utilizare: ./gather.sh <cale_fisier_remote> <folder_local>

CALE_REMOTE=$1
DIR_LOCAL=$2

if [ -z "$CALE_REMOTE" ] || [ -z "$DIR_LOCAL" ]; then
    echo "Utilizare: ./gather.sh <cale_remote> <folder_local>"
    exit 1
fi

mkdir -p "$DIR_LOCAL"

# Lista cu toate IP-urile de la Nivelul 2 (Nepotii)
# Deoarece am adaugat rute statice, Master-ul ii poate accesa direct!
NEPOTI=("192.168.100.24" "192.168.100.219" "192.168.101.178" "192.168.101.244")

echo "--- Pornire operatiune GATHER ---"

for IP in "${NEPOTI[@]}"; do
    echo "[Gather] Colectare de la $IP..."
    NUME_FISIER=$(basename "$CALE_REMOTE")
    
    # Copiem fisierul si il redenumim cu IP-ul sursei pentru a nu suprascrie
    scp -q "student@$IP:$CALE_REMOTE" "$DIR_LOCAL/${NUME_FISIER}_${IP}"
done

echo "--- Colectare finalizata in $DIR_LOCAL ---"
