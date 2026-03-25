#!/bin/bash
# ============================================================
# Module : cleanup.sh
# Description : Supprime les fichiers inutiles (.tmp)
# Commande : ./syskit.sh cleanup /chemin
# ============================================================

# Récupérer le chemin passé en argument
CHEMIN=$1

echo ""
echo "================================================"
echo "        NETTOYAGE DE FICHIERS"
echo "================================================"
echo ""

# Vérifier que le chemin existe
if [ ! -d "$CHEMIN" ]; then
    echo "[ERREUR] Le dossier '$CHEMIN' n'existe pas."
    echo "Veuillez verifier le chemin et reessayer."
    exit 1
fi

echo "  Dossier cible : $CHEMIN"
echo ""

# Compteur
NB_TMP=0

# --- Suppression des fichiers .tmp ---
echo "Recherche des fichiers .tmp ..."
for fichier in $(find "$CHEMIN" -type f -name "*.tmp" 2>/dev/null); do
    echo "  Suppression : $fichier"
    rm -f "$fichier"
    NB_TMP=$((NB_TMP + 1))
done

if [ $NB_TMP -eq 0 ]; then
    echo "  Aucun fichier .tmp trouve."
fi
echo ""
echo "================================================"
# Compteur log
NB_LOG=0

# --- Suppression des fichiers .log ---
echo "Recherche des fichiers .log ..."
for fichier in $(find "$CHEMIN" -type f -name "*.log" 2>/dev/null); do
    echo "  Suppression : $fichier"
    rm -f "$fichier"
    NB_LOG=$((NB_LOG + 1))
done

if [ $NB_LOG -eq 0 ]; then
    echo "  Aucun fichier .log trouve."
fi
echo ""

# Calcul du total
NB_TOTAL=$((NB_TMP + NB_LOG))
echo "  Nettoyage termine !"
echo "  Fichiers .tmp supprimes : $NB_TMP"
echo "  Fichiers .log supprimes : $NB_LOG"
echo "  Total supprimes         : $NB_TOTAL"
echo "================================================"
echo ""
