# Guide des Brands

Documentation complète sur les 4 brands supportés par EAE Prism.

## Vue d'ensemble

EAE Prism supporte 4 brands de dating différents, chacun avec sa propre identité visuelle et ses fonctionnalités spécifiques.

```
┌─────────────────────────────────────────────────────────┐
│                    EAE Prism Brands                     │
├─────────────────────────────────────────────────────────┤
│  Match     │  Meetic    │  OKCupid   │  Plenty of Fish │
│  🔴 Rouge  │  💜 Violet │  🔵 Bleu   │  🟠 Orange      │
└─────────────────────────────────────────────────────────┘
```

## Match

### Identité
- **Nom**: Match
- **ID**: `match`
- **Tagline**: "Find your perfect match"
- **Personnalité**: Bold, passionate, confident

### Couleurs

```
Primary:    #D6002F (Rouge vif)
Secondary:  #FF6B6B (Rose corail)
Background: #FFFFFF (Blanc)
Surface:    #F8F8F8 (Gris très clair)
```

### Palette Visuelle

```
████████  Primary Color - Rouge Match (#D6002F)
████████  Secondary Color - Corail (#FF6B6B)
████████  Surface - Gris clair (#F8F8F8)
```

### Fonctionnalités

- ✅ Messaging (Messagerie)
- ✅ Likes (J'aime)
- ✅ Super-Likes (Super J'aime)
- ✅ Boost (Mise en avant)

### Utilisation dans le Code

```dart
// Flutter
const brand = Brand.match;
final theme = BrandTheme.getTheme(Brand.match);
```

```bash
# API
curl http://localhost:3000/api/brands/match
```

---

## Meetic

### Identité
- **Nom**: Meetic
- **ID**: `meetic`
- **Tagline**: "Rencontrez des célibataires"
- **Personnalité**: Modern, sophisticated, European

### Couleurs

```
Primary:    #6C5CE7 (Violet profond)
Secondary:  #A29BFE (Lavande)
Background: #FFFFFF (Blanc)
Surface:    #F5F4F9 (Gris lavande)
```

### Palette Visuelle

```
████████  Primary Color - Violet Meetic (#6C5CE7)
████████  Secondary Color - Lavande (#A29BFE)
████████  Surface - Gris lavande (#F5F4F9)
```

### Fonctionnalités

- ✅ Messaging (Messagerie)
- ✅ Likes (J'aime)
- ✅ Events (Événements)
- ✅ Boost (Mise en avant)

### Utilisation dans le Code

```dart
// Flutter
const brand = Brand.meetic;
final theme = BrandTheme.getTheme(Brand.meetic);
```

```bash
# API
curl http://localhost:3000/api/brands/meetic
```

---

## OKCupid

### Identité
- **Nom**: OKCupid
- **ID**: `okc`
- **Tagline**: "Be yourself"
- **Personnalité**: Fresh, friendly, inclusive

### Couleurs

```
Primary:    #00A8E8 (Bleu cyan)
Secondary:  #00D9FF (Turquoise)
Background: #FFFFFF (Blanc)
Surface:    #F0F9FF (Bleu très clair)
```

### Palette Visuelle

```
████████  Primary Color - Bleu OKC (#00A8E8)
████████  Secondary Color - Turquoise (#00D9FF)
████████  Surface - Bleu pâle (#F0F9FF)
```

### Fonctionnalités

- ✅ Messaging (Messagerie)
- ✅ Likes (J'aime)
- ✅ Questions (Questions de compatibilité)
- ✅ Personality Match (Match de personnalité)

### Utilisation dans le Code

```dart
// Flutter
const brand = Brand.okc;
final theme = BrandTheme.getTheme(Brand.okc);
```

```bash
# API
curl http://localhost:3000/api/brands/okc
```

---

## Plenty of Fish

### Identité
- **Nom**: Plenty of Fish
- **ID**: `pof`
- **Tagline**: "Plenty of connections"
- **Personnalité**: Warm, inviting, casual

### Couleurs

```
Primary:    #FF6B35 (Orange chaleureux)
Secondary:  #4ECDC4 (Turquoise doux)
Background: #FFFFFF (Blanc)
Surface:    #FFF5F0 (Pêche très clair)
```

### Palette Visuelle

```
████████  Primary Color - Orange POF (#FF6B35)
████████  Secondary Color - Turquoise (#4ECDC4)
████████  Surface - Pêche pâle (#FFF5F0)
```

### Fonctionnalités

- ✅ Messaging (Messagerie)
- ✅ Likes (J'aime)
- ✅ Meet Me (Rencontre Rapide)
- ✅ Live Streams (Streams en direct)

### Utilisation dans le Code

```dart
// Flutter
const brand = Brand.okc;
final theme = BrandTheme.getTheme(Brand.pof);
```

```bash
# API
curl http://localhost:3000/api/brands/pof
```

---

## Comparaison des Brands

### Tableau Comparatif

| Caractéristique | Match | Meetic | OKCupid | Plenty of Fish |
|----------------|-------|--------|---------|----------------|
| **Couleur principale** | 🔴 Rouge | 💜 Violet | 🔵 Bleu | 🟠 Orange |
| **Marché principal** | US/Global | Europe | US/Global | US/Canada |
| **Style** | Bold | Sophisticated | Fresh | Casual |
| **Messaging** | ✅ | ✅ | ✅ | ✅ |
| **Likes** | ✅ | ✅ | ✅ | ✅ |
| **Super-Likes** | ✅ | ❌ | ❌ | ❌ |
| **Events** | ❌ | ✅ | ❌ | ❌ |
| **Questions** | ❌ | ❌ | ✅ | ❌ |
| **Live Streams** | ❌ | ❌ | ❌ | ✅ |
| **Boost** | ✅ | ✅ | ❌ | ❌ |

### Codes Couleur Hex

```
Brand           Primary     Secondary   Surface
─────────────────────────────────────────────────
Match           #D6002F     #FF6B6B     #F8F8F8
Meetic          #6C5CE7     #A29BFE     #F5F4F9
OKCupid         #00A8E8     #00D9FF     #F0F9FF
Plenty of Fish  #FF6B35     #4ECDC4     #FFF5F0
```

## Changer de Brand

### Dans Flutter App

**Méthode 1: Éditer le code**

```dart
// apps/client/lib/main.dart
void main() {
  const brand = Brand.match; // Changer ici
  runApp(MyApp(brand: brand));
}
```

**Méthode 2: Dynamic (pour production)**

```dart
// apps/client/lib/main.dart
import 'dart:io';

void main() {
  // Lire depuis variable d'environnement
  final brandId = Platform.environment['BRAND'] ?? 'match';
  final brand = _parseBrand(brandId);
  runApp(MyApp(brand: brand));
}

Brand _parseBrand(String id) {
  switch (id) {
    case 'meetic': return Brand.meetic;
    case 'okc': return Brand.okc;
    case 'pof': return Brand.pof;
    default: return Brand.match;
  }
}
```

### Dans Widgetbook

Utilisez simplement le sélecteur de thème dans l'interface Widgetbook :

1. Lancez `flutter run` dans `packages/widgetbook_app`
2. Cliquez sur l'icône de thème dans la barre d'outils
3. Sélectionnez le brand désiré
4. Les composants se mettent à jour instantanément

### Via l'API Backend

```bash
# Récupérer la configuration d'un brand
curl http://localhost:3000/api/brands/match
curl http://localhost:3000/api/brands/meetic
curl http://localhost:3000/api/brands/okc
curl http://localhost:3000/api/brands/pof
```

## Ajouter un Nouveau Brand

### Étape 1: Design System

```dart
// packages/design_system/lib/src/theme/brand_colors.dart

enum Brand {
  match,
  meetic,
  okc,
  pof,
  newbrand, // Ajouter ici
}

class BrandColors {
  // Ajouter les couleurs
  static const newbrandPrimary = Color(0xFF123456);
  static const newbrandSecondary = Color(0xFF789ABC);
  static const newbrandBackground = Color(0xFFFFFFFF);
  static const newbrandSurface = Color(0xFFF5F5F5);

  static Color getPrimaryColor(Brand brand) {
    switch (brand) {
      // ... autres cases
      case Brand.newbrand:
        return newbrandPrimary;
    }
  }
  
  // Répéter pour les autres getters
}
```

### Étape 2: Theme

```dart
// packages/design_system/lib/src/theme/brand_theme.dart

static String getBrandName(Brand brand) {
  switch (brand) {
    // ... autres cases
    case Brand.newbrand:
      return 'New Brand';
  }
}
```

### Étape 3: Backend

```typescript
// apps/backend/src/types/brand.types.ts
export type Brand = 'match' | 'meetic' | 'okc' | 'pof' | 'newbrand';

// apps/backend/src/routes/brand.routes.ts
const brandConfigs: Record<Brand, BrandConfig> = {
  // ... autres brands
  newbrand: {
    id: 'newbrand',
    name: 'New Brand',
    primaryColor: '#123456',
    secondaryColor: '#789ABC',
    backgroundColor: '#FFFFFF',
    surfaceColor: '#F5F5F5',
    features: ['messaging', 'likes'],
    apiEndpoints: {
      base: 'https://api.newbrand.com',
      auth: '/v1/auth',
      profiles: '/v1/profiles',
    },
  },
};
```

### Étape 4: Widgetbook

```dart
// packages/widgetbook_app/lib/main.dart

addons: [
  MaterialThemeAddon(
    themes: [
      // ... autres thèmes
      WidgetbookTheme(
        name: 'New Brand',
        data: BrandTheme.getTheme(Brand.newbrand),
      ),
    ],
  ),
],
```

### Étape 5: Test

```bash
# Lancer l'app avec le nouveau brand
cd apps/client
# Éditer main.dart: const brand = Brand.newbrand;
flutter run

# Tester l'API
curl http://localhost:3000/api/brands/newbrand

# Vérifier dans Widgetbook
cd packages/widgetbook_app
flutter run
```

## Guidelines de Design

### Principes pour Chaque Brand

1. **Cohérence**: Utilisez toujours les couleurs définies
2. **Contraste**: Assurez-vous d'un bon contraste (WCAG AA minimum)
3. **Accessibilité**: Testez avec différentes tailles de texte
4. **Responsive**: Adaptez les designs à différentes tailles d'écran

### Utilisation des Couleurs

```dart
// ✅ Bon - Utilise le thème
Container(
  color: theme.colorScheme.primary,
  child: Text('Hello', style: TextStyle(color: theme.colorScheme.onPrimary)),
)

// ❌ Mauvais - Hardcode la couleur
Container(
  color: Color(0xFFD6002F),
  child: Text('Hello', style: TextStyle(color: Colors.white)),
)
```

### Composants Brand-Agnostic

Tous les composants du design system doivent :
- Utiliser les couleurs du thème
- S'adapter automatiquement au brand
- Maintenir une UX cohérente entre les brands

## Ressources

### Fichiers Clés

- `packages/design_system/lib/src/theme/brand_colors.dart` - Définitions des couleurs
- `packages/design_system/lib/src/theme/brand_theme.dart` - Configuration des thèmes
- `apps/backend/src/routes/brand.routes.ts` - Configuration backend des brands

### API Endpoints

```
GET /api/brands                          - Liste tous les brands
GET /api/brands/:brandId                 - Configuration complète
GET /api/brands/:brandId/theme           - Couleurs du thème
GET /api/brands/:brandId/features        - Fonctionnalités disponibles
GET /api/brands/:brandId/features/:name  - Vérifier une fonctionnalité
```

### Tests Multi-Brand

Assurez-vous de tester chaque composant avec tous les brands :

```bash
# Script de test (exemple)
for brand in match meetic okc pof; do
  echo "Testing $brand..."
  # Lancer tests avec le brand
done
```

## FAQ

**Q: Puis-je utiliser plusieurs brands dans la même app ?**  
R: Oui, mais vous devez gérer le switch de thème dynamiquement.

**Q: Comment ajouter une couleur custom à un brand ?**  
R: Ajoutez-la dans `BrandColors` et mettez à jour les getters.

**Q: Les brands peuvent-ils avoir des composants différents ?**  
R: Oui, utilisez des conditions basées sur `Brand` dans vos widgets.

**Q: Comment gérer le dark mode ?**  
R: Créez un `BrandTheme.getDarkTheme(Brand)` avec des couleurs adaptées.

**Q: Peut-on avoir des logos différents par brand ?**  
R: Oui, stockez les assets par brand et chargez-les dynamiquement.

