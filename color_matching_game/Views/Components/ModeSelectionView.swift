import SwiftUI

struct ModeSelectionView: View {
    let onSelect: (GameMode) -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            Text("🎮 Select Game Mode")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Easy (3×3)") {
                onSelect(.easy)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Medium (4×4)") {
                onSelect(.medium)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Hard (6×6)") {
                onSelect(.hard)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
