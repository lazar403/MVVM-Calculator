import SwiftUI

struct ButtonView: View {
    
    let calculatorButton: CalculatorButton
    
    let fgColor: Color
    let bgColor: Color
    
    // Computed checks
    var systemImage: String? {
        let value = calculatorButton.rawValue
        return value.contains("IMG") ? value.replacingOccurrences(of: "IMG", with: "") : nil
    }
    var text: String? {
        let value = calculatorButton.rawValue
        return value.contains("IMG") ? nil : value
    }
    
    let buttonDimension: CGFloat = UIDevice.isIpad ? UIScreen.main.bounds.width / 6 : UIScreen.main.bounds.width / 5
    
    
    var body: some View {
        ZStack {
            Text(text ?? "")
            Image(systemName: systemImage ?? "")
        }
        .font(UIDevice.isIpad ? .largeTitle :.title2)
        .fontWeight(UIDevice.isIpad ? .heavy : .semibold)
        .frame(width: buttonDimension, height: buttonDimension)
        .foregroundColor(fgColor)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: bgColor.opacity(0.5), radius: 3, x: 5, y: 5)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonView(calculatorButton: .one,
                       fgColor: foregroundButtonColor,
                       bgColor: buttonBackground)
            
            ButtonView(calculatorButton: .percent,
                       fgColor: greenForegroundColor,
                       bgColor: buttonBackground)
            
            ButtonView(calculatorButton: .add,
                       fgColor: redForegroundColor,
                       bgColor: buttonBackground)
            
            ButtonView(calculatorButton: .undo,
                       fgColor: redForegroundColor,
                       bgColor: buttonBackground)
            
            ButtonView(calculatorButton: .negative,
                       fgColor: redForegroundColor,
                       bgColor: buttonBackground)
            
            
        }
    }
}
