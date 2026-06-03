import SwiftUI

struct DeviceSidebarView: View {
    let session: DeviceSession

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.name)
                Text(session.serialPath)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if (session.status == .connected) {
                Image(systemName: "circle.fill").scaleEffect(0.5).foregroundStyle(.green)
            } else if (session.status == .busy) {
                Image(systemName: "circle.fill").symbolEffect(.breathe).scaleEffect(0.5).foregroundStyle(.yellow)
            } else {
                Image(systemName: "circle.fill").scaleEffect(0.5).foregroundStyle(.gray)
            }
            
        }.swipeActions(edge: .trailing) {
            Button(role: .destructive) {
            } label: {
                Label("Disconnect", systemImage: "trash")
            }
        }.swipeActions(edge: .leading) {
            Button() {
            } label: {
                Label("Favorite", systemImage: "star")
            }
        }
    }
}

struct DeviceSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSidebarView(
            session: DeviceSession(
                name: "Device 1",
                serialPath: "/dev/cu.usbserial-0001",
                baudRate: 115200,
                loopBack: false
            )
        )
    }
}
