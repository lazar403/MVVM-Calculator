import SwiftUI

struct CalculatorButtonsView: View {
    
    @Binding var mainResult: String
    @Binding var currentComputation: String
    
    let buttonData: [RowOfCalculatorButtonsModel] = [
        RowOfCalculatorButtonsModel(row:[
            CalculatorButtonModel(
                calcButton: .clear,
                color: greenForegroundColor),
            CalculatorButtonModel(
                calcButton: .negative,
                color: greenForegroundColor),
            CalculatorButtonModel(
                calcButton: .percent,
                color: greenForegroundColor),
            CalculatorButtonModel(
                calcButton: .divide,
                color: redForegroundColor)
            
        ]),
        RowOfCalculatorButtonsModel(row: [
            CalculatorButtonModel(calcButton: .seven),
            CalculatorButtonModel(calcButton: .eight),
            CalculatorButtonModel(calcButton: .nine),
            CalculatorButtonModel(
                calcButton: .multiply,
                color: redForegroundColor)
        ]),
        RowOfCalculatorButtonsModel(row: [
            CalculatorButtonModel(calcButton: .four),
            CalculatorButtonModel(calcButton: .five),
            CalculatorButtonModel(calcButton: .six),
            CalculatorButtonModel(
                calcButton: .subtract,
                color: redForegroundColor)
        ]),
        RowOfCalculatorButtonsModel(row: [
            CalculatorButtonModel(calcButton: .one),
            CalculatorButtonModel(calcButton: .two),
            CalculatorButtonModel(calcButton: .three),
            CalculatorButtonModel(
                calcButton: .add,
                color: redForegroundColor)
        ]),
        RowOfCalculatorButtonsModel(row: [
            CalculatorButtonModel(calcButton: .undo),
            CalculatorButtonModel(calcButton: .zero),
            CalculatorButtonModel(calcButton: .decimal),
            CalculatorButtonModel(
                calcButton: .equal,
                color: redForegroundColor)
        ])]
    
    func buttonPressed(calculatorButton: CalculatorButton) {
        //: Function Logic
        switch calculatorButton {
            case .clear:
                currentComputation = ""
                mainResult = "0"
                
            case .equal, .negative:
                if !currentComputation.isEmpty {
                    if !lastCharacterIsOperator(str: currentComputation) {
                        let sign = calculatorButton == .negative ? -1.0 : 1.0
                        
                        mainResult = formatResult(val: sign * calculateResults())
                        
                        if calculatorButton == .negative {
                            currentComputation = mainResult
                        }
                    }
                }
                
            case .decimal:
                //: If it's nil it will be skipped, if not the value will be used.
                if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: ".") {
                    if lastCharacterIsDigit(str: currentComputation) {
                        let startIndex = currentComputation.index(lastOccurenceOfDecimal, offsetBy: 1)
                        let endIndex = currentComputation.endIndex
                        let rangeOfValues = startIndex..<endIndex
                        let rightSubstring = String(currentComputation[rangeOfValues])
                        
                        // 123.45, rightSubstring is 45 and it will not be nil. Bad -> Remains 123.45
                        if Int(rightSubstring) == nil && !rightSubstring.isEmpty {
                            currentComputation += "."
                        }
                    }
                } else {
                    if currentComputation.isEmpty {
                        currentComputation += "0."
                    } else if lastCharacterIsDigit(str: currentComputation){
                        currentComputation += "0."
                    }
                }
                
            case .percent:
                if lastCharacterIsDigit(str: currentComputation) {
                    appendToCurrentComputation(calculatorButton: calculatorButton)
                }
                
            case .undo:
                currentComputation = String(currentComputation.dropLast())
                
            case .add, .subtract, .divide, .multiply:
                if lastCharacterIsDigitOrPercent(str: currentComputation) {
                    appendToCurrentComputation(calculatorButton: calculatorButton)
                }
                
            default:
                currentComputation += calculatorButton.rawValue
        }
    }
    
    func appendToCurrentComputation(calculatorButton: CalculatorButton) {
        currentComputation += calculatorButton.rawValue
    }
    
    //: Implements the actual computation.
    func calculateResults() -> Double {
        let visibleWorking: String = currentComputation
        var working = visibleWorking.replacingOccurrences(of: "%",
                                                          with: "*0.01")
        
        working = working.replacingOccurrences(of: multiplySymbol,
                                               with: "*")
        working = working.replacingOccurrences(of: divisionSymbol,
                                               with: "/")
        //: If the string is 10. it will be replaced with "10.0"
        if getLastCharacter(str: visibleWorking) == "." {
            working += "0"
        }
        
        //: An actual computation.
        let express = NSExpression(format: working)
        let expressVal = express.expressionValue(with: nil, context: nil) as! Double // casting it into a double..
        
        return expressVal
    }
    
    var body: some View {
        Grid() {
            ForEach(buttonData) { rowOfCalculatorButtonsModel in
                GridRow {
                    ForEach(rowOfCalculatorButtonsModel.row) { calculatorButtonModel in
                        Button {
                            //: Calculator Logic
                            buttonPressed(calculatorButton: calculatorButtonModel.calcButton)
                        } label: {
                            ButtonView(calculatorButton: calculatorButtonModel.calcButton,
                                       fgColor: calculatorButtonModel.color,
                                       bgColor: backgroundColor)
                        }
                    }
                } //: End of GridRow
            }
        } //: End of Grid
        .padding()
        .background(buttonBackground
            .cornerRadius(UIDevice.isIpad ? 40 : 20))
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(mainResult: .constant("6"), currentComputation: .constant("5 + 1"))
    }
}
