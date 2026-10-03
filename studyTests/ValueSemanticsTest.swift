//
//  ValueSemanticsTest.swift
//  study
//
//  Created by Ronaldo Akira Fujigaki Kinoshita on 01/10/26.
//

import Testing


// MARK: - Independent values experiment
@Suite("Experiment 1: Independent Values")
struct IndependentValuesTests {

    private struct Score {
        var value: Int
    }

    @Test("Changing a copy doesn't change the original")
    func changingCopyDoesNotChangeOriginal() {
        // Given
        let originalScore = Score(value: 1)
        var copy = originalScore

        // When
        copy.value = 2

        // Then
        #expect(originalScore.value == 1)
        #expect(copy.value == 2)
    }

    @Test("Passing a value to a function preserves the original")
    func passingValueToFunctionPreservesOriginal() {

        func changeScore(_ score: Score) -> Score {
            var localScore = score
            localScore.value = 3
            return localScore
        }

        // Given
        let originalScore = Score(value: 1)

        // When
        let changed = changeScore(originalScore)

        // Then
        #expect(originalScore.value == 1)
        #expect(changed.value == 3)
    }

    @Test("Passing a value as inout allows the function to modify the original")
    func passingValueAsInoutAllowsModification() {

        func changeScore(_ score: inout Score, newValue: Int) {
            score.value = newValue
        }

        // Given
        var originalScore = Score(value: 1)
        let copy = originalScore

        // When
        changeScore(&originalScore, newValue: 4)

        // Then
        #expect(originalScore.value == 4)
        #expect(copy.value == 1)

    }

}

// MARK: - Shared references experiment
@Suite("Experiment 2: Shared References")
struct SharedReferenceTests{

    private final class Score{
        var value: Int

        init(value: Int) {
            self.value = value
        }
    }

    @Test("Changing a reference affects the original shared instance")
    func changeReferenceAffectsOriginal() {
        // Given
        let originalScore = Score(value: 1)
        let copy = originalScore

        //When
        copy.value = 2

        //Then
        #expect(originalScore.value == copy.value)
        #expect(originalScore === copy)
    }

}

