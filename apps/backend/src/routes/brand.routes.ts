import { Elysia, t } from "elysia";
import type { Brand, BrandConfig } from "../types/brand.types";

// Mock database for demonstration
const brandConfigs: Record<Brand, BrandConfig> = {
  match: {
    id: "match",
    name: "Match",
    primaryColor: "#11144C",
    secondaryColor: "#2A2D7C",
    backgroundColor: "#FFFFFF",
    surfaceColor: "#F8F8F8",
    features: ["messaging", "likes", "super-likes", "boost"],
    apiEndpoints: {
      base: "https://api.match.com",
      auth: "/v1/auth",
      profiles: "/v1/profiles",
    },
  },
  meetic: {
    id: "meetic",
    name: "Meetic",
    primaryColor: "#E9006D",
    secondaryColor: "#FF4D9A",
    backgroundColor: "#FFFFFF",
    surfaceColor: "#F5F4F9",
    features: ["messaging", "likes", "events", "boost"],
    apiEndpoints: {
      base: "https://api.meetic.com",
      auth: "/v1/auth",
      profiles: "/v1/profiles",
    },
  },
  okc: {
    id: "okc",
    name: "OKCupid",
    primaryColor: "#0046D5",
    secondaryColor: "#002A80",
    backgroundColor: "#FFFFFF",
    surfaceColor: "#F0F9FF",
    features: ["messaging", "likes", "questions", "personality-match"],
    apiEndpoints: {
      base: "https://api.okcupid.com",
      auth: "/v1/auth",
      profiles: "/v1/profiles",
    },
  },
  pof: {
    id: "pof",
    name: "Plenty of Fish",
    primaryColor: "#000000",
    secondaryColor: "#4ECDC4",
    backgroundColor: "#FFFFFF",
    surfaceColor: "#FFF5F0",
    features: ["messaging", "likes", "meet-me", "live-streams"],
    apiEndpoints: {
      base: "https://api.pof.com",
      auth: "/v1/auth",
      profiles: "/v1/profiles",
    },
  },
};

export const brandRoutes = new Elysia({ prefix: "/api/brands" })
  // Get all brands
  .get("/", () => ({
    brands: Object.values(brandConfigs).map((config) => ({
      id: config.id,
      name: config.name,
    })),
  }))
  // Get specific brand configuration
  .get(
    "/:brandId",
    ({ params: { brandId }, error }) => {
      const brand = brandConfigs[brandId as Brand];

      if (!brand) {
        return error(404, {
          message: `Brand '${brandId}' not found`,
          availableBrands: Object.keys(brandConfigs),
        });
      }

      return {
        brand,
      };
    },
    {
      params: t.Object({
        brandId: t.String(),
      }),
    }
  )
  // Get brand theme colors
  .get(
    "/:brandId/theme",
    ({ params: { brandId }, error }) => {
      const brand = brandConfigs[brandId as Brand];

      if (!brand) {
        return error(404, {
          message: `Brand '${brandId}' not found`,
        });
      }

      return {
        id: brand.id,
        name: brand.name,
        colors: {
          primary: brand.primaryColor,
          secondary: brand.secondaryColor,
          background: brand.backgroundColor,
          surface: brand.surfaceColor,
        },
      };
    },
    {
      params: t.Object({
        brandId: t.String(),
      }),
    }
  )
  // Get brand features
  .get(
    "/:brandId/features",
    ({ params: { brandId }, error }) => {
      const brand = brandConfigs[brandId as Brand];

      if (!brand) {
        return error(404, {
          message: `Brand '${brandId}' not found`,
        });
      }

      return {
        id: brand.id,
        name: brand.name,
        features: brand.features,
      };
    },
    {
      params: t.Object({
        brandId: t.String(),
      }),
    }
  )
  // Check if feature is enabled for brand
  .get(
    "/:brandId/features/:feature",
    ({ params: { brandId, feature }, error }) => {
      const brand = brandConfigs[brandId as Brand];

      if (!brand) {
        return error(404, {
          message: `Brand '${brandId}' not found`,
        });
      }

      return {
        id: brand.id,
        name: brand.name,
        feature,
        enabled: brand.features.includes(feature),
      };
    },
    {
      params: t.Object({
        brandId: t.String(),
        feature: t.String(),
      }),
    }
  );
