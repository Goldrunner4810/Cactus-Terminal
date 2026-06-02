import SwiftUI

struct SettingsView: View {
    @AppStorage("showLoopbackDevice") private var showLoopbackDevice = false
    var body: some View {
        Form {
            Section(header: Text("Developer")){
                Toggle("Show loopback device", isOn: $showLoopbackDevice).toggleStyle(.switch)
            }
            Section(header: Text("About")) {
                HStack {
                    Spacer()
                    VStack {
                        Text("Cactus Terminal v0")
                        Text("Made by Goldrunner4810")
                    }
                    Spacer()
                }
                
            }
            
        }.formStyle(.grouped)
        .frame(maxWidth: 350, minHeight: 100)
    }
}

#Preview {
    SettingsView()
}
