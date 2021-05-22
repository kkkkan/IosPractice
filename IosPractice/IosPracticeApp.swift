//
//  IosPracticeApp.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//

import SwiftUI

@main
struct IosPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Model())
        }
    }
}
