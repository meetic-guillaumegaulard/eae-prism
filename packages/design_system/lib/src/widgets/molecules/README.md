# SelectableButtonGroupEAE

Un composant molecule qui gère un groupe de boutons sélectionnables (`SelectableButtonEAE`).

## Fonctionnalités

- **Gestion de la sélection** : Garde en mémoire quel bouton a été sélectionné
- **Événement de callback** : Notifie le parent lors d'un clic avec la valeur sélectionnée
- **Options principales** : Liste d'options à afficher par défaut
- **Options additionnelles** : Liste secondaire d'options qui peuvent être affichées/cachées
- **Affichage flexible** : Peut afficher les boutons en colonne ou en ligne
- **Alignement personnalisé** : Pour l'affichage en colonne, supporte l'alignement à gauche, à droite, ou en pleine largeur
- **Labels personnalisables** : Labels pour "Afficher plus" / "Afficher moins"
- **Support des icônes** : Chaque option peut avoir une icône

## Utilisation

### Exemple basique

```dart
SelectableButtonGroupEAE<String>(
  options: [
    SelectableButtonOption(label: 'Option 1', value: 'opt1'),
    SelectableButtonOption(label: 'Option 2', value: 'opt2'),
    SelectableButtonOption(label: 'Option 3', value: 'opt3'),
  ],
  selectedValue: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)
```

### Avec options additionnelles

```dart
SelectableButtonGroupEAE<String>(
  options: [
    SelectableButtonOption(label: 'Option 1', value: 'opt1'),
    SelectableButtonOption(label: 'Option 2', value: 'opt2'),
  ],
  additionalOptions: [
    SelectableButtonOption(label: 'Option 3', value: 'opt3'),
    SelectableButtonOption(label: 'Option 4', value: 'opt4'),
  ],
  selectedValue: selectedValue,
  showMoreLabel: 'Afficher plus',
  showLessLabel: 'Afficher moins',
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)
```

### Affichage en colonne avec alignement

```dart
// Aligné à gauche
SelectableButtonGroupEAE<String>(
  options: [...],
  axis: SelectableButtonGroupAxis.vertical,
  alignment: SelectableButtonGroupAlignment.start,
  onChanged: (value) { ... },
)

// Aligné à droite
SelectableButtonGroupEAE<String>(
  options: [...],
  axis: SelectableButtonGroupAxis.vertical,
  alignment: SelectableButtonGroupAlignment.end,
  onChanged: (value) { ... },
)

// Pleine largeur (par défaut)
SelectableButtonGroupEAE<String>(
  options: [...],
  axis: SelectableButtonGroupAxis.vertical,
  alignment: SelectableButtonGroupAlignment.stretch,
  onChanged: (value) { ... },
)
```

### Affichage en ligne (horizontal)

```dart
SelectableButtonGroupEAE<String>(
  options: [...],
  axis: SelectableButtonGroupAxis.horizontal,
  onChanged: (value) { ... },
)
```

### Avec icônes

```dart
SelectableButtonGroupEAE<String>(
  options: [
    SelectableButtonOption(
      label: 'Home',
      value: 'home',
      icon: Icons.home,
    ),
    SelectableButtonOption(
      label: 'Profile',
      value: 'profile',
      icon: Icons.person,
    ),
  ],
  selectedValue: selectedValue,
  onChanged: (value) { ... },
)
```

## Propriétés

| Propriété | Type | Description | Défaut |
|-----------|------|-------------|--------|
| `options` | `List<SelectableButtonOption<T>>` | Liste des options principales (requis) | - |
| `additionalOptions` | `List<SelectableButtonOption<T>>?` | Liste des options additionnelles | `null` |
| `selectedValue` | `T?` | Valeur actuellement sélectionnée | `null` |
| `onChanged` | `ValueChanged<T>?` | Callback appelé lors d'un changement de sélection | `null` |
| `axis` | `SelectableButtonGroupAxis` | Direction d'affichage (vertical ou horizontal) | `vertical` |
| `alignment` | `SelectableButtonGroupAlignment` | Alignement pour l'affichage vertical | `stretch` |
| `size` | `ButtonEAESize` | Taille des boutons | `medium` |
| `showMoreLabel` | `String` | Label du bouton "afficher plus" | `'Show more'` |
| `showLessLabel` | `String` | Label du bouton "afficher moins" | `'Show less'` |
| `spacing` | `double` | Espacement entre les boutons | `8.0` |

## Classes auxiliaires

### SelectableButtonOption

Représente une option dans le groupe de boutons.

```dart
class SelectableButtonOption<T> {
  final String label;
  final T value;
  final IconData? icon;
}
```

### SelectableButtonGroupAxis

Énumération pour la direction d'affichage.

- `vertical` : Affichage en colonne
- `horizontal` : Affichage en ligne

### SelectableButtonGroupAlignment

Énumération pour l'alignement en mode vertical.

- `start` : Alignement à gauche
- `end` : Alignement à droite
- `stretch` : Pleine largeur

## Architecture

Ce composant est une **molecule** dans le Design System qui compose plusieurs **atoms** (`SelectableButtonEAE`).

```
SelectableButtonGroupEAE (molecule)
  └── SelectableButtonEAE (atom)
        └── ButtonEAE (atom)
```

