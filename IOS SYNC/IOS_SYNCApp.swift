//
//  IOS_SYNCApp.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import SwiftUI

@main
struct IOS_SYNCApp: App {
    let itemsProvider = FilesProvider()
    let itemsClient = ItemsClient()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(itemsProvider)
                .environmentObject(itemsClient);
        }
    }
}
