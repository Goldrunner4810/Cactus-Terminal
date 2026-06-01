import Foundation
import Combine

class SessionStore: ObservableObject {
    @Published var sessions: [DeviceSession] = [
        DeviceSession(name: "Device 1", serialPath: "/dev/cu.usbserial-0001", baudRate: 115200)
    ]

    func add(session: DeviceSession) {
        sessions.append(session)
    }
}

class DeviceSession: Identifiable {
    let id = UUID()
    let name: String
    let serialPath: String
    let baudRate: Int
    let status: Status

    init(name: String, serialPath: String, baudRate: Int) {
        self.name = name
        self.serialPath = serialPath
        self.baudRate = baudRate
        self.status = .connected
    }

}

enum Status {
    case connected
    case busy
    case disconnected
}
