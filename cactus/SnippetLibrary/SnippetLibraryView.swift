import SwiftUI

struct SnippetLibraryView: View {
    let currentSession: DeviceSession
    @StateObject var snippetStore = SnippetStore()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack() {
            ForEach(snippetStore.snippets) { snippet in
                SnippetView(snippet: snippet, session: currentSession)
            }
            Spacer()
            HStack {
                Spacer()
                Button( action: { isPresented.toggle() }) {
                    Image(systemName: "plus")
                }
                .buttonStyle(.glass).tint(.green)
                .controlSize(.large)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            SnippetEditor(snippetStore: snippetStore)
        }
        
    }
}
