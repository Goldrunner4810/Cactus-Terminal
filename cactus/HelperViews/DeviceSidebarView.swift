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

            Image(systemName: "circle.fill").symbolEffect(.breathe)
                .scaleEffect(0.5)
                .foregroundStyle(statusColor)
        }.swipeActions(edge: .trailing) {
            Button(role: .destructive) {
            } label: {
                Label("Disconnect", systemImage: "trash")
            }
        }
    }

    private var statusColor: Color {
        switch session.status {
        case .connected:
            .green
        case .busy:
            .yellow
        case .disconnected:
            .gray
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
