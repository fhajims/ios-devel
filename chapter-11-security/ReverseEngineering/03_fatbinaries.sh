#!/bin/sh


cd tmp/opmnini/Payload/Opera\ Mini.app/
lipo -info Opera\ Mini 
   # Architectures in the fat file: 
   #   opmnini/Payload/Opera Mini.app/
   #     Opera Mini are: armv7 arm64 

lipo -thin armv7 Opera\ Mini -output operamini.armv7

file operamini.armv7 
   # operamini.armv7: Mach-O executable arm
  
otool -h operamini.armv7 
   # operamini.armv7:
   # Mach header
   #      magic cputype cpusubtype  caps    ...
   #  0xfeedface      12          9  0x00   ...