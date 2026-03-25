#!/bin/bash
# ============================================================
# Module : report.sh
# Description : Génère un rapport système complet
# Commande : ./syskit.sh report
# ============================================================

# Dossiers
REPORTS_DIR="$(dirname "$0")/../reports"
BACKUP_DIR="$(dirname "$0")/../backup"
LOG_DIR="$(dirname "$0")/../logs"
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
# Section 2 : Sauvegardes
echo "[ 2. SAUVEGARDES REALISEES ]"
echo "----------------------------"

NB_BACKUPS=0
if [ -d "$BACKUP_DIR" ]; then
    for archive in "$BACKUP_DIR"/*.tar; do
        if [ -f "$archive" ]; then
            NOM=$(basename "$archive")
            TAILLE=$(du -sh "$archive" 2>/dev/null | cut -f1)
            echo "  - $NOM  ($TAILLE)"
            NB_BACKUPS=$((NB_BACKUPS + 1))
        fi
    done
fi

if [ $NB_BACKUPS -eq 0 ]; then
    echo "  Aucune sauvegarde trouvee."
fi
echo "  Nombre total de sauvegardes : $NB_BACKUPS"
echo ""

# Section 3 : Fichiers supprimés
echo "[ 3. FICHIERS SUPPRIMES (dernier cleanup) ]"
echo "----------------------------"

FICHIER_SUPP="$LOG_DIR/derniere_suppression.txt"
if [ -f "$FICHIER_SUPP" ]; then
    NB_SUPP=$(cat "$FICHIER_SUPP")
    echo "  Fichiers supprimes lors du dernier cleanup : $NB_SUPP"
else
    echo "  Aucun cleanup effectue."
fi
echo ""
echo ""
