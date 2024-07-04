//
//  Provider.swift
//  Widget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import WidgetKit

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (TodoWidgetEntry) -> Void) {
        if context.isPreview {
            return completion(TodoWidgetEntry.preview)
        }

        completion(TodoWidgetEntry.current)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TodoWidgetEntry>) -> Void) {
        if context.isPreview {
            return completion( Timeline(entries: [TodoWidgetEntry.preview], policy: .never))
        }

        completion(Timeline(entries: [TodoWidgetEntry.current], policy: .never))
    }

    func placeholder(in context: Context) -> TodoWidgetEntry {
        TodoWidgetEntry.preview
    }
}
