//Color matching game
import SwiftUI

enum GameMode {
    case easy, medium, hard
}

struct Tile: Identifiable {
    let id = UUID()
    let color: Color
    var isRevealed: Bool = false
    var isMatched: Bool = false
}

struct ContentView: View {

    // MARK: - State
    @State private var selectedMode: GameMode? = nil
    @State private var gridSize = 4
    @State private var tiles: [Tile] = []
    @State private var firstSelectedIndex: Int? = nil
    @State private var isChecking = false

    var body: some View {
        VStack {
            if selectedMode == nil {
                modeSelectionView
            } else {
                gameView
            }
        }
        .padding()
    }

    // MARK: - Mode Selection
    var modeSelectionView: some View {
        VStack(spacing: 25) {
            Text("🎮 Select Game Mode")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button("Easy (3×3)") {
                startGame(mode: .easy)
            }
            .buttonStyle(.borderedProminent)

            Button("Medium (4×4)") {
                startGame(mode: .medium)
            }
            .buttonStyle(.borderedProminent)

            Button("Hard (6×6)") {
                startGame(mode: .hard)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    // MARK: - Game View
    var gameView: some View {
        VStack(spacing: 20) {

            Text("🎨 Color Match Game")
                .font(.title)
                .fontWeight(.bold)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: gridSize),
                spacing: 10
            ) {
                ForEach(tiles.indices, id: \.self) { index in
                    Rectangle()
                        .fill(tiles[index].isRevealed || tiles[index].isMatched
                              ? tiles[index].color
                              : Color.gray)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(8)
                        .onTapGesture {
                            tileTapped(index)
                        }
                }
            }

            Button("Back to Mode Selection") {
                resetGame()
            }
            .foregroundColor(.red)
        }
    }

    // MARK: - Game Logic
    func startGame(mode: GameMode) {
        selectedMode = mode
        firstSelectedIndex = nil

        switch mode {
        case .easy:
            gridSize = 3
        case .medium:
            gridSize = 4
        case .hard:
            gridSize = 6
        }

        setupTiles()
    }

    func setupTiles() {
        let totalTiles = gridSize * gridSize
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

        colors.shuffle()

        tiles = colors.map { Tile(color: $0) }
    }

    func tileTapped(_ index: Int) {
        if isChecking || tiles[index].isRevealed || tiles[index].isMatched {
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
            } else {
                // Not match → hide both
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    tiles[firstIndex].isRevealed = false
                    tiles[index].isRevealed = false
                    firstSelectedIndex = nil
                    isChecking = false
                }
            }
        }
    }

    func resetGame() {
        selectedMode = nil
        tiles = []
        firstSelectedIndex = nil
    }
}

#Preview {
    ContentView()
}
