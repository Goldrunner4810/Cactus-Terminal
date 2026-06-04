import SwiftUI

struct DeviceSidebarView: View {
    let session: DeviceSession
    let sessionStore: SessionStore
    
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
                session.closePort()
                sessionStore.remove(session: session)
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
