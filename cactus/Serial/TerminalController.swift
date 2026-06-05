import AppKit
import SwiftTerm
class TerminalController: NSViewController, TerminalViewDelegate {
    var terminalView: TerminalView!
    weak var session: DeviceSession?


    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        terminalView = TerminalView(frame: view.bounds)
        terminalView.terminal.setCursorStyle(.blinkBlock)
        terminalView.nativeBackgroundColor = .windowBackgroundColor
        terminalView.nativeForegroundColor = .textColor
        terminalView.autoresizingMask = [.width, .height]
        terminalView.terminalDelegate = self
        view.addSubview(terminalView)
    }


    func send(source: TerminalView, data: ArraySlice<UInt8>) {
        session?.sendToDevice(data)
    }

    func receiveFromSession(_ data: ArraySlice<UInt8>) {
        terminalView.feed(byteArray: data)
    }
    
    func search(s: String, backwards: Bool) {
        if (backwards) {
            terminalView.findPrevious(s)
        } else {
            terminalView.findNext(s)
        }
        
    }


    func sizeChanged(source: TerminalView, newCols: Int, newRows: Int) {}
    func setTerminalTitle(source: TerminalView, title: String) {}
    func hostCurrentDirectoryUpdate(source: TerminalView, directory: String?) {}
    func scrolled(source: TerminalView, position: Double) {}
    func requestOpenLink(source: TerminalView, link: String, params: [String: String]) {}
    func clipboardCopy(source: TerminalView, content: Data) {}
    func rangeChanged(source: TerminalView, startY: Int, endY: Int) {}
}
