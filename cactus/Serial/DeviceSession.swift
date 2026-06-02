import Foundation
import SwiftUI
import Combine
import SwiftTerm

class SessionStore: ObservableObject {
    @Published var sessions: [DeviceSession] = []

    func add(session: DeviceSession) {
        sessions.append(session)
    }
}

class DeviceSession: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let serialPath: String
    let baudRate: Int
    let status: Status
    let loopBack: Bool
    let terminalController = TerminalController()

    init(name: String, serialPath: String, baudRate: Int, loopBack: Bool) {
        self.name = name
        self.serialPath = serialPath
        self.baudRate = baudRate
        self.status = .connected
        self.loopBack = loopBack
        terminalController.session = self
    }
    
    func sendToDevice(_ data: ArraySlice<UInt8>) {
        if (!loopBack) {
            // Implement Serial
            print("Serial Logic")
        } else {
            terminalController.receiveFromSession(data)
        }
        
    }


    func receivedFromDevice(_ data: ArraySlice<UInt8>) {
        if (!loopBack) {
            print("Serial Logic recieved")
        }
    }

}

enum Status {
    case connected
    case busy
    case disconnected
}

