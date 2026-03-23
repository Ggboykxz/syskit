#!/bin/bash
# ============================================================
# Module : inventory.sh
# Description : Affiche les informations du système
# Commande : ./syskit.sh inventory
# ============================================================

# Fichier de log
LOG_DIR="$(dirname "$0")/../logs"
LOG_FILE="$LOG_DIR/inventory.log"

# Créer le dossier logs s'il n'existe pas
mkdir -p "$LOG_DIR"

echo ""
echo "================================================"
echo "        INVENTAIRE DU SYSTEME"
echo "================================================"
echo ""

# --- Système d'exploitation ---
echo "[ Systeme d exploitation ]"
OS=$(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)
if [ -z "$OS" ]; then
    OS=$(uname -s)
fi
echo "  OS         : $OS"
echo ""

# --- Version du noyau Linux ---
echo "[ Noyau Linux ]"
NOYAU=$(uname -r)
echo "  Version    : $NOYAU"
echo ""

# --- Processeur ---
echo "[ Processeur ]"
CPU=$(grep "model name" /proc/cpuinfo 2>/dev/null | head -1 | cut -d':' -f2 | sed 's/^[ \t]*//')
if [ -z "$CPU" ]; then
    CPU="Information non disponible"
fi
echo "  CPU        : $CPU"
echo ""

# --- Mémoire RAM ---
echo "[ Memoire RAM ]"
# Utiliser une boucle pour afficher chaque ligne de free
while read -r ligne; do
    echo "  $ligne"
done < <(free -h 2>/dev/null | grep -E "Mem|Swap")
echo ""

# --- Espace disque ---
echo "[ Espace disque ]"
# Utiliser une boucle pour afficher les partitions
while read -r ligne; do
    echo "  $ligne"
done < <(df -h 2>/dev/null | grep -E "^/dev/|^Filesystem")
echo ""

# --- Adresse IP ---
echo "[ Adresse IP ]"
IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$IP" ]; then
    IP="Non disponible"
fi
echo "  IP locale  : $IP"
echo ""

echo "================================================"
echo "  Inventaire termine avec succes."
echo "================================================"
echo ""

# Enregistrement de l'action dans le fichier log
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$DATE] Inventaire systeme effectue - OS: $OS - IP: $IP" >> "$LOG_FILE"

