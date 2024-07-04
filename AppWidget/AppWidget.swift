//
//  AppWidget.swift
//  AppWidget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import WidgetKit
import SwiftUI

@main
struct AppWidget: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,  provider: Provider()) { entry in
            TodoEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
    }
}

#Preview(as: .systemLarge) {
    AppWidget()
} timeline: {
    TodoWidgetEntry.preview
}
