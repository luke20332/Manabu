//
//  LearnViewModelTests.swift
//  ManabuTests
//
//  Created by Luke on 27/03/2026.
//

import XCTest
import Combine
import CoreData
@testable import Manabu

final class LearnViewModelTests: XCTestCase {

    var sut: LearnViewModel!
    var context: NSManagedObjectContext!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        context = makeInMemoryContext()
        seedSyllabaryEntity(title: "hiragana", in: context)
        sut = LearnViewModel(syllabary: .hiragana, context: context)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        context = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_init_setsSyllabary() {
        XCTAssertEqual(sut.syllabary, .hiragana)
    }
    
    func test_init_currentIndexIsZero() {
        XCTAssertEqual(sut.currentIndex, 0)
    }
    
    func test_init_currentCharacterSeenIsFirstCharacter() {
        XCTAssertEqual(sut.currentCharacter, sut.characters[0])
    }

    func test_init_seenCharactersIsEmpty() {
        XCTAssertTrue(sut.seenCharacters.isEmpty)
    }
    
    func test_init_hiraganaCharactersIsNotEmpty() {
        XCTAssertFalse(sut.characters.isEmpty)
    }
    
    func test_init_katakanaCharactersIsNotEmpty() {
        seedSyllabaryEntity(title: "katakana", in: context)
        let viewModel = LearnViewModel(syllabary: .katakana, context: context)
        XCTAssertFalse(sut.characters.isEmpty)
    }
    
    func test_init_romajiCharactersIsEmpty() {
        seedSyllabaryEntity(title: "romanji", in: context)
        let viewModel = LearnViewModel(syllabary: .romanji, context: context)
        XCTAssertTrue(sut.characters.isEmpty)
    }
    
    func test_init_kanjiCharactersIsEmpty() {
        seedSyllabaryEntity(title: "kanji", in: context)
        let viewModel = LearnViewModel(syllabary: .kanji, context: context)
        XCTAssertTrue(sut.characters.isEmpty)
    }
    
    // MARK: - NextCharacter
    
    func test_nextCharacter_incrementsIndex() {
        let initialIndex = sut.currentIndex
        _ = sut.nextCharacter()
        XCTAssertEqual(sut.currentIndex, initialIndex + 1)
    }
    
    func test_nextCharacter_returnsCharacterAtNewIndex() {
        let newCharacter = sut.nextCharacter()
        XCTAssertEqual(newCharacter, sut.characters[1])
    }
    
    func test_nextCharacter_updatesCurrentCharacter() {
        let oldCharacter = sut.currentCharacter
        let newCharacter = sut.nextCharacter()
        XCTAssertNotEqual(oldCharacter, newCharacter)
    }
    
    func test_nextCharacter_appendsToSeenCharacters() {
        let seenCharacters = sut.seenCharacters
        let newCharacter = sut.nextCharacter()
        XCTAssertEqual(seenCharacters.last, newCharacter)
    }
    
    func test_nextCharacter_calledMultipleTimes_appendsAll() {
        _ = sut.nextCharacter()
        _ = sut.nextCharacter()
        XCTAssertEqual(sut.seenCharacters.count, 2)
    }
    
    // MARK: - PreviousCharacter
    
    func test_previousCharacter_atStart_returnsFirstCharacter() {
        let character = sut.previousCharacter()
        XCTAssertEqual(character, sut.characters.first)
    }
    
    func test_previousCharacter_atStart_doesNotDecrementIndex() {
        _ = sut.previousCharacter()
        XCTAssertEqual(sut.currentIndex, 0)
    }
    
    func test_previousCharacter_afterNext_decrementsIndex() {
        _ = sut.nextCharacter()
        XCTAssertEqual(sut.currentIndex, 1)
        _ = sut.previousCharacter()
        XCTAssertEqual(sut.currentIndex, 0)
    }
    
    func test_previousCharacter_afterNext_returnsCorrectCharacter() {
        _ = sut.nextCharacter()
        let previousCharacter = sut.previousCharacter()
        XCTAssertEqual(previousCharacter, sut.characters[0])
    }
    
    func test_previousCharacter_withEmptySeenCharacters_returnsFirstCharacter() {
        let result = sut.previousCharacter()
        XCTAssertEqual(result, sut.characters[0])
    }
    
    // MARK: - IncrementCharactersSeen
    
    func test_incrementCharactersSeen_publishesIncrementedValue() {
        let expectation = expectation(description: "updateCharactersSeen publishes")
        var receivedValue: Int?
        
        sut.updateCharactersSeen
            .sink { value in
                receivedValue = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.incrementCharactersSeen()
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedValue, 1)
    }
    
    func test_incrementCharactersSeen_calledMultipleTimes_publishesCorrectCount() {
        let expectation = expectation(description: "receives 3 updates")
        var receivedValue: Int?
        
        sut.updateCharactersSeen
            .sink { value in
                receivedValue = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.incrementCharactersSeen()
        sut.incrementCharactersSeen()
        sut.incrementCharactersSeen()
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedValue, 3)
    }
    
    // MARK: - save()
    
    func test_save_doesNotThrow() {
        XCTAssertNoThrow(try sut.save())
    }
    
    // MARK: - fetchSyllabaryEntity()
    
//    func test_fetchSyllabaryEntity_throwsWhenNoMatchingEntity() {
//        // using a context with no seeded data
////        let emptyContext = makeInMemoryContext()
////        XCTAssertThrowsError(try LearnViewModel(syllabary: .hiragana, context: emptyContext)) { error in
////            // Init captures the error
////        }
//        let viewModel = sut
//        
////        let viewModel = LearnViewModel(syllabary: .hiragana, context: emptyContext)
//        XCTAssertThrowsError(try viewModel?.fetchSyllabaryEntity())
//    }
    
    func test_fetchSyllabaryEntity_succeedsWithMatchingEntity() {
        XCTAssertNoThrow(try sut.fetchSyllabaryEntity())
    }
}

private extension LearnViewModelTests {
    
    // create an in memory NSPersistentContainer for isolated testing
    func makeInMemoryContext() -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: "Manabu")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error { fatalError("Failed to load persistent stores: \(error)") }
        }
        return container.viewContext
    }
    
    //seed a SyllabaryEntity with the title so that fetchSyllabaryEntity() succeeds
    @discardableResult
    func seedSyllabaryEntity(title: String, in context: NSManagedObjectContext) -> SyllabaryEntity {
        let entity = SyllabaryEntity(context: context)
        entity.title = title
        try? context.save()
        return entity
    }
}
