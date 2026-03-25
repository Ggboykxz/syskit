#!/bin/bash
# ============================================================
# Module : report.sh
# Description : Génère un rapport système complet
# Commande : ./syskit.sh report
# ============================================================

# Dossiers
REPORTS_DIR="$(dirname "$0")/../reports"
RAPPORT_FILE="$REPORTS_DIR/report.txt"

# Créer le dossier s'il n'existe pas
mkdir -p "$REPORTS_DIR"

# Date et heure
DATE=$(date '+%Y-%m-%d')
HEURE=$(date '+%H:%M:%S')

echo ""
echo "================================================"
echo "        GENERATION DU RAPPORT"
echo "================================================"
echo ""
echo "Creation du rapport en cours..."

# Écriture du rapport
{
echo "================================================"
echo "   RAPPORT SYSKIT"
echo "   Date    : $DATE"
echo "   Heure   : $HEURE"
echo "================================================"
echo ""

# Section 1 : Informations système
echo "[ 1. INFORMATIONS SYSTEME ]"
echo "----------------------------"

OS=$(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)
if [ -z "$OS" ]; then
    OS=$(uname -s)
fi
echo "Systeme d'exploitation : $OS"

NOYAU=$(uname -r)
echo "Version du noyau       : $NOYAU"

IP=$(hostname -I 2>/dev/null | awk '{print $1}')
echo "Adresse IP             : $IP"
echo ""

echo "================================================"
echo "   Fin du rapport SysKit"
echo "================================================"

} > "$RAPPORT_FILE"

echo ""
echo "================================================"
echo "  Rapport genere : $RAPPORT_FILE"
echo "================================================"
echo ""
