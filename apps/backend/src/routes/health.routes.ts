import { Elysia } from 'elysia';

export const healthRoutes = new Elysia()
  .get('/health', () => ({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
  }))
  .get('/health/ready', () => ({
    ready: true,
    timestamp: new Date().toISOString(),
  }));
