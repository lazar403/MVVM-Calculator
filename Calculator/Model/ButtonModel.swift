import SwiftUI


struct CalculatorButtonModel: Identifiable {
    
    let id = UUID()
    let calcButton: CalculatorButton
    var color: Color = foregroundButtonColor
}


struct RowOfCalculatorButtonsModel: Identifiable {
    
    let id = UUID()
    let row: [CalculatorButtonModel]
}
