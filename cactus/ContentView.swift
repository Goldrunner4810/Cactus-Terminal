import SwiftUI

struct ContentView: View {
    @StateObject private var sessionStore = SessionStore()
    @State private var showingNewConnectionSheet = false
    @State private var selectedSessionID: DeviceSession.ID?

    private var selectedSession: DeviceSession? {
        if let selectedSessionID {
            return sessionStore.sessions.first { $0.id == selectedSessionID }
        }

        return sessionStore.sessions.first
    }

    var body: some View {

        NavigationSplitView {
            VStack {
                List(selection: $selectedSessionID) {
                    ForEach(sessionStore.sessions) { session in
                        DeviceSidebarView(session: session)
                            .tag(session.id)
                    }
                }
                .onAppear {
                    selectedSessionID = selectedSession?.id
                }

                HStack {
                    Button(action: {}) {
                        Image(systemName: "clock")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: {}) {
                        Image(systemName: "star")
                    }.buttonStyle(.glass).controlSize(.large).buttonBorderShape(.circle)
                    Button(action: { showingNewConnectionSheet = true }) {
                        Image(systemName: "plus").frame(maxWidth: .infinity)
                    }.buttonStyle(.glass).tint(.green)
                    .controlSize(.large)
                    .buttonBorderShape(.capsule).sheet(isPresented: $showingNewConnectionSheet) {
                        AddSessionView(sessionStore: sessionStore)
                    }
                }.padding()
            }
        } detail: {
            if let selectedSession {
                TerminalControllerView(session: selectedSession)
                    .id(selectedSession.id)
            } else {
                WelcomeView()
            }
        }.background(.ultraThinMaterial).navigationTitle("Cactus Terminal")
    }
}

struct TerminalControllerView: NSViewControllerRepresentable {
    let session: DeviceSession

    func makeNSViewController(context: Context) -> TerminalController {
        session.terminalController
    }

    func updateNSViewController(_ nsViewController: TerminalController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
