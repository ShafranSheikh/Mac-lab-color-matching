import SwiftUI

struct GameGridView: View {
    let gridSize: Int
    @Binding var tiles: [Tile]
    let timeRemaining: TimeInterval
    let isGameOver: Bool
    let isGameWon: Bool
    let onTileTap: (Int) -> Void
    let onReset: () -> Void
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Header
            HStack {
                Text("Color Match")
                    .font(.headline)
                Spacer()
                Label(timeString, systemImage: "timer")
                    .font(.headline)
                    .monospacedDigit()
                    .foregroundColor(timeRemaining <= 10 ? .red : .primary)
            }
            .padding(.horizontal)

            if isGameOver {
                Spacer()
                VStack(spacing: 25) {
                    Image(systemName: isGameWon ? "trophy.fill" : "alarm.fill")
                        .font(.system(size: 80))
                        .foregroundColor(isGameWon ? .yellow : .red)
                    
                    Text(isGameWon ? "VICTORY!" : "GAME OVER")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(isGameWon ? .green : .red)
                    
                    if isGameWon {
                        Text("You matched all tiles in time!")
                            .foregroundColor(.secondary)
                    } else {
                        Text("You ran out of time!")
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: onReset) {
                        Text("Play Again")
                            .font(.title3)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(isGameWon ? .green : .blue)
                    .padding(.horizontal, 40)
                }
                Spacer()
            } else {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: gridSize),
                    spacing: 10
                ) {
                    ForEach(tiles.indices, id: \.self) { index in
                        TileView(tile: tiles[index]) {
                            onTileTap(index)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Button("End Game") {
                    onReset()
                }
                .foregroundColor(.red)
            }
        }
    }
}
