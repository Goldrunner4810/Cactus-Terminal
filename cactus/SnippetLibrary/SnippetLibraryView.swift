import SwiftUI

struct SnippetLibraryView: View {
    let currentSession: DeviceSession
    @StateObject var snippetStore = SnippetStore()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack() {
            List {
                ForEach(snippetStore.snippets) { snippet in
                    SnippetView(snippet: snippet, session: currentSession)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            snippetStore.remove(snippet: snippet)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .contextMenu {
                        Button("Delete") {
                            snippetStore.remove(snippet: snippet)
                        }
                    }
                }
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
