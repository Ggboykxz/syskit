#!/bin/bash
# ============================================================
# Module : backup.sh
# Description : Sauvegarde un dossier dans une archive .tar
# Commande : ./syskit.sh backup /chemin/dossier
# ============================================================

# Dossier de sauvegarde
BACKUP_DIR="$(dirname "$0")/../backup"
LOG_DIR="$(dirname "$0")/../logs"
LOG_FILE="$LOG_DIR/backup.log"

# Créer le dossier logs s'il n'existe pas
mkdir -p "$LOG_DIR"

# Créer le dossier backup/ s'il n'existe pas
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "  Dossier backup/ cree automatiquement."
fi
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

# Vérifier si la création a réussi
if [ $? -eq 0 ]; then
    TAILLE=$(du -sh "$ARCHIVE_COMPLETE" 2>/dev/null | cut -f1)
    echo ""
    echo "================================================"
    echo "  Sauvegarde reussie !"
    echo "  Archive : $NOM_ARCHIVE"
    echo "  Taille  : $TAILLE"
    echo "================================================"
    # Enregistrement dans le log
    DATE_LOG=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$DATE_LOG] Backup OK - Source: $DOSSIER_SOURCE - Archive: $NOM_ARCHIVE - Taille: $TAILLE" >> "$LOG_FILE"
    echo ""
else
    echo ""
    echo "[ERREUR] La sauvegarde a echoue."
    # Enregistrement de l'erreur dans le log
    DATE_LOG=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$DATE_LOG] Backup ECHEC - Source: $DOSSIER_SOURCE" >> "$LOG_FILE"
    echo ""
    exit 1
fi
