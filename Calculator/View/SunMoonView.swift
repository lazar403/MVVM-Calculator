import SwiftUI

struct SunMoonView: View {
    
    var lightMode: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "sun.min")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonSelectedColor : sunOrMoonNotSelectedColor)
            
            Image(systemName: "moon")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonNotSelectedColor : sunOrMoonSelectedColor)

        }
        .font(UIDevice.isIpad ? .title : .body)
        .fontWeight(UIDevice.isIpad ? .semibold : .regular)
        .padding()
        .background(buttonBackground)
        .cornerRadius(20)
    }
}

struct SunMoonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SunMoonView(lightMode: true)
            SunMoonView(lightMode: false)
        }
    }
}
