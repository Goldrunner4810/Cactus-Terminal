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
                    }
                    .keyboardShortcut("n", modifiers: .command)
                    .buttonStyle(.glass).tint(.green)
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
        .background(
            Group {
                Button("") { switchSession(forward: true) }
                    .keyboardShortcut(.tab, modifiers: .control)
                
                Button("") { switchSession(forward: false) }
                    .keyboardShortcut(.tab, modifiers: [.control, .shift])
            }
            .opacity(0)
            .frame(width: 0, height: 0)
        )
        }
    
        private func switchSession(forward: Bool) {
            let sessions = sessionStore.sessions
            guard !sessions.isEmpty else { return }
            
            let currentIndex = sessions.firstIndex { $0.id == selectedSessionID } ?? 0
            
            let nextIndex: Int
            if forward {
                nextIndex = (currentIndex + 1) % sessions.count
            } else {
                nextIndex = (currentIndex - 1 + sessions.count) % sessions.count
            }
            
            selectedSessionID = sessions[nextIndex].id
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
