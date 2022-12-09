import SwiftUI

extension UIDevice {
    
    static var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIphone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
