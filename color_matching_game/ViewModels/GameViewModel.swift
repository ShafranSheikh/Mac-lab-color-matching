import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var selectedMode: GameMode? = nil
    @Published var tiles: [Tile] = []
    @Published var firstSelectedIndex: Int? = nil
    @Published var isChecking = false
    
    // Timer & Game State
    @Published var timeRemaining: TimeInterval = 0
    @Published var isGameOver = false
    @Published var isGameWon = false
    
    private var timer: Timer?
    
    var gridSize: Int {
        selectedMode?.gridSize ?? 4
    }
    
    func startGame(mode: GameMode) {
        selectedMode = mode
        firstSelectedIndex = nil
        isGameOver = false
        isGameWon = false
        timeRemaining = mode.timeLimit
        setupTiles()
        startTimer()
    }
    
    func setupTiles() {
        let size = gridSize
        let totalTiles = size * size
        let pairCount = totalTiles / 2
        
        var colors: [Color] = []
        for _ in 0..<pairCount {
            let color = Color(
                red: Double.random(in: 0.2...0.9),
                green: Double.random(in: 0.2...0.9),
                blue: Double.random(in: 0.2...0.9)
            )
            colors.append(color)
            colors.append(color)
        }
        
        // If odd number of tiles (like 3x3=9), add one extra random tile or handle it
        if totalTiles % 2 != 0 {
            colors.append(.gray)
        }
        
        colors.shuffle()
        tiles = colors.map { Tile(color: $0) }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
                self.isGameOver = true
                self.isGameWon = false
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func tileTapped(at index: Int) {
        if isChecking || tiles[index].isRevealed || tiles[index].isMatched || isGameOver {
            return
        }
        
        tiles[index].isRevealed = true
        
        if firstSelectedIndex == nil {
            firstSelectedIndex = index
        } else {
            isChecking = true
            let firstIndex = firstSelectedIndex!
            
            if tiles[firstIndex].color == tiles[index].color {
                // Match
                tiles[firstIndex].isMatched = true
                tiles[index].isMatched = true
                firstSelectedIndex = nil
                isChecking = false
                checkWinCondition()
            } else {
                // Not match → hide both
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                    guard let self = self else { return }
                    self.tiles[firstIndex].isRevealed = false
                    self.tiles[index].isRevealed = false
                    self.firstSelectedIndex = nil
                    self.isChecking = false
                }
            }
        }
    }
    
    func checkWinCondition() {
        // All non-gray tiles matched?
        // Note: Gray tile for odd grid sizes is never matched.
        let matchableTiles = tiles.filter { $0.color != .gray }
        if matchableTiles.allSatisfy({ $0.isMatched }) {
            stopTimer()
            isGameWon = true
            isGameOver = true
        }
    }
    
    func resetGame() {
        stopTimer()
        selectedMode = nil
        tiles = []
        firstSelectedIndex = nil
        isGameOver = false
        isGameWon = false
    }
}
