import SwiftUI

struct WorkoutView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ZStack {
            // Elegant gradient background
            LinearGradient(
                colors: [Color.black, Color.gray.opacity(0.3), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                searchBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        greetingSection
                        workoutSection(title: "Recommended for You", images: filteredWorkouts(viewModel.recommendedWorkouts))
                        workoutSection(title: "Full Body", images: filteredWorkouts(viewModel.fullBodyWorkouts))
                        workoutSection(title: "Upper Body", images: filteredWorkouts(viewModel.upperBodyWorkouts))
                        workoutSection(title: "Leg Day", images: filteredWorkouts(viewModel.legDayWorkouts))
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .onTapGesture {
            hideKeyboard()
        }
    }

    // MARK: - SearchBar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.yellow)
            TextField("Search workouts...", text: $searchText)
                .focused($isSearchFocused)
                .padding(8)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.white)
                .keyboardType(.default)
                .textInputAutocapitalization(.never)
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

    // MARK: - Greeting Section
    private var greetingSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Let's Crush It!")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.yellow)
               
            }
            Spacer()
        }
    }

    // MARK: - Workout Section Builder
    @ViewBuilder
    private func workoutSection(title: String, images: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(images, id: \.self) { imageName in
                        CardView(imageName: imageName)
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }

    // MARK: - Filtered Workouts
    private func filteredWorkouts(_ workouts: [String]) -> [String] {
        viewModel.filteredWorkouts(workouts, searchText: searchText)
    }
    
    // MARK: - Keyboard Helper
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutView()
        }
        .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    let imageName: String
    @State private var isPressed = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 140)
                .clipped()
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            VStack(alignment: .leading) {
                Text(imageName.capitalized)
                    .font(.headline)
                    .foregroundColor(.yellow)
                Text("30 min • Medium")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color(white: 0.15))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.yellow, lineWidth: 2)
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .shadow(color: Color.yellow.opacity(0.3), radius: 8, x: 0, y: 4)
        .onTapGesture {
            withAnimation(.spring()) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring()) {
                    isPressed = false
                }
            }
            // TODO: Navigate to detail or play video
        }
    }
}
