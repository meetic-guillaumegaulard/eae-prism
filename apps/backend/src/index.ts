import { Elysia } from "elysia";
import { brandRoutes } from "./routes/brand.routes";
import { healthRoutes } from "./routes/health.routes";

const app = new Elysia()
  .use(healthRoutes)
  .use(brandRoutes)
  .get("/", () => ({
    message: "EAE Prism API",
    version: "1.0.0",
    documentation: "/docs",
  }))
  .listen(3000);

console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);

export type App = typeof app;
