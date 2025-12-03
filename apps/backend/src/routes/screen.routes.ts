import { Elysia, t } from "elysia";

/**
 * Routes pour la navigation dynamique des écrans
 *
 * Ces routes démontrent comment le serveur peut retourner des configurations
 * d'écran avec des instructions de navigation.
 *
 * Pour le bouton "Retour", utilisez apiEndpoint: ":back" qui déclenche
 * un Navigator.pop() standard côté client.
 */

// Écran 1: Formulaire de base
const screen1Config = {
  template: "screen_layout",
  props: {
    backgroundColor: "#FFFFFF",
    screenId: "step1",
  },
  header: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "text",
          props: {
            text: "Étape 1: Informations",
            type: "headline_medium",
            fontWeight: "bold",
          },
        },
      ],
    },
  ],
  content: [
    {
      type: "column",
      props: { crossAxisAlignment: "stretch" },
      children: [
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text_input",
              props: {
                label: "Prénom",
                hintText: "Entrez votre prénom",
                field: "firstName",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text_input",
              props: {
                label: "Nom",
                hintText: "Entrez votre nom",
                field: "lastName",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "progress_bar",
              props: {
                value: 33,
                showCounter: true,
              },
            },
          ],
        },
      ],
    },
  ],
  footer: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "button",
          props: {
            label: "Continuer",
            variant: "primary",
            isFullWidth: true,
            apiEndpoint: "/screens/step2",
          },
        },
      ],
    },
  ],
};

// Écran 2: Préférences
const screen2Config = {
  template: "screen_layout",
  props: {
    backgroundColor: "#FFFFFF",
    screenId: "step2",
  },
  header: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "text",
          props: {
            text: "Étape 2: Préférences",
            type: "headline_medium",
            fontWeight: "bold",
          },
        },
      ],
    },
  ],
  content: [
    {
      type: "column",
      props: { crossAxisAlignment: "stretch" },
      children: [
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text",
              props: {
                text: "Sélectionnez votre genre",
                type: "title_medium",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: { left: 16, right: 16, bottom: 16 } },
          children: [
            {
              type: "selectable_button_group",
              props: {
                labels: ["Homme", "Femme", "Autre"],
                field: "gender",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text",
              props: {
                text: "Vos centres d'intérêt",
                type: "title_medium",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: { left: 16, right: 16, bottom: 16 } },
          children: [
            {
              type: "selectable_tag_group",
              props: {
                labels: [
                  "Voyages",
                  "Musique",
                  "Sport",
                  "Cinéma",
                  "Cuisine",
                  "Art",
                ],
                field: "interests",
                defaultValue: [],
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "progress_bar",
              props: {
                value: 66,
                showCounter: true,
              },
            },
          ],
        },
      ],
    },
  ],
  footer: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "row",
          props: { mainAxisAlignment: "spaceBetween" },
          children: [
            {
              type: "button",
              props: {
                label: "Retour",
                variant: "outline",
                // :back déclenche un Navigator.pop() standard
                apiEndpoint: ":back",
              },
            },
            {
              type: "button",
              props: {
                label: "Continuer",
                variant: "primary",
                apiEndpoint: "/screens/step3",
              },
            },
          ],
        },
      ],
    },
  ],
};

// Écran 3: Confirmation
const screen3Config = {
  template: "screen_layout",
  props: {
    backgroundColor: "#FFFFFF",
    screenId: "step3",
  },
  header: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "text",
          props: {
            text: "Étape 3: Confirmation",
            type: "headline_medium",
            fontWeight: "bold",
          },
        },
      ],
    },
  ],
  content: [
    {
      type: "column",
      props: { crossAxisAlignment: "stretch" },
      children: [
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text",
              props: {
                text: "Vérifiez vos informations",
                type: "title_large",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "labeled_control",
              props: {
                htmlLabel:
                  "J'accepte les <a href='#'>conditions d'utilisation</a>",
                field: "acceptTerms",
                defaultValue: false,
                controlType: "checkbox",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "labeled_control",
              props: {
                htmlLabel: "Je souhaite recevoir la newsletter",
                field: "newsletter",
                defaultValue: true,
                controlType: "toggle",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "progress_bar",
              props: {
                value: 100,
                showCounter: true,
              },
            },
          ],
        },
      ],
    },
  ],
  footer: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "row",
          props: { mainAxisAlignment: "spaceBetween" },
          children: [
            {
              type: "button",
              props: {
                label: "Retour",
                variant: "outline",
                // :back déclenche un Navigator.pop() standard
                apiEndpoint: ":back",
              },
            },
            {
              type: "button",
              props: {
                label: "Terminer",
                variant: "primary",
                apiEndpoint: "/screens/complete",
              },
            },
          ],
        },
      ],
    },
  ],
};

// Écran de succès
const successConfig = {
  template: "screen_layout",
  props: {
    backgroundColor: "#E8F5E9",
    screenId: "success",
  },
  header: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "text",
          props: {
            text: "Inscription réussie !",
            type: "headline_medium",
            fontWeight: "bold",
          },
        },
      ],
    },
  ],
  content: [
    {
      type: "column",
      props: {
        crossAxisAlignment: "center",
        mainAxisAlignment: "center",
      },
      children: [
        {
          type: "padding",
          props: { padding: 32 },
          children: [
            {
              type: "text",
              props: {
                text: "Merci pour votre inscription !",
                type: "title_large",
                textAlign: "center",
              },
            },
          ],
        },
        {
          type: "padding",
          props: { padding: 16 },
          children: [
            {
              type: "text",
              props: {
                text: "Vos informations ont été enregistrées avec succès.",
                type: "body_large",
                textAlign: "center",
              },
            },
          ],
        },
      ],
    },
  ],
  footer: [
    {
      type: "container",
      props: { padding: 16 },
      children: [
        {
          type: "button",
          props: {
            label: "Recommencer",
            variant: "primary",
            isFullWidth: true,
            apiEndpoint: "/screens/restart",
          },
        },
      ],
    },
  ],
};

// Map des configs par screenId
const screenConfigs: Record<string, object> = {
  step1: screen1Config,
  step2: screen2Config,
  step3: screen3Config,
  success: successConfig,
};

export const screenRoutes = new Elysia({ prefix: "/api/screens" })
  // Route GET générique pour récupérer un écran par son ID
  .get(
    "/:screenId",
    ({ params: { screenId } }) => {
      const config = screenConfigs[screenId];
      if (!config) {
        return {
          error: "Screen not found",
          screenId,
        };
      }
      return {
        screen: config,
        formValues: {},
      };
    },
    {
      params: t.Object({
        screenId: t.String(),
      }),
    }
  )

  // Obtenir l'écran initial (legacy, redirige vers step1)
  .get("/initial", () => ({
    navigation: {
      type: "refresh",
      scope: "full",
    },
    screen: screen1Config,
    formValues: {},
  }))

  // Navigation vers étape 2
  .post(
    "/step2",
    ({ body }) => {
      console.log("Step 2 - Received data:", body);
      return {
        navigation: {
          type: "navigate",
          direction: "left",
          scope: "content",
          durationMs: 300,
        },
        screen: screen2Config,
        formValues: body as Record<string, unknown>,
      };
    },
    {
      body: t.Any(),
    }
  )

  // Navigation vers étape 3
  .post(
    "/step3",
    ({ body }) => {
      console.log("Step 3 - Received data:", body);
      return {
        navigation: {
          type: "navigate",
          direction: "left",
          scope: "content",
          durationMs: 300,
        },
        screen: screen3Config,
        formValues: body as Record<string, unknown>,
      };
    },
    {
      body: t.Any(),
    }
  )

  // Finalisation de l'inscription
  .post(
    "/complete",
    ({ body }) => {
      console.log("Complete - Final data:", body);
      return {
        navigation: {
          type: "navigate",
          direction: "up",
          scope: "full",
          durationMs: 400,
        },
        screen: successConfig,
        formValues: body as Record<string, unknown>,
      };
    },
    {
      body: t.Any(),
    }
  )

  // Recommencer
  .post(
    "/restart",
    ({ body }) => {
      console.log("Restart");
      return {
        navigation: {
          type: "navigate",
          direction: "down",
          scope: "full",
          durationMs: 400,
        },
        screen: screen1Config,
        formValues: {},
      };
    },
    {
      body: t.Any(),
    }
  );
