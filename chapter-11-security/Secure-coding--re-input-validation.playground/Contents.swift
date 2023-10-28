import UIKit

// Mark: - Input Validation

class FormValidator {
    class func isNameValid(_ name: String) -> Bool {
        // we use #"..."# for not escaping escape characters
        let nameRegex = #".*[^A-Za-z].*"#
        return isInputValid(field: name, regexRule: nameRegex)
    }
    public func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return FormValidator.isInputValid(field: email, regexRule: emailRegEx)
    }

    class private func isInputValid(field: String, regexRule: String) -> Bool {
        let resRange = field.range(of: regexRule, options: .regularExpression)
        return resRange != nil
        // Optional:
        // let validateField = NSPredicate(format:"SELF MATCHES %@", regexRule)
        // return validateField.evaluate(with: field)
    }
}



// Testing the Validator:

let demoEmailAddesses:[String] = [
    "max",
    "max.moritz@bush.de",
    "max@"
]

for email in demoEmailAddesses {
    let mail = email.trimmingCharacters(in: .whitespaces)
    guard FormValidator().isEmailValid(mail) else {
        print("Error: The given email '\(mail)' is invalid!")
        print("       Please use another one and try again.")
        continue
    }
    print("Success: Your email '\(mail)' ")
    print("       was accepted by the system.")
}

/* Output:
 
 Error: The given email 'max' is invalid!
        Please use another one and try again.
 Success: Your email 'max.moritz@bush.de'
        was accepted by the system.
 Error: The given email 'max@' is invalid!
        Please use another one and try again.
 */
