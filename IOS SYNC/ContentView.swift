//
//  ContentView.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var filesProvider:FilesProvider
    @EnvironmentObject var itemsClient:ItemsClient
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("GALLERY")
        }
        .padding()
        Button("SYNC") {
            let files = filesProvider.getFiles()
            Task{
                await itemsClient.syncItems(files: files)
            }
        }
        Browser(onSelect: onSelectFileUrl)
    }
    
    func onSelectFileUrl(fileUrl: [URL]) {
        filesProvider.setUrls(urls: fileUrl)
    }
}

#Preview {
    ContentView()
}
