# EAE Prism Monorepo

A monorepo containing a Flutter multi-brand app, design system with Widgetbook, and Elysia backend.

## 🏗 Structure

```
eae-prism/
├── apps/
│   ├── client/                # Flutter app with multi-brand support
│   ├── widgetbook/            # Widgetbook component showcase
│   └── backend/               # Elysia Node.js backend (TypeScript)
└── packages/
    └── design_system/         # Shared Flutter design system
```

## 🎨 Brands Supported

- **Match** - Red/Pink theme (#D6002F)
- **Meetic** - Purple theme (#6C5CE7)
- **OKCupid (okc)** - Blue/Teal theme (#00A8E8)
- **Plenty of Fish (pof)** - Orange/Green theme (#FF6B35)

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (>=3.0.0) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Bun** (>=1.0.0) - [Install Bun](https://bun.sh) (or Node.js >=18)
- **Nx CLI** (optional): `npm install -g nx`

### Quick Start

1. **Clone and setup:**
```bash
cd eae-prism
```

2. **Install backend dependencies:**
```bash
cd apps/backend
bun install
cd ../..
```

3. **Install Flutter dependencies:**
```bash
cd packages/design_system
flutter pub get
cd ../..
cd apps/widgetbook
flutter pub get
cd ../client
flutter pub get
cd ../..
```

## 📱 Running the Apps

### Client App (Multi-Brand)

```bash
cd apps/client
flutter run
```

**Switching brands:**
Edit `lib/main.dart` and change the brand constant:
```dart
const brand = Brand.match; // Options: match, meetic, okc, pof
```

### Widgetbook (Component Showcase)

```bash
cd apps/widgetbook
flutter run
```

The Widgetbook app allows you to:
- Preview all components
- Switch between brand themes in real-time
- Test different device frames
- Adjust text scale for accessibility

### Backend API (Elysia)

```bash
cd apps/backend
bun run dev
```

The API will be available at `http://localhost:3000`

**API Endpoints:**
- `GET /` - API info
- `GET /health` - Health check
- `GET /api/brands` - List all brands
- `GET /api/brands/:brandId` - Get brand config
- `GET /api/brands/:brandId/theme` - Get brand theme colors
- `GET /api/brands/:brandId/features` - Get brand features

## 🧩 Components

### BrandButton

A versatile button component with multiple variants and states.

**Example usage in Flutter:**

```dart
import 'package:design_system/design_system.dart';

// Primary button
BrandButton(
  label: 'Get Started',
  onPressed: () {},
  variant: BrandButtonVariant.primary,
  size: BrandButtonSize.large,
)

// Button with icon
BrandButton(
  label: 'Send Message',
  icon: Icons.send,
  onPressed: () {},
  variant: BrandButtonVariant.secondary,
)

// Loading state
BrandButton(
  label: 'Loading...',
  isLoading: true,
  onPressed: null,
)
```

## 🎯 Features

### Design System
- ✅ Multi-brand theming system
- ✅ Reusable UI components
- ✅ Consistent design tokens
- ✅ Type-safe brand colors
- ✅ Material 3 support

### Widgetbook
- ✅ Interactive component showcase
- ✅ Real-time theme switching
- ✅ Device frame preview
- ✅ Accessibility testing (text scale)

### Backend
- ✅ Type-safe API with Elysia
- ✅ Brand configuration management
- ✅ Theme color endpoints
- ✅ Feature flag system
- ✅ Health check endpoints

## 📦 Monorepo Management

This project uses **Nx** for monorepo management and task orchestration.

### Nx Commands (Optional)

```bash
# Run affected tests
nx affected:test

# Build affected projects
nx affected:build

# View dependency graph
nx graph
```

## 🛠 Development

### Adding a New Component

1. Create the component in `packages/design_system/lib/src/widgets/`
2. Export it in `packages/design_system/lib/design_system.dart`
3. Add use cases to `packages/widgetbook_app/lib/usecases/`
4. Document in the design system README

### Adding a New Brand

1. Add brand to `Brand` enum in `design_system/lib/src/theme/brand_colors.dart`
2. Add brand colors in `BrandColors` class
3. Add brand case in `BrandTheme.getTheme()`
4. Update backend brand configs in `apps/backend/src/routes/brand.routes.ts`

## 📚 Documentation

Each package/app has its own README:

- [Client App](apps/client/README.md)
- [Widgetbook](apps/widgetbook/README.md)
- [Backend API](apps/backend/README.md)
- [Design System](packages/design_system/README.md)

## 🧪 Testing

```bash
# Flutter tests
cd apps/client
flutter test

# Backend (when tests are added)
cd apps/backend
bun test
```

## 📝 License

Private monorepo for EAE Prism project.

## 🤝 Contributing

This is a monorepo structure for multi-brand applications. Follow the established patterns when adding new features:

1. Keep design system components brand-agnostic
2. Use theme colors from `BrandColors`
3. Test all components in Widgetbook with all brands
4. Document new components and APIs

