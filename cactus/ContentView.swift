import SwiftUI

struct ContentView: View {
    @StateObject private var sessionStore = SessionStore()
    @State private var showingNewConnectionSheet = false

    var body: some View {

        NavigationSplitView {
            VStack {
                List {
                    ForEach(sessionStore.sessions) { session in
                        DeviceSidebarView(session: session)
                    }
                }

                HStack {
                    Button(action: {}) {
                        Image(systemName: "clock")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: {}) {
                        Image(systemName: "star")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: {showingNewConnectionSheet=true}) {
                        Image(systemName: "plus").frame(maxWidth: .infinity)
                    }.buttonStyle(.glass).tint(.green)
                    .controlSize(.large)
                    .buttonBorderShape(.capsule).sheet(isPresented: $showingNewConnectionSheet) {
                            AddSessionView()

                }
                }.padding()
            }
        } detail: {
            WelcomeView()
        }.background(.ultraThinMaterial).navigationTitle("Cactus Terminal")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
