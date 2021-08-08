//
//  IosPracticeApp.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//

import SwiftUI


@main
struct IosPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TopView(apiModel: ApiModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
