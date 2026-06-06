//
//  SnippetEditor.swift
//  Cactus Terminal
//
//  Created by Simon Gabryel on 06.06.26.
//

import SwiftUI

struct SnippetEditor: View {
    let snippetStore: SnippetStore
    @State private var name: String = ""
    @State private var content: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
            }
            TextEditor(text: $content).frame(height: 200)
            HStack() {
                Button(action: {dismiss()}) {
                    Text("Cancel")
                }.keyboardShortcut(.cancelAction)
                Spacer()
                Button("Add") {
                    snippetStore.add(snippet: Snippet(name: name, content: content))
                    dismiss()
                }.keyboardShortcut(.defaultAction)
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }.padding()
    }
}
