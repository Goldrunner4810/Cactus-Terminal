import Foundation
import SwiftUI
import Combine
import SwiftTerm
import AppKit
import ORSSerial

class SessionStore: ObservableObject {
    @Published var sessions: [DeviceSession] = []

    func add(session: DeviceSession) {
        sessions.append(session)
    }
    func remove(session: DeviceSession) {
        sessions.removeAll(where: { $0.id == session.id })
    }
}

class DeviceSession: NSObject, Identifiable, ObservableObject, ORSSerialPortDelegate {
    let id = UUID()
    @Published var name: String
    let serialPath: String
    let baudRate: Int
    @Published var status: Status
    let loopBack: Bool
    let terminalController = TerminalController()
    private var serialPort: ORSSerialPort?

    init(name: String, serialPath: String, baudRate: Int, loopBack: Bool) {
        self.name = name
        self.serialPath = serialPath
        self.baudRate = baudRate
        self.status = .connected
        self.loopBack = loopBack
        super.init()
        
        if (name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "habicht") {
            if let url = URL(string: "https://www.youtube.com/watch?v=2wiFX31VCQs") {
                NSWorkspace.shared.open(url)
            }
        } else if (name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "67") {
            if let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
                NSWorkspace.shared.open(url)
            }
        }
        
        terminalController.session = self
        openSerialPortIfNeeded()
    }

    deinit {
        serialPort?.close()
    }
    
    func sendToDevice(_ data: ArraySlice<UInt8>) {
        if (!loopBack) {
            let dataToSend = Data(data)
            serialPort?.send(dataToSend)
        } else {
            terminalController.receiveFromSession(data)
        }
        
    }
    
    func sendStringToDevice(_ string: String) {
        let array: [UInt8] = Array(string.utf8)
        sendToDevice(array[...])
    }


    func receivedFromDevice(_ data: ArraySlice<UInt8>) {
        if (!loopBack) {
            terminalController.receiveFromSession(data)
        }
    }

    private func openSerialPortIfNeeded() {
        guard !loopBack else { return }

        guard let port = ORSSerialPort(path: serialPath) else {
            print("Could not create serial port at \(serialPath)")
            status = .disconnected
            return
        }

        serialPort = port
        port.delegate = self
        port.baudRate = NSNumber(value: baudRate)
        port.open()
    }
    
    func closePort() {
        if (!loopBack) {
            serialPort?.close()
        }
        status = .disconnected
    }

    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        receivedFromDevice(Array(data)[...])
    }

    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        status = .connected
        print("Opened serial port \(serialPort.path)")
    }

    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        status = .disconnected
        print("Closed serial port \(serialPort.path)")
    }

    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        status = .disconnected
        self.serialPort = nil
        print("Serial port removed \(serialPort.path)")
    }

    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        status = .disconnected
        print("Serial port error on \(serialPort.path): \(error.localizedDescription)")
    }

}

enum Status {
    case connected
    case busy
    case disconnected
}
