# Product Roadmap

This roadmap describes what to build; the [[docs/Learning/iOS/iOS Learning Roadmap|Learning Roadmap]] describes what to study. The plans should inform each other without becoming the same plan. Learning opportunities below are possibilities, not requirements to use a technology.

## Foundation Phase

### Goal

Build enough iOS and Swift understanding to begin implementing the app with informed choices.

### Capabilities

Continue focused study through value and reference semantics (studied), ARC and memory management, protocols, generics, error handling, and concurrency fundamentals. Begin product implementation after this checkpoint; exhaustive mastery is not a prerequisite.

### Learning Opportunities

Use focused experiments when they clarify a concept. Apply a concept in the app when it naturally solves a current problem; some topics may remain experiment-only.

### Explicitly Deferred

Do not require every roadmap topic to become a feature or block implementation until every topic is mastered.

## MVP 0 — Knowledge Browser

### Goal

Make the repository's technical knowledge useful in a simple study app.

### Capabilities

Browse knowledge areas and topics, open a topic, and read its study content. Initially focus on this repository's iOS learning material, with AI Engineering content added as that learning develops. Bundled or transformed structured content is sufficient.

Keep concepts such as study topics and knowledge areas open to other technical domains where that generality is natural and inexpensive.

### Learning Opportunities

SwiftUI views, navigation, state, content/domain modeling, `Codable` if useful, and focused tests.

### Explicitly Deferred

AI, accounts, user-imported vaults or files, runtime Obsidian/Markdown integration, remote content, and backend services.

## MVP 1 — Active Study

### Goal

Let the learner practice recall instead of only reading.

### Capabilities

Use manually authored flashcards and quiz questions in focused sessions. Reveal answers and record known/missed responses during a session.

### Learning Opportunities

Question and session modeling, state transitions, SwiftUI interaction, and tests for deterministic study behavior.

### Explicitly Deferred

AI-generated questions, adaptive scheduling, durable history, and complex scoring. Keep initial questions deterministic and trusted.

## MVP 2 — Progress and History

### Goal

Help the learner see what they studied and how their sessions are going.

### Capabilities

Persist attempts and sessions; show last studied, topic progress, correct/incorrect history, and basic statistics.

### Learning Opportunities

Local persistence, state restoration, data modeling, and aggregation of study history.

### Explicitly Deferred

Backend sync, accounts, advanced analytics, and AI analysis. Use normal application logic for reliable calculations and summaries.

## MVP 3 — AI Explanations

### Goal

Offer help understanding a concept or a missed answer when the learner asks for it.

### Capabilities

Request an explanation grounded in relevant trusted study content. Show loading, success, and failure states; keep the explanation separate from canonical notes.

### Learning Opportunities

Networking, async/await, error handling, API integration, prompt design, and response handling.

### Explicitly Deferred

Automatic knowledge-base edits, broad AI chat, and provider or backend abstractions without a demonstrated need.

## MVP 4 — AI-Generated Questions

### Goal

Expand practice material from trusted knowledge while retaining review and quality control.

### Capabilities

Generate candidate study questions from selected trusted content, validate their structure and relevance, and distinguish generated questions from manually authored content.

### Learning Opportunities

Structured responses, validation, provenance, and evaluation of generated content.

### Explicitly Deferred

Automatically making generated questions canonical or treating unreviewed output as guaranteed correct.

## MVP 5 — Free-Text Evaluation

### Goal

Help the learner find gaps between their explanation and the concepts a topic requires.

### Capabilities

Evaluate a free-text answer against trusted material and return useful feedback, such as covered ideas, omissions, or possible misconceptions.

### Learning Opportunities

Evaluation criteria, grounding, structured feedback, uncertainty, and ways to assess probabilistic model output.

### Explicitly Deferred

Treating an AI judgment as an authoritative grade or silently changing canonical knowledge.

## MVP 6 — Weak-Area Analysis

### Goal

Make study history useful for deciding what needs review.

### Capabilities

Identify topics with repeated missed answers, low recent performance, or overdue review using transparent, deterministic rules. Explain which observations led to each result.

### Learning Opportunities

History aggregation, interpretable measures, and testing analysis rules against example data.

### Explicitly Deferred

AI interpretation unless it adds value beyond deterministic analysis; opaque scoring and unsupported claims about mastery.

## Later — Recommendations and Personalized Study

### Goal

Help learners choose what to study next and adapt practice to their needs.

### Capabilities

Recommend topics or sessions using knowledge relationships and study history. Begin with understandable rules; consider AI for richer personalization only when it meaningfully improves recommendations.

### Learning Opportunities

Recommendation quality, user control, and evaluating whether personalization helps.

### Explicitly Deferred

Unexplained recommendations, complex adaptive systems, and personalization that lacks enough useful study data.

## Later — Retrieval, Content Growth, and Sync

### Goal

Keep study content and grounded assistance useful as the knowledge base and usage grow.

### Capabilities

Introduce content pipelines, remote content, APIs, backend services, synchronization, embeddings, or retrieval/RAG only when scale, multi-device use, or grounded responses create a real need. Retrieval may support explanations and related-topic suggestions when selecting relevant knowledge manually no longer scales.

### Learning Opportunities

Content transformation, networking, synchronization, embeddings, search, and retrieval evaluation as relevant to the product problem.

### Explicitly Deferred

Commitments to a specific backend, vector store, AI provider, or deployment architecture before a concrete requirement justifies them.
