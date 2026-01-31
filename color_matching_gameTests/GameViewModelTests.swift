import XCTest
@testable import color_matching_game

class GameViewModelTests: XCTestCase {
    var viewModel: GameViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = GameViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGameInitializationEasyMode() {
        // Given
        let mode = GameMode.easy
        
        // When
        viewModel.startGame(mode: mode)
        
        // Then
        XCTAssertEqual(viewModel.selectedMode, .easy)
        XCTAssertEqual(viewModel.gridSize, 3)
        XCTAssertEqual(viewModel.tiles.count, 9) // 3x3
        XCTAssertEqual(viewModel.hintsRemaining, 3)
        XCTAssertEqual(viewModel.timeBoostsRemaining, 2)
        XCTAssertEqual(viewModel.timeRemaining, mode.timeLimit)
        XCTAssertFalse(viewModel.isGameOver)
    }
    
    func testGameInitializationHardMode() {
        // Given
        let mode = GameMode.hard
        
        // When
        viewModel.startGame(mode: mode)
        
        // Then
        XCTAssertEqual(viewModel.selectedMode, .hard)
        XCTAssertEqual(viewModel.gridSize, 6)
        XCTAssertEqual(viewModel.tiles.count, 36) // 6x6
        XCTAssertEqual(viewModel.hintsRemaining, 1)
        XCTAssertEqual(viewModel.timeBoostsRemaining, 1)
    }
    
    func testTileTappedRevealsTile() {
        // Given
        viewModel.startGame(mode: .easy)
        
        // When
        viewModel.tileTapped(at: 0)
        
        // Then
        XCTAssertTrue(viewModel.tiles[0].isRevealed)
        XCTAssertEqual(viewModel.firstSelectedIndex, 0)
    }
    
    func testTileMatching() {
        // Given
        viewModel.startGame(mode: .easy)
        
        // Find two tiles of the same color (excluding gray)
        var firstIndex: Int?
        var secondIndex: Int?
        
        for i in 0..<viewModel.tiles.count {
            for j in (i + 1)..<viewModel.tiles.count {
                if viewModel.tiles[i].color == viewModel.tiles[j].color && viewModel.tiles[i].color != .gray {
                    firstIndex = i
                    secondIndex = j
                    break
                }
            }
            if firstIndex != nil { break }
        }
        
        XCTAssertNotNil(firstIndex)
        XCTAssertNotNil(secondIndex)
        
        // When
        viewModel.tileTapped(at: firstIndex!)
        viewModel.tileTapped(at: secondIndex!)
        
        // Then
        XCTAssertTrue(viewModel.tiles[firstIndex!].isMatched)
        XCTAssertTrue(viewModel.tiles[secondIndex!].isMatched)
        XCTAssertNil(viewModel.firstSelectedIndex)
    }
    
    func testTimeBoostIncreasesTime() {
        // Given
        viewModel.startGame(mode: .easy)
        let initialTime = viewModel.timeRemaining
        
        // When
        viewModel.useTimeBoost()
        
        // Then
        XCTAssertEqual(viewModel.timeRemaining, initialTime + 15)
        XCTAssertEqual(viewModel.timeBoostsRemaining, 1) // Started with 2 in easy
    }
    
    func testHintReducesCount() {
        // Given
        viewModel.startGame(mode: .easy)
        
        // When
        viewModel.useHint()
        
        // Then
        XCTAssertEqual(viewModel.hintsRemaining, 2) // Started with 3 in easy
        XCTAssertTrue(viewModel.isPowerUpActive)
    }
    
    func testResetGame() {
        // Given
        viewModel.startGame(mode: .easy)
        
        // When
        viewModel.resetGame()
        
        // Then
        XCTAssertNil(viewModel.selectedMode)
        XCTAssertTrue(viewModel.tiles.isEmpty)
        XCTAssertFalse(viewModel.isGameOver)
    }
}
