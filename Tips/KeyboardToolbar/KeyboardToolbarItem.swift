#if canImport(UIKit)
import SwiftUI

public struct KeyboardToolbarItem: Identifiable {
    public let id: UUID = UUID()
    let image: Image?
    let callback: () -> Void
    let color: Color
    let isFixed: KeyboardToolbarEdge?
    let text: String?
    
    private init(image: Image?, text: String?, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.image = image
        self.text = text
        self.callback = callback
        self.color = color
        self.isFixed = isFixed
    }
    
    public init(image: Image, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(image: image, text: nil, color: color, isFixed: isFixed, callback: callback)
    }
    
    public init(systemName: String, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(image: Image(systemName: systemName), color: color, isFixed: isFixed, callback: callback)
    }
    
    public init(imageName: String, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(image: Image(imageName), color: color, isFixed: isFixed, callback: callback)
    }
    
    public init(text: String, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(image: nil, text: text, color: color, isFixed: isFixed, callback: callback)
    }
}

public enum KeyboardToolbarEdge {
    case leading, trailing
}

// MARK: Presets
public extension KeyboardToolbarItem {
    static let dismissKeyboard = KeyboardToolbarItem(systemName: "keyboard.chevron.compact.down", color: .accentColor, isFixed: .trailing, callback: {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    })
}
#endif
