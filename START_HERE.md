# 🚀 Commencez Ici !

Bienvenue dans **EAE Prism** - Un monorepo multi-brand avec Flutter et Elysia.

## ⚡ Démarrage Ultra-Rapide (5 minutes)

### 1️⃣ Installation

```bash
# Backend
cd apps/backend && bun install && cd ../..

# Flutter packages
cd packages/design_system && flutter pub get && cd ../..
cd packages/widgetbook_app && flutter pub get && cd ../..
cd apps/client && flutter pub get && cd ../..
```

### 2️⃣ Lancement

**Terminal 1 - Backend:**
```bash
cd apps/backend
bun run dev
```
✅ Backend disponible sur http://localhost:3000

**Terminal 2 - Flutter App:**
```bash
cd apps/client
flutter run
```
✅ App Flutter lancée avec le thème **Match** 🔴

**Terminal 3 (Optionnel) - Widgetbook:**
```bash
cd packages/widgetbook_app
flutter run
```
✅ Widgetbook pour explorer les composants

### 3️⃣ Testez !

L'app est lancée avec le brand **Match** par défaut.

## 🎨 Les 4 Brands

```
╔════════════════════════════════════════════════════════╗
║                    EAE PRISM BRANDS                    ║
╠════════════════════════════════════════════════════════╣
║                                                        ║
║  🔴 MATCH           💜 MEETIC                         ║
║  Rouge passionné    Violet sophistiqué                ║
║  #D6002F            #6C5CE7                           ║
║                                                        ║
║  🔵 OKCUPID         🟠 PLENTY OF FISH                 ║
║  Bleu frais         Orange chaleureux                 ║
║  #00A8E8            #FF6B35                           ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## 🔄 Changer de Brand

Éditez `apps/client/lib/main.dart` :

```dart
// Ligne 6
const brand = Brand.match;   // 🔴 Thème rouge
// const brand = Brand.meetic;  // 💜 Thème violet
// const brand = Brand.okc;     // 🔵 Thème bleu
// const brand = Brand.pof;     // 🟠 Thème orange
```

Puis appuyez sur `r` dans le terminal Flutter pour hot reload !

## 📦 Ce que vous avez

### ✅ App Flutter Multi-Brand
- 4 thèmes complets (Match, Meetic, OKC, POF)
- Composant BrandButton avec 3 variantes
- Page d'exemple avec tous les états
- Support hot reload

**Localisation:** `apps/client/`

### ✅ Design System
- Gestion des couleurs par brand
- Thèmes Material 3
- Composant BrandButton réutilisable
- Type-safe avec enum Brand

**Localisation:** `packages/design_system/`

### ✅ Widgetbook
- Showcase interactif des composants
- Switch de thème en temps réel
- Prévisualisation sur différents devices
- Tests d'accessibilité

**Localisation:** `packages/widgetbook_app/`

### ✅ Backend Elysia
- API RESTful avec TypeScript
- Configuration des brands
- Endpoints de thème et features
- Type-safe avec Elysia

**Localisation:** `apps/backend/`

## 📚 Documentation

| Fichier | Description |
|---------|-------------|
| [README.md](README.md) | Vue d'ensemble complète du projet |
| [QUICKSTART.md](QUICKSTART.md) | Guide de démarrage en 5 minutes |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Documentation de l'architecture |
| [BRANDS.md](BRANDS.md) | Guide complet des 4 brands |
| [EXAMPLES.md](EXAMPLES.md) | Exemples de code pratiques |
| [COMMANDS.md](COMMANDS.md) | Toutes les commandes utiles |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Guide de contribution |
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | Structure détaillée du projet |

## 🧪 Exemples Rapides

### Utiliser le Bouton dans Flutter

```dart
import 'package:design_system/design_system.dart';

BrandButton(
  label: 'Click Me',
  icon: Icons.favorite,
  onPressed: () {
    print('Button clicked!');
  },
  variant: BrandButtonVariant.primary,
  size: BrandButtonSize.large,
)
```

### Appeler l'API Backend

```bash
# Liste des brands
curl http://localhost:3000/api/brands

# Configuration Match
curl http://localhost:3000/api/brands/match

# Couleurs du thème Meetic
curl http://localhost:3000/api/brands/meetic/theme
```

## 🎯 Prochaines Étapes

### Développement

1. **Ajouter un nouveau composant**
   - Créer dans `packages/design_system/lib/src/widgets/`
   - Ajouter à Widgetbook
   - Utiliser dans l'app

2. **Créer une nouvelle page**
   - Ajouter dans `apps/client/lib/screens/`
   - Utiliser les composants du design system

3. **Ajouter une API endpoint**
   - Créer dans `apps/backend/src/routes/`
   - Enregistrer dans `index.ts`

### Explorer

- 🎨 Ouvrez Widgetbook pour voir tous les composants
- 🔧 Testez l'API avec curl ou Postman
- 📱 Changez de brand et voyez les différences
- 🌙 Ajoutez un mode dark (exercice)

## 🔗 Structure Visuelle

```
eae-prism/
│
├── 📱 apps/
│   ├── flutter_app/          ← App principale
│   └── backend/               ← API Elysia
│
└── 📦 packages/
    ├── design_system/         ← Composants réutilisables
    └── widgetbook_app/        ← Documentation interactive
```

## 🆘 Aide Rapide

### Problème: Flutter command not found
```bash
# Installer Flutter
https://flutter.dev/docs/get-started/install
```

### Problème: Bun command not found
```bash
# Installer Bun
curl -fsSL https://bun.sh/install | bash
```

### Problème: Port 3000 occupé
```bash
# Changer le port dans apps/backend/src/index.ts
.listen(3001)
```

### Hot reload ne marche pas
```bash
# Appuyez sur 'R' (majuscule) pour full restart
```

## 💡 Tips

- **VS Code**: Ouvrez le workspace avec `code .`
- **Extensions**: Installez Dart, Flutter, Prettier (voir `.vscode/extensions.json`)
- **Debug**: Utilisez F5 pour lancer le debugger
- **DevTools**: Tapez `o` dans le terminal Flutter

## 🎓 Apprendre Plus

### Flutter & Dart
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)

### Backend
- [Elysia Docs](https://elysiajs.com)
- [Bun Documentation](https://bun.sh/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

### Monorepo
- [Nx Documentation](https://nx.dev)
- [Widgetbook Docs](https://docs.widgetbook.io)

## ✨ Fonctionnalités Clés

### Composant BrandButton

✅ 3 variants (Primary, Secondary, Outline)  
✅ 3 tailles (Small, Medium, Large)  
✅ Avec/sans icônes  
✅ État de chargement  
✅ Pleine largeur  
✅ Désactivable  

### API Backend

✅ Type-safe avec TypeScript  
✅ Configuration par brand  
✅ Endpoints de thème  
✅ Feature flags  
✅ Health checks  

## 🚀 Commandes Essentielles

```bash
# Développement
cd apps/backend && bun run dev                    # Lancer backend
cd apps/client && flutter run                # Lancer app
cd packages/widgetbook_app && flutter run         # Lancer Widgetbook

# Tests
flutter test                                       # Tests Flutter
flutter analyze                                    # Analyser le code

# Build
flutter build apk                                  # Build Android
flutter build ios                                  # Build iOS
flutter build web                                  # Build Web

# Maintenance
flutter clean && flutter pub get                   # Nettoyer Flutter
rm -rf node_modules && bun install                 # Nettoyer Node
```

## 📊 Architecture

```
┌─────────────────────────────────────────────┐
│         USER INTERACTION                    │
│              ↓                              │
│  ┌──────────────────────┐                  │
│  │    Flutter App       │                  │
│  │  (Multi-Brand UI)    │←─────┐          │
│  └──────────┬───────────┘       │          │
│             │ uses               │          │
│             ↓                    │          │
│  ┌──────────────────────┐       │          │
│  │   Design System      │       │ API      │
│  │  - BrandButton       │       │ Calls    │
│  │  - Brand Themes      │       │          │
│  │  - Brand Colors      │       │          │
│  └──────────────────────┘       │          │
│             ↑                    │          │
│             │ showcased in       │          │
│  ┌──────────────────────┐       │          │
│  │    Widgetbook        │       │          │
│  │  (Documentation)     │       │          │
│  └──────────────────────┘       │          │
│                                  │          │
│                        ┌─────────┴───────┐  │
│                        │  Backend API    │  │
│                        │  (Elysia)       │  │
│                        │  Port: 3000     │  │
│                        └─────────────────┘  │
└─────────────────────────────────────────────┘
```

## 🎉 Vous êtes Prêt !

Vous avez maintenant :
- ✅ Un monorepo fonctionnel avec Nx
- ✅ Une app Flutter multi-brand
- ✅ Un design system réutilisable
- ✅ Un backend API type-safe
- ✅ Une documentation complète

**Bon développement ! 🚀**

---

💬 **Questions ?** Consultez [CONTRIBUTING.md](CONTRIBUTING.md) ou [EXAMPLES.md](EXAMPLES.md)

🐛 **Bug trouvé ?** Créez une issue avec les détails de reproduction

💡 **Nouvelle idée ?** Créez une branche et contribuez !

