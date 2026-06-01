import SwiftUI

struct DeviceSidebarView: View, session: Session {
    var body: some View {
        HStack {
            Text("Device 1")
            Spacer()
            Image(systemName: "circle.fill").symbolEffect(.breathe)
                .scaleEffect(0.5)
                .foregroundStyle(Color.green)
        }.swipeActions(edge: .trailing) {
            Image(systemName: "trash").tint(.red)
        }.swipeActions(edge: .leading) {
            Image(systemName: "info")
        }
    }
}

#Preview {
    DeviceSidebarView()
}
