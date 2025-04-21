import SwiftUI

struct ShowInfoView: View {
    @StateObject private var viewModel = ShowInfoViewModel()

    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Your coach is working for you")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .scaleEffect(viewModel.isPulsing ? 1.1 : 1.0)
                    .animation(viewModel.isPulsing ? Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default, value: viewModel.isPulsing)

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 30)

                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: geo.size.width * viewModel.progress, height: 30)
                    }
                    .overlay(
                        Text("\(Int(viewModel.progress * 100))%")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 10),
                        alignment: .leading
                    )
                }
                .frame(height: 30)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(0..<viewModel.infoItems.count, id: \.self) { index in
                        if index < viewModel.visibleItems {
                            HStack {
                                (
                                    Text("• \(viewModel.infoItems[index].text): ")
                                        .font(.body)
                                        .foregroundColor(.black) +
                                    Text(viewModel.infoItems[index].value)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                )

                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .transition(.opacity)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.loadData()
            viewModel.startProgress()
        }
        .onChange(of: viewModel.progress) { newValue in
            if newValue >= 1.0 {
                viewModel.isPulsing = false
            }
        }
    }
}

#Preview {
    ShowInfoView()
}

