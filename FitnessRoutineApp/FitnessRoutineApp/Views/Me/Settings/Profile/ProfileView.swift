import SwiftUI
import PhotosUI
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        if let image = viewModel.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                )
                        }
                    }
                    .onTapGesture {
                        viewModel.showPhotoOptions = true
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                Section(header: Text("Your Info")) {
                    ForEach(viewModel.infoItems, id: \.text) { item in
                        HStack {
                            Text(item.text)
                            Spacer()
                            Text(item.value)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .confirmationDialog("Choose Photo Source", isPresented: $viewModel.showPhotoOptions, titleVisibility: .visible) {
                Button("Camera") {
                    viewModel.sourceType = .camera
                    viewModel.showImagePicker = true
                }
                Button("Photo Library") {
                    viewModel.sourceType = .photoLibrary
                    viewModel.showImagePicker = true
                }
                Button("Cancel", role: .cancel) {}
            }
            .fullScreenCover(isPresented: $viewModel.showImagePicker) {
                ImagePicker(sourceType: viewModel.sourceType, selectedImage: $viewModel.profileImage)
            }
        }
    }
}
struct EditFieldView: View {
    var item: ProfileItem
    var onSave: (String) -> Void

    @State private var newValue: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("New Value", text: $newValue)
            }
            .navigationTitle("Edit \(item.text)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(newValue)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                newValue = item.value
            }
        }
    }
}

struct ProfileItem: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let value: String
}

