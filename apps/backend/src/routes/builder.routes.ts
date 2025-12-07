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

function buildFileTree(basePath: string, relativePath: string = ""): FileTreeItem[] {
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
export const builderRoutes = new Elysia({ prefix: "/api/builder" })
  // Lister tous les fichiers (arborescence complète)
  .get("/files", () => {
    const tree = buildFileTree(assetsPath);
    return { tree };
  })

  // Lire un fichier JSON
  .get(
    "/files/*",
    ({ params }) => {
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
    }
  )

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
  .delete(
    "/files/*",
    ({ params }) => {
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
    }
  )

  // Créer un dossier
  .post(
    "/folders/*",
    ({ params }) => {
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
    }
  )

  // Supprimer un dossier (vide)
  .delete(
    "/folders/*",
    ({ params }) => {
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
    }
  )

  // Obtenir les specs des composants disponibles
  .get("/component-specs", () => {
    // Liste des types de composants disponibles avec leurs propriétés
    const specs = {
      templates: [
        {
          type: "screen_layout",
          label: "Screen Layout",
          description: "Layout standard avec header, content, footer",
          props: {
            backgroundColor: { type: "color", default: "#FFFFFF" },
            topBarHeight: { type: "number", default: 80 },
            screenId: { type: "string", required: true },
          },
        },
        {
          type: "landing",
          label: "Landing Screen",
          description: "Landing page avec background image",
          props: {
            brand: { type: "enum", values: ["match", "meetic", "okc", "pof"], required: true },
            backgroundImageMobile: { type: "string" },
            backgroundImageDesktop: { type: "string" },
            mobileLogoType: { type: "enum", values: ["small", "onDark", "onWhite"], default: "onDark" },
            desktopLogoType: { type: "enum", values: ["small", "onDark", "onWhite"], default: "small" },
          },
        },
      ],
      atoms: [
        {
          type: "text",
          label: "Texte",
          description: "Affiche du texte",
          props: {
            text: { type: "string", required: true },
            type: { type: "enum", values: ["headline_large", "headline_medium", "headline_small", "body_large", "body_medium", "body_small", "label_large", "label_medium", "label_small"], default: "body_medium" },
            fontWeight: { type: "enum", values: ["normal", "bold", "w100", "w200", "w300", "w400", "w500", "w600", "w700", "w800", "w900"] },
            color: { type: "color" },
            textAlign: { type: "enum", values: ["left", "center", "right", "justify"] },
          },
        },
        {
          type: "button",
          label: "Bouton",
          description: "Bouton interactif",
          props: {
            label: { type: "string", required: true },
            variant: { type: "enum", values: ["primary", "secondary", "tertiary", "ghost"], default: "primary" },
            isFullWidth: { type: "boolean", default: false },
            apiEndpoint: { type: "string" },
            exit: { type: "string" },
          },
        },
        {
          type: "text_input",
          label: "Champ texte",
          description: "Champ de saisie texte",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
            hintText: { type: "string" },
            isRequired: { type: "boolean", default: false },
            isPassword: { type: "boolean", default: false },
          },
        },
        {
          type: "checkbox",
          label: "Checkbox",
          description: "Case à cocher",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
          },
        },
        {
          type: "toggle",
          label: "Toggle",
          description: "Interrupteur on/off",
          props: {
            field: { type: "string", required: true },
            label: { type: "string" },
          },
        },
        {
          type: "slider",
          label: "Slider",
          description: "Curseur de valeur",
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
          label: "Barre de progression",
          description: "Indicateur de progression",
          props: {
            value: { type: "number", required: true },
            showCounter: { type: "boolean", default: false },
          },
        },
        {
          type: "icon",
          label: "Icône",
          description: "Icône Material",
          props: {
            icon: { type: "string", required: true },
            size: { type: "number", default: 24 },
            color: { type: "color" },
          },
        },
        {
          type: "logo",
          label: "Logo",
          description: "Logo de marque",
          props: {
            brand: { type: "enum", values: ["match", "meetic", "okc", "pof"], required: true },
            type: { type: "enum", values: ["small", "onDark", "onWhite"], default: "small" },
            height: { type: "number" },
          },
        },
      ],
      molecules: [
        {
          type: "header",
          label: "Header",
          description: "En-tête avec titre et bouton retour",
          props: {
            title: { type: "string" },
            subtitle: { type: "string" },
            showBackButton: { type: "boolean", default: true },
          },
        },
        {
          type: "selection_group",
          label: "Groupe de sélection",
          description: "Groupe de radio buttons ou checkboxes",
          props: {
            field: { type: "string", required: true },
            options: { type: "array", items: { label: "string", value: "string" }, required: true },
            isMultiple: { type: "boolean", default: false },
          },
        },
        {
          type: "selectable_button_group",
          label: "Groupe de boutons sélectionnables",
          description: "Grille de boutons sélectionnables",
          props: {
            field: { type: "string", required: true },
            options: { type: "array", items: { label: "string", value: "string" }, required: true },
            isMultiple: { type: "boolean", default: false },
            columns: { type: "number", default: 2 },
          },
        },
      ],
      layouts: [
        {
          type: "container",
          label: "Container",
          description: "Conteneur simple",
          hasChildren: true,
          props: {
            padding: { type: "number" },
            margin: { type: "number" },
            color: { type: "color" },
          },
        },
        {
          type: "column",
          label: "Colonne",
          description: "Disposition verticale",
          hasChildren: true,
          props: {
            mainAxisAlignment: { type: "enum", values: ["start", "end", "center", "spaceBetween", "spaceAround", "spaceEvenly"], default: "start" },
            crossAxisAlignment: { type: "enum", values: ["start", "end", "center", "stretch"], default: "center" },
            spacing: { type: "number" },
          },
        },
        {
          type: "row",
          label: "Ligne",
          description: "Disposition horizontale",
          hasChildren: true,
          props: {
            mainAxisAlignment: { type: "enum", values: ["start", "end", "center", "spaceBetween", "spaceAround", "spaceEvenly"], default: "start" },
            crossAxisAlignment: { type: "enum", values: ["start", "end", "center", "stretch"], default: "center" },
            spacing: { type: "number" },
          },
        },
        {
          type: "padding",
          label: "Padding",
          description: "Ajoute un espacement interne",
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
          description: "Remplit l'espace disponible",
          hasChildren: true,
          props: {
            flex: { type: "number", default: 1 },
          },
        },
        {
          type: "sized_box",
          label: "SizedBox",
          description: "Boîte de taille fixe",
          hasChildren: true,
          props: {
            width: { type: "number" },
            height: { type: "number" },
          },
        },
        {
          type: "center",
          label: "Center",
          description: "Centre le contenu",
          hasChildren: true,
          props: {},
        },
        {
          type: "scrollable",
          label: "Scrollable",
          description: "Zone défilable",
          hasChildren: true,
          props: {
            direction: { type: "enum", values: ["vertical", "horizontal"], default: "vertical" },
          },
        },
      ],
    };

    return specs;
  });

