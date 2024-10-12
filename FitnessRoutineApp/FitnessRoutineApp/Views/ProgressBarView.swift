import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var progressViewModel: ProgressViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: CGFloat(progressViewModel.progress) * geometry.size.width, height: 8)
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: progressViewModel.progress)
            }
            .cornerRadius(4)
        }
        .frame(height: 8)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progressViewModel: ProgressViewModel())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

