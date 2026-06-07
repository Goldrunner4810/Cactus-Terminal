import SwiftUI

struct SnippetView: View {
    let snippet: Snippet
    let session: DeviceSession
    
    var body: some View {
        Button(action: { run() }) {
            VStack(alignment: .leading, spacing: 4) {
                Text(snippet.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(snippet.content.prefix(20) + "...")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
       
    }
    func run() {
        session.sendStringToDevice(snippet.content)
    }
}
