//
//  TodoWidgetEntry.swift
//  Widget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import WidgetKit

struct TodoWidgetEntry: TimelineEntry {
    let date: Date
    let tasks: [UserTask]

    static var preview: TodoWidgetEntry {
        let demoTasks: [UserTask] = [.init(id: .init(), creationDate: .now, text: "Demo task #1", isDone: false, doneDate: nil),
                                     .init(id: .init(), creationDate: .now, text: "Demo task #2", isDone: false, doneDate: nil),
                                     .init(id: .init(), creationDate: .now, text: "Demo task #3", isDone: true, doneDate: .now)]

        return TodoWidgetEntry(date: .now, tasks: demoTasks)
    }

    static var current: TodoWidgetEntry {
        let tasks = UserTask.getFromStore()
            .filter({ !$0.isDone })
            .sorted(by: { $0.creationDate > $1.creationDate })

        return TodoWidgetEntry(date: .now, tasks: tasks)
    }
}
