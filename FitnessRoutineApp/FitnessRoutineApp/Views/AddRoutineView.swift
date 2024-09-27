import SwiftUI

struct AddRoutineView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var createdDate: Date = Date()
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.6)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Create a New Routine")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Form for input
                Form {
                    Section(header: Text("Routine Details").foregroundColor(.purple)) {
                        TextField("Enter routine name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        DatePicker("Select Date", selection: $createdDate, displayedComponents: .date)
                            .padding()
                    }
                    .listRowBackground(Color.clear)
                }
                .frame(height: 300)
                .cornerRadius(15)
                .padding(.horizontal)

                Spacer()

                // Save button
                Button(action: {
                    if name.isEmpty {
                        showAlert = true // Show alert if the name is empty
                    } else {
                        addRoutine()
                        dismiss()
                    }
                }) {
                    Text("Save Routine")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(name.isEmpty ? Color.gray : Color.purple)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(name.isEmpty)

                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("The routine name cannot be empty."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add New Routine")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func addRoutine() {
        let newRoutine = Rutina(context: viewContext)
        newRoutine.name = name
        newRoutine.createdDate = createdDate
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving routine: \(error.localizedDescription)")
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

