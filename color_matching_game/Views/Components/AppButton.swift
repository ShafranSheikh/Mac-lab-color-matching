import SwiftUI

enum AppButtonStyle {
    case primary
    case secondary
    case card(icon: String, subtitle: String?)
}

struct AppButton: View {
    let title: String
    var subtitle: String? = nil
    var icon: String? = nil
    var color: Color = .blue
    let style: AppButtonStyle
    let action: () -> Void
    
    @State private var isPressed = false
    
    init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        color: Color = .blue,
        style: AppButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.color = color
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            content
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
    
    @ViewBuilder
    private var content: some View {
        switch style {
        case .primary:
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color)
                        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
                )
            
        case .secondary:
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.6))
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            
        case .card(let iconName, let subtitleText):
            HStack(spacing: 20) {
                // Icon Container
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: iconName)
                        .font(.title3)
                        .foregroundColor(color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if let sub = subtitleText {
                        Text(sub)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .foregroundColor(.white)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        AppButton(title: "Primary Button") {}
        AppButton(title: "Secondary Button", style: .secondary) {}
        AppButton(title: "Easy", color: .green, style: .card(icon: "leaf.fill", subtitle: "Relaxing 3x3")) {}
    }
    .padding()
    .background(Color.black)
}
