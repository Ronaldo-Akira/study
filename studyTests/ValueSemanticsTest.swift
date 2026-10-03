//
//  ValueSemanticsTest.swift
//  study
//
//  Created by Ronaldo Akira Fujigaki Kinoshita on 01/10/26.
//

import Testing

private struct Score {
    var value: Int
}

@Test("Given a value, when its copy changes, then the original remains unchanged")
func indepedentValuesTest() {
    // Given
    let initialValue = Score(value: 1)
    var secondValue = initialValue

    // When
    secondValue.value = 2

    // Then
    #expect(initialValue.value == 1)
    #expect(secondValue.value == 2)
}


private class ScoreClass{
    var value: Int

    init(value: Int) {
        self.value = value
    }
}

@Test("Given a class value, when its copy changes, then the original also changes")
func sharedReferenceTest() {
    // Given
    let initialValue = ScoreClass(value: 1)
    var secondValue = initialValue

    //When
    secondValue.value = 2

    //Then
    #expect(initialValue.value == secondValue.value)
    #expect(initialValue === secondValue)




}
