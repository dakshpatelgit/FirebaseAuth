
import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var textColor: Color = .white
    var bgColor: Color = .teal
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ?
                Capsule()
                    .stroke(.gray, lineWidth: 1)
                :
                nil
            }
    }
}
