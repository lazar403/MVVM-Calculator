import SwiftUI

struct MainView: View {
    
    @State var lightMode: Bool = true
    @State var currentComputation: String = ""
    @State var mainResult: String = "0"
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack {
                
                SunMoonView(lightMode: lightMode)
                    .onTapGesture {
                        withAnimation {
                            lightMode.toggle()
                        }
                    }
                
                Spacer()
                
                ComputationView(mainResult: mainResult, currentComputation: currentComputation)
                    .padding(.horizontal, UIDevice.isIpad ? UIScreen.main.bounds.width * 0.1 : 0)
                
                Spacer()
                
                CalculatorButtonsView(mainResult: $mainResult, currentComputation: $currentComputation)
                
                if UIDevice.isIpad {
                        Spacer()
                }
            }
        }
        .environment(\.colorScheme, lightMode ? .light : .dark )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
