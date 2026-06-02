import AppKit
import SwiftTerm
class TerminalController: NSViewController, TerminalViewDelegate {
    var terminalView: TerminalView!

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
        terminalView.feed(byteArray: data)
    }


    // Feed incoming data from the backend into the terminal:
    //func onDataReceived(_ data: ArraySlice<UInt8>) {
    //    terminalView.feed(byteArray: data)
    //}


    func sizeChanged(source: TerminalView, newCols: Int, newRows: Int) {}
    func setTerminalTitle(source: TerminalView, title: String) {}
    func hostCurrentDirectoryUpdate(source: TerminalView, directory: String?) {}
    func scrolled(source: TerminalView, position: Double) {}
    func requestOpenLink(source: TerminalView, link: String, params: [String: String]) {}
    func clipboardCopy(source: TerminalView, content: Data) {}
    func rangeChanged(source: TerminalView, startY: Int, endY: Int) {}
}
