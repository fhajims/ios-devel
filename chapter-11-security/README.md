---

---
#### [Home](../README.md) | [Overview-Mini-apps](../demo-apps.md)

---


# 11 Security

## Secure Coding

Better, use strong typing (the compiler can check for **Null Safety**) and explicit type checks (if necessary), exit early, input validation, structured error handling, ..., and testing.

Open playground [Input Validation with RegEx](Secure-coding--re-input-validation.playground)

## Secure Storing Data

Better store sensitive data in a secure way. For example use the secure keychain. 


## Insecure Coding

Using pointers is **not** recommended! It is considered unsafe as it cannot be checked by the compiler. 

Open playground [Unsafe Pointers](Insecure-coding--unsafe-pointers.playground).

## Compile and debug with LLVM (tools)

See selected scripts in directory [Secure Coding](./SecureCoding/)

## Reverse Engineering

Many Unix command line tools support inspection of artefacts. Check out, for example, `codesign`, `otool`, `lipo`, `strings`, `lldb`, ...  

See selected scripts in directory [Reverse Engineering](./ReverseEngineering/)


## Forensics

Inspect user settings and other data in configuration files and databases. For example, play around with `plutil`, `sqlite3`, ...

See selected scripts in directory [Forensics](./Forensics/)


---
#### Proceed to [Chapter 12 System (Services)](../chapter-12-system/README.md) | Back to [Chapter 10 Sensors](../chapter-10-sensors/README.md)

---