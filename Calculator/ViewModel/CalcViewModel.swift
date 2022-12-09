//
//  CalcViewModel.swift
//  Calculator
//
//  Created by Lazar Dejanovic on 5.12.22..
//

import SwiftUI


struct CalculatorButtonView: View {
    
    @Binding var display: String
    @Binding var lastNumber: String
    @Binding var lastOperator: String
    @Binding var operatorSelected: Bool
    var button: CalculatorButton
    
    var body: some View {
        Button(button.title) {
            buttonTapped(button)
        }
        .font(.system(size: 32))
        .frame(width: self.getWidth(button), height: self.getHeight(button))
        .foregroundColor(Color("TextColor"))
        .background(button.backgroundColor)
        .cornerRadius(self.getWidth(button))
    }
    
    private func getWidth(_ button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 5 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func getHeight(_ button: CalculatorButton) -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func buttonTapped(_ button: CalculatorButton) {
        switch button {
            case .zero:
                numberTapped(value: "0")
            case .one:
                numberTapped(value: "1")
            case .two:
                numberTapped(value: "2")
            case .three:
                numberTapped(value: "3")
            case .four:
                numberTapped(value: "4")
            case .five:
                numberTapped(value: "5")
            case .six:
                numberTapped(value: "6")
            case .seven:
                numberTapped(value: "7")
            case .eight:
                numberTapped(value: "8")
            case .nine:
                numberTapped(value: "9")
            case .decimal:
                if !display.contains(".") {
                    display += "."
                }
                operatorSelected = false
            case .equals:
                perform(lastOperator)
            case .plus:
                if !operatorSelected {
                    perform(lastOperator)
                }
                lastOperator = "plus"
                operatorSelected = true
            case .minus:
                if !operatorSelected {
                    perform(lastOperator)
                }
                lastOperator = "minus"
                operatorSelected = true
            case .multiply:
                if !operatorSelected {
                    perform(lastOperator)
                }
                lastOperator = "multiply"
                operatorSelected = true
            case .divide:
                if !operatorSelected {
                    perform(lastOperator)
                }
                lastOperator = "divide"
                operatorSelected = true
            case .ac:
                display = "0"
                lastNumber = "0"
                lastOperator = ""
                operatorSelected = false
            case .plusMinus:
                if !display.contains("-") {
                    display.insert("-", at: display.startIndex)
                } else {
                    display.removeFirst()
                }
            case .percent:
                // Never understood how this actually works on a real calculator
                print("Move decimal place to the left 2 times")
        }
    }
    
    private func numberTapped(value: String) {
        if !operatorSelected {
            if display == "0" {
                display = value
            } else {
                display += value
            }
        } else {
            lastNumber = display
            display = value
        }
        operatorSelected = false
    }
    
    private func perform(_ lastOperator: String) {
        switch lastOperator {
            case "plus":
                display = "\(Double(lastNumber)! + Double(display)!)"
                display = trimDecimal(for: display)
            case "minus":
                display = "\(Double(lastNumber)! - Double(display)!)"
                display = trimDecimal(for: display)
            case "multiply":
                display = "\(Double(lastNumber)! * Double(display)!)"
                display = trimDecimal(for: display)
            case "divide":
                display = "\(Double(lastNumber)! / Double(display)!)"
                display = trimDecimal(for: display)
            default:
                break
        }
    }
    
    private func trimDecimal(for display: String) -> String {
        var didHitDecimal = false
        var beforeDecimal = ""
        var afterDecimal = ""
        for i in 0..<display.count {
            let index = display.index(display.startIndex, offsetBy: i)
            if !didHitDecimal {
                if display[index] != "." {
                    beforeDecimal += "\(display[index])"
                } else {
                    didHitDecimal = true
                }
            } else {
                afterDecimal += "\(display[index])"
            }
        }
        return Double(afterDecimal)! == 0 ? beforeDecimal : afterDecimal
    }
    
}
