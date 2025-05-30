import SwiftUI

struct GroceryListSheetView: View {
    @ObservedObject var vm: DietViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showShareSheet = false
    @State private var showUncheckedOnly = false

    private let cardCorner: CGFloat = 16
    private let borderColor = Color.yellow.opacity(0.7)

    var filteredIngredients: [Ingredient] {
        showUncheckedOnly
            ? vm.groceryList.filter { !$0.isChecked }
            : vm.groceryList
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 16) {
                    // Toggle
                    HStack {
                        Text("Only unchecked")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Spacer()
                        Toggle("", isOn: $showUncheckedOnly)
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: .yellow))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: cardCorner))
                    .padding(.horizontal)

                    // Lista de ingredientes
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredIngredients) { item in
                                HStack(spacing: 16) {
                                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                        .font(.title2)
                                        .foregroundColor(item.isChecked ? .yellow : .white)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(item.quantity)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color(white: 0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: cardCorner)
                                        .stroke(item.isChecked ? borderColor : Color.clear, lineWidth: 2)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: cardCorner))
                                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 2)
                                .contentShape(Rectangle())      // toda la tarjeta es tappable
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        vm.toggleCheck(for: item)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }

                    // Botón compartir
                    Button {
                        showShareSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share List")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: cardCorner))
                        .shadow(color: Color.yellow.opacity(0.4), radius: 6, x: 0, y: 3)
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
                .padding(.top)
            }
            .navigationTitle("Grocery List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        withAnimation {
                            vm.resetGroceryChecks()
                        }
                    }
                    .foregroundColor(.yellow)
                    .fontWeight(.semibold)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(.yellow)
                        .fontWeight(.semibold)
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [vm.groceryListText])
            }
        }
    }
}


// MARK: - Helpers on ViewModel

extension DietViewModel {
    func resetGroceryChecks() {
        for idx in groceryList.indices {
            groceryList[idx].isChecked = false
        }
        saveCheckedIngredientNames()
    }
}

// MARK: - ShareSheet

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems,
                                 applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: Context) {}
}

