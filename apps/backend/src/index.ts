import { Elysia } from "elysia";
import { resolve, dirname, join } from "path";
import { fileURLToPath } from "url";
import { brandRoutes } from "./routes/brand.routes";
import { healthRoutes } from "./routes/health.routes";
import { screenRoutes } from "./routes/screen.routes";

const __dirname = dirname(fileURLToPath(import.meta.url));
const assetsPath = resolve(__dirname, "assets");

const corsHeaders: Record<string, string> = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "*",
  "Access-Control-Max-Age": "86400",
};

// Create Elysia app with existing routes
const elysiaApp = new Elysia()
  .use(healthRoutes)
  .use(brandRoutes)
  .use(screenRoutes)
  .get("/", () => ({
    message: "EAE Prism API",
    version: "1.0.0",
    documentation: "/docs",
  }));

// Helper to add CORS headers to any Response
function addCorsHeaders(response: Response): Response {
  const newHeaders = new Headers(response.headers);
  Object.entries(corsHeaders).forEach(([key, value]) => {
    newHeaders.set(key, value);
  });

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers: newHeaders,
  });
}

const server = Bun.serve({
  port: 3000,
  async fetch(request) {
    const url = new URL(request.url);

    // Handle CORS preflight for ALL routes
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders,
      });
    }

    // Serve static assets (handled by Bun directly for performance)
    if (url.pathname.startsWith("/api/assets/")) {
      const assetPath = url.pathname.replace("/api/assets/", "");
      const filePath = join(assetsPath, assetPath);

      const file = Bun.file(filePath);
      const exists = await file.exists();

      if (!exists) {
        return new Response(JSON.stringify({ error: "File not found" }), {
          status: 404,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      return new Response(file, {
        headers: {
          ...corsHeaders,
          "Content-Type": file.type,
          "Cache-Control": "public, max-age=86400",
        },
      });
    }

    // Delegate all other routes to Elysia
    const elysiaResponse = await elysiaApp.handle(request);

    // Add CORS headers to Elysia response
    return addCorsHeaders(elysiaResponse);
  },
});

console.log(`🚀 Server is running at http://localhost:${server.port}`);

export type App = typeof elysiaApp;
