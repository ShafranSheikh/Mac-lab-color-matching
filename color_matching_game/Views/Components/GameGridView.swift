import SwiftUI

struct GameGridView: View {
    let gridSize: Int
    @Binding var tiles: [Tile]
    let timeRemaining: TimeInterval
    let isGameOver: Bool
    let isGameWon: Bool
    let hintsRemaining: Int
    let timeBoostsRemaining: Int
    let onTileTap: (Int) -> Void
    let onReset: () -> Void
    let onUseHint: () -> Void
    let onUseTimeBoost: () -> Void
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            // Background consistent with Home
            LinearGradient(colors: [Color.black.opacity(0.9), Color.blue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("COLOR MATCH")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.black)
                        .foregroundStyle(LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom))
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Image(systemName: "timer")
                        Text(timeString)
                            .monospacedDigit()
                    }
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(timeRemaining <= 10 ? .red : .white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                if isGameOver {
                    gameOverView
                } else {
                    gamePlayView
                }
            }
        }
    }
    
    private var gamePlayView: some View {
        VStack {
            // Power-up Bar
            HStack(spacing: 20) {
                PowerUpButton(
                    icon: "eye.fill",
                    label: "Hint",
                    count: hintsRemaining,
                    color: .purple,
                    action: onUseHint
                )
                
                PowerUpButton(
                    icon: "clock.badge.plus.fill",
                    label: "+15s",
                    count: timeBoostsRemaining,
                    color: .orange,
                    action: onUseTimeBoost
                )
            }
            .padding(.top, 10)
            
            Spacer()
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: gridSize),
                spacing: 12
            ) {
                ForEach(tiles.indices, id: \.self) { index in
                    TileView(tile: tiles[index]) {
                        onTileTap(index)
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .padding(.horizontal)
            
            Spacer()
            
            AppButton(
                title: "Exit Game",
                style: .secondary,
                action: onReset
            )
            .padding(.bottom, 20)
        }
    }
    
    private var gameOverView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(isGameWon ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .frame(width: 160, height: 160)
                
                Image(systemName: isGameWon ? "trophy.fill" : "exclamationmark.triangle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(isGameWon ? .green : .red)
            }
            
            VStack(spacing: 12) {
                Text(isGameWon ? "VICTORY!" : "OUT OF TIME")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                
                Text(isGameWon ? "You've mastered this level." : "Don't give up! Try again.")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            AppButton(
                title: isGameWon ? "Next Challenge" : "Try Again",
                color: isGameWon ? .green : .blue,
                style: .primary,
                action: onReset
            )
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

struct PowerUpButton: View {
    let icon: String
    let label: String
    let count: Int
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(color.opacity(0.3), lineWidth: 1)
                        )
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                        .frame(width: 50, height: 50)
                    
                    Text("\(count)")
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(color)
                        .clipShape(Circle())
                        .offset(x: 5, y: -5)
                        .opacity(count > 0 ? 1 : 0.5)
                }
                
                Text(label)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .disabled(count == 0)
        .opacity(count > 0 ? 1 : 0.4)
    }
}
