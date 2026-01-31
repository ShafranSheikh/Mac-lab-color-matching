import SwiftUI

struct ModeSelectionView: View {
    let onSelect: (GameMode) -> Void
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(colors: [Color.black.opacity(0.8), Color.blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("COLOR MATCH")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
                        )
                    
                    Text("Select your level of mastery")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .kerning(2)
                }
                .padding(.top, 40)
                
                VStack(spacing: 20) {
                    ForEach([GameMode.easy, .medium, .hard], id: \.self) { mode in
                        AppButton(
                            title: mode.name,
                            color: mode.color,
                            style: .card(icon: mode.icon, subtitle: mode.description)
                        ) {
                            onSelect(mode)
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
        }
    }
}

// Helper for glassmorphism
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    ModeSelectionView { _ in }
}
