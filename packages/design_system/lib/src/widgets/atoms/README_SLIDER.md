# SliderEAE Component

Un composant atom de type slider qui gère uniquement des nombres entiers avec support pour une valeur unique ou une plage de valeurs (range).

## Caractéristiques

- ✅ Gère uniquement des nombres entiers
- ✅ Valeur minimale et maximale configurables
- ✅ Deux modes : valeur unique ou range (2 valeurs)
- ✅ Labels personnalisables
- ✅ Style adaptatif selon le brand
- ✅ Support de toutes les marques (Match, Meetic, OKCupid, POF)

## Modes d'utilisation

### Mode Single (Valeur unique)

Utilisez le constructeur `SliderEAE.single()` pour créer un slider avec une seule valeur.

```dart
SliderEAE.single(
  minValue: 0,
  maxValue: 100,
  initialValue: 50,
  label: 'Sélectionnez une valeur',
  onChanged: (value) {
    print('Valeur sélectionnée: $value');
  },
)
```

### Mode Range (Plage de valeurs)

Utilisez le constructeur `SliderEAE.range()` pour créer un slider avec une plage de valeurs.

```dart
SliderEAE.range(
  minValue: 18,
  maxValue: 80,
  initialRange: RangeValues(25, 50),
  label: 'Sélectionnez une plage d\'âge',
  onRangeChanged: (values) {
    print('Plage sélectionnée: ${values.start.round()} - ${values.end.round()}');
  },
)
```

## Paramètres

### Paramètres communs

| Paramètre | Type | Obligatoire | Description |
|-----------|------|-------------|-------------|
| `minValue` | `int` | ✅ | Valeur minimale du slider |
| `maxValue` | `int` | ✅ | Valeur maximale du slider |
| `showLabels` | `bool` | ❌ | Affiche la valeur courante (défaut: `true`) |
| `label` | `String?` | ❌ | Label affiché au-dessus du slider |
| `showMinMaxLabels` | `bool` | ❌ | Affiche les valeurs min/max (défaut: `true`) |

### Paramètres spécifiques au mode Single

| Paramètre | Type | Description |
|-----------|------|-------------|
| `initialValue` | `int?` | Valeur initiale (défaut: `minValue`) |
| `onChanged` | `ValueChanged<int>?` | Callback appelé lors du changement de valeur |

### Paramètres spécifiques au mode Range

| Paramètre | Type | Description |
|-----------|------|-------------|
| `initialRange` | `RangeValues?` | Plage initiale (défaut: `minValue` à `maxValue`) |
| `onRangeChanged` | `ValueChanged<RangeValues>?` | Callback appelé lors du changement de plage |

## Exemples d'utilisation

### Sélecteur d'âge simple

```dart
int age = 25;

SliderEAE.single(
  minValue: 18,
  maxValue: 99,
  initialValue: age,
  label: 'Votre âge',
  onChanged: (value) {
    setState(() {
      age = value;
    });
  },
)
```

### Sélecteur de plage d'âge

```dart
RangeValues ageRange = RangeValues(25, 35);

SliderEAE.range(
  minValue: 18,
  maxValue: 99,
  initialRange: ageRange,
  label: 'Plage d\'âge recherchée',
  onRangeChanged: (values) {
    setState(() {
      ageRange = values;
    });
  },
)
```

### Slider sans labels

```dart
SliderEAE.single(
  minValue: 0,
  maxValue: 100,
  initialValue: 50,
  showLabels: false,
  showMinMaxLabels: false,
  onChanged: (value) {
    // Gestion de la valeur
  },
)
```

## Configuration de brand

Le composant utilise la configuration `BrandSliderConfig` pour adapter son apparence à chaque marque.

### Propriétés configurables par brand

- `activeTrackColor` : Couleur de la piste active
- `inactiveTrackColor` : Couleur de la piste inactive
- `thumbColor` : Couleur du curseur
- `overlayColor` : Couleur de l'effet de survol
- `trackHeight` : Hauteur de la piste (défaut: 4.0)
- `thumbRadius` : Rayon du curseur (défaut: 10.0)
- `overlayRadius` : Rayon de l'effet de survol (défaut: 20.0)
- `thumbElevation` : Élévation (ombre) du curseur (défaut: 0.0)
- `thumbShadowColor` : Couleur de l'ombre du curseur (défaut: Colors.black26)
- `thumbBorderWidth` : Épaisseur de la bordure du curseur (défaut: 0.0)
- `thumbBorderColor` : Couleur de la bordure du curseur

Note: L'indicateur de valeur popup est désactivé par défaut.

### Exemples de configuration pour différents brands

#### Style avec ombre (Meetic, Match, OKCupid)

```dart
@override
BrandSliderConfig get sliderConfig => const BrandSliderConfig(
  activeTrackColor: Color(0xFFE9006D), // Couleur de la piste active
  inactiveTrackColor: Color(0xFFE0E0E0), // Couleur de la piste inactive
  thumbColor: Colors.white, // Curseurs blancs
  overlayColor: Color(0x1FE9006D), // Effet de clic semi-transparent
  trackHeight: 6.0,
  thumbRadius: 16.0, // Curseurs plus grands
  overlayRadius: 24.0,
  thumbElevation: 4.0, // Ombre sur les curseurs
  thumbShadowColor: Color(0x40000000), // Ombre grise
);
```

#### Style avec bordure (POF)

```dart
@override
BrandSliderConfig get sliderConfig => const BrandSliderConfig(
  activeTrackColor: Colors.black, // Piste active noire
  inactiveTrackColor: Color(0xFFE0E0E0), // Piste inactive grise
  thumbColor: Colors.white, // Curseur blanc
  overlayColor: Color(0x1F000000), // Noir transparent
  trackHeight: 6.0,
  thumbRadius: 16.0,
  overlayRadius: 24.0,
  thumbBorderWidth: 3.0, // Bordure épaisse style POF
  thumbBorderColor: Colors.black, // Bordure noire
);
```

## Notes importantes

- Les valeurs sont toujours des **nombres entiers** (int)
- Le slider utilise automatiquement le nombre de divisions approprié (maxValue - minValue)
- Les callbacks `onChanged` et `onRangeChanged` retournent des valeurs arrondies
- Le composant s'adapte automatiquement au thème et à la marque active

## Voir aussi

- Fichier d'exemples : `/apps/showroom/lib/usecases/slider_usecases.dart`
- Configuration des brands : `/packages/design_system/lib/src/brands/brand_config.dart`

