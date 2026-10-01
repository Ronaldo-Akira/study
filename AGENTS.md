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
