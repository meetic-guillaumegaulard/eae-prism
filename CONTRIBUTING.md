# Contributing to EAE Prism

Thank you for your interest in contributing to EAE Prism! This document provides guidelines and instructions for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/eae-prism.git`
3. Install dependencies (see QUICKSTART.md)
4. Create a feature branch: `git checkout -b feature/your-feature-name`

## Development Workflow

### Before Making Changes

1. Ensure you're on the latest main branch:
```bash
git checkout main
git pull origin main
```

2. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

### Making Changes

#### For Design System Changes

1. Make changes in `packages/design_system/`
2. Add/update Widgetbook use cases in `packages/widgetbook_app/`
3. Test with all brand themes
4. Update documentation in README

#### For Flutter App Changes

1. Make changes in `apps/client/`
2. Test with all brands (match, meetic, okc, pof)
3. Ensure hot reload works correctly
4. Update screenshots if UI changed

#### For Backend Changes

1. Make changes in `apps/backend/`
2. Update type definitions if needed
3. Test all endpoints
4. Update API documentation

### Code Style

#### Dart/Flutter

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter format` before committing
- Maximum line length: 80 characters
- Use `const` constructors when possible

```dart
// Good
const BrandButton(
  label: 'Click Me',
  onPressed: handleClick,
)

// Bad
BrandButton(
  label: 'Click Me',
  onPressed: handleClick,
)
```

#### TypeScript

- Follow [TypeScript best practices](https://www.typescriptlang.org/docs/handbook/declaration-files/do-s-and-don-ts.html)
- Use Prettier for formatting
- Prefer explicit types over `any`

```typescript
// Good
function getBrand(id: Brand): BrandConfig | undefined {
  return brandConfigs[id];
}

// Bad
function getBrand(id: any): any {
  return brandConfigs[id];
}
```

### Testing

#### Flutter Tests

```bash
cd apps/client
flutter test
```

#### Backend Tests (when implemented)

```bash
cd apps/backend
bun test
```

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add new Card component
fix: resolve button loading state bug
docs: update README with new examples
style: format code with prettier
refactor: extract color logic to utility
test: add tests for BrandButton
chore: update dependencies
```

Examples:
- `feat(design-system): add Card component`
- `fix(flutter-app): resolve brand switching issue`
- `docs(widgetbook): add Button examples`
- `refactor(backend): extract brand service`

## Adding New Features

### New Component

1. Create component file:
```bash
packages/design_system/lib/src/widgets/brand_card.dart
```

2. Export in `design_system.dart`:
```dart
export 'src/widgets/brand_card.dart';
```

3. Add Widgetbook use cases:
```bash
packages/widgetbook_app/lib/usecases/brand_card_usecases.dart
```

4. Document in README:
```markdown
### BrandCard
A card component that adapts to brand themes...
```

### New Brand

1. Add to Brand enum:
```dart
enum Brand {
  match,
  meetic,
  okc,
  pof,
  newbrand, // Add here
}
```

2. Add colors in BrandColors
3. Add theme case in BrandTheme
4. Add backend configuration
5. Test all components with new brand

### New API Endpoint

1. Create or update route file:
```typescript
// apps/backend/src/routes/your.routes.ts
export const yourRoutes = new Elysia({ prefix: '/api/your' })
  .get('/', () => ({ data: 'example' }));
```

2. Register in `index.ts`:
```typescript
import { yourRoutes } from './routes/your.routes';

const app = new Elysia()
  .use(yourRoutes)
  // ...
```

3. Update API documentation in README

## Pull Request Process

1. Update documentation if needed
2. Ensure all tests pass
3. Format code:
```bash
# Flutter
flutter format .

# TypeScript
bun run format
```

4. Commit your changes with conventional commits
5. Push to your fork
6. Create a Pull Request with:
   - Clear title and description
   - Screenshots/videos if UI changed
   - Testing steps
   - Related issue number (if applicable)

### PR Checklist

- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] No new warnings
- [ ] Tested with all brands (if applicable)

## Branch Naming

- Feature: `feature/description`
- Bug fix: `fix/description`
- Documentation: `docs/description`
- Refactor: `refactor/description`

Examples:
- `feature/add-card-component`
- `fix/button-loading-state`
- `docs/update-quickstart`
- `refactor/extract-theme-logic`

## Project Structure Guidelines

### File Organization

```
packages/design_system/
├── lib/
│   ├── design_system.dart          # Main export
│   └── src/
│       ├── theme/                  # Theme-related files
│       │   ├── brand_colors.dart
│       │   └── brand_theme.dart
│       ├── widgets/                # UI components
│       │   ├── brand_button.dart
│       │   └── brand_card.dart
│       └── utils/                  # Utility functions
│           └── helpers.dart
```

### Naming Conventions

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Functions/Variables: `camelCase`
- Constants: `camelCase` or `SCREAMING_SNAKE_CASE`
- Private members: `_prefixWithUnderscore`

## Questions or Issues?

- Check existing issues
- Create a new issue with:
  - Clear title
  - Detailed description
  - Steps to reproduce (for bugs)
  - Expected vs actual behavior
  - Environment details

## Code Review

All submissions require review. We aim to:
- Review PRs within 48 hours
- Provide constructive feedback
- Ensure code quality and consistency
- Help you improve your contribution

## Community

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Follow the code of conduct

Thank you for contributing! 🚀

