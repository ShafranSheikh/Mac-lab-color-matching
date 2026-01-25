import SwiftUI

struct AchievementsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 60))
                .foregroundColor(.yellow)
            
            Text("Achievements")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Complete games to earn badges!")
                .foregroundColor(.secondary)
            
            List {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                    Text("First Win")
                    Spacer()
                    Text("Locked")
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.gray)
                    Text("Speedster")
                    Spacer()
                    Text("Locked")
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "brain.head.profile")
                        .foregroundColor(.gray)
                    Text("Memory Master")
                    Spacer()
                    Text("Locked")
                        .foregroundColor(.gray)
                }
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    AchievementsView()
}
