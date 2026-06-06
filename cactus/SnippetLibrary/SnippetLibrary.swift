import Foundation
import Combine

class SnippetStore: ObservableObject {
    @Published var snippets: [Snippet] = []
    
    func add(snippet: Snippet) {
        snippets.append(snippet)
    }
    func remove(snippet: Snippet) {
        snippets.removeAll(where: { $0.id == snippet.id })
    }
    
}


class Snippet: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var content: String
    
    init(name: String, content: String) {
        self.name = name
        self.content = content
    }
}
