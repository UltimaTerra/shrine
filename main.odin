package main
import "core:fmt"
///
///
///
///

/*
*
* 
*
*/ 


Signalable :: struct($Send, $Receive: typeid) {
	msgsend: [Send],
	msgreceive: [Receive]

	sendMessage :: proc() {
		///
		///

		///
		///
	}
	receiveMessage :: proc() {
		///
		///
		
		///
		///

	}

} 
///
///
Process :: struct {
	///

	processID: [int]string, 
	workerID: [int]string,
	workerTag: [string]string

}
///
///
Processable :: struct($Order, $Data: typeid) {

	/// Processable is our interface which works with our Processes; returning various kernel calls
	/// The order of the process type and the data that it comes with matters
	/// TODO: Might help to pad this
	



	/// Processable functions, such as for handling mapping processes
	/// or creating branching processes
	/// TODO: Routine/coroutine schema definitely would help and we can always return order/data, or pad/packet 

}
///
main :: proc() {
	/// main entry, this final exe might look for the Module for the bootstrapped build

	/// After we init the microkernel and return our array of green checks, we can begin calling to the container
	/// The microkernel + container will ASSUME that calling main with this particular parameter means our list
	/// of processes, calls, and ringed ecosystem will assert fatal errors (cxtProcBlack)


	/// This is our cleanup of the state. We cache and sleep our container.
	/// If a mk update is invoked, we eagerly execute and gracefully execute.

	/// if not, we lazily execute any cached modules/package manifest configurations.
}
///
///
comain :: proc() {


	/// secondary entry, something has caught on to here and we are probably handling main errors.

	/// we can also clean up our data engine and 'hot reload' from zero... but we trade data persistability for now.

	/// ->
	/// ->


}

get_main_engine :: proc() {


}

play_game_engine :: proc() {


}

close_game_play :: proc() {


}




