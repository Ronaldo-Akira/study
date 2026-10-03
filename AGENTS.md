# Repository Guidelines

## Project Structure & Module Organization

This repository contains a SwiftUI iOS app with three Xcode targets: `study`, `studyTests`, and `studyUITests`.

- `study/`: app code. `studyApp.swift` is the entry point; `ContentView.swift` defines the initial screen.
- `study/Assets.xcassets/`: app icons, accent colors, and other image or color assets.
- `studyTests/`: unit tests.
- `studyUITests/`: UI and launch-performance tests.
- `study.xcodeproj/`: project and build configuration.

Source and test directories use Xcode filesystem synchronization. Add files to the appropriate directory; avoid manually adding individual file references to `project.pbxproj`.

## Build, Test, and Development Commands

Use Xcode with an iOS SDK supporting the configured minimum deployment target, iOS 18.6.

```sh
open study.xcodeproj
xcodebuild -project study.xcodeproj -scheme study -showdestinations
xcodebuild -project study.xcodeproj -scheme study -sdk iphonesimulator build
xcodebuild -project study.xcodeproj -scheme study \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_UUID>' test
```

These commands open the project, list destinations, build for the simulator, and run tests. Replace `<SIMULATOR_UUID>` with an available destination identifier. To run interactively, select the `study` scheme and a simulator in Xcode, then press Command-R.

## Coding Style & Naming Conventions

Follow the existing four-space indentation and Swift conventions: `UpperCamelCase` for new types and `lowerCamelCase` for properties and functions. Match filenames to their primary type. Keep SwiftUI views readable and place previews alongside their views. No formatter or linter configuration is currently checked in.

## Testing Guidelines

Unit tests use Swift Testing (`import Testing`, `@Test`, `#expect`). UI tests use XCTest (`XCTestCase`, `XCUIApplication`). Give unit tests descriptive behavior names; XCTest methods must start with `test`. Add meaningful tests for changed behavior and run the relevant suites before submitting. No coverage threshold is currently configured.

## Commit & Pull Request Guidelines

Git history currently contains only `Initial Commit`, so no established commit convention is evident. Use concise, imperative messages describing the change. Pull requests should explain the purpose, summarize behavior changes, record validation performed, and link relevant issues. Include screenshots for visible UI changes. Keep unrelated changes out of the pull request.

## AI-Assisted Development Guidelines

This repository is primarily a learning project. Codex should help the
developer understand and implement solutions rather than automatically
implementing every requested feature.

### Knowledge Base Maintenance

- Treat `docs/Learning/` as the canonical, evolving knowledge base/wiki.
  Roadmaps are learning plans; a listed topic does not imply that a knowledge
  note should exist. Create knowledge pages as topics are actually studied.
- Search existing notes and relevant sections before adding knowledge. Explicitly
  prefer improving and extending existing notes over creating new files.
- Keep closely related concepts together when pedagogically useful. Give a
  concept its own page only when its depth, independent reuse, or navigation
  value justifies it; reorganize gradually as the repository grows.
- Present the core idea concisely before deeper explanations, examples, and
  experiments. A particular heading or one-line-summary format is not required.
- Connect related concepts with Obsidian links, using explicit paths or section
  links where helpful. Avoid duplicating explanations; link to their canonical
  location and replace duplicated detail with links when extracting a concept.
- Keep executable experiments in `studyTests/` or application code. Notes may
  include small explanatory snippets and links to demonstrations. Distinguish
  planned exercises from observed results; do not claim tests passed without
  validation evidence.
- Maintain `docs/Home.md` as the navigation index when adding, moving, or
  splitting notes. Use descriptive titles and headings for human and agent
  retrieval, cite sources when used, and preserve learning intent and Git history
  as explanations evolve.
- Keep Requirements, Specifications, Architecture, and Decisions focused on the
  Study application. `AGENTS.md` and future Skills contain agent instructions.

### Knowledge Note Frontmatter

- Apply YAML frontmatter only to canonical knowledge notes under
  `docs/Learning/`, excluding roadmaps. Do not automatically apply it to
  Requirements, Specifications, Architecture documents, Decisions, executable
  experiments, source code, `AGENTS.md`, or Skills.
- The schema is `title`, `area`, `type`, `status`, `tags`, `related`, `sources`,
  `experiments`, `created`, and `updated`. Normally match `title` to the main
  heading and use a broad knowledge domain for `area`.
- Start with types `concept`, `technology`, `pattern`, and `architecture`;
  add types only for demonstrated needs. Use statuses `draft` (new/incomplete),
  `learning` (actively studied), `studied` (reasonably consolidated), and
  `review` (needs revisiting or validation), independently of roadmap inclusion.
- Keep tags concise and intentional, using them for useful retrieval and
  cross-cutting classification rather than repeating the title or primary area.
- `related` should contain strong conceptual relationships useful for knowledge
  navigation, not every concept mentioned or referenced by the note. Quote
  Obsidian wiki links and prefer existing canonical titles. A relationship does
  not require creating a page for the linked concept.
- Record only external sources actually used to build or validate knowledge,
  each with `title`, `type`, and `url`. Source types may include documentation,
  book, article, paper, video, course, or repository; never invent provenance.
- Use repository-relative paths for `experiments`. These are demonstrations,
  not external sources; do not claim verified behavior without evidence of
  successful execution. Empty collections are acceptable.
- Keep `created` and `updated` in the schema and use YYYY-MM-DD when reliable
  dates are available. Inspect Git history for uncertain dates; during migration,
  omit an unresolved date field rather than guessing or writing `null`.
- Preserve `created` during normal updates. Change `updated` only for meaningful
  knowledge changes, not formatting, navigation, typos, or metadata-only edits.
- Frontmatter is metadata: keep explanations, summaries, examples, and key
  points in the body. Do not add `summary`, `description`, `abstract`, or
  `key_points` without demonstrated future need.
- Search and extend existing knowledge first. Maintain strong relationships,
  consulted sources, and meaningful experiment references as knowledge evolves;
  update navigation when notes are added, moved, renamed, or split.

### Experiment Evaluation

Use the `evaluate-experiment` skill when reviewing user-created learning
experiments or exploratory tests. Evaluation is read-only by default; explain
findings rather than fixing them. Ordinary production-code reviews are outside
this skill's scope.

### Default Workflow

For non-trivial changes:

1. Inspect the relevant existing code.
2. Explain the relevant iOS/Swift concepts.
3. Propose an implementation approach.
4. Identify the files that would be created or modified.
5. Wait for explicit approval before implementing the change.
6. Implement the approved approach.
7. Build the project.
8. Run relevant tests.
9. Summarize what changed and explain important implementation decisions.

Do not make significant architectural changes without discussing them first.

### Learning Mode

When the developer is studying a concept:

- Prefer explanations before implementation.
- Explain why an approach is appropriate, not only how to implement it.
- Mention relevant Swift, SwiftUI, UIKit, or iOS concepts.
- Present important trade-offs when multiple reasonable approaches exist.
- Avoid unnecessary abstraction or complexity.
- Do not generate complete implementations when the developer explicitly
  asks to implement something themselves.
- Review developer-written code and explain problems rather than immediately
  replacing it.

### Architecture

Do not introduce architectural patterns simply because they are common.

Architecture should evolve from actual application requirements.

Before introducing patterns such as MVVM, Coordinator, Repository,
dependency injection, or other abstractions, explain what problem the
pattern solves in this project.

Prefer the simplest architecture that satisfies the current requirements.

### Validation

After modifying Swift source code:

- Build the relevant target.
- Run relevant tests when practical.
- Do not consider a task complete when the project does not compile.
- Report build or test failures rather than hiding them.
