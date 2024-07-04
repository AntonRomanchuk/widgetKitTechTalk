//
//  TodoEntryView.swift
//  AppWidgetExtension
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import SwiftUI

struct TodoEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack (alignment: .firstTextBaseline) {
                Text("Make It Done")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                Spacer()
                Text(entry.tasks.count, format: .number)
                    .font(.title)
            }

            ForEach(entry.tasks.prefix(7), id: \.id) { task in
                Toggle(isOn: task.isDone, intent: MarkTaskDoneIntent(task.id.uuidString)) {
                    Text(task.text)
                        .lineLimit(1)
                }
                .toggleStyle(CheckToggleStyle())
                .frame(maxHeight: 30, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TodoEntryView(entry: .preview)
}
