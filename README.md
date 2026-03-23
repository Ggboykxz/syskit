# SysKit - Outil d'administration Linux

## Description

SysKit est un outil d'administration Linux écrit en Bash.  
Il permet d'automatiser des tâches courantes sur un système Linux.

Ce projet a été réalisé dans le cadre du cours de **Programmation Shell**  
pour les étudiants de **DUT-1 CI** du **CUK de Koulamoutou**.

---

## Membres du groupe

| Nom               | Rôle                          |
|-------------------|-------------------------------|
| SEPH POATY        | Script principal + Inventory  |
| ONTOUNGA        | Module Backup                 |
| CHINYCOTITA        | Module Cleanup + Report       |

---

## Structure du projet

```
syskit/
│
├── README.md           <- Ce fichier
├── syskit.sh           <- Script principal
│
├── modules/
│   ├── inventory.sh    <- Informations système
│   ├── backup.sh       <- Sauvegarde de dossier
│   ├── cleanup.sh      <- Nettoyage de fichiers
│   └── report.sh       <- Génération de rapport
│
├── logs/               <- Fichiers journaux
├── backup/             <- Dossier des archives
├── reports/            <- Rapports générés
└── docs/
    └── rapport_final.pdf
```

---

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/<votre-groupe>/syskit.git
cd syskit
```

### 2. Donner les permissions d'exécution

```bash
chmod +x syskit.sh
chmod +x modules/*.sh
```

---

## Utilisation

### Afficher l'aide

```bash
./syskit.sh help
```

### 1. Inventaire système

Affiche les informations du système (OS, noyau, CPU, RAM, disque, IP).

```bash
./syskit.sh inventory
```

### 2. Sauvegarde d'un dossier

Crée une archive `.tar` du dossier spécifié avec la date dans le nom.

```bash
./syskit.sh backup /chemin/vers/dossier
```

Exemple :
```bash
./syskit.sh backup /home/utilisateur/documents
```

Résultat : `backup/documents_2026-03-20.tar`

### 3. Nettoyage de fichiers

Supprime les fichiers `.tmp` et `.log` dans le dossier spécifié.

```bash
./syskit.sh cleanup /chemin/vers/dossier
```

Exemple :
```bash
./syskit.sh cleanup /home/utilisateur/temp
```

### 4. Génération d'un rapport

Génère un fichier `reports/report.txt` contenant :
- les informations système
- la liste des sauvegardes
- le nombre de fichiers supprimés
- l'historique des actions

```bash
./syskit.sh report
```

---

## Exemple de session complète

```bash
# 1. Voir les infos système
./syskit.sh inventory

# 2. Sauvegarder un dossier
./syskit.sh backup /home/user/projets

# 3. Nettoyer les fichiers inutiles
./syskit.sh cleanup /home/user/temp

# 4. Générer le rapport final
./syskit.sh report
```

---

## Technologies utilisées

- **Bash** - Langage de script
- **Git** - Gestion de version
- **GitHub** - Hébergement du code
- **Vim** - Éditeur de texte

---

## Date de rendu

**26 Mars 2026**

