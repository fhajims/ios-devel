#!/bin/sh

echo "Are we sure to start unknown code? Could be dangerous!"
echo "learn about lldb:"
echo "      (lldb) help"
echo "      (lldb) exit"
lldb tmp/opmnini/Payload/Opera\ Mini.app/operamini.armv7 # works only if decrypted 

# (lldb) help

# (lldb) exit


# (lldb) l 27
#    27 #import <UIKit/UIKit.h>
#    28
#    29 int main(int argc, char* argv[])
#    30 {
#    31   @autoreleasepool {
#    32    int retVal = UIApplicationMain(argc, argv,
#                                  nil, @"AppDelegate");
#    33    return retVal;
#    34   }
#    35 }