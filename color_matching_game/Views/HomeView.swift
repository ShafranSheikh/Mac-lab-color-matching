import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        ZStack {
            if let mode = viewModel.selectedMode {
                GameGridView(
                    gridSize: mode.gridSize,
                    tiles: $viewModel.tiles,
                    timeRemaining: viewModel.timeRemaining,
                    isGameOver: viewModel.isGameOver,
                    isGameWon: viewModel.isGameWon,
                    hintsRemaining: viewModel.hintsRemaining,
                    timeBoostsRemaining: viewModel.timeBoostsRemaining,
                    onTileTap: { index in
                        viewModel.tileTapped(at: index)
                    },
                    onReset: {
                        viewModel.resetGame()
                    },
                    onUseHint: {
                        viewModel.useHint()
                    },
                    onUseTimeBoost: {
                        viewModel.useTimeBoost()
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
