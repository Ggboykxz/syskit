#!/bin/bash
# ============================================================
# SysKit - Outil d'administration Linux
# Projet DUT-1 CI - CUK de Koulamoutou
# ============================================================

# Chemin vers les modules
MODULES_DIR="$(dirname "$0")/modules"

# Fonction : afficher l'aide
afficher_aide() {
    echo "================================================"
    echo "   SysKit - Outil d'administration Linux"
    echo "================================================"
    echo ""
    echo "Utilisation : ./syskit.sh <commande> [option]"
    echo ""
    echo "Commandes disponibles :"
    echo "  inventory            Affiche les informations systeme"
    echo "  backup <dossier>     Sauvegarde un dossier"
    echo "  cleanup <chemin>     Supprime les fichiers inutiles"
    echo "  report               Genere un rapport systeme"
    echo "  help                 Affiche cette aide"
    echo ""
    echo "Exemples :"
    echo "  ./syskit.sh inventory"
    echo "  ./syskit.sh backup /home/utilisateur/documents"
    echo "  ./syskit.sh cleanup /home/utilisateur/temp"
    echo "  ./syskit.sh report"
    echo "================================================"
}

# Vérification qu'une commande est fournie
if [ $# -eq 0 ]; then
    echo "[ERREUR] Aucune commande fournie."
    echo ""
    afficher_aide
    exit 1
fi

# Lecture de la commande passée en argument
COMMANDE=$1

# Sélection du module à exécuter
case $COMMANDE in
    inventory)
        bash "$MODULES_DIR/inventory.sh"
        ;;
    backup)
        if [ -z "$2" ]; then
            echo "[ERREUR] Veuillez indiquer le dossier a sauvegarder."
            echo "Exemple : ./syskit.sh backup /chemin/dossier"
            exit 1
        fi
        bash "$MODULES_DIR/backup.sh" "$2"
        ;;
    cleanup)
        if [ -z "$2" ]; then
            echo "[ERREUR] Veuillez indiquer le chemin a nettoyer."
            echo "Exemple : ./syskit.sh cleanup /chemin"
            exit 1
        fi
        bash "$MODULES_DIR/cleanup.sh" "$2"
        ;;
    report)
        bash "$MODULES_DIR/report.sh"
        ;;
    help|--help|-h)
        afficher_aide
        ;;
    *)
        echo "[ERREUR] Commande inconnue : '$COMMANDE'"
        echo ""
        afficher_aide
        exit 1
        ;;
esac

