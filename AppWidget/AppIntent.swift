//
//  AppIntent.swift
//  AppWidgetExtension
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import WidgetKit
import AppIntents

struct MarkTaskDoneIntent: AppIntent {
    static var title: LocalizedStringResource = "Mark task as done"
    static var description = IntentDescription("Make task done or undone")

    init() {
        self.taskId = nil
    }

    init(_ taskId: String) {
        self.taskId = taskId
    }

    @Parameter(title: "Task Id")
    var taskId: String?

    func perform() async throws -> some IntentResult {
        if taskId == nil { return .result() }
        let allTasks = UserTask.getFromStore()

        if var task = allTasks.first(where: {$0.id.uuidString == taskId }) {
            task.setStatus(isDone: !task.isDone)
            // Giving the user a 1.5 second grace period before the widget view is redrawn.
            try? await Task.sleep(nanoseconds: 1_500_000_000)
        }

        return .result()
    }
}
