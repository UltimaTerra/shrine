public enum GooInstruction {

}
public enum GooState {

}
private class TapeStorage {

}
private class TapeInstruction {

}
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

}

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
