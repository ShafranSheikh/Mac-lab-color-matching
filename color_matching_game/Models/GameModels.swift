import SwiftUI

enum GameMode {
    case easy, medium, hard
    
    var gridSize: Int {
        switch self {
        case .easy: return 3
        case .medium: return 4
        case .hard: return 6
        }
    }
    
    var timeLimit: TimeInterval {
        switch self {
        case .easy: return 30
        case .medium: return 60
        case .hard: return 120
        }
    }
}

struct Tile: Identifiable {
    let id = UUID()
    let color: Color
    var isRevealed: Bool = false
    var isMatched: Bool = false
}
