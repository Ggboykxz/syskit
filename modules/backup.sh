#!/bin/bash
# ============================================================
# Module : backup.sh
# Description : Sauvegarde un dossier dans une archive .tar
# Commande : ./syskit.sh backup /chemin/dossier
# ============================================================

# Dossier de sauvegarde
BACKUP_DIR="$(dirname "$0")/../backup"

# Créer le dossier s'il n'existe pas
mkdir -p "$BACKUP_DIR"

# Récupérer le dossier source passé en argument
DOSSIER_SOURCE=$1

echo ""
echo "================================================"
echo "        SAUVEGARDE DE DOSSIER"
echo "================================================"
echo ""

# Récupérer le nom du dossier
NOM_DOSSIER=$(basename "$DOSSIER_SOURCE")

# Récupérer la date du jour
DATE=$(date '+%Y-%m-%d')

# Nom de l'archive avec la date
NOM_ARCHIVE="${NOM_DOSSIER}_${DATE}.tar"

# Chemin complet
ARCHIVE_COMPLETE="$BACKUP_DIR/$NOM_ARCHIVE"

# Vérifier que le dossier source existe
if [ ! -d "$DOSSIER_SOURCE" ]; then
    echo "[ERREUR] Le dossier '$DOSSIER_SOURCE' n'existe pas."
    echo "Veuillez verifier le chemin et reessayer."
    exit 1
    # Vérifier que le dossier source existe
    # if [ ! -d "$DOSSIER_SOURCE" ]; then
    #     echo "[ERREUR] Le dossier '$DOSSIER_SOURCE' n'existe pas."
    #         echo "Veuillez verifier le chemin et reessayer."
    #             exit 1
    #             fi
fi
echo "  Dossier source  : $DOSSIER_SOURCE"
echo "  Fichier archive : $NOM_ARCHIVE"
echo ""

# Création de l'archive
tar -cf "$ARCHIVE_COMPLETE" -C "$(dirname "$DOSSIER_SOURCE")" "$NOM_DOSSIER" 2>/dev/null

echo "  Sauvegarde terminee : $NOM_ARCHIVE"
echo ""
