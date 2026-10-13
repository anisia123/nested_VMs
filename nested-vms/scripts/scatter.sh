#!/bin/bash
# Utilizare: ./scatter.sh <fisier_local> <cale_destinatie>

FISIER_SURSA=$1
DESTINATIE=$2

if [ -z "$FISIER_SURSA" ] || [ -z "$DESTINATIE" ]; then
    echo "Utilizare: ./scatter.sh <fisier> <cale_absoluta_destinatie>"
    exit 1
fi

# Definim structura arborelui tau
# Format: "IP_PARINTE|IP_COPIL1 IP_COPIL2 ..."
declare -A ARBORE
ARBORE["192.168.123.191"]="192.168.100.24 192.168.100.219" # vm1 si copiii sai
ARBORE["192.168.123.37"]="192.168.101.178 192.168.101.244"  # vm2 si copiii sai

echo "--- Pornire operatiune SCATTER ---"

# Iteram prin parinti (VM1, VM2)
for PARINTE in "${!ARBORE[@]}"; do
    COPII=${ARBORE[$PARINTE]}
    
    echo "[MASTER -> $PARINTE] Transfer fisier catre parinte..."
    # Pas 1: Trimitem fisierul pe masina parinte (intermediar)
    scp -q "$FISIER_SURSA" student@$PARINTE:~/temp_scatter_file
    
    # Pas 2: Instruim parintele sa distribuie fisierul catre copiii sai
    for COPIL in $COPII; do
        echo "    [$PARINTE -> $COPIL] Distribuire..."
        ssh -q student@$PARINTE "scp ~/temp_scatter_file student@$COPIL:$DESTINATIE"
    done
    
    # Curatenie pe parinte
    ssh -q student@$PARINTE "rm ~/temp_scatter_file"
done

echo "--- Scatter finalizat ---"
