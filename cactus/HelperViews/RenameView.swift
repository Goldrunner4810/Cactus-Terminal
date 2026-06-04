//
//  RenameView.swift
//  Cactus Terminal
//
//  Created by Simon Gabryel on 04.06.26.
//

import SwiftUI

struct RenameView: View {
    let session: DeviceSession
    @State private var name: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("New name", text: $name)
            }
            HStack() {
                Button(action: {dismiss()}) {
                    Text("Cancel")
                }.keyboardShortcut(.cancelAction)
                Spacer()
                Button("Add") {
                    session.name = name
                    dismiss()
                }.keyboardShortcut(.defaultAction)
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }.padding()
    }
    
}
