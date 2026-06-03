import SwiftUI
import ORSSerial

struct AddSessionView: View {
    @ObservedObject var sessionStore: SessionStore
    @AppStorage("showLoopbackDevice") private var showLoopbackDevice = false
    @Environment(\.dismiss) private var dismiss
    
    let paths = ORSSerialPortManager.shared().availablePorts
    
    @State private var name: String = "Device"
    @State private var selectedPath = ""
    @State private var baudRate: String = "9600"
    @State private var isLoopback: Bool = false

    var body: some View {
        VStack {
            Form {
                TextField("Name",text: $name)
                Picker("Device", selection: $selectedPath) {
                    ForEach(paths, id: \.self) { path in
                        Text(path.path)
                            .tag(path.path)
                    }
                }
                if (showLoopbackDevice) {
                    Toggle("Loopback", isOn: $isLoopback)
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
        }.padding().onAppear {
            if selectedPath.isEmpty, let firstPort = paths.first {
                selectedPath = firstPort.path
            }
        }
        
    }
    
    private func addSession() {
        let session = DeviceSession(
            name: name,
            serialPath: selectedPath,
            baudRate: Int(baudRate) ?? 0,
            loopBack: isLoopback
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
