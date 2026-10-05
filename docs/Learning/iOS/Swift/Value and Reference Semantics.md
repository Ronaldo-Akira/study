---
title: Value and Reference Semantics
area: Swift
type: concept
status: learning

tags:
  - language-fundamentals
  - semantics

related:
  - "[[Memory Management]]"
  - "[[Equatable]]"

sources: []

experiments:
  - studyTests/ValueSemanticsTest.swift
---

# Value and Reference Semantics

Part of the [[iOS Learning Roadmap]]. Related concepts: [[Memory Management]] and [[Equatable]]. Also see [[Swift Language Fundamentals]], [[Protocols]], and [[SwiftUI State Management]].

## Mental Model

- **Value semantics:** copies behave as independent observable values.
- **Reference semantics:** multiple references can access the same instance; mutation through either is visible through both.

**Rule:** Independent behavior is the guarantee of value semantics; assignment need not immediately make a physical memory copy. Object lifetime for class instances is managed by [[Automatic Reference Counting]].

## Struct vs Class

| Behavior | `struct` | `class` |
| --- | --- | --- |
| Assignment | Copies the value | Copies a reference to the instance |
| Mutation | Changes that value | Changes the referenced instance |
| Identity | No instance identity | Identity can be checked with `===` |
| Inheritance | No class inheritance | Supports inheritance |
| Protocol conformance | Supported | Supported |

Both support properties, initializers, and methods. Neither a type's syntax nor assumptions about stack/heap placement determine whether it is faster.

## Mutation Rules

| Binding / parameter         | Rule                                                                                                                                                                             |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `let` struct                | The value and its stored properties cannot be mutated.                                                                                                                           |
| `var` struct                | The value can be mutated; a mutating method requires a `var` binding.                                                                                                            |
| `let` class                 | The reference cannot be replaced; mutable instance state can change.                                                                                                             |
| `var` class                 | The instance can change and the reference can be replaced.                                                                                                                       |
| Normal value-type parameter | Passing a value type preserves value semantics. Mutating a separate local copy does not change the caller's value.                                                               |
| Normal class parameter      | The parameter receives a reference to the same instance; mutating that instance is visible to the caller. Rebinding the local parameter does not replace the caller's reference. |
| `inout` parameter           | Grants temporary mutable access to the caller's variable. With a value type, it does not change that type's value semantics.                                                     |

```swift
struct Counter {
    var value = 0
    mutating func increment() { value += 1 }
}

var counter = Counter()
counter.increment()
```

## Identity vs Equality

- `==` / `!=`: value equality as defined by `Equatable`.
- `===` / `!==`: whether two class references identify the same instance.

Two distinct class instances can compare equal with `==` while `===` is false. Structs have equality when they conform to `Equatable`; they do not have class-instance identity.

## Nested References

Copying a struct copies its stored references; it does not deep-copy the referenced objects.

```text
original ─┐
          ├──> Score instance
copy ─────┘
```

- `copy.score.value = 2` mutates the shared object; both struct values observe it.
- `copy.score = Score(value: 2)` replaces only the `copy` struct's reference. The original still refers to the previous instance.

Even a `let` struct can expose mutable state through a stored class reference.

## Copy-on-Write

Swift types such as `Array`, `Dictionary`, and `String` can use Copy-on-Write (CoW): copies may share backing storage until mutation requires independent storage. CoW preserves observable value semantics; observing a changed value does not establish when physical storage was copied. CoW is not automatic for every custom struct.

For an array of class instances, CoW separates the array's element storage, not the referenced objects:

```swift
copy[0].value = 3       // Mutates the shared object; visible through both arrays.
copy[0] = Element(value: 3) // Replaces this array's element; the other array is unchanged.
```

## When to Use Each

| Value semantics                                        | Reference semantics                                                |
| ------------------------------------------------------ | ------------------------------------------------------------------ |
| Independent data, snapshots, results, or configuration | Shared identity or coordinated mutation is intentional             |
| Shared identity is unnecessary                         | Object identity/lifetime matters, or a class-based API requires it |

Value semantics can simplify reasoning about [[Testing]] and [[Concurrency]]. A value type containing shared references is not automatically safe across concurrency boundaries; see [[Sendable]]. Reference sharing also requires attention to ownership and [[Retain Cycles]].

## Rules to Remember

1. `struct` and `enum` have value semantics; `class` has reference semantics and identity.
2. Value semantics means independent observable behavior, not necessarily an immediate physical copy.
3. Assigning a class instance copies its reference; both references can access the same object.
4. A `let` struct cannot change its stored value; a `var` struct can.
5. A `let` class binding cannot be reassigned, but mutable object state can change.
6. A `var` class binding can be reassigned to another instance.
7. Passing a value type normally preserves its value semantics; `inout` grants temporary access to mutate the caller's variable.
8. `==` checks equality; `===` checks whether class references identify the same instance.
9. A struct can contain references to shared mutable objects; copying it does not deep-copy them.
10. CoW can preserve collection value semantics efficiently, but does not deep-copy class instances stored in a collection.

## Experiments

Source implementations for experiments 1–6 are in [ValueSemanticsTest.swift](../../../../studyTests/ValueSemanticsTest.swift). Their presence in source does not establish that tests pass. Experiment 3's intentionally invalid compiler examples are comments; this repository does not establish that their diagnostics were verified.
