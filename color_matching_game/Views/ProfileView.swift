import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Player One")
                .font(.title)
                .fontWeight(.bold)
            
            Form {
                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Games Played")
                        Spacer()
                        Text("0")
                    }
                    HStack {
                        Text("Best Score")
                        Spacer()
                        Text("0")
                    }
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Sound Effects", isOn: .constant(true))
                    Toggle("Dark Mode", isOn: .constant(false))
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
