# Code Examples

This document provides practical examples for working with the EAE Prism monorepo.

## Flutter Examples

### Using BrandButton Component

#### Basic Button

```dart
import 'package:design_system/design_system.dart';

BrandButton(
  label: 'Get Started',
  onPressed: () {
    print('Button clicked!');
  },
)
```

#### Button with Icon

```dart
BrandButton(
  label: 'Send Message',
  icon: Icons.send,
  onPressed: () {
    // Handle send message
  },
  variant: BrandButtonVariant.primary,
)
```

#### Different Sizes

```dart
// Small button
BrandButton(
  label: 'Small',
  size: BrandButtonSize.small,
  onPressed: () {},
)

// Medium button (default)
BrandButton(
  label: 'Medium',
  size: BrandButtonSize.medium,
  onPressed: () {},
)

// Large button
BrandButton(
  label: 'Large',
  size: BrandButtonSize.large,
  onPressed: () {},
)
```

#### Button Variants

```dart
// Primary button (filled)
BrandButton(
  label: 'Primary',
  variant: BrandButtonVariant.primary,
  onPressed: () {},
)

// Secondary button
BrandButton(
  label: 'Secondary',
  variant: BrandButtonVariant.secondary,
  onPressed: () {},
)

// Outline button
BrandButton(
  label: 'Outline',
  variant: BrandButtonVariant.outline,
  onPressed: () {},
)
```

#### Loading State

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;

  Future<void> _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    // Perform async operation
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BrandButton(
      label: 'Submit',
      isLoading: _isLoading,
      onPressed: _isLoading ? null : _handleSubmit,
    );
  }
}
```

#### Full Width Button

```dart
BrandButton(
  label: 'Continue',
  isFullWidth: true,
  onPressed: () {},
)
```

### Setting Up Multi-Brand App

```dart
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brand _currentBrand = Brand.match;

  void _switchBrand(Brand newBrand) {
    setState(() {
      _currentBrand = newBrand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BrandTheme.getBrandName(_currentBrand),
      theme: BrandTheme.getTheme(_currentBrand),
      home: HomePage(
        currentBrand: _currentBrand,
        onBrandChanged: _switchBrand,
      ),
    );
  }
}
```

### Using Brand Colors Directly

```dart
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

Container(
  decoration: BoxDecoration(
    color: BrandColors.getPrimaryColor(Brand.match),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    'Custom Widget',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
)
```

### Creating a Custom Branded Widget

```dart
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const BrandCard({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      color: theme.colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Backend Examples

### Basic Elysia Server

```typescript
import { Elysia } from 'elysia';

const app = new Elysia()
  .get('/', () => 'Hello World!')
  .listen(3000);

console.log(`Server running at http://localhost:3000`);
```

### Fetching Brand Configuration

```typescript
// Get all brands
const response = await fetch('http://localhost:3000/api/brands');
const data = await response.json();
console.log(data.brands);
// Output: [{ id: 'match', name: 'Match' }, ...]
```

### Getting Brand Theme Colors

```typescript
// Get Match theme colors
const response = await fetch('http://localhost:3000/api/brands/match/theme');
const data = await response.json();
console.log(data.colors);
// Output: { primary: '#D6002F', secondary: '#FF6B6B', ... }
```

### Checking Brand Features

```typescript
// Check if messaging is enabled for OKCupid
const response = await fetch('http://localhost:3000/api/brands/okc/features/messaging');
const data = await response.json();
console.log(data.enabled); // true or false
```

### Creating a New Route

```typescript
import { Elysia, t } from 'elysia';

export const userRoutes = new Elysia({ prefix: '/api/users' })
  .get('/', () => ({
    users: [
      { id: 1, name: 'John Doe' },
      { id: 2, name: 'Jane Smith' },
    ],
  }))
  .get(
    '/:id',
    ({ params: { id } }) => ({
      user: { id, name: 'User ' + id },
    }),
    {
      params: t.Object({
        id: t.String(),
      }),
    }
  )
  .post(
    '/',
    ({ body }) => ({
      message: 'User created',
      user: body,
    }),
    {
      body: t.Object({
        name: t.String(),
        email: t.String(),
      }),
    }
  );
```

### Using the New Route

```typescript
// In apps/backend/src/index.ts
import { userRoutes } from './routes/user.routes';

const app = new Elysia()
  .use(userRoutes) // Add this
  // ... other routes
  .listen(3000);
```

### Type-Safe API Client (TypeScript)

```typescript
import type { Brand, BrandTheme } from '../types/brand.types';

class BrandAPI {
  private baseURL: string;

  constructor(baseURL = 'http://localhost:3000') {
    this.baseURL = baseURL;
  }

  async getAllBrands(): Promise<{ id: Brand; name: string }[]> {
    const response = await fetch(`${this.baseURL}/api/brands`);
    const data = await response.json();
    return data.brands;
  }

  async getBrandTheme(brandId: Brand): Promise<BrandTheme> {
    const response = await fetch(`${this.baseURL}/api/brands/${brandId}/theme`);
    return await response.json();
  }

  async isFeatureEnabled(brandId: Brand, feature: string): Promise<boolean> {
    const response = await fetch(
      `${this.baseURL}/api/brands/${brandId}/features/${feature}`
    );
    const data = await response.json();
    return data.enabled;
  }
}

// Usage
const api = new BrandAPI();
const brands = await api.getAllBrands();
const matchTheme = await api.getBrandTheme('match');
const hasMessaging = await api.isFeatureEnabled('match', 'messaging');
```

## Widgetbook Examples

### Adding a New Use Case

```dart
// In packages/widgetbook_app/lib/usecases/brand_button_usecases.dart

Widget buildDisabledButton(BuildContext context) {
  return Center(
    child: BrandButton(
      label: 'Disabled Button',
      onPressed: null, // null makes it disabled
    ),
  );
}
```

### Registering the Use Case

```dart
// In packages/widgetbook_app/lib/main.dart

WidgetbookComponent(
  name: 'BrandButton',
  useCases: [
    // ... existing use cases
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => buildDisabledButton(context),
    ),
  ],
)
```

## Integration Examples

### Flutter App Calling Backend

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class BrandService {
  final String baseUrl;

  BrandService({this.baseUrl = 'http://localhost:3000'});

  Future<List<String>> getAvailableBrands() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/brands'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['brands'] as List)
          .map((brand) => brand['id'] as String)
          .toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<Map<String, String>> getBrandColors(String brandId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/brands/$brandId/theme'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Map<String, String>.from(data['colors']);
    } else {
      throw Exception('Failed to load brand colors');
    }
  }
}

// Usage
final service = BrandService();
final brands = await service.getAvailableBrands();
final colors = await service.getBrandColors('match');
```

## Testing Examples

### Widget Test for BrandButton

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

void main() {
  testWidgets('BrandButton shows label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.getTheme(Brand.match),
        home: Scaffold(
          body: BrandButton(
            label: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
  });

  testWidgets('BrandButton calls onPressed', (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.getTheme(Brand.match),
        home: Scaffold(
          body: BrandButton(
            label: 'Test Button',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(wasPressed, true);
  });
}
```

### Backend Route Test (with Elysia)

```typescript
import { describe, expect, it } from 'bun:test';
import { Elysia } from 'elysia';
import { brandRoutes } from '../src/routes/brand.routes';

describe('Brand Routes', () => {
  const app = new Elysia().use(brandRoutes);

  it('should get all brands', async () => {
    const response = await app
      .handle(new Request('http://localhost/api/brands'))
      .then((res) => res.json());

    expect(response.brands).toBeDefined();
    expect(response.brands.length).toBeGreaterThan(0);
  });

  it('should get specific brand', async () => {
    const response = await app
      .handle(new Request('http://localhost/api/brands/match'))
      .then((res) => res.json());

    expect(response.brand).toBeDefined();
    expect(response.brand.id).toBe('match');
  });
});
```

## Common Patterns

### Conditional Brand-Specific Logic

```dart
Widget build(BuildContext context) {
  final brand = getCurrentBrand(); // Your method to get current brand
  
  return Column(
    children: [
      // Common content for all brands
      Text('Welcome!'),
      
      // Brand-specific content
      if (brand == Brand.match)
        Text('Find your perfect match!'),
      if (brand == Brand.meetic)
        Text('Rencontrez des célibataires!'),
      if (brand == Brand.okc)
        Text('Be yourself!'),
      if (brand == Brand.pof)
        Text('Plenty of connections!'),
      
      // Common button
      BrandButton(
        label: 'Get Started',
        onPressed: () {},
      ),
    ],
  );
}
```

### Environment-Based Configuration

```typescript
// apps/backend/src/config.ts
export const config = {
  port: process.env.PORT || 3000,
  env: process.env.NODE_ENV || 'development',
  corsOrigin: process.env.CORS_ORIGIN || 'http://localhost:*',
  isDevelopment: process.env.NODE_ENV === 'development',
  isProduction: process.env.NODE_ENV === 'production',
};

// Usage in index.ts
import { config } from './config';

const app = new Elysia()
  .get('/', () => ({
    environment: config.env,
  }))
  .listen(config.port);
```

These examples should help you get started with the EAE Prism monorepo! For more details, check the individual README files in each package/app directory.

