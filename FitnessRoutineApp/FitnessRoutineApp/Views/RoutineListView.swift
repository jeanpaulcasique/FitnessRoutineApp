import SwiftUI
import CoreData

struct RoutineListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Rutina.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Rutina.createdDate, ascending: true)],
        animation: .default)
    private var routines: FetchedResults<Rutina>
    
    @State private var showingAddRoutineView = false
    @State private var routineToDelete: Rutina? = nil
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo degradado moderno
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    if routines.isEmpty {
                        // Mensaje cuando no hay rutinas
                        VStack(spacing: 20) {
                            Image(systemName: "tray.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                            
                            Text("No routines available")
                                .foregroundColor(.gray)
                                .font(.title2)
                                .padding()
                        }
                    } else {
                        // Lista de rutinas
                        List {
                            ForEach(routines) { routine in
                                NavigationLink(destination: RoutineDetailView(routine: routine)) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(routine.name ?? "Unnamed Routine")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        HStack {
                                            Image(systemName: "calendar")
                                                .foregroundColor(.secondary)
                                            Text("Created on \(routine.createdDate!, formatter: itemFormatter)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 10)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                routineToDelete = routines[indexSet.first!]
                                showDeleteAlert = true
                            })
                        }
                        .listStyle(InsetGroupedListStyle()) // Estilo de lista moderno
                    }
                }

                // Botón flotante para agregar nueva rutina
                VStack {
                    Spacer()

                    Button(action: {
                        showingAddRoutineView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("Add Routine")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                                   startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .shadow(radius: 10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Routines")
            .sheet(isPresented: $showingAddRoutineView) {
                AddRoutineView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete Routine"),
                    message: Text("Are you sure you want to delete this routine?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let routine = routineToDelete {
                            deleteRoutine(routine: routine)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func deleteRoutine(routine: Rutina) {
        viewContext.delete(routine)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting routine: \(error)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

