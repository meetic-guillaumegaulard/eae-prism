import { Elysia, t } from "elysia";
import {
  readFileSync,
  writeFileSync,
  existsSync,
  readdirSync,
  statSync,
  mkdirSync,
  unlinkSync,
  rmdirSync,
} from "fs";
import { resolve, dirname, join } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const assetsPath = resolve(__dirname, "dynamic-pages/assets");

/**
 * Liste récursive de tous les fichiers JSON
 */
interface FileTreeItem {
  name: string;
  type: "folder" | "file";
  path: string;
  children?: FileTreeItem[];
}

function buildFileTree(
  basePath: string,
  relativePath: string = ""
): FileTreeItem[] {
  const fullPath = join(basePath, relativePath);
  if (!existsSync(fullPath)) return [];

  const entries = readdirSync(fullPath);
  const items: FileTreeItem[] = [];

  for (const entry of entries) {
    const entryPath = join(fullPath, entry);
    const entryRelativePath = relativePath ? `${relativePath}/${entry}` : entry;
    const stat = statSync(entryPath);

    if (stat.isDirectory()) {
      items.push({
        name: entry,
        type: "folder",
        path: entryRelativePath,
        children: buildFileTree(basePath, entryRelativePath),
      });
    } else if (entry.endsWith(".json")) {
      items.push({
        name: entry.replace(".json", ""),
        type: "file",
        path: entryRelativePath.replace(".json", ""),
      });
    }
  }

  return items;
}

/**
 * Routes pour l'édition des fichiers JSON (builder)
 */

/**
 * Représente un noeud dans le graphe de fichiers
 */
interface GraphNode {
  id: string;
  label: string;
  type: "screen" | "logic";
  path: string;
}

/**
 * Représente un lien entre deux fichiers
 */
interface GraphEdge {
  source: string;
  target: string;
  label?: string;
}

/**
 * Analyse le contenu d'un fichier pour trouver les liens sortants
 */
function analyzeFileLinks(content: any): string[] {
  const links: string[] = [];

  function traverse(obj: any) {
    if (!obj) return;

    if (typeof obj === "object") {
      // Vérifier si c'est une propriété apiEndpoint
      if (obj.apiEndpoint && typeof obj.apiEndpoint === "string") {
        links.push(obj.apiEndpoint);
      }
      // Vérifier si c'est une propriété exit
      if (obj.exit && typeof obj.exit === "string") {
        links.push(obj.exit);
      }

      // Parcourir les enfants
      for (const key in obj) {
        traverse(obj[key]);
      }
    } else if (Array.isArray(obj)) {
      obj.forEach(traverse);
    }
  }

  traverse(content);
  return links;
}

export const builderRoutes = new Elysia({ prefix: "/api/builder" })
  // ... (existing routes)

  // Obtenir le graphe de fichiers pour un dossier
  .get("/graph/*", ({ params }) => {
    const path = (params as { "*": string })["*"];
    const folderPath = join(assetsPath, path);

    if (!existsSync(folderPath)) {
      return { error: "Folder not found", path };
    }

    const nodes: GraphNode[] = [];
    const edges: GraphEdge[] = [];
    const files = readdirSync(folderPath).filter((f) => f.endsWith(".json"));

    // 1. Créer les noeuds
    for (const file of files) {
      const fileName = file.replace(".json", "");
      const filePath = join(folderPath, file);

      nodes.push({
        id: fileName,
        label: fileName,
        type: "screen",
        path: `${path}/${fileName}`,
      });
    }

    // 2. Analyser les liens
    for (const file of files) {
      const sourceId = file.replace(".json", "");
      const filePath = join(folderPath, file);

      try {
        const content = JSON.parse(readFileSync(filePath, "utf-8"));
        const links = analyzeFileLinks(content);

        for (const link of links) {
          // Résoudre le lien vers un ID de fichier
          // Ex: "/dynamic-pages/meetic/profile-capture/step2" -> "step2"
          // Ex: ":back" -> ignored or special node

          if (link === ":back") continue;

          const parts = link.split("/");
          const targetId = parts[parts.length - 1];

          // Vérifier si la cible existe dans ce dossier (ou lien externe ?)
          // Pour l'instant on assume que c'est dans le même dossier si c'est un ID simple
          // ou si le chemin correspond

          if (nodes.find((n) => n.id === targetId)) {
            edges.push({
              source: sourceId,
              target: targetId,
              label: "navigates to",
            });
          }
        }
      } catch (e) {
        console.error(`Error parsing ${file} for graph:`, e);
      }
    }

    return { nodes, edges };
  })

  // Lister tous les fichiers (arborescence complète)

  .get("/files", () => {
    const tree = buildFileTree(assetsPath);
    return { tree };
  })

  // Lire un fichier JSON
  .get("/files/*", ({ params }) => {
    const path = (params as { "*": string })["*"];
    const filePath = join(assetsPath, `${path}.json`);

    if (!existsSync(filePath)) {
      return { error: "File not found", path };
    }

    try {
      const content = readFileSync(filePath, "utf-8");
      return { path, content: JSON.parse(content) };
    } catch (error) {
      return { error: "Failed to read file", details: String(error) };
    }
  })

  // Créer ou mettre à jour un fichier JSON
  .put(
    "/files/*",
    ({ params, body }) => {
      const path = (params as { "*": string })["*"];
      const filePath = join(assetsPath, `${path}.json`);

      // Créer le dossier parent si nécessaire
      const parentDir = dirname(filePath);
      if (!existsSync(parentDir)) {
        mkdirSync(parentDir, { recursive: true });
      }

      try {
        const content = JSON.stringify(body, null, 2);
        writeFileSync(filePath, content, "utf-8");
        return { success: true, path };
      } catch (error) {
        return { error: "Failed to write file", details: String(error) };
      }
    },
    {
      body: t.Any(),
    }
  )

  // Supprimer un fichier JSON
  .delete("/files/*", ({ params }) => {
    const path = (params as { "*": string })["*"];
    const filePath = join(assetsPath, `${path}.json`);

    if (!existsSync(filePath)) {
      return { error: "File not found", path };
    }

    try {
      unlinkSync(filePath);
      return { success: true, path };
    } catch (error) {
      return { error: "Failed to delete file", details: String(error) };
    }
  })

  // Créer un dossier
  .post("/folders/*", ({ params }) => {
    const path = (params as { "*": string })["*"];
    const folderPath = join(assetsPath, path);

    if (existsSync(folderPath)) {
      return { error: "Folder already exists", path };
    }

    try {
      mkdirSync(folderPath, { recursive: true });
      return { success: true, path };
    } catch (error) {
      return { error: "Failed to create folder", details: String(error) };
    }
  })

  // Supprimer un dossier (vide)
  .delete("/folders/*", ({ params }) => {
    const path = (params as { "*": string })["*"];
    const folderPath = join(assetsPath, path);

    if (!existsSync(folderPath)) {
      return { error: "Folder not found", path };
    }

    try {
      rmdirSync(folderPath, { recursive: true });
      return { success: true, path };
    } catch (error) {
      return { error: "Failed to delete folder", details: String(error) };
    }
  })

  // Obtenir les specs des composants disponibles
  .get("/component-specs", () => {
    // Liste des types de composants disponibles avec leurs propriétés
    const specs = {
      templates: [
        {
          type: "screen_layout",
          label: "Screen Layout",
          description: "Standard layout with header, content, footer",
          props: {
            backgroundColor: { type: "color", default: "#FFFFFF" },
            topBarHeight: { type: "number", default: 80 },
            screenId: { type: "string", required: true },
          },
        },
        {
          type: "landing",
          label: "Landing Screen",
          description: "Landing page with background image",
          props: {
            brand: {
              type: "enum",
              values: ["match", "meetic", "okc", "pof"],
              required: true,
            },
            backgroundImageMobile: { type: "string" },
            backgroundImageDesktop: { type: "string" },
            mobileLogoType: {
              type: "enum",
              values: ["small", "onDark", "onWhite"],
              default: "onDark",
            },
            desktopLogoType: {
              type: "enum",
              values: ["small", "onDark", "onWhite"],
              default: "small",
            },
          },
        },
      ],
      atoms: [
        {
          type: "text",
          label: "Text",
          description: "Displays text",
          props: {
            text: { type: "string", required: true },
            type: {
              type: "enum",
              values: [
                "headline_large",
                "headline_medium",
                "headline_small",
                "body_large",
                "body_medium",
                "body_small",
                "label_large",
                "label_medium",
                "label_small",
              ],
              default: "body_medium",
            },
            fontWeight: {
              type: "enum",
              values: [
                "normal",
                "bold",
                "w100",
                "w200",
                "w300",
                "w400",
                "w500",
                "w600",
                "w700",
                "w800",
                "w900",
              ],
            },
            color: { type: "color" },
            textAlign: {
              type: "enum",
              values: ["left", "center", "right", "justify"],
            },
          },
        },
        {
          type: "button",
          label: "Button",
          description: "Interactive button",
          props: {
            label: { type: "string", required: true },
            variant: {
              type: "enum",
              values: ["primary", "secondary", "tertiary", "ghost"],
              default: "primary",
            },
            isFullWidth: { type: "boolean", default: false },
            apiEndpoint: { type: "string" },
            exit: { type: "string" },
          },
        },
        {
          type: "text_input",
          label: "Text Input",
          description: "Text input field",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
            hintText: { type: "string" },
            defaultValue: { type: "string" },
            obscureText: { type: "boolean", default: false },
            enabled: { type: "boolean", default: true },
            errorText: { type: "string" },
          },
        },
        {
          type: "checkbox",
          label: "Checkbox",
          description: "Checkbox input",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
          },
        },
        {
          type: "toggle",
          label: "Toggle",
          description: "On/off switch",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
          },
        },
        {
          type: "slider",
          label: "Slider",
          description: "Value slider",
          props: {
            field: { type: "string", required: true },
            min: { type: "number", default: 0 },
            max: { type: "number", default: 100 },
            divisions: { type: "number" },
            label: { type: "string" },
          },
        },
        {
          type: "progress_bar",
          label: "Progress Bar",
          description: "Progress indicator",
          props: {
            value: { type: "number", required: true },
            showCounter: { type: "boolean", default: false },
          },
        },
        {
          type: "icon",
          label: "Icon",
          description: "Material icon",
          props: {
            icon: { type: "string", required: true },
            size: { type: "number", default: 24 },
            color: { type: "color" },
          },
        },
        {
          type: "logo",
          label: "Logo",
          description: "Brand logo",
          props: {
            brand: {
              type: "enum",
              values: ["match", "meetic", "okc", "pof"],
              required: true,
            },
            type: {
              type: "enum",
              values: ["small", "onDark", "onWhite"],
              default: "small",
            },
            height: { type: "number" },
          },
        },
      ],
      molecules: [
        {
          type: "header",
          label: "Header",
          description: "Header with title and back button",
          props: {
            title: { type: "string" },
            subtitle: { type: "string" },
            showBackButton: { type: "boolean", default: true },
          },
        },
        {
          type: "selection_group",
          label: "Selection Group",
          description: "Group of radio buttons or checkboxes",
          props: {
            field: { type: "string", required: true },
            options: {
              type: "array",
              items: { label: "string", value: "string" },
              required: true,
            },
            isMultiple: { type: "boolean", default: false },
          },
        },
        {
          type: "selectable_button_group",
          label: "Selectable Button Group",
          description: "Grid of selectable buttons",
          props: {
            field: { type: "string", required: true },
            options: {
              type: "array",
              items: { label: "string", value: "string" },
              required: true,
            },
            isMultiple: { type: "boolean", default: false },
            columns: { type: "number", default: 2 },
          },
        },
        {
          type: "labeled_control",
          label: "Labeled Control",
          description: "Label with checkbox or toggle",
          props: {
            htmlLabel: { type: "string" },
            label: { type: "string" },
            field: { type: "string" },
            controlType: {
              type: "enum",
              values: ["checkbox", "toggle"],
              default: "checkbox",
            },
            defaultValue: { type: "boolean", default: false },
            expanded: { type: "boolean", default: true },
          },
        },
        {
          type: "selectable_tag_group",
          label: "Tag Group",
          description: "Selectable cloud of tags",
          props: {
            field: { type: "string" },
            labels: {
              type: "array",
              items: { type: "string" },
              required: true,
            },
            title: { type: "string" },
            defaultValue: { type: "array", items: { type: "string" } },
            tagSize: {
              type: "enum",
              values: ["small", "medium", "large"],
              default: "medium",
            },
            tagSpacing: { type: "number", default: 8.0 },
          },
        },
      ],
      layouts: [
        {
          type: "container",
          label: "Container",
          description: "Simple container",
          hasChildren: true,
          props: {
            padding: { type: "number" },
            margin: { type: "number" },
            color: { type: "color" },
          },
        },
        {
          type: "column",
          label: "Column",
          description: "Vertical arrangement",
          hasChildren: true,
          props: {
            mainAxisAlignment: {
              type: "enum",
              values: [
                "start",
                "end",
                "center",
                "spaceBetween",
                "spaceAround",
                "spaceEvenly",
              ],
              default: "start",
            },
            crossAxisAlignment: {
              type: "enum",
              values: ["start", "end", "center", "stretch"],
              default: "center",
            },
            spacing: { type: "number" },
          },
        },
        {
          type: "row",
          label: "Row",
          description: "Horizontal arrangement",
          hasChildren: true,
          props: {
            mainAxisAlignment: {
              type: "enum",
              values: [
                "start",
                "end",
                "center",
                "spaceBetween",
                "spaceAround",
                "spaceEvenly",
              ],
              default: "start",
            },
            crossAxisAlignment: {
              type: "enum",
              values: ["start", "end", "center", "stretch"],
              default: "center",
            },
            spacing: { type: "number" },
          },
        },
        {
          type: "padding",
          label: "Padding",
          description: "Adds internal spacing",
          hasChildren: true,
          props: {
            padding: { type: "number" },
            paddingHorizontal: { type: "number" },
            paddingVertical: { type: "number" },
            paddingTop: { type: "number" },
            paddingBottom: { type: "number" },
            paddingLeft: { type: "number" },
            paddingRight: { type: "number" },
          },
        },
        {
          type: "expanded",
          label: "Expanded",
          description: "Fills available space",
          hasChildren: true,
          props: {
            flex: { type: "number", default: 1 },
          },
        },
        {
          type: "sized_box",
          label: "SizedBox",
          description: "Fixed size box",
          hasChildren: true,
          props: {
            width: { type: "number" },
            height: { type: "number" },
          },
        },
        {
          type: "center",
          label: "Center",
          description: "Centers content",
          hasChildren: true,
          props: {},
        },
        {
          type: "scrollable",
          label: "Scrollable",
          description: "Scrollable area",
          hasChildren: true,
          props: {
            direction: {
              type: "enum",
              values: ["vertical", "horizontal"],
              default: "vertical",
            },
          },
        },
      ],
    };

    return specs;
  });
