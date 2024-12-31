import CoreFoundation
import Foundation

/*
*
*/

struct TerminalBuffer {

}

class TerminalGateway {
    var globBuffer: TerminalBuffer

    init(globBuffer: TerminalBuffer) {
        self.globBuffer = globBuffer
    }

}
