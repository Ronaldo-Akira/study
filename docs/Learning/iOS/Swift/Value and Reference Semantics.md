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

Part of [[iOS Learning Roadmap]]. Related topics: [[Swift Language Fundamentals]], [[Protocols]], [[Memory Management]], [[SwiftUI State Management]], and [[Concurrency]].

## Value Semantics

A value behaves as independent data. Assigning it to another variable or passing it to a function gives the recipient its own value: changing one should not change the other.

Swift structures and enumerations are value types. Standard types such as `Int`, `Bool`, `String`, `Array`, and `Dictionary` are also value types.

```swift
struct Score {
    var points: Int
}

var first = Score(points: 10)
var second = first
second.points = 20

print(first.points)  // 10
print(second.points) // 20
```

The important guarantee is independent observable behavior, not that every assignment immediately duplicates all underlying memory.
**One-line summary:** Value semantics means copies behave independently.

## Reference Semantics

A class instance is an object accessed through references. Assignment copies the reference, so multiple variables can access the same instance. Mutation through one reference is visible through the others.

```swift
final class Counter {
    var count = 0
}

let first = Counter()
let second = first
second.count += 1

print(first.count) // 1
print(first === second) // true
```

Passing a class instance to a function has the same sharing behavior. Assigning or passing an instance does not automatically clone it. Object lifetime is managed through [[Automatic Reference Counting]], which is separate from assignment semantics.

**One-line summary:** Reference semantics means multiple references can point to and mutate the same instance.

## Struct vs Class

| Property | `struct` | `class` |
| --- | --- | --- |
| Assignment | Copies a value | Copies a reference to an instance |
| Mutation | Changes that variable's value | Changes the shared instance |
| Identity | No object identity | Supports identity with `===` |
| Inheritance | Does not support type inheritance | Supports class inheritance |
| Protocol conformance | Supported | Supported |

Both can have properties, initializers, methods, and computed properties. Choose based on the behavior needed, rather than assuming structs always live on the stack or classes are always slower.

**One-line summary:** A struct is a value type; a class is a reference type with object identity and support for inheritance.

## Assignment and Mutation

For a struct, `let` prevents changing its stored properties. A method that changes the struct's value must be marked `mutating` and called on a mutable variable.

```swift
struct CounterValue {
    var count = 0

    mutating func increment() {
        count += 1
    }
}

var counter = CounterValue()
counter.increment()

let fixed = CounterValue()
// fixed.increment() // Does not compile: fixed is immutable.
```

For a class, `let` prevents replacing the reference; it does not freeze the instance. The earlier `let second` can still change `count` because that property is declared `var`. Class methods do not use `mutating`.

[[Inout Parameters]] explicitly allow a function to update a caller's variable. This does not turn a struct into a reference type.

**One-line summary:** Assignment copies a value or a reference, while `let` prevents changing a struct's stored properties or replacing a class reference, without freezing the class instance.

### A Struct Can Contain a Reference

Being a value type does not automatically provide independent behavior for everything inside it. A copied struct containing a class reference still refers to the same nested object.

```swift
struct Holder {
    var counter: Counter
}

let original = Holder(counter: Counter())
let copy = original
copy.counter.count = 5

print(original.counter.count) // 5
```

The two holders are separate values, but their `counter` properties reference one instance. Even `let` permits this nested object mutation. To design independent values, consider the semantics of every stored property.

**One-line summary:** Copying a struct copies its stored references too, so nested class instances can remain shared.

## Identity vs Equality

**Identity** asks whether two references point to the same class instance. Use `===` or `!==`.

**Equality** asks whether two values are equivalent according to their type's definition. Use `==` or `!=` with types conforming to [[Equatable]]. Equality is not automatically available for every struct or class.

```swift
struct Point: Equatable {
    var x: Int
    var y: Int
}

let first = Point(x: 2, y: 3)
let second = Point(x: 2, y: 3)
print(first == second) // true
// first === second // Invalid: Point is not a class.
```

For classes that define content-based equality, two distinct instances can compare equal while `===` is false. Identity and equality answer different questions.

**One-line summary:** Identity asks whether references point to the same instance; equality asks whether values match according to the type's equality rules.

## Copy-on-Write

Copy-on-Write (CoW) preserves value semantics while avoiding unnecessary storage copies. Swift's standard collections, such as `Array` and `Dictionary`, and `String` use this strategy.

Copies can share backing storage while neither changes it. When a mutation needs independent storage, shared storage is copied before the write. If storage is already uniquely owned, a mutation may reuse it.

```swift
var original = [1, 2, 3]
var copy = original
copy.append(4)

print(original) // [1, 2, 3]
print(copy)     // [1, 2, 3, 4]
```

This example demonstrates observable independence; it does not prove when a physical allocation occurs. CoW is an implementation strategy, not automatic behavior for every custom struct.

Copying an array of class instances preserves the array's value semantics, but its elements still reference shared objects. Changing an element's object properties can therefore be visible through both arrays.

**One-line summary:** Copy-on-Write shares storage until a write requires an independent copy, preserving value semantics while avoiding unnecessary copying.

## When Value Semantics Are Preferable

Prefer values when data should be independent: coordinates, configuration, results, or snapshots. They make local changes easier to reason about, support predictable comparisons, and reduce accidental shared mutation.

Value semantics are a useful starting point when shared identity is unnecessary. They can simplify [[Testing]] and [[Concurrency]], but a struct containing shared references is not automatically safe to send across concurrency boundaries; see [[Sendable]].

**One-line summary:** Prefer value semantics when data should change independently and shared identity is unnecessary.

## When Reference Semantics Are Appropriate

Use references when shared identity and coordinated mutation are intentional: multiple consumers observing one session object, an object whose lifetime matters, or an API that requires class inheritance, such as a UIKit view controller.

Consider who owns the object, who may change it, and how those changes are synchronized. Reference semantics introduce questions about shared state and [[Retain Cycles]]. These are language-level considerations, not a prescription for this project's architecture.

**One-line summary:** Use reference semantics when shared identity, coordinated mutation, or a class-based API is required.

## Questions

1. What does assignment copy for a struct? What does it copy for a class?
2. Why can a property of a `let` class instance change, while a stored property of a `let` struct cannot?
3. When must a struct method be marked `mutating`?
4. How do `==` and `===` differ? Can distinct objects be equal?
5. Why can copying a struct still leave shared mutable state?
6. What does CoW optimize, and what observable behavior must it preserve?
7. What happens when you copy an array containing class instances and mutate one instance?
8. Which situations need independent values, and which need shared identity?
9. Why does choosing a struct alone not guarantee concurrency safety?

## Experiments

Implement these yourself in the study Xcode project. Use `studyTests/` for isolated Swift Testing experiments with `@Test` and `#expect`; UI tests are unnecessary for these language behaviors.

The implementations for experiments 1 and 2 are in
[ValueSemanticsTest.swift](../../../../studyTests/ValueSemanticsTest.swift).
This link identifies the demonstration code; it does not establish that every
exercise step is complete or that the tests have passed.

1. **Independent values:** Define a small struct, assign it to two variables, and mutate one. Assert that the original remains unchanged. Repeat with a function that changes a local copy.
2. **Shared references:** Repeat using a class. Assert that mutation is visible through both references and that `first === second` is true. Compare with a newly initialized instance.
3. **Mutation rules:** Try modifying `let` and `var` structs and classes. Predict compilation results first. Keep intentionally invalid statements commented out after checking them.
4. **Equality:** Define an `Equatable` struct. Compare equal and unequal values. Optionally define a class with content-based equality and demonstrate `==` being true while `===` is false.
5. **Nested references:** Put a mutable class inside a struct. Copy the struct and mutate the nested object. Then replace that object with a new instance in one mutable holder and observe the difference.
6. **CoW behavior:** Copy an integer array and mutate one copy. Assert independence. Repeat with an array of class instances; compare changing an object's property with replacing an array element.

For each experiment, write down your prediction, the observed result, and the rule that explains it. Assertions verify semantics; printed results alone do not reveal backing-storage allocation.
