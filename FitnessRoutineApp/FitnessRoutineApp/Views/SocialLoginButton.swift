import SwiftUI

struct SocialLoginButton: View {
    let imageName: String
    let text: String
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                Text(text).fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
