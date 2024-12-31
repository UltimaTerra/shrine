indirect enum EngineState {
    case engine
    case game
}
/// DOC: FOO
private indirect enum GooInstruction {
    /// assembly-like instructions, but we have a runtime so we consider the GooBase Kernel + GooCore types to be related, but those don't exist
    /// todo
    case mov
    case load
    case rd
    case wrt
    case add
    case divide
}
/// DOC: BAR
public enum GooState {
    case okay
    /// in the runtime, this 'state' is okay
    case fine
    /// in the runtime, this 'state' is fine (it is being updated/changed hopefully to okay)
    case warn
    /// in the runtime  this state is warning (it has some erratic behavior)
    case fail
    /// in the runtime, this state is failing (it is about to crash, write logs and updates.)

}
/// DOC: BIZZ
private class TapeStorage {

}
/// DOC: BAR
private class TapeInstruction {

}
/// Tape Machine is the public runtime queue, for either the game/engine (but 'never' both)
/// It is a reference tuple to two arrays for the related storage and instructions
/// When we start global runner functions; our TapeMachine is exposed to other states/instructions
/// The game framework will take GooState/Instructions as control branches for the TapeMachine app loop.
public class TapeMachine {
    private let t1: ([TapeStorage], [TapeInstruction])
    private let t2: ([TapeStorage], [TapeInstruction])

    fileprivate init(t1: ([TapeStorage], [TapeInstruction]), t2: ([TapeStorage], [TapeInstruction]))
    {
        self.t1 = t1
        self.t2 = t2
    }
    deinit {
        ///todo:
    }
    ///
    ///
    ///
    ///
}
/// function for zero parameters; with the return of a new TapeMachine with relevant GS/GI
/// GooStates will often branch into other functions if switching between game/engine
/// GooInstructions will also call other functions if switching between the various modes like the system/kernel code
/// If we need to mutate, we will use the changeRunner or branchRunner
func startRunner() {

}
func changeRunner() {

}
func branchRunner() {

}
func pauseRunner() {

}
func switchRunner() {

}
