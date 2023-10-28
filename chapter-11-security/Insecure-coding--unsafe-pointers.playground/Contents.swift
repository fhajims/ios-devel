import Foundation

// MARK - UnsafePointer



// Info: typealias CChar = Int8

var unsafePointer  : UnsafePointer<CChar>? = nil


func messingWithPointers() -> UnsafePointer<CChar>? {
    var message = "Original-Msg."
    var unsafePointer  : UnsafePointer<CChar>? = nil
    message.withCString { myStringPointer in
        // points to ... null-terminated sequence of UTF-8 code units...
        unsafePointer = myStringPointer
        if let ptr = unsafePointer {
            print("Safe use of pointer inside code block / closure")
            print("The message is (char as int-value): '\( ptr.pointee )', i.e. string ",
                  terminator: " ")
            print( NSString.init(format: "%c", ptr.pointee) )
            for i in 0...79 {
                print( NSString.init(format: "%c", ptr.advanced(by: i).pointee ), terminator: " " )
            }
            print("")
        }
    }
    print("We change the message, but the pointer stays as before.")
    message="!!Changed!! Will this message be accessed only in a secure way?"
    return unsafePointer
}
unsafePointer = messingWithPointers()



print("NEVER use the pointer outside the closure!!")
print("      We access memory locations feed within the function.")
print("      Your program might even crash.")
if let ptr = unsafePointer {
    print("The message is (char as int-value): '\( ptr.pointee )'")
    for i in 0...79 {
        print( NSString.init(format: "%c", ptr.advanced(by: i).pointee ), terminator: " " )
    }
}


/*
 
 Safe use of pointer inside code block / closure
 The message is (char as int-value): '79', i.e. string  O
 O r i g i n a l - M s g .    - M s g .   í  ÿ Ü · ÷    M . J                                            K ½  ÿ 
 We change the message, but the pointer stays as before.
 NEVER use the pointer outside the closure!!
       We access memory locations feed within the function.
       Your program might even crash.
 The message is (char as int-value): '80'
  X ?      0 þ Ü · ÷    ¦     ÿ    X s ½  ÿ            P            ÿ            H        H        
 
 */
