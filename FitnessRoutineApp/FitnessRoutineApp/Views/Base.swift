
import SwiftUI

// MARK: - Icon Styles
extension Image {
    func bodyFatIconStyle() -> some View {
        self
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
    }
}

// MARK: - Text Styles
extension Text {
    func bodyFatTitleStyle() -> some View {
        self
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.black)
    }
    
    func bodyFatRangeStyle() -> some View {
        self
            .font(.system(size: 16))
            .foregroundColor(.primary)
    }
    
    func bodyFatDescriptionStyle() -> some View {
        self
            .font(.system(size: 13))
            .foregroundColor(.gray)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
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
}

// MARK: - View Modifiers
extension View {
    func infoCardStyle() -> some View {
        self
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
    }
    
    func navigationBackButtonStyle() -> some View {
        self
            .foregroundColor(.blue)
            .imageScale(.large)
    }
}
