import { Elysia, t } from "elysia";

// OpenAI API Key - must be set via environment variable
const OPENAI_API_KEY = process.env.OPENAI_API_KEY || "";

const SYSTEM_PROMPT = `You are an expert in interest recommendation.
The user is telling you about their preferences. You must analyze WHAT THEY ARE SAYING NOW and return a JSON with two arrays:
- "toAdd": IDs to ADD (what they like, what interests them) - MAXIMUM 10 items
- "toRemove": IDs to REMOVE (what they DON'T like, what they want to exclude)

IMPORTANT RULES:
1. Analyze ONLY the user's new sentence
2. If the user says "I like X", "I love X", "I enjoy X" → add X to toAdd (MAX 10 most relevant)
3. If the user says "I don't like X", "not X", "except X", "no X" → add X to toRemove
4. Understand synonyms (sporty = sports, coding = programming, etc.)
5. Be PRECISE and SELECTIVE: choose the most relevant interests, not an entire category
6. STRICT LIMIT: maximum 10 items in toAdd
7. Return ONLY the JSON, nothing else

OUTPUT FORMAT (MANDATORY):
{"toAdd": [1, 5, 23], "toRemove": [12, 45]}

If nothing to add: {"toAdd": [], "toRemove": [12]}
If nothing to remove: {"toAdd": [1, 5], "toRemove": []}`;

export const aiRoutes = new Elysia({ prefix: "/api/ai" }).post(
  "/recommend",
  async ({ body }) => {
    const { userQuery, interests, currentlySelected } = body;

    if (!userQuery || !interests) {
      return {
        error: "Missing userQuery or interests",
        toAdd: [],
        toRemove: [],
      };
    }

    try {
      // Construit le contexte avec les intérêts disponibles
      const interestsJson = JSON.stringify(
        interests.map((i: any) => ({
          id: i.id,
          name: i.name,
          category: i.category,
        }))
      );

      // List of already selected interests
      const selectedInfo =
        currentlySelected && currentlySelected.length > 0
          ? `\n\nInterests ALREADY SELECTED by the user: ${JSON.stringify(
              currentlySelected
            )}`
          : "";

      const systemPrompt = `${SYSTEM_PROMPT}\n\nAvailable hobbies list:\n${interestsJson}${selectedInfo}`;

      // Log la requête
      console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      console.log("📝 Text sent to AI:", userQuery);
      console.log("📊 Already selected:", currentlySelected || []);
      console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      // Appel à l'API OpenAI
      const response = await fetch(
        "https://api.openai.com/v1/chat/completions",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${OPENAI_API_KEY}`,
          },
          body: JSON.stringify({
            model: "gpt-4o-mini",
            messages: [
              { role: "system", content: systemPrompt },
              { role: "user", content: userQuery },
            ],
            temperature: 0.2,
            max_tokens: 300,
          }),
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        console.error("OpenAI API error:", errorText);
        return {
          error: `OpenAI API error: ${response.status}`,
          toAdd: [],
          toRemove: [],
          raw: errorText,
        };
      }

      const data = await response.json();
      const rawResponse = data.choices?.[0]?.message?.content || "";
      console.log("🤖 Raw AI response:", rawResponse);

      // Parse le JSON de la réponse
      let toAdd: number[] = [];
      let toRemove: number[] = [];

      try {
        let cleanResponse = rawResponse.trim();
        // Enlève les backticks markdown si présents
        if (cleanResponse.startsWith("```")) {
          cleanResponse = cleanResponse.replace(/^```\w*\n?/, "");
          cleanResponse = cleanResponse.replace(/\n?```$/, "");
        }
        cleanResponse = cleanResponse.trim();

        const parsed = JSON.parse(cleanResponse);
        toAdd = Array.isArray(parsed.toAdd)
          ? parsed.toAdd.filter((n: any) => typeof n === "number").slice(0, 10) // Max 10
          : [];
        toRemove = Array.isArray(parsed.toRemove)
          ? parsed.toRemove.filter((n: any) => typeof n === "number")
          : [];
      } catch (e) {
        console.error("Parse error:", e, "Raw:", rawResponse);
        // Fallback: essaie de parser comme un simple tableau (ancien format)
        try {
          const arr = JSON.parse(rawResponse.trim());
          if (Array.isArray(arr)) {
            toAdd = arr.filter((n: any) => typeof n === "number");
          }
        } catch {}
      }

      console.log("✅ Final result - toAdd:", toAdd, "toRemove:", toRemove);

      return {
        toAdd,
        toRemove,
        raw: rawResponse,
      };
    } catch (error) {
      console.error("AI route error:", error);
      return {
        error: String(error),
        toAdd: [],
        toRemove: [],
      };
    }
  },
  {
    body: t.Object({
      userQuery: t.String(),
      interests: t.Array(
        t.Object({
          id: t.Number(),
          name: t.String(),
          category: t.String(),
        })
      ),
      currentlySelected: t.Optional(t.Array(t.Number())),
    }),
  }
);
