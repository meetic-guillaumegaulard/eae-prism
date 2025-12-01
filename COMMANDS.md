# Commandes Utiles

Guide de référence rapide pour toutes les commandes du projet EAE Prism.

## Installation

### Installation Complète

```bash
# Backend
cd apps/backend
bun install
cd ../..

# Design System
cd packages/design_system
flutter pub get
cd ../..

# Widgetbook
cd packages/widgetbook_app
flutter pub get
cd ../..

# Flutter App
cd apps/client
flutter pub get
cd ../..
```

### Installation avec Nx (optionnel)

```bash
# Installer Nx globalement
npm install -g nx

# Installer toutes les dépendances
nx run eae-prism:install:all
```

## Lancement des Applications

### Backend (Elysia)

```bash
# Mode développement (avec hot reload)
cd apps/backend
bun run dev

# Mode production
bun run start

# Builder
bun run build
```

### Flutter App

```bash
cd apps/client

# Lancer sur un device connecté
flutter run

# Lister les devices disponibles
flutter devices

# Lancer sur un device spécifique
flutter run -d <device-id>

# Mode release
flutter run --release

# Mode web
flutter run -d chrome
```

### Widgetbook

```bash
cd packages/widgetbook_app

# Lancer Widgetbook
flutter run

# Lancer sur web
flutter run -d chrome
```

## Développement

### Flutter

```bash
# Hot reload (dans le terminal Flutter)
r

# Hot restart
R

# Ouvrir DevTools
o

# Quitter
q

# Analyser le code
flutter analyze

# Formater le code
flutter format .

# Tester
flutter test

# Nettoyer le build
flutter clean

# Obtenir les dépendances
flutter pub get

# Mettre à jour les dépendances
flutter pub upgrade
```

### Backend

```bash
cd apps/backend

# Lancer en mode dev
bun run dev

# Tester l'API
curl http://localhost:3000
curl http://localhost:3000/api/brands
curl http://localhost:3000/api/brands/match
curl http://localhost:3000/health

# Installer une dépendance
bun add <package-name>

# Installer une dépendance de dev
bun add -d <package-name>

# Supprimer une dépendance
bun remove <package-name>
```

## Tests

### Flutter Tests

```bash
# Tous les tests
cd apps/client
flutter test

# Tests avec coverage
flutter test --coverage

# Test spécifique
flutter test test/widget_test.dart

# Tests en mode verbose
flutter test --verbose
```

### Backend Tests (quand implémentés)

```bash
cd apps/backend

# Lancer les tests
bun test

# Tests avec coverage
bun test --coverage

# Tests en mode watch
bun test --watch
```

## Build

### Flutter (Production)

```bash
cd apps/client

# Build Android APK
flutter build apk

# Build Android App Bundle
flutter build appbundle

# Build iOS (nécessite macOS)
flutter build ios

# Build Web
flutter build web

# Build avec configuration spécifique
flutter build apk --release --target-platform android-arm64
```

### Backend (Production)

```bash
cd apps/backend

# Builder
bun build src/index.ts --outdir=dist --target=bun

# Lancer le build
cd dist
bun index.js
```

## Nx Commands

```bash
# Afficher le graphe de dépendances
nx graph

# Lancer une tâche
nx run <project>:<target>

# Exemples
nx run eae-prism:flutter-app:run
nx run eae-prism:backend:dev
nx run eae-prism:widgetbook:run

# Lancer les tests affectés (après changement)
nx affected:test

# Builder les projets affectés
nx affected:build

# Réinitialiser le cache
nx reset
```

## Git

```bash
# Cloner le repo
git clone <repository-url>
cd eae-prism

# Créer une branche
git checkout -b feature/ma-fonctionnalite

# Voir le statut
git status

# Ajouter des fichiers
git add .

# Commit
git commit -m "feat: ajouter nouveau composant"

# Push
git push origin feature/ma-fonctionnalite

# Pull les derniers changements
git pull origin main

# Voir les branches
git branch -a

# Changer de branche
git checkout main
```

## Gestion des Brands

### Changer le Brand dans Flutter App

```bash
# Éditer le fichier
nano apps/client/lib/main.dart

# Ou avec votre éditeur préféré
code apps/client/lib/main.dart

# Modifier la ligne:
# const brand = Brand.match;  // match, meetic, okc, pof
```

### Tester tous les Brands

```dart
// Dans apps/client/lib/main.dart
void main() {
  // Tester avec chaque brand
  const brands = [Brand.match, Brand.meetic, Brand.okc, Brand.pof];
  
  for (var brand in brands) {
    print('Testing ${BrandTheme.getBrandName(brand)}');
    runApp(MyApp(brand: brand));
    break; // Enlever pour tester automatiquement
  }
}
```

## API Testing

### Avec curl

```bash
# Santé du serveur
curl http://localhost:3000/health

# Liste des brands
curl http://localhost:3000/api/brands

# Configuration d'un brand
curl http://localhost:3000/api/brands/match

# Thème d'un brand
curl http://localhost:3000/api/brands/match/theme

# Features d'un brand
curl http://localhost:3000/api/brands/okc/features

# Vérifier une feature spécifique
curl http://localhost:3000/api/brands/meetic/features/messaging
```

### Avec httpie (plus lisible)

```bash
# Installer httpie
brew install httpie  # macOS
# ou
apt install httpie  # Ubuntu

# Utilisation
http GET localhost:3000/api/brands
http GET localhost:3000/api/brands/match/theme
http GET localhost:3000/api/brands/pof/features
```

## Debug

### Flutter DevTools

```bash
# Ouvrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Ou depuis l'app en cours d'exécution
# Taper 'o' dans le terminal Flutter
```

### Backend Debug

```bash
# Lancer avec logs détaillés
cd apps/backend
DEBUG=* bun run dev

# Ou avec bun en mode debug
bun --inspect src/index.ts
```

## Maintenance

### Nettoyage

```bash
# Nettoyer Flutter
cd apps/client
flutter clean
flutter pub get

# Nettoyer Backend
cd apps/backend
rm -rf node_modules
rm -rf dist
bun install

# Nettoyer tout (depuis la racine)
find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
find . -name "build" -type d -prune -exec rm -rf '{}' +
find . -name ".dart_tool" -type d -prune -exec rm -rf '{}' +
```

### Mise à jour des Dépendances

```bash
# Flutter
cd apps/client
flutter pub upgrade
flutter pub outdated

# Backend
cd apps/backend
bun update
bun outdated
```

## VS Code

### Ouvrir le Workspace

```bash
# Ouvrir avec VS Code
code .

# Ou ouvrir un projet spécifique
code apps/client
code apps/backend
```

### Commandes VS Code

- `Cmd/Ctrl + Shift + P` - Command Palette
- `F5` - Lancer le debugger
- `Shift + F5` - Arrêter le debugger
- `Cmd/Ctrl + K, Cmd/Ctrl + S` - Keyboard Shortcuts

### Extensions Recommandées

Les extensions recommandées sont dans `.vscode/extensions.json`:
- Dart
- Flutter
- Prettier
- ESLint
- Nx Console

## Raccourcis Pratiques

### Tout démarrer rapidement

```bash
# Terminal 1 - Backend
cd apps/backend && bun run dev

# Terminal 2 - Flutter App
cd apps/client && flutter run

# Terminal 3 (optionnel) - Widgetbook
cd packages/widgetbook_app && flutter run
```

### Script pour tout installer

```bash
#!/bin/bash
# save as: install-all.sh

echo "Installing backend..."
cd apps/backend && bun install && cd ../..

echo "Installing design_system..."
cd packages/design_system && flutter pub get && cd ../..

echo "Installing widgetbook..."
cd packages/widgetbook_app && flutter pub get && cd ../..

echo "Installing flutter_app..."
cd apps/client && flutter pub get && cd ../..

echo "Done! ✅"
```

## Troubleshooting

### Flutter ne trouve pas le SDK

```bash
# Vérifier l'installation
which flutter
flutter doctor

# Configurer le PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### Bun command not found

```bash
# Installer Bun
curl -fsSL https://bun.sh/install | bash

# Ou avec Homebrew (macOS)
brew install oven-sh/bun/bun
```

### Port 3000 déjà utilisé

```bash
# Trouver le processus
lsof -i :3000

# Tuer le processus
kill -9 <PID>

# Ou changer le port dans apps/backend/src/index.ts
```

### Erreurs de dépendances Flutter

```bash
cd apps/client
flutter clean
flutter pub get
flutter pub upgrade
```

## Documentation

### Générer la doc

```bash
# Flutter (DartDoc)
cd packages/design_system
dart doc .

# TypeScript (TypeDoc)
cd apps/backend
npm install -g typedoc
typedoc src/
```

## Performance

### Analyser les performances Flutter

```bash
# Build profile
flutter build apk --profile

# Lancer en mode profile
flutter run --profile

# Analyser avec DevTools
flutter run --profile
# Puis ouvrir DevTools et aller dans Performance tab
```

### Mesurer la taille du bundle

```bash
# Flutter
flutter build apk --analyze-size

# Backend
bun build src/index.ts --minify
ls -lh dist/
```

## Commandes Rapides

```bash
# Développement rapide
alias dev-backend="cd apps/backend && bun run dev"
alias dev-flutter="cd apps/client && flutter run"
alias dev-widgetbook="cd packages/widgetbook_app && flutter run"

# Tests rapides
alias test-flutter="cd apps/client && flutter test"
alias test-backend="cd apps/backend && bun test"

# Formatage
alias fmt-flutter="flutter format ."
alias fmt-backend="cd apps/backend && bunx prettier --write ."
```

Ajoutez ces alias dans votre `~/.zshrc` ou `~/.bashrc` !

## Ressources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Elysia Docs](https://elysiajs.com)
- [Bun Docs](https://bun.sh/docs)
- [Widgetbook Docs](https://docs.widgetbook.io)
- [Nx Docs](https://nx.dev)

