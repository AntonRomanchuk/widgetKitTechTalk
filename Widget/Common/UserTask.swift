//
//  UserTask.swift
//  Widget
//
//  Created by Anton Romanchuk on 27.06.2024.
//

import Foundation

struct UserTask: Identifiable, Codable {
    let id: UUID
    let creationDate: Date
    let text: String
    private(set) var isDone: Bool
    private(set) var doneDate: Date?

    static func getFromStore() -> [UserTask] {
        guard let userDefaults = UserDefaults(suiteName: Storage.appGroupIdentifier),
              let userDefaultsString = userDefaults.string(forKey: Storage.appGroupTasks),
              let jsonData = userDefaultsString.data(using: .utf8) else { return [] }
        return (try? JSONDecoder().decode([UserTask].self, from: jsonData)) ?? []
    }

    static func saveToStore(_ newTasks: [UserTask] ) {
        guard let jsonData = try? JSONEncoder().encode(newTasks),
              let jsonString = String(data: jsonData, encoding: .utf8),
        let userDefaults =  UserDefaults(suiteName: Storage.appGroupIdentifier) else { return }
        userDefaults.set(jsonString, forKey: Storage.appGroupTasks)
    }

    mutating func setStatus(isDone: Bool) {
        self.isDone = isDone
        self.doneDate = isDone ? .now : nil
        addOrUpdate()
    }

    func addOrUpdate() {
        var allTasks = UserTask.getFromStore()

        if let index = allTasks.firstIndex(where: { $0.id == self.id }) {
            allTasks[index] = self
        } else {
            allTasks.append(self)
        }

        UserTask.saveToStore(allTasks)
    }
}
