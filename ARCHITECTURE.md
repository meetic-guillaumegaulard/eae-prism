# Architecture Documentation

## Overview

EAE Prism is a monorepo built with Nx that contains a multi-brand Flutter application, a shared design system, a Widgetbook component showcase, and an Elysia backend API.

## Project Structure

```
eae-prism/
├── apps/
│   ├── flutter_app/              # Main Flutter application
│   │   ├── lib/
│   │   │   ├── main.dart         # App entry point with brand selection
│   │   │   └── screens/
│   │   │       └── home_page.dart # Home screen with button examples
│   │   └── pubspec.yaml
│   │
│   └── backend/                  # Elysia Node.js backend
│       ├── src/
│       │   ├── index.ts          # Server entry point
│       │   ├── routes/
│       │   │   ├── brand.routes.ts    # Brand configuration endpoints
│       │   │   └── health.routes.ts   # Health check endpoints
│       │   └── types/
│       │       └── brand.types.ts     # TypeScript type definitions
│       ├── package.json
│       └── tsconfig.json
│
├── packages/
│   ├── design_system/            # Shared Flutter design system
│   │   ├── lib/
│   │   │   ├── design_system.dart     # Main export file
│   │   │   └── src/
│   │   │       ├── theme/
│   │   │       │   ├── brand_colors.dart  # Brand color definitions
│   │   │       │   └── brand_theme.dart   # Theme configurations
│   │   │       └── widgets/
│   │   │           └── brand_button.dart  # Button component
│   │   └── pubspec.yaml
│   │
│   └── widgetbook_app/           # Component showcase
│       ├── lib/
│       │   ├── main.dart         # Widgetbook app entry
│       │   └── usecases/
│       │       └── brand_button_usecases.dart  # Button demos
│       └── pubspec.yaml
│
├── package.json                  # Root package.json for workspace
├── nx.json                       # Nx configuration
└── project.json                  # Nx project targets

```

## Multi-Brand System

### Brand Definition

Brands are defined as an enum in the design system:

```dart
enum Brand {
  match,   // Red/Pink theme
  meetic,  // Purple theme
  okc,     // Blue/Teal theme
  pof,     // Orange/Green theme
}
```

### Brand Colors

Each brand has its own color palette defined in `BrandColors`:

- **Primary Color**: Main brand color for CTAs and important elements
- **Secondary Color**: Supporting color for secondary actions
- **Background Color**: Main background color
- **Surface Color**: Card and surface backgrounds

### Theme System

The `BrandTheme` class provides Material Theme configurations for each brand:

```dart
ThemeData theme = BrandTheme.getTheme(Brand.match);
```

This returns a complete `ThemeData` object with:
- ColorScheme (Material 3)
- ElevatedButtonTheme
- TextTheme
- Other Material components

## Component Architecture

### BrandButton

A highly customizable button component that adapts to the current brand theme.

**Features:**
- 3 variants: Primary, Secondary, Outline
- 3 sizes: Small, Medium, Large
- Optional icon
- Loading state
- Full-width option
- Disabled state

**Implementation:**
- Uses theme colors from `Theme.of(context)`
- Fully responsive
- Follows Material Design guidelines
- Accessible (proper contrast, touch targets)

## Backend Architecture

### Technology Stack

- **Runtime**: Bun (high-performance JavaScript runtime)
- **Framework**: Elysia (fast, ergonomic web framework)
- **Language**: TypeScript

### API Structure

#### Health Endpoints
- `GET /health` - Returns server health status
- `GET /health/ready` - Returns readiness status

#### Brand Endpoints
- `GET /api/brands` - List all available brands
- `GET /api/brands/:brandId` - Get complete brand configuration
- `GET /api/brands/:brandId/theme` - Get brand theme colors
- `GET /api/brands/:brandId/features` - Get brand-specific features
- `GET /api/brands/:brandId/features/:feature` - Check if feature is enabled

### Brand Configuration

Brand configurations are stored in memory (can be replaced with a database):

```typescript
interface BrandConfig {
  id: Brand;
  name: string;
  primaryColor: string;
  secondaryColor: string;
  backgroundColor: string;
  surfaceColor: string;
  features: string[];
  apiEndpoints: {
    base: string;
    auth: string;
    profiles: string;
  };
}
```

## Data Flow

### Flutter App Flow

```
User Action
    ↓
Component (BrandButton)
    ↓
Theme System (BrandTheme)
    ↓
Brand Colors (BrandColors)
    ↓
Rendered with brand-specific styling
```

### Backend Flow

```
HTTP Request
    ↓
Route Handler (brand.routes.ts)
    ↓
Brand Configuration (in-memory)
    ↓
JSON Response
```

## Dependency Graph

```
flutter_app
    └── depends on: design_system

widgetbook_app
    └── depends on: design_system
    └── depends on: widgetbook (package)

design_system
    └── depends on: flutter

backend
    └── depends on: elysia
```

## Key Design Decisions

### 1. Monorepo Structure

**Why**: Shared code reusability, consistent versioning, easier refactoring

**Tool**: Nx for build orchestration and caching

### 2. Shared Design System

**Why**: Consistency across apps, single source of truth, easier maintenance

**Implementation**: Flutter package with path dependency

### 3. Widgetbook Integration

**Why**: Interactive component documentation, visual testing, design system governance

**Benefits**: Designers can preview components, developers have live examples

### 4. Enum-Based Brand System

**Why**: Type-safe, compile-time checking, prevents invalid brand values

**Alternative Considered**: String-based (rejected for type safety)

### 5. Theme-Based Styling

**Why**: Leverages Flutter's built-in theming, consistent with Material Design

**Benefits**: Automatic dark mode support (future), accessibility

### 6. Elysia Backend

**Why**: Modern, fast, type-safe, great developer experience

**Benefits**: Automatic OpenAPI generation, validation, WebSocket support

## Scalability Considerations

### Adding New Brands

1. Add enum value to `Brand`
2. Add colors to `BrandColors`
3. Add theme case in `BrandTheme`
4. Add config to backend
5. Test in Widgetbook

### Adding New Components

1. Create in `packages/design_system/lib/src/widgets/`
2. Export in `design_system.dart`
3. Add Widgetbook use cases
4. Document in README

### Backend Scaling

- Replace in-memory storage with database
- Add caching layer (Redis)
- Implement rate limiting
- Add monitoring and logging

## Testing Strategy

### Unit Tests

- Component logic (BrandButton states)
- Theme calculations (color contrast)
- API endpoint responses

### Widget Tests

- Component rendering
- Theme application
- User interactions

### Integration Tests

- Full app flows
- API integration
- Brand switching

### Visual Regression Tests

- Widgetbook snapshot testing
- Compare renders across brands

## Future Enhancements

### Short Term

- [ ] Add more components (Input, Card, Modal)
- [ ] Implement dark mode
- [ ] Add animations and transitions
- [ ] Backend: Add database integration

### Medium Term

- [ ] Add i18n support
- [ ] Implement feature flags
- [ ] Add analytics integration
- [ ] Create CI/CD pipeline

### Long Term

- [ ] Server-side theme configuration
- [ ] A/B testing framework
- [ ] Component versioning
- [ ] Design token automation

## Performance Considerations

### Flutter

- Use `const` constructors where possible
- Minimize rebuilds with proper state management
- Lazy load images and assets
- Code splitting for web

### Backend

- Implement caching for brand configs
- Use database connection pooling
- Compress responses
- Implement CDN for static assets

## Security Considerations

### Backend

- Implement rate limiting
- Add authentication/authorization
- Validate all inputs
- Use HTTPS in production
- Implement CORS properly

### Flutter

- Secure API keys
- Implement certificate pinning
- Validate server responses
- Use secure storage for sensitive data

## Monitoring and Observability

### Metrics to Track

- App launch time
- Component render time
- API response time
- Error rates
- Brand switch performance

### Tools

- Flutter DevTools
- Backend logging (Pino, Winston)
- APM (Application Performance Monitoring)
- Error tracking (Sentry)

## Documentation Standards

Each component should include:
- Description of purpose
- Props/parameters documentation
- Usage examples
- Accessibility considerations
- Known limitations

Each API endpoint should include:
- Purpose and use case
- Request/response schemas
- Example requests
- Error codes
- Rate limit information

