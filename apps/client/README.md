# Client App

Multi-brand Flutter application supporting Match, Meetic, OKCupid, and Plenty of Fish.

## Features

- Multi-brand theming system
- Shared design system with reusable components
- Brand-specific color palettes
- Responsive UI
- Button component showcase

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

```bash
flutter pub get
```

### Running the App

```bash
flutter run
```

### Changing Brand

To switch between brands, edit the `brand` constant in `lib/main.dart`:

```dart
const brand = Brand.match; // Options: match, meetic, okc, pof
```

## Project Structure

```
lib/
├── main.dart           # App entry point
└── screens/
    └── home_page.dart  # Home screen with button examples
```

## Brands

### Match
- Primary Color: Red (#D6002F)
- Theme: Bold and passionate

### Meetic
- Primary Color: Purple (#6C5CE7)
- Theme: Modern and sophisticated

### OKCupid
- Primary Color: Blue (#00A8E8)
- Theme: Fresh and friendly

### Plenty of Fish
- Primary Color: Orange (#FF6B35)
- Theme: Warm and inviting

## Components Used

- `BrandButton` - Reusable button component from design_system
  - Variants: Primary, Secondary, Outline
  - Sizes: Small, Medium, Large
  - States: Normal, Loading, Disabled
  - With/without icons

