import SwiftUI

struct NextButton: View {
    let title: String
    let action: () -> Void
    @Binding var isLoading: Bool
    @Binding var isDisabled: Bool

    var body: some View {
        Button(action: {
            if !isDisabled {
                isDisabled = true
                isLoading = true
                action()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isDisabled = false
                    isLoading = false
                }
            }
        }) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal, 20)
        .disabled(isDisabled)
    }
}

