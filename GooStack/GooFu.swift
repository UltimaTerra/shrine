// Core instruction set architecture
protocol ISA {
    associatedtype Instruction
    associatedtype State

    var currentInstruction: Instruction { get }
    var state: State { get }
}

protocol Templatable: ISA {
    // Event handling for tape one
    func handleInstruction(_ event: Instruction) -> State
    func validateTransition(to nextState: State) -> Bool
}

protocol Partionable: ISA {
    // Event handling for tape two
    func receiveState(_ state: State) -> Bool
    func emitNextInstruction() -> Instruction?
}

class FuBar<TapeOne: Templatable, TapeTwo: Partionable>
where
    TapeOne.State == TapeTwo.State,
    TapeOne.Instruction == TapeTwo.Instruction
{

    var tapeRunnerOne: TapeOne
    var tapeRunnerTwo: TapeTwo

    lazy var tapeWindUp: TapeTwo? = {
        // Type-safe state transition in the instruction queue
        guard tapeRunnerTwo.receiveState(tapeRunnerOne.state),
            let nextInstruction = tapeRunnerTwo.emitNextInstruction(),
            tapeRunnerOne.validateTransition(
                to: tapeRunnerOne.handleInstruction(nextInstruction)
            )
        else {
            return nil
        }
        return tapeRunnerTwo
    }()

    init(tapeRunnerOne: TapeOne, tapeRunnerTwo: TapeTwo) {
        self.tapeRunnerOne = tapeRunnerOne
        self.tapeRunnerTwo = tapeRunnerTwo
    }
}
