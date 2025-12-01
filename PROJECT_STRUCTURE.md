# Project Structure

Complete directory structure of the EAE Prism monorepo.

```
eae-prism/
│
├── .vscode/                          # VS Code configuration
│   ├── settings.json                 # Editor settings
│   ├── extensions.json               # Recommended extensions
│   └── launch.json                   # Debug configurations
│
├── apps/                             # Applications
│   │
│   ├── flutter_app/                  # Main Flutter application
│   │   ├── lib/
│   │   │   ├── main.dart             # App entry point with brand selection
│   │   │   └── screens/
│   │   │       └── home_page.dart    # Home screen with button examples
│   │   ├── pubspec.yaml              # Flutter dependencies
│   │   └── README.md                 # App documentation
│   │
│   └── backend/                      # Elysia backend API
│       ├── src/
│       │   ├── index.ts              # Server entry point
│       │   ├── routes/
│       │   │   ├── brand.routes.ts   # Brand configuration endpoints
│       │   │   └── health.routes.ts  # Health check endpoints
│       │   └── types/
│       │       └── brand.types.ts    # TypeScript type definitions
│       ├── package.json              # Node.js dependencies
│       ├── tsconfig.json             # TypeScript configuration
│       ├── .gitignore                # Git ignore rules
│       ├── .env.example              # Environment variables template
│       └── README.md                 # Backend documentation
│
├── packages/                         # Shared packages
│   │
│   ├── design_system/                # Shared design system
│   │   ├── lib/
│   │   │   ├── design_system.dart    # Main export file
│   │   │   └── src/
│   │   │       ├── theme/
│   │   │       │   ├── brand_colors.dart   # Brand color definitions
│   │   │       │   └── brand_theme.dart    # Theme configurations
│   │   │       └── widgets/
│   │   │           └── brand_button.dart   # Button component
│   │   ├── pubspec.yaml              # Package dependencies
│   │   └── README.md                 # Design system documentation
│   │
│   └── widgetbook_app/               # Component showcase
│       ├── lib/
│       │   ├── main.dart             # Widgetbook app entry
│       │   └── usecases/
│       │       └── brand_button_usecases.dart  # Button demonstrations
│       ├── pubspec.yaml              # Package dependencies
│       └── README.md                 # Widgetbook documentation
│
├── .gitignore                        # Root Git ignore rules
├── package.json                      # Root package.json (workspace config)
├── nx.json                           # Nx configuration
├── project.json                      # Nx project targets
│
├── README.md                         # Main project documentation
├── QUICKSTART.md                     # Quick start guide
├── ARCHITECTURE.md                   # Architecture documentation
├── CONTRIBUTING.md                   # Contribution guidelines
├── EXAMPLES.md                       # Code examples
└── PROJECT_STRUCTURE.md              # This file
```

## Key Files Explained

### Root Level

- **package.json**: Defines workspace structure and root-level scripts
- **nx.json**: Nx monorepo configuration for task orchestration
- **project.json**: Defines Nx targets (tasks) for the entire workspace
- **.gitignore**: Git ignore patterns for the entire monorepo

### Apps

#### flutter_app/
The main Flutter application that uses the design system.

**Key Files:**
- `lib/main.dart`: Entry point, handles brand selection and theme setup
- `lib/screens/home_page.dart`: Example page demonstrating all button variants and states
- `pubspec.yaml`: Dependencies including design_system package

**Features:**
- Multi-brand support (Match, Meetic, OKC, POF)
- Example usage of BrandButton component
- Responsive UI
- Hot reload support

#### backend/
Node.js backend using Elysia framework.

**Key Files:**
- `src/index.ts`: Server setup and route registration
- `src/routes/brand.routes.ts`: Brand configuration API endpoints
- `src/routes/health.routes.ts`: Health check endpoints
- `src/types/brand.types.ts`: TypeScript type definitions

**Features:**
- RESTful API
- Type-safe with TypeScript
- Brand configuration management
- Health monitoring

### Packages

#### design_system/
Shared Flutter design system library.

**Key Files:**
- `lib/design_system.dart`: Main export file
- `lib/src/theme/brand_colors.dart`: Color definitions for all brands
- `lib/src/theme/brand_theme.dart`: Material Theme configurations
- `lib/src/widgets/brand_button.dart`: Reusable button component

**Features:**
- Multi-brand theming
- Reusable UI components
- Type-safe brand selection
- Material 3 support

#### widgetbook_app/
Component showcase using Widgetbook.

**Key Files:**
- `lib/main.dart`: Widgetbook configuration and setup
- `lib/usecases/brand_button_usecases.dart`: Button component demonstrations

**Features:**
- Interactive component showcase
- Theme switching
- Device frame preview
- Accessibility testing

## File Relationships

### Dependency Graph

```
flutter_app
    └── imports: design_system

widgetbook_app
    └── imports: design_system
    └── imports: widgetbook (pub.dev)

design_system
    └── imports: flutter (SDK)

backend
    └── imports: elysia (npm)
```

### Data Flow

```
User Interaction (flutter_app)
    ↓
BrandButton (design_system)
    ↓
Theme System (design_system)
    ↓
Brand Colors (design_system)
    ↓
Rendered UI

API Request (flutter_app)
    ↓
Backend Routes (backend)
    ↓
Brand Configuration (backend)
    ↓
JSON Response
```

## Adding New Files

### New Component in Design System

1. Create: `packages/design_system/lib/src/widgets/brand_card.dart`
2. Export: Add to `packages/design_system/lib/design_system.dart`
3. Showcase: Create `packages/widgetbook_app/lib/usecases/brand_card_usecases.dart`
4. Use: Import in `apps/client/lib/screens/`

### New Backend Route

1. Create: `apps/backend/src/routes/new.routes.ts`
2. Register: Import and use in `apps/backend/src/index.ts`
3. Types: Add types to `apps/backend/src/types/`
4. Document: Update `apps/backend/README.md`

### New Screen in Flutter App

1. Create: `apps/client/lib/screens/new_screen.dart`
2. Navigate: Add navigation in existing screens
3. Use: Import design_system components

## File Naming Conventions

### Dart/Flutter
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Example: `brand_button.dart` contains `BrandButton` class

### TypeScript
- Files: `kebab-case.ts` or `camelCase.ts`
- Classes: `PascalCase`
- Example: `brand.routes.ts` contains route definitions

### Documentation
- All caps with extension: `README.md`, `CONTRIBUTING.md`
- Descriptive names for specific docs: `QUICKSTART.md`, `ARCHITECTURE.md`

## Build Artifacts (Git Ignored)

### Flutter
- `.dart_tool/`
- `build/`
- `.flutter-plugins`
- `.packages`

### Node.js
- `node_modules/`
- `dist/`
- `bun.lockb`

### IDE
- `.vscode/` (some files)
- `.idea/`
- `*.iml`

### OS
- `.DS_Store` (macOS)
- `Thumbs.db` (Windows)

## Environment Files

### Development
- `.env.example` (template, committed)
- `.env` (local values, ignored)
- `.env.local` (local overrides, ignored)

### Configuration Files
- `tsconfig.json` - TypeScript compiler options
- `pubspec.yaml` - Dart/Flutter dependencies
- `package.json` - Node.js dependencies
- `nx.json` - Nx workspace configuration

## Documentation Files

Located in root directory:

1. **README.md** - Main project overview and setup
2. **QUICKSTART.md** - 5-minute getting started guide
3. **ARCHITECTURE.md** - Detailed architecture documentation
4. **CONTRIBUTING.md** - Contribution guidelines and workflow
5. **EXAMPLES.md** - Code examples and patterns
6. **PROJECT_STRUCTURE.md** - This file, structure documentation

Each app/package also has its own README.md for specific documentation.

## Version Control

### What's Committed
- Source code (`.dart`, `.ts`, etc.)
- Configuration files
- Documentation
- Example environment files (`.env.example`)
- Lock files (for reproducible builds)

### What's Ignored
- Build artifacts
- Dependencies (`node_modules`, `.pub-cache`)
- IDE-specific settings (some)
- Environment files with secrets (`.env`)
- OS-specific files
- Log files

## Package Boundaries

### Allowed Dependencies

✅ **flutter_app** can import:
- design_system
- flutter (SDK)
- pub.dev packages

✅ **widgetbook_app** can import:
- design_system
- widgetbook (pub.dev)
- flutter (SDK)

✅ **design_system** can import:
- flutter (SDK)
- pub.dev packages (minimal)

✅ **backend** can import:
- elysia (npm)
- bun types
- npm packages

### Not Allowed

❌ **design_system** cannot import:
- flutter_app (circular dependency)
- widgetbook_app (circular dependency)

❌ **backend** cannot import:
- Any Flutter packages (different runtime)

This structure ensures clean separation of concerns and maintainable code organization.

