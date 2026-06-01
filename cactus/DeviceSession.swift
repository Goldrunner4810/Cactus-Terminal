import Foundation

@Observable
class SessionStore {
    var sessions: [DeviceSession] = []
    func add(session: DeviceSession) {
        sessions.append(session)
    }
}

class DeviceSession {
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
