import SwiftUI

struct ContentView: View {
    
    var body: some View {
        @State var sessionStore = SessionStore()
        
        NavigationSplitView {
            VStack {
                List {
                    sessionStore.sessions.forEach { session in
                        DeviceSidebarView(session: session)
                    }
                        
                    }
                    
                }
                Spacer()
                HStack {
                    Button(action: {}) {
                        Image(systemName: "clock")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: {}) {
                        Image(systemName: "star")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: {}) {
                        Image(systemName: "plus").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glass).tint(.green)
                    .controlSize(.large)
                    .buttonBorderShape(.capsule)
                }.padding()
            }
        } detail: {
            WelcomeView()
        }.background(.ultraThinMaterial).navigationTitle("Cactus Terminal")
    }
        
}


#Preview {
    ContentView()
}
