import Foundation
import Combine

class SnippetStore: ObservableObject {
    @Published var snippets: [Snippet] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(snippets) {
                UserDefaults.standard.set(encoded, forKey: "snippets")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "snippets"),
           let decoded = try? JSONDecoder().decode([Snippet].self, from: data) {
            self.snippets = decoded
        }
    }
    
    func add(snippet: Snippet) {
        snippets.append(snippet)
    }
    func remove(snippet: Snippet) {
        snippets.removeAll(where: { $0.id == snippet.id })
    }
    
}


struct Snippet: Identifiable, Codable {
    var id = UUID()
    var name: String
    var content: String
}
