import UIKit

/*
 
 Swift supports **functions** with **named arguments** and **default parameters**. Internal and external names for parameters are possible. An external name can be suppressed by using an underscore `_`.
 
 */


var greeting = "Function Demos:"
print(greeting)

func power( _ b:Int,   // external name = _ = not needed
            exp:Int=2, // named with default value
            msg:String)
            -> (powRes:Int,
                powMsg:String){
    var r=1
    // unused variable, so better use underscore _
    for _ in 1...exp {
        r *= b
    }
    // returning a tuple
    return (r,"\(msg) \(r)")
}

// usage of named return values. Here: "powMsg"
let res = power(6,msg:"The final result is")
print(res.powMsg)
