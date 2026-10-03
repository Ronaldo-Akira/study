---
name: evaluate-experiment
description: Evaluate, review, validate, or critique user-created learning experiments and exploratory tests for programming or software-engineering concepts. Assess conceptual correctness, implementation, assertions, and evidence without editing files. Use for requests asking whether an experiment demonstrates a concept; not for ordinary production-code review or implementation.
---

# Evaluate Experiment

Help the developer understand what their experiment demonstrates, where its
evidence is weak, and how they could improve it themselves.

## Scope and Modification Policy

Follow applicable `AGENTS.md` instructions for repository conventions.

Evaluation is read-only by default. Do not modify or rewrite experiments,
tests, knowledge notes, frontmatter, roadmaps, or other repository files.
Do not create experiments or automatically fix findings. Recommend changes
in the review; implementation requires a subsequent explicit user request.

Do not turn evaluation into knowledge-base maintenance.

## Establish Context

- Identify the intended concept or claim from the user's request, test name,
  implementation, and exercise instructions. Distinguish stated intent from
  inferred intent; ask for clarification if ambiguity changes the evaluation.
- Locate and read the relevant knowledge note under `docs/Learning/`, when
  one exists. Search note content and frontmatter experiment paths; use
  `docs/Home.md` for navigation. Do not create a missing note.
- Inspect the relevant implementation, assertions, helpers, and configuration
  needed to understand behavior. Evaluate the requested experiment without
  expanding into unrelated code review.

## Evaluate the Experiment

Consider the following dimensions without forcing a separate report section
for each one:

- **Conceptual correctness:** Does the experiment demonstrate its intended
  claim, accidentally demonstrate something else, or support a narrower
  conclusion than its name or explanation suggests?
- **Implementation quality:** Check idiomatic usage and correct language/API
  semantics. For Swift, assess relevant value/reference behavior, mutability,
  identity/equality, ownership, isolation, or state behavior as applicable.
  Identify complexity or implementation details that obscure the concept.
  Use equivalent language-specific criteria for other experiments.
- **Assertion quality:** Could the test pass if the intended action did not
  occur or the claimed behavior were wrong? Check expected outcomes, missing
  observations, and redundant or irrelevant assertions.
- **Experiment design:** Assess isolation, assumptions, uncontrolled variables,
  and relevant contrasting or edge cases. Recommend simpler designs when
  they clarify the same claim, without writing a replacement implementation.
  Distinguish essential missing cases from optional follow-up experiments.
- **Knowledge consistency:** Compare the experiment with the associated note.
  Identify discrepancies explicitly; do not assume the note is authoritative
  or silently correct either artifact.

## Evidence and Verification

Distinguish conclusions based on source inspection, observed execution results,
documented behavior, and interpretation or inference.

A passing example demonstrates behavior under its tested conditions; it does
not prove a general language or framework guarantee. Do not infer physical
copying, scheduling guarantees, or other hidden mechanisms solely from outputs.

Existing execution evidence may be considered when available and applicable to
the current code. Clearly distinguish those observed results from source-based
conclusions. State whether the experiment was run and what remains unverified.

Execution is explicitly opt-in. Default to source review; do not execute tests,
builds, or experiments unless the user explicitly requests execution or
verification. Requests to evaluate, review, validate, or critique alone do not
authorize execution. If execution would materially strengthen or resolve the
evaluation, explain what should be run and why.

When execution is explicitly requested, run only suitable existing checks with
understood and permitted side effects. Respect explicit no-file-write constraints,
keep generated artifacts outside the repository, and do not change tracked files
or configuration. Report execution failures or limitations without treating them
as failures of the intended concept.

When external verification is needed, identify the specific uncertain claim
and consult authoritative documentation where available. Cite only sources
actually consulted. If verification is unavailable, state the uncertainty
and what evidence would resolve it. Do not invent provenance or add sources
to knowledge-note metadata.

## Present Findings

Lead with whether the experiment demonstrates its intended concept.

For meaningful findings, cite the relevant file and line when available,
explain what you found and why it matters, describe what the current evidence
establishes, and suggest what would strengthen it.

Clearly distinguish correctness problems, conceptual misunderstandings,
test-design weaknesses, and implementation issues from optional improvements.
Use only categories that help this particular review.

Keep simple reviews concise. If the experiment is correct, explain why;
do not invent issues to fill a checklist. Explain recommended changes rather
than supplying a rewritten test.

End with a short assessment of what the experiment successfully demonstrates
and what, if anything, remains unverified.
