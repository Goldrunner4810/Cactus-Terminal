import SwiftUI

struct SnippetView: View {
    let snippet: Snippet
    let session: DeviceSession
    
    var body: some View {
        Button(action: { run() }) {
                VStack {
                    HStack {
                        Text(snippet.name)
                        Spacer()
                    }
                    HStack {
                        Text(snippet.content.prefix(20) + "...")
                        Spacer()
                    }
                    
                }
                .buttonStyle(.glass)
                Spacer()
            
        }
       
    }
    func run() {
        session.sendStringToDevice(snippet.content)
    }
}
