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
 * Charge un fichier JSON d'écran depuis le dossier assets/{flowId}/{screenId}.json
 */
function loadScreenConfig(
  flowId: string,
  screenId: string
): ScreenResponse | null {
  const filePath = join(assetsPath, flowId, `${screenId}.json`);

  if (!existsSync(filePath)) {
    return null;
  }

  try {
    const content = readFileSync(filePath, "utf-8");
    return JSON.parse(content) as ScreenResponse;
  } catch (error) {
    console.error(`Error loading screen config ${flowId}/${screenId}:`, error);
    return null;
  }
}

/**
 * Liste tous les flows disponibles (dossiers dans assets/)
 */
function listAvailableFlows(): string[] {
  try {
    const entries = readdirSync(assetsPath);
    return entries.filter((entry) => {
      const entryPath = join(assetsPath, entry);
      return statSync(entryPath).isDirectory();
    });
  } catch {
    return [];
  }
}

/**
 * Liste tous les écrans disponibles pour un flow donné
 */
function listAvailableScreens(flowId: string): string[] {
  try {
    const flowPath = join(assetsPath, flowId);
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
  flowId: string,
  screenId: string,
  formValues?: Record<string, unknown>
) {
  const config = loadScreenConfig(flowId, screenId);

  if (!config) {
    return {
      error: "Screen not found",
      flowId,
      screenId,
      availableFlows: listAvailableFlows(),
      availableScreens: listAvailableScreens(flowId),
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
 * - GET  /api/dynamic-pages                     → Liste les flows disponibles
 * - GET  /api/dynamic-pages/:flowId             → Liste les écrans d'un flow
 * - GET  /api/dynamic-pages/:flowId/:screenId   → Récupère un écran
 * - POST /api/dynamic-pages/:flowId/:screenId   → Navigue avec données du formulaire
 *
 * Structure des fichiers: assets/{flowId}/{screenId}.json
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

  // Liste tous les flows disponibles
  .get("/", () => {
    const flows = listAvailableFlows();
    return { flows, count: flows.length };
  })

  // Liste tous les écrans d'un flow
  .get(
    "/:flowId",
    ({ params: { flowId } }) => {
      const screens = listAvailableScreens(flowId);
      if (screens.length === 0) {
        return {
          error: "Flow not found",
          flowId,
          availableFlows: listAvailableFlows(),
        };
      }
      return { flowId, screens, count: screens.length };
    },
    {
      params: t.Object({
        flowId: t.String(),
      }),
    }
  )

  // Endpoint GET pour récupérer un écran (navigation initiale)
  .get(
    "/:flowId/:screenId",
    ({ params: { flowId, screenId } }) => buildScreenResponse(flowId, screenId),
    {
      params: t.Object({
        flowId: t.String(),
        screenId: t.String(),
      }),
    }
  )

  // Endpoint POST pour naviguer vers un écran (avec données du formulaire)
  .post(
    "/:flowId/:screenId",
    ({ params: { flowId, screenId }, body }) => {
      console.log(`[${flowId}/${screenId}] Received data:`, body);
      return buildScreenResponse(
        flowId,
        screenId,
        body as Record<string, unknown>
      );
    },
    {
      params: t.Object({
        flowId: t.String(),
        screenId: t.String(),
      }),
      body: t.Any(),
    }
  );
