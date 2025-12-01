# Design System

Shared design system for EAE Prism multi-brand applications.

## Features

- Multi-brand theming support
- Reusable UI components
- Consistent design tokens
- Type-safe brand colors

## Installation

Add as a path dependency in your `pubspec.yaml`:

```yaml
dependencies:
  design_system:
    path: ../../packages/design_system
```

## Usage

### Import

```dart
import 'package:design_system/design_system.dart';
```

### Setting Up Theme

```dart
MaterialApp(
  theme: BrandTheme.getTheme(Brand.match),
  home: MyHomePage(),
)
```

### Using Components

#### BrandButton

```dart
// Primary button
BrandButton(
  label: 'Click Me',
  onPressed: () {},
  variant: BrandButtonVariant.primary,
)

// Secondary button with icon
BrandButton(
  label: 'Send Message',
  icon: Icons.send,
  onPressed: () {},
  variant: BrandButtonVariant.secondary,
  size: BrandButtonSize.large,
)

// Outline button (full width)
BrandButton(
  label: 'Learn More',
  onPressed: () {},
  variant: BrandButtonVariant.outline,
  isFullWidth: true,
)

// Loading state
BrandButton(
  label: 'Loading...',
  isLoading: true,
  onPressed: null,
)
```

## Brands

The design system supports 4 brands:

- `Brand.match` - Match
- `Brand.meetic` - Meetic
- `Brand.okc` - OKCupid
- `Brand.pof` - Plenty of Fish

## Components

### BrandButton

A versatile button component with multiple variants, sizes, and states.

**Props:**
- `label` (String) - Button text
- `onPressed` (VoidCallback?) - Tap handler
- `variant` (BrandButtonVariant) - primary, secondary, outline
- `size` (BrandButtonSize) - small, medium, large
- `icon` (IconData?) - Optional icon
- `isLoading` (bool) - Shows loading indicator
- `isFullWidth` (bool) - Expands to full width

## Theme Customization

Each brand has its own color palette:

```dart
// Get brand colors
final primaryColor = BrandColors.getPrimaryColor(Brand.match);
final secondaryColor = BrandColors.getSecondaryColor(Brand.match);

// Get complete theme
final theme = BrandTheme.getTheme(Brand.match);
```

## Adding New Components

1. Create component in `lib/src/widgets/`
2. Export in `lib/design_system.dart`
3. Add use cases to Widgetbook
4. Document usage in README

