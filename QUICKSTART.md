# Quick Start Guide

Get up and running with EAE Prism in 5 minutes!

## Step 1: Install Dependencies

### Backend
```bash
cd apps/backend
bun install
cd ../..
```

### Flutter Projects
```bash
# Design System
cd packages/design_system
flutter pub get

# Widgetbook
cd ../../apps/widgetbook
flutter pub get

# Client App
cd ../client
flutter pub get
cd ../..
```

**Or use the Nx command:**
```bash
nx run eae-prism:install:all
```

## Step 2: Start the Backend

```bash
cd apps/backend
bun run dev
```

You should see:
```
🦊 Elysia is running at localhost:3000
```

Test it:
```bash
curl http://localhost:3000/api/brands
```

## Step 3: Run the Client App

Open a new terminal:

```bash
cd apps/client
flutter run
```

Select your device (iOS Simulator, Android Emulator, or Web).

The app will launch showing the **Match** brand by default.

## Step 4: Try Different Brands

Edit `apps/client/lib/main.dart`:

```dart
// Change this line:
const brand = Brand.match;

// To one of:
const brand = Brand.meetic;   // Purple theme
const brand = Brand.okc;      // Blue theme
const brand = Brand.pof;      // Orange theme
```

Hot reload (press `r` in the terminal) to see the changes!

## Step 5: Explore Widgetbook

Open a new terminal:

```bash
cd apps/widgetbook
flutter run
```

In the Widgetbook app, you can:
1. Browse all components in the sidebar
2. Switch themes using the theme selector
3. Try different device frames
4. Test text scaling

## What You've Built

✅ A Flutter app with 4 different brand themes  
✅ A shared design system with reusable components  
✅ A Widgetbook for component documentation  
✅ A backend API with brand configuration  

## Next Steps

### Add a New Component

1. Create it in `packages/design_system/lib/src/widgets/your_component.dart`
2. Export it in `packages/design_system/lib/design_system.dart`
3. Add showcase in `apps/widgetbook/lib/usecases/`
4. Use it in `apps/client/lib/screens/home_page.dart`

### Add a Backend Endpoint

1. Create a new route file in `apps/backend/src/routes/`
2. Import and use it in `apps/backend/src/index.ts`
3. Test with curl or your favorite API client

## Common Issues

### "Flutter command not found"
Install Flutter: https://flutter.dev/docs/get-started/install

### "Bun command not found"
Install Bun: https://bun.sh

### Hot reload not working
Press `R` (capital R) for a full restart instead of `r`.

### Port 3000 already in use
Change the port in `apps/backend/src/index.ts`:
```typescript
.listen(3001) // or any available port
```

## Architecture Overview

```
┌─────────────────────────────────────────┐
│         EAE Prism Monorepo             │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────┐    ┌───────────────┐  │
│  │ Client App  │    │   Backend     │  │
│  │  (Match)    │────│   (Elysia)    │  │
│  │  (Meetic)   │ API│  Port: 3000   │  │
│  │  (OKC)      │    │               │  │
│  │  (POF)      │    └───────────────┘  │
│  └──────┬──────┘                        │
│         │                               │
│         │ uses                          │
│         ↓                               │
│  ┌──────────────────┐                  │
│  │  Design System   │                  │
│  │  - BrandButton   │                  │
│  │  - Brand Themes  │                  │
│  │  - Brand Colors  │                  │
│  └────────┬─────────┘                  │
│           │                            │
│           │ showcased in               │
│           ↓                            │
│  ┌──────────────────┐                 │
│  │   Widgetbook     │                 │
│  │  Component Demo  │                 │
│  └──────────────────┘                 │
│                                        │
└────────────────────────────────────────┘
```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Widgetbook Documentation](https://docs.widgetbook.io)
- [Elysia Documentation](https://elysiajs.com)
- [Nx Documentation](https://nx.dev)

Happy coding! 🚀
