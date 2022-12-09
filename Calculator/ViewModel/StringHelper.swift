import Foundation

///: Returns last character if it exists
///: Otherwise return an empty string.
func getLastCharacter(str: String) -> String {
    return str.isEmpty ? "" : String(str.last!)
}

///: Return true if last character of input string is equal to character.
func lastCharacterIsEqualTo(str: String, character: String) -> Bool {
    let last = getLastCharacter(str: str)
    return last == character
}

///: Returns a string from a double
func formatResult(val: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 16
    return numberFormatter
        .string(from: NSNumber(value: val)) ?? "0"
}

///: Returns if last char is a digit.
func lastCharacterIsDigit(str: String) -> Bool {
    return "0123456789".contains(getLastCharacter(str: str))
}

///: Returns if last char is a digit or percent.
func lastCharacterIsDigitOrPercent(str: String) -> Bool {
    return "0123456789%".contains(getLastCharacter(str: str))
}

///: Returns if last char is an operator.
func lastCharacterIsOperator(str: String) -> Bool {
    let last = getLastCharacter(str: str)
    return textOp.contains(last)
}
