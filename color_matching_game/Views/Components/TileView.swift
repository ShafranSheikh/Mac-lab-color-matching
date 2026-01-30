import SwiftUI

struct TileView: View {
    let tile: Tile
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(tile.isRevealed || tile.isMatched ? tile.color : Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: (tile.isRevealed || tile.isMatched ? tile.color : Color.clear).opacity(0.4), radius: 8, x: 0, y: 4)
            
            if !tile.isRevealed && !tile.isMatched {
                Image(systemName: "questionmark")
                    .foregroundColor(.white.opacity(0.2))
                    .font(.headline)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onTapGesture {
            action()
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: tile.isRevealed)
    }
}
