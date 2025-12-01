# Backend API - Elysia

Backend API built with Elysia (Bun) for the EAE Prism monorepo.

## Features

- Multi-brand configuration management
- Brand theme colors
- Feature flags per brand
- Health check endpoints
- Type-safe API with Elysia
- **Hot Reload** enabled in development

## Installation

```bash
bun install
```

## Development

```bash
bun run dev
```

The server will start on http://localhost:3000.
**Hot Reload is active**: any change to source files will automatically restart the server.

## API Endpoints

### Health Check

- `GET /health` - Health status
- `GET /health/ready` - Readiness check

### Brands

- `GET /api/brands` - List all brands
- `GET /api/brands/:brandId` - Get brand configuration
- `GET /api/brands/:brandId/theme` - Get brand theme colors
- `GET /api/brands/:brandId/features` - Get brand features
- `GET /api/brands/:brandId/features/:feature` - Check if feature is enabled

### Example Requests

```bash
# Get all brands
curl http://localhost:3000/api/brands

# Get Match brand configuration
curl http://localhost:3000/api/brands/match

# Get Meetic theme colors
curl http://localhost:3000/api/brands/meetic/theme

# Get OKCupid features
curl http://localhost:3000/api/brands/okc/features

# Check if messaging is enabled for POF
curl http://localhost:3000/api/brands/pof/features/messaging
```

## Supported Brands

- `match` - Match
- `meetic` - Meetic
- `okc` - OKCupid
- `pof` - Plenty of Fish

## Tech Stack

- **Framework**: Elysia
- **Runtime**: Bun
- **Language**: TypeScript
