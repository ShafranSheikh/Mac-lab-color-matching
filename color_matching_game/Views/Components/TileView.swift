import SwiftUI

struct TileView: View {
    let tile: Tile
    let action: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(tile.isRevealed || tile.isMatched ? tile.color : Color.gray)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(8)
            .onTapGesture {
                action()
            }
    }
}
