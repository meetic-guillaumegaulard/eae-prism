# Dynamic JSON Screen Builder

Ce module permet de construire des écrans Flutter de manière dynamique à partir de configurations JSON.
**Les valeurs des formulaires sont automatiquement collectées sans avoir à gérer de callbacks manuellement.**

## Vue d'ensemble

Le système se compose de :
- **`ScreenConfig`** : Configuration globale d'un écran (header, content, footer, template)
- **`ComponentConfig`** : Configuration d'un composant individuel
- **`FormStateManager`** : Gestionnaire d'état qui collecte automatiquement les valeurs
- **`ComponentFactory`** : Factory qui transforme les configs en widgets Flutter
- **`DynamicScreen`** : Widget principal qui orchestre la construction

## Utilisation

### 1. À partir d'une chaîne JSON

```dart
DynamicScreen(
  jsonString: jsonString,
  onFormChanged: (values) {
    print('Form values: $values');
  },
  onSubmit: (values) {
    print('Submit! Values: $values');
  },
)
```

### 2. À partir d'un fichier asset

```dart
DynamicScreen.fromAsset(
  'assets/my_screen.json',
  onFormChanged: (values) => print(values),
  onSubmit: (values) => saveToApi(values),
)
```

### 3. Avec des actions personnalisées

```dart
DynamicScreen(
  config: config,
  actions: {
    'reset': () => print('Reset clicked'),
    'custom': () => doSomething(),
  },
  onSubmit: (values) => print(values),
)
```

## Structure JSON

### Format général

```json
{
  "template": "screen_layout",
  "props": {
    "backgroundColor": "#FFFFFF"
  },
  "header": [...],
  "content": [...],
  "footer": [...]
}
```

### Configuration d'un composant avec champ de formulaire

```json
{
  "type": "text_input",
  "props": {
    "label": "Your Name",
    "hintText": "Enter your name",
    "field": "user.name"
  }
}
```

La propriété **`field`** indique où la valeur sera stockée dans le JSON de sortie.
Les chemins avec des points (`user.name`) créent des structures imbriquées :

```json
{
  "user": {
    "name": "John"
  }
}
```

## Propriétés communes

| Propriété | Description |
|-----------|-------------|
| `field` | Chemin où stocker la valeur (ex: `user.email`, `preferences.theme`) |
| `defaultValue` | Valeur par défaut du champ |

## Composants disponibles

### Layout Components

#### `column` / `row` / `container` / `padding` / `sizedbox`
Fonctionnent comme avant, sans changement.

### Atoms avec field

#### `text_input`
```json
{
  "type": "text_input",
  "props": {
    "label": "Email",
    "hintText": "Enter your email",
    "field": "email",
    "defaultValue": ""
  }
}
```

#### `checkbox`
```json
{
  "type": "checkbox",
  "props": {
    "field": "acceptTerms",
    "defaultValue": false
  }
}
```

#### `toggle`
```json
{
  "type": "toggle",
  "props": {
    "field": "notifications",
    "defaultValue": true
  }
}
```

#### `height_slider`
```json
{
  "type": "height_slider",
  "props": {
    "field": "profile.height",
    "minValue": 140,
    "maxValue": 220,
    "defaultValue": 170
  }
}
```

#### `tag`
```json
{
  "type": "tag",
  "props": {
    "label": "Sports",
    "field": "tags.sports",
    "defaultValue": false
  }
}
```

### Molecules avec field

#### `labeled_control`
```json
{
  "type": "labeled_control",
  "props": {
    "htmlLabel": "I accept the <a href='#'>terms</a>",
    "field": "legal.acceptTerms",
    "defaultValue": false,
    "controlType": "checkbox"
  }
}
```

#### `selectable_button_group`
```json
{
  "type": "selectable_button_group",
  "props": {
    "labels": ["Male", "Female", "Other"],
    "field": "profile.gender",
    "defaultValue": "Male"
  }
}
```

#### `selectable_tag_group`
```json
{
  "type": "selectable_tag_group",
  "props": {
    "labels": ["Sports", "Music", "Art"],
    "field": "interests",
    "defaultValue": ["Sports"]
  }
}
```

#### `selection_group` (radio)
```json
{
  "type": "selection_group",
  "props": {
    "labels": ["Option 1", "Option 2"],
    "selectionType": "radio",
    "field": "selectedOption",
    "defaultValue": "Option 1"
  }
}
```

#### `selection_group` (checkbox)
```json
{
  "type": "selection_group",
  "props": {
    "labels": ["A", "B", "C"],
    "selectionType": "checkbox",
    "field": "multiSelect",
    "defaultValue": ["A", "B"]
  }
}
```

### Boutons avec actions

#### `button`
```json
{
  "type": "button",
  "props": {
    "label": "Submit",
    "variant": "primary",
    "action": "submit"
  }
}
```

Actions spéciales :
- `"submit"` : Déclenche `onSubmit` avec les valeurs du formulaire

## Exemple complet

### JSON
```json
{
  "template": "screen_layout",
  "header": [
    {
      "type": "container",
      "props": { "padding": 16 },
      "children": [
        {
          "type": "text",
          "props": { "text": "Registration", "type": "headline_large" }
        }
      ]
    }
  ],
  "content": [
    {
      "type": "column",
      "props": { "crossAxisAlignment": "stretch" },
      "children": [
        {
          "type": "padding",
          "props": { "padding": 16 },
          "children": [
            {
              "type": "text_input",
              "props": {
                "label": "Email",
                "field": "user.email"
              }
            }
          ]
        },
        {
          "type": "padding",
          "props": { "padding": 16 },
          "children": [
            {
              "type": "labeled_control",
              "props": {
                "htmlLabel": "I accept the terms",
                "field": "acceptTerms",
                "defaultValue": false
              }
            }
          ]
        }
      ]
    }
  ],
  "footer": [
    {
      "type": "container",
      "props": { "padding": 16 },
      "children": [
        {
          "type": "button",
          "props": {
            "label": "Register",
            "action": "submit",
            "isFullWidth": true
          }
        }
      ]
    }
  ]
}
```

### Dart
```dart
DynamicScreen.fromAsset(
  'assets/registration.json',
  onSubmit: (values) {
    // values sera :
    // {
    //   "user": { "email": "john@example.com" },
    //   "acceptTerms": true
    // }
    api.register(values);
  },
)
```

## Accès aux valeurs programmatiquement

```dart
final screenKey = GlobalKey<DynamicScreenState>();

DynamicScreen(
  key: screenKey,
  jsonString: json,
)

// Plus tard...
final values = screenKey.currentState?.formValues;
final nestedValues = screenKey.currentState?.nestedFormValues;

// Reset le formulaire
screenKey.currentState?.resetForm();

// Définir des valeurs
screenKey.currentState?.setFormValues({'email': 'test@test.com'});
```

## Notes

- Les composants sont thémés automatiquement selon la brand active
- Le callback `onFormChanged` est appelé à chaque modification de valeur
- Le callback `onSubmit` est automatiquement lié à l'action `"submit"`
- Les valeurs sont collectées de manière réactive et type-safe
