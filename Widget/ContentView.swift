//
//  ContentView.swift
//  Widget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var tasks: [UserTask] = []
    @State private var showingAddTask: Bool = false

    private func rereadUserTasks() {
        tasks = UserTask.getFromStore().sorted(by: { $0.creationDate > $1.creationDate })
    }

    private func toggleBinding(_ task: UserTask) -> Binding<Bool> {
        Binding {
            task.isDone
        } set: { newValue in
            var newTask = task
            newTask.setStatus(isDone: newValue)
            rereadUserTasks()
        }
    }

    private func createTaskAction(_ newTask: UserTask) {
        newTask.addOrUpdate()
        rereadUserTasks()
        showingAddTask.toggle()
    }

    private func deleteAction(at offsets: IndexSet) {
        var newTasks = tasks
        newTasks.remove(atOffsets: offsets)
        UserTask.saveToStore(newTasks)
        rereadUserTasks()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 10) {
                NavigationStack {
                    List {
                        ForEach(tasks, id: \.id) { task in
                            Toggle(isOn: toggleBinding(task)) {
                                Text(task.text)
                            }
                            .toggleStyle(CheckToggleStyle())
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteAction)
                    }
                    .listStyle(.inset)
                    .navigationTitle("Todo list")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.bottom, 50)

            Button(action: { showingAddTask.toggle() }) {
                Text("Add task")
                    .padding(10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    )

            }
            .padding(.horizontal, 20)
        }
        .sheet(isPresented: $showingAddTask) { AddTaskView(createTaskAction) }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                rereadUserTasks()
            case .background:
                WidgetCenter.shared.reloadAllTimelines()
            default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
