import SwiftUI

struct AddSessionView: View {
    @ObservedObject var sessionStore: SessionStore
    @Environment(\.dismiss) private var dismiss
    
    let paths = [
        "/dev/tty.usbserial.130",
        "/dev/tty.usbserial.230"
    ]
    
    @State private var name: String = ""
    @State private var selectedPath = "/dev/tty.usbserial.130"
    @State private var baudRate: String = "9600"

    var body: some View {
        VStack {
            Form {
                TextField("Name",text: $name)
                Picker("Device", selection: $selectedPath) {
                    ForEach(paths, id: \.self) { path in
                        Text(path)
                    }
                }
                TextField("Baud Rate",text: $baudRate)
            }
            HStack() {
                Button(action: {dismiss()}) {
                    Text("Cancel")
                }.keyboardShortcut(.cancelAction)
                Spacer()
                Button(action: addSession) {
                    Text("Add")
                }.keyboardShortcut(.defaultAction)
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }.padding()
        
    }
    
    private func addSession() {
        let session = DeviceSession(
            name: name,
            serialPath: selectedPath,
            baudRate: Int(baudRate) ?? 0
        )

        sessionStore.add(session: session)
        dismiss()
    }
}

struct AddSessionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSessionView(sessionStore: SessionStore())
    }
}
