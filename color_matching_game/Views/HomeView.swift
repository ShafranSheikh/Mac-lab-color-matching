import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack {
            if let mode = viewModel.selectedMode {
                GameGridView(
                    gridSize: mode.gridSize,
                    tiles: $viewModel.tiles,
                    timeRemaining: viewModel.timeRemaining,
                    isGameOver: viewModel.isGameOver,
                    isGameWon: viewModel.isGameWon,
                    onTileTap: { index in
                        viewModel.tileTapped(at: index)
                    },
                    onReset: {
                        viewModel.resetGame()
                    }
                )
            } else {
                ModeSelectionView { mode in
                    viewModel.startGame(mode: mode)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
