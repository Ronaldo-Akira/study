//
//  ValueSemanticsTest.swift
//  study
//
//  Created by Ronaldo Akira Fujigaki Kinoshita on 01/10/26.
//

import Testing

// MARK: - Independent Values

@Suite("Experiment 1: Independent Values")
struct IndependentValuesTests {

    /// Value type used to demonstrate independent value semantics.
    private struct Score {
        var value: Int
    }

    @Test("Mutating a copied value does not affect the original")
    func mutatingCopiedValueDoesNotAffectOriginal() {
        // Given: a value and an independent copy of that value.
        let original = Score(value: 1)
        var copy = original

        // When: the copy is mutated.
        copy.value = 2

        // Then: the original remains unchanged while the copy reflects the mutation.
        #expect(original.value == 1)
        #expect(copy.value == 2)
    }

    @Test("Mutating a local copy inside a function does not affect the original")
    func mutatingLocalCopyDoesNotAffectOriginal() {
        func changedScore(from score: Score, to newValue: Int) -> Score {
            var localCopy = score
            localCopy.value = newValue
            return localCopy
        }

        // Given: an original value.
        let original = Score(value: 1)

        // When: a function creates and mutates a local copy.
        let changed = changedScore(from: original, to: 3)

        // Then: the caller's original remains unchanged,
        // while the returned value contains the mutation.
        #expect(original.value == 1)
        #expect(changed.value == 3)
    }

    @Test("Passing a value as inout allows the function to modify the caller's variable")
    func passingValueAsInoutAllowsCallerModification() {
        func changeScore(_ score: inout Score, to newValue: Int) {
            score.value = newValue
        }

        // Given: a mutable value and an independent copy of its initial state.
        var original = Score(value: 1)
        let copy = original

        // When: the original is passed as inout and mutated by the function.
        changeScore(&original, to: 4)

        // Then: the caller's variable reflects the mutation,
        // while the previously created copy remains unchanged.
        #expect(original.value == 4)
        #expect(copy.value == 1)
    }
}


// MARK: - Shared References

@Suite("Experiment 2: Shared References")
struct SharedReferenceTests {

    /// Reference type used to demonstrate shared instance semantics.
    private final class Score {
        var value: Int

        init(value: Int) {
            self.value = value
        }
    }

    @Test("Mutating an instance through one reference is visible through the other")
    func mutatingInstanceIsVisibleThroughBothReferences() {
        // Given: two references to the same Score instance.
        let original = Score(value: 1)
        let copy = original

        // When: the shared instance is mutated through one reference.
        copy.value = 2

        // Then: both references observe the mutation
        // because they point to the same instance.
        #expect(original === copy)
        #expect(original.value == 2)
        #expect(copy.value == 2)
    }

    @Test("Equal state does not imply shared identity")
    func equalStateDoesNotImplySharedIdentity() {
        // Given: two references to one instance and a separate instance
        // initialized with the value the shared instance will receive.
        let first = Score(value: 1)
        let second = first
        let separate = Score(value: 2)

        // When: the shared instance is mutated through the second reference.
        second.value = 2

        // Then: the instances can contain the same state
        // while still having different identities.
        #expect(first === second)
        #expect(first !== separate)
        #expect(first.value == separate.value)
    }
}


// MARK: - Mutation Rules

@Suite("Experiment 3: Mutation Rules")
struct MutationRulesTests {

    /// Value type used to demonstrate mutation rules for `let` and `var`.
    private struct ScoreValue {
        var value: Int
    }

    /// Reference type used to demonstrate the distinction between
    /// mutating an instance and replacing a reference.
    private final class ScoreReference {
        var value: Int

        init(value: Int) {
            self.value = value
        }
    }

    @Test("A var struct can mutate while a let struct cannot")
    func structMutationDependsOnBindingMutability() {
        // Given: mutable and immutable struct values.
        var mutable = ScoreValue(value: 1)
        let immutable = ScoreValue(value: 1)

        // When: the mutable value is changed.
        mutable.value = 2

        // Then: the mutation is reflected in the mutable value.
        #expect(mutable.value == 2)
        #expect(immutable.value == 1)

        // Does not compile: a property of a let-bound struct cannot be mutated.
        // immutable.value = 2
    }

    @Test("A class instance can mutate through let while only a var reference can be replaced")
    func classMutationAndReferenceReplacementFollowDifferentRules() {
        // Given: a mutable reference and a fixed reference.
        var mutableReference = ScoreReference(value: 1)
        let fixedReference = ScoreReference(value: 1)

        // When: the instance referenced by the let binding is mutated.
        fixedReference.value = 2

        // Then: instance mutation is allowed even though the reference is fixed.
        #expect(fixedReference.value == 2)

        // When: the var binding is replaced with a reference to a new instance.
        mutableReference = ScoreReference(value: 3)

        // Then: the var binding now refers to the new instance.
        #expect(mutableReference.value == 3)

        // Does not compile: a let-bound reference cannot be replaced.
        // fixedReference = ScoreReference(value: 4)
    }
}


// MARK: - Equality

@Suite("Experiment 4: Equality")
struct EqualityTests {

    /// Value type with content-based equality synthesized by Swift.
    private struct EquatableScore: Equatable {
        var value: Int
    }

    /// Reference type with equality explicitly defined by its stored value.
    private final class EquatableScoreReference: Equatable {
        var value: Int

        init(value: Int) {
            self.value = value
        }

        static func == (
            lhs: EquatableScoreReference,
            rhs: EquatableScoreReference
        ) -> Bool {
            lhs.value == rhs.value
        }
    }

    @Test("Struct equality compares values according to Equatable")
    func structEqualityComparesValues() {
        // Given: two equal values and one different value.
        let first = EquatableScore(value: 1)
        let second = EquatableScore(value: 1)
        let different = EquatableScore(value: 2)

        // Then: values with matching state are equal,
        // while different state is not equal.
        #expect(first == second)
        #expect(first != different)
    }

    @Test("Class equality and identity answer different questions")
    func classEqualityAndIdentityAreIndependent() {
        // Given: two distinct instances with equal state
        // and another instance with different state.
        let first = EquatableScoreReference(value: 1)
        let second = EquatableScoreReference(value: 1)
        let different = EquatableScoreReference(value: 2)

        // Then: distinct instances can be equal by value
        // while still having different identities.
        #expect(first == second)
        #expect(first !== second)
        #expect(first != different)
    }
}
