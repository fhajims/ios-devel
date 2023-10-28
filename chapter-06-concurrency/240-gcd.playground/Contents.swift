import Dispatch
let concurrentQueue = DispatchQueue( // custom queue
    label: "at.fhj.ims.worker",
    qos: .background, // very low priority
    attributes: .concurrent) // not: one after the other

print("1 Start .async, i.e. no blocking wait.")
concurrentQueue.async {
    print("2 Task a is executing in the background.")
    sleep(13)// do something for 13 seconds
    print("7 Task a is done")
}
print("3 Start off another one and do not wait.")
concurrentQueue.async {
    print("4 Task b at the same time in background.")
    sleep(12)// do another thing for 12 seconds
    print("6 Task b is done")
}
print("5 Done. Starting two background tasks.")
// watch the output: 1, 2, 3, 4, 5, ..pause.. 6,7



let workItem = DispatchWorkItem( // some code to execute
    qos: .userInitiated,
    flags: .assignCurrentContext) {
        print("Working in the background")
}

concurrentQueue.async(execute: workItem)




print("(MAIN) Queues")

// (A) Use of existing queues:
// 1.) execute a sequence of code blocks
DispatchQueue.global(qos: .utility).sync {
    sleep(2)
    print("(A) Task 1a sync after 2 secs")
}
DispatchQueue.global(qos: .utility).sync {
    sleep(1)
    print("(A) Task 1b sync after 1 sec")
}

// 2.) execute a sequence of code blocks (in the background)
DispatchQueue.main.async {
    sleep(4)
    print("(A) Task 2a executing async after 4 secs")
}

DispatchQueue.main.async {
    sleep(1)
    print("(A) Task 2b executing async after 1 sec")
}


let a3 = DispatchQueue.global(qos: .unspecified)
a3.async {
    sleep(2)
    print("(A) Task 3a executing async in the global queue after 2 secs")
}
a3.async {
    sleep(1)
    print("(A) Task 3b executing async in the global queue after 1 sec")
}



// (B) Create your own queues:
let concurrentQueue2 = DispatchQueue(
        label: "at.fhj.ims.worker",
        qos: .background) // background, default, utility,...

concurrentQueue2.async {
    print("(B) 1a my queue works in the background")
    for i in 1...15 {
        print("(B) 1a \(i)", terminator:"...\n")
        sleep(1)
    }
    print("(B) 1a Background Done.")
}

// execute a (code) block (several times):
let workItem2 = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext) {
    print("(B) 2 AGAIN in the background")
}
concurrentQueue.async(execute: workItem2)



// (C) typical usage:


// Move to a background thread to do some long running work
concurrentQueue.async {
    sleep(3)
    print("(C) after 3 secs:")
    DispatchQueue.main.async {
        // Bounce back to the main thread to update the UI
        print("(C) Back in main tread")
    }
}


print("(MAIN) Nearly done...")
sleep(12) // in sec. We would need to wait for a queue
print("(MAIN) Done")




sleep(80)
// DISPATCH GROUP DEMOS

let dq = DispatchQueue( label: "Concurrent Dispatch Queue for DG-Demo",
                        attributes: .concurrent)

// Dispatch Groups:
print("D DISPATCH GROUP DEMO")

let dgr = DispatchGroup()
dq.async(group:dgr) {
    print("D1 AsyncQueue \(dq.label) started")
    sleep(1)
    print("D1 AsyncQueue \(dq.label) finished")
}

// ... when a group of previously submitted block objects have completed.
dgr.notify(queue: DispatchQueue.main) {
    print("D-Main Dispatch Group: notify on main.")
}
print("D-FINISH before waiting for all worker items completed in the dispatch group")
dgr.wait()
print("D-FINISH after waiting for the group")

sleep(4)

// more demos
let q = DispatchQueue( label: "concurrent Dispatch Queue",
                       attributes: .concurrent)

print("E some more SYNC/ASYNC QUEUES DEMO")

q.sync {
    print("E2 SyncQueue \(q.label) started")
    sleep(2)
    print("E2 SyncQueue \(q.label) finished")
}
q.asyncAfter( deadline: DispatchTime.now() + 4){
    print("E3 ASyncAfterQueue \(q.label) started after 4 secs")
    sleep(2)
    print("E3 ASyncAfterQueue \(q.label) finished after 4+2 secs")
}



/* Output:
 D DISPATCH GROUP DEMO
 D1 AsyncQueue Concurrent Dispatch Queue for DG-Demo started
 D-FINISH before waiting for all worker items completed in the dispatch group
 D1 AsyncQueue Concurrent Dispatch Queue for DG-Demo finished
 D-FINISH after waiting for the group
 E some more SYNC/ASYNC QUEUES DEMO
 E2 SyncQueue concurrent Dispatch Queue started
 E2 SyncQueue concurrent Dispatch Queue finished
 D-Main Dispatch Group: notify on main.
 E3 ASyncAfterQueue concurrent Dispatch Queue started after 4 secs
 E3 ASyncAfterQueue concurrent Dispatch Queue finished after 4+2 secs
 */



sleep(80)
// DISPATCH GROUP & ConcurrentPerform DEMOS
print("(F) DISPATCH GROUP (with concurrent perform) DEMO")





let cdgr = DispatchGroup()
print("(F) We configure the gloabel dispatch queue")
/* NEW: QoS:
 case userInteractive   //  The user-interactive quality of service class.
 case userInitiated     //  The user-initiated quality of service class.
 case `default`         //  The default quality of service class.
 case utility           //  The utility quality of service class.
 case background        //  The background quality of service class
 case unspecified       //  The absence of a quality of service class.
 
 OLD:
 var DISPATCH_QUEUE_PRIORITY_HIGH: Int32
 var DISPATCH_QUEUE_PRIORITY_DEFAULT: Int32
 var DISPATCH_QUEUE_PRIORITY_LOW: Int32
 var DISPATCH_QUEUE_PRIORITY_BACKGROUND: Int32
 */
DispatchQueue.global(qos: .utility) //

DispatchQueue.concurrentPerform(iterations: 33) { i in
    print("(F) The global dispatch Queue will enter dispatch group")
    cdgr.enter()
    print("(F) * \(i).task: work in progresss... ")
    cdgr.leave()
    print("(F) The global dispatch Queue left dispatch group")
}
print("(F) Done 1")
dgr.notify(queue: DispatchQueue.main){
    print("(F) Dispatch Group notify")
}
print("(F) Done 2 (after notify)")
dgr.notify(queue: DispatchQueue.main){
    print("(F) Dispatch Group wait")
}
print("(F) Done 3 (after wait)")
