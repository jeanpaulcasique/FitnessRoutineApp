import SwiftUI
import CoreData

struct RoutineDetailView: View {
    @ObservedObject var routine: Rutina
    @Environment(\.managedObjectContext) private var viewContext

    @State private var exerciseName: String = ""
    @State private var showAlert = false
    @State private var exerciseToDelete: Ejercicio? = nil
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Fondo degradado pequeño
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .frame(height: 300) // Ajusta la altura del fondo degradado
                    .ignoresSafeArea(edges: .top)

                Spacer() // Empuja el contenido hacia abajo
            }
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Encabezado de la rutina
                Text(routine.name ?? "Unnamed Routine")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Lista de ejercicios con estilo
                List {
                    ForEach(routine.exercisesArray, id: \.self) { exercise in
                        HStack {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text(exercise.name ?? "Unnamed Exercise")
                                .font(.headline)
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: { indexSet in
                        exerciseToDelete = routine.exercisesArray[indexSet.first!]
                        showDeleteAlert = true
                    })
                }
                .listStyle(InsetGroupedListStyle())
                .frame(height: 300) // Limitar altura de la lista para mejor presentación

                Spacer() // Empuja los elementos hacia abajo

                // Sección para agregar nuevo ejercicio
                VStack(spacing: 16) {
                    TextField("Enter exercise name", text: $exerciseName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)

                    // Botón estilizado para agregar ejercicio
                    Button(action: {
                        if exerciseName.isEmpty {
                            showAlert = true
                        } else {
                            addExercise()
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Add Exercise")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .shadow(radius: 5)
                    }
                }

                Spacer() // Empuja todo hacia la parte baja de la pantalla
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("The exercise name cannot be empty."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete Exercise"),
                    message: Text("Are you sure you want to delete this exercise?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let exercise = exerciseToDelete {
                            deleteExercise(exercise: exercise)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Routine Details")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
        }
    }

    private func addExercise() {
        let newExercise = Ejercicio(context: viewContext)
        newExercise.name = exerciseName
        newExercise.routine = routine

        do {
            try viewContext.save()
        } catch {
            print("Error saving exercise: \(error)")
        }

        exerciseName = ""
    }

    private func deleteExercise(exercise: Ejercicio) {
        viewContext.delete(exercise)

        do {
            try viewContext.save()
        } catch {
            print("Error deleting exercise: \(error)")
        }
    }
}

struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let routine = Rutina(context: context)
        routine.name = "Test Routine"
        return RoutineDetailView(routine: routine)
            .environment(\.managedObjectContext, context)
    }
}

