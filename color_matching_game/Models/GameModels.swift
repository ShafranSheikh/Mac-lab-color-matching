import SwiftUI

enum GameMode {
    case easy, medium, hard
    
    var name: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    var description: String {
        switch self {
        case .easy: return "Relaxing 3×3 grid"
        case .medium: return "Classic 4×4 challenge"
        case .hard: return "Master's 6×6 grid"
        }
    }
    
    var icon: String {
        switch self {
        case .easy: return "leaf.fill"
        case .medium: return "bolt.fill"
        case .hard: return "flame.fill"
        }
    }

    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

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
