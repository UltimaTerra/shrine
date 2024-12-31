/*
*
*
*/
import Foundation

enum ProcessID {
    case one
    case two
    case three
    case four
}
enum Process {
    case value
    case task
}
enum ProcessBuffer<I> {
    case buff
    case work
}
enum ProcessSignal<O> {
    case signal
    case exit
}

class ProcessManager<I, O> {
    var procID: ProcessID
    var proc: Process
    var procBuffer: ProcessBuffer<I>
    var procSignal: ProcessSignal<O>

    init(
        procID: ProcessID, proc: Process, procBuffer: ProcessBuffer<I>, procSignal: ProcessSignal<O>
    ) {
        self.procID = procID
        self.proc = proc
        self.procBuffer = procBuffer
        self.procSignal = procSignal
    }

    func accessAnyProcess<Head, Tape>(
        procBuffer: ProcessBuffer<Head>, procSignal: ProcessSignal<Tape>
    ) -> ([UInt: String]) {
        let _: [UInt64] = [0]
        let _: [Head] = []

        return ([0: "Okay"])
    }

}
