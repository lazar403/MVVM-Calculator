import SwiftUI

struct ComputationView: View {
    
    let mainResult: String
    let currentComputation: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Text(currentComputation)
                    .foregroundColor(foregroundButtonColor)
                    .font(UIDevice.isIpad ? .title : .body)
                    .lineLimit(1)
            } //: End of HStack
            .minimumScaleFactor(0.1)
            
            HStack {
                Spacer()
                
                Text(mainResult)
                    .foregroundColor(foregroundButtonColor)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
            } //: End of HStack
            .minimumScaleFactor(0.1)
        } //: End of VStack
        .padding(.horizontal)
    }
}

struct ComputationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            Spacer()
            ComputationView(mainResult: "1342", currentComputation: "5 + 1")
            Spacer()
            ComputationView(mainResult: "1234132", currentComputation: "12000 + 39102")
            Spacer()
            ComputationView(mainResult: "12311231", currentComputation: "127765000 + 391012312")
            Spacer()
            ComputationView(mainResult: "12391828381", currentComputation: "127765000 / 123112")
            Spacer()
        }

    }
}
