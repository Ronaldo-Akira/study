# Product Vision

## Product

Study is a developer-focused app for learning technical topics through structured knowledge, active recall, and review. It begins with the knowledge in this repository: first iOS, then AI Engineering. It is initially built for its developer, with a direction that can serve other developers too.

## Why It Exists

The project joins deliberate learning with building a real application. Studying concepts prepares the developer to make informed implementation choices; building the app creates practical questions that deepen study. Not every concept needs to become a feature, and no feature should exist only to showcase a technology.

## Long-Term Direction

The app can grow from browsing knowledge into flashcards, quizzes, study history, explanations, question generation, answer feedback, and increasingly useful study recommendations. Retrieval over the knowledge base may help as content grows. These are directions for gradual development, not an initial scope commitment.

The repository's `docs/Learning/` is the initial content source. Early app versions may use bundled or transformed structured content. The domain should represent technical topics beyond iOS where natural, while user-imported content remains a future capability.

## Principles

- **Learn by building:** Connect product work to relevant learning without forcing every topic into the app.
- **Solve real needs:** Use deterministic application logic for reliable behavior such as progress calculations and history aggregation. Use AI when probabilistic or generative capabilities add meaningful value, such as explanations or evaluating free-text answers.
- **Grow incrementally:** Start with a useful non-AI study experience; add complexity when a product need justifies it.
- **Keep knowledge authoritative:** Repository learning notes remain canonical. AI-generated explanations and questions are study artifacts unless a future review workflow explicitly accepts changes to the knowledge base.
- **Start personal, leave room for others:** Optimize the first versions for this developer's content and workflow without making technical subject area an unnecessary domain constraint.
- **Aim for portfolio quality:** Prefer clear, tested, maintainable work while allowing architecture to evolve with actual requirements.
- **Defer production complexity:** Publishing may become a goal. It does not justify premature backend, synchronization, or scaling infrastructure.
