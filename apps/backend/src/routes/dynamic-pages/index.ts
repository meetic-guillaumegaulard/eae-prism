import { Elysia, t } from "elysia";
import { readFileSync, existsSync, readdirSync, statSync } from "fs";
import { resolve, dirname, join } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const assetsPath = resolve(__dirname, "assets");

/**
 * Type pour la configuration de navigation
 */
interface NavigationConfig {
  type: "navigate" | "refresh";
  direction?: "left" | "right" | "up" | "down";
  scope?: "content" | "full";
  durationMs?: number;
}

/**
 * Type pour la réponse d'un écran
 */
interface ScreenResponse {
  navigation: NavigationConfig;
  screen: Record<string, unknown>;
  formValues?: Record<string, unknown>;
}

/**
 * Charge un fichier JSON d'écran depuis assets/{brand}/{flowId}/{screenId}.json
 */
function loadScreenConfig(
  brand: string,
  flowId: string,
  screenId: string
): ScreenResponse | null {
  const filePath = join(assetsPath, brand, flowId, `${screenId}.json`);

  if (!existsSync(filePath)) {
    return null;
  }

  try {
    const content = readFileSync(filePath, "utf-8");
    return JSON.parse(content) as ScreenResponse;
  } catch (error) {
    console.error(
      `Error loading screen config ${brand}/${flowId}/${screenId}:`,
      error
    );
    return null;
  }
}

/**
 * Liste les sous-dossiers d'un chemin
 */
function listSubdirectories(path: string): string[] {
  try {
    if (!existsSync(path)) {
      return [];
    }
    const entries = readdirSync(path);
    return entries.filter((entry) => {
      const entryPath = join(path, entry);
      return statSync(entryPath).isDirectory();
    });
  } catch {
    return [];
  }
}

/**
 * Liste toutes les brands disponibles
 */
function listAvailableBrands(): string[] {
  return listSubdirectories(assetsPath);
}

/**
 * Liste tous les flows disponibles pour une brand
 */
function listAvailableFlows(brand: string): string[] {
  return listSubdirectories(join(assetsPath, brand));
}

/**
 * Liste tous les écrans disponibles pour un flow
 */
function listAvailableScreens(brand: string, flowId: string): string[] {
  try {
    const flowPath = join(assetsPath, brand, flowId);
    if (!existsSync(flowPath)) {
      return [];
    }
    const files = readdirSync(flowPath);
    return files
      .filter((file) => file.endsWith(".json"))
      .map((file) => file.replace(".json", ""));
  } catch {
    return [];
  }
}

/**
 * Construit la réponse pour un écran donné
 */
function buildScreenResponse(
  brand: string,
  flowId: string,
  screenId: string,
  formValues?: Record<string, unknown>
) {
  const config = loadScreenConfig(brand, flowId, screenId);

  if (!config) {
    return {
      error: "Screen not found",
      brand,
      flowId,
      screenId,
      availableBrands: listAvailableBrands(),
      availableFlows: listAvailableFlows(brand),
      availableScreens: listAvailableScreens(brand, flowId),
    };
  }

  return {
    ...config,
    formValues: formValues ?? config.formValues ?? {},
  };
}

/**
 * Routes pour la navigation dynamique des écrans
 *
 * Structure des URLs:
 * - GET  /api/dynamic-pages                              → Liste les brands
 * - GET  /api/dynamic-pages/:brand                       → Liste les flows d'une brand
 * - GET  /api/dynamic-pages/:brand/:flowId               → Liste les écrans d'un flow
 * - GET  /api/dynamic-pages/:brand/:flowId/:screenId     → Récupère un écran
 * - POST /api/dynamic-pages/:brand/:flowId/:screenId     → Navigue avec données du formulaire
 *
 * Structure des fichiers: assets/{brand}/{flowId}/{screenId}.json
 *
 * Structure d'un fichier JSON:
 * {
 *   "navigation": { "type": "navigate", "direction": "left", "scope": "content", "durationMs": 300 },
 *   "screen": { ... configuration de l'écran ... }
 * }
 *
 * Pour le bouton "Retour", utilisez apiEndpoint: ":back" qui déclenche
 * un Navigator.pop() standard côté client.
 */
export const dynamicPagesRoutes = new Elysia({ prefix: "/api/dynamic-pages" })

  // Liste toutes les brands disponibles
  .get("/", () => {
    const brands = listAvailableBrands();
    return { brands, count: brands.length };
  })

  // Liste tous les flows d'une brand
  .get(
    "/:brand",
    ({ params: { brand } }) => {
      const flows = listAvailableFlows(brand);
      if (flows.length === 0) {
        return {
          error: "Brand not found",
          brand,
          availableBrands: listAvailableBrands(),
        };
      }
      return { brand, flows, count: flows.length };
    },
    {
      params: t.Object({
        brand: t.String(),
      }),
    }
  )

  // Liste tous les écrans d'un flow
  .get(
    "/:brand/:flowId",
    ({ params: { brand, flowId } }) => {
      const screens = listAvailableScreens(brand, flowId);
      if (screens.length === 0) {
        return {
          error: "Flow not found",
          brand,
          flowId,
          availableBrands: listAvailableBrands(),
          availableFlows: listAvailableFlows(brand),
        };
      }
      return { brand, flowId, screens, count: screens.length };
    },
    {
      params: t.Object({
        brand: t.String(),
        flowId: t.String(),
      }),
    }
  )

  // Endpoint GET pour récupérer un écran (navigation initiale)
  .get(
    "/:brand/:flowId/:screenId",
    ({ params: { brand, flowId, screenId } }) =>
      buildScreenResponse(brand, flowId, screenId),
    {
      params: t.Object({
        brand: t.String(),
        flowId: t.String(),
        screenId: t.String(),
      }),
    }
  )

  // Endpoint POST pour naviguer vers un écran (avec données du formulaire)
  .post(
    "/:brand/:flowId/:screenId",
    ({ params: { brand, flowId, screenId }, body }) => {
      console.log(`[${brand}/${flowId}/${screenId}] Received data:`, body);
      return buildScreenResponse(
        brand,
        flowId,
        screenId,
        body as Record<string, unknown>
      );
    },
    {
      params: t.Object({
        brand: t.String(),
        flowId: t.String(),
        screenId: t.String(),
      }),
      body: t.Any(),
    }
  );
