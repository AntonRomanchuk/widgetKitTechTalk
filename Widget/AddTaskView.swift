//
//  AddTaskView.swift
//  Widget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import SwiftUI

struct AddTaskView: View {
    @State private var newTask: String = ""

    private let createTaskAction: (_ : UserTask) -> Void

    init(_ createTaskAction: @escaping (_ : UserTask) -> Void) {
        self.createTaskAction = createTaskAction
    }

    func createNewTask() {
        let newTask = UserTask(id: .init(), creationDate: .now, text: newTask, isDone: false)
        createTaskAction(newTask)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add new task")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)
            TextField("Describe a task...", text: $newTask, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5...10)
                .onSubmit(createNewTask)
            Spacer()
            Button(action: createNewTask) {
                Text("Create")
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
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .presentationDetents([.height(300)])
        .presentationDragIndicator(.hidden)
    }
}

#Preview {
    AddTaskView({ _ in })
}

