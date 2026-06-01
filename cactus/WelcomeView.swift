import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to \(Text("Cactus!").bold().foregroundStyle(.green))")
            .font(.largeTitle)
        Text(" ")
        Text("Press the + button in the sidebar to get started.")
    }
}

#Preview {
    WelcomeView()
}
