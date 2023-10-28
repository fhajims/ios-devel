// import UIKit, or import only _Concurrency:
import _Concurrency // for Task
import Foundation // for sleep

func myAsyncCountdownFunction() async -> String {
    for idx in stride(from: 9, to: 0, by:-1){
        print("\t- \(idx) background countdown")
        sleep(1)
    }
    return "Countdown Done"
}
func asyncCalculationFunction(_ t :String) async -> Int {
    let res = 8765
    sleep(3) // simulate longer calculation
    print("\t- \(res) background calc '\(t)' done.")
    return res
}

func nestedAsyncCalculationTask() async -> Int {
    // better NOT serialise your execution with await:
    // let a = await asyncCalculationFunction("a")
    
    // better startup multiple async functions
    async let b = asyncCalculationFunction("b")
    async let c = asyncCalculationFunction("c")
    // and wait for multiple results where needed:
    return await b+c
}

print("* We will execute an async task within a Task block in a moment:")
Task {
    let calcResult = await nestedAsyncCalculationTask()
    print(" - Background: The async calculation function finished. And we got the result: '\(calcResult)'.")
    let finalMessage = await myAsyncCountdownFunction()
    print(" - Background: The async countdown function finished. And we got message: '\(finalMessage)'.")
}
print("* Main prog executes statements and does NOT wait for the Task to complete.")
for idx in stride(from: 33, to: 39, by:1){
    print(" * main prog is working \(idx) ")
    sleep(1)
}
print("* Main prog is done.")



/*
 
 * We will execute an async task within a Task block in a moment:
 * Main prog executes statements and does NOT wait for the Task to complete.
  * main prog is working 33
  * main prog is working 34
  * main prog is working 35
     - 8765 background calc 'c' done.
     - 8765 background calc 'b' done.
  - Background: The async calculation function finished. And we got the result: '17530'.
     - 9 background countdown
  * main prog is working 36
     - 8 background countdown
  * main prog is working 37
     - 7 background countdown
  * main prog is working 38
     - 6 background countdown
 * Main prog is done.
     - 5 background countdown
     - 4 background countdown
     - 3 background countdown
     - 2 background countdown
     - 1 background countdown
  - Background: The async countdown function finished. And we got message: 'Countdown Done'.

 */
