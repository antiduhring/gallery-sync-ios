//
//  ContentView.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var filesProvider:FilesProvider
    let itemsClient = HttpClient()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("GALLERY")
        }
        .padding()
        List(filesProvider.files, id: \.absoluteString) { file in
            HStack{
                Image(systemName: "trash")
                    .onTapGesture{filesProvider.delete(file: file)}
                Image(uiImage: getImageData(file: file))
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("\(file.lastPathComponent)")
            }.padding()
        }.onAppear() {
            filesProvider.loadFiles()
        }
        Button("SYNC") {
            let files = filesProvider.getFiles()
            Task{
                await itemsClient.clear()
                await itemsClient.syncItems(files: files)
            }
        }.padding()
        Button("CLEAR") {
            filesProvider.clear()
        }.padding()
        Browser(onSelect: onSelectFileUrl)
    }
    
    func onSelectFileUrl(files: [URL]) {
        filesProvider.addFiles(files: files)
        filesProvider.loadFiles()
    }
    
    func getImageData(file: URL) -> UIImage {
        do {
            return try UIImage(data: Data(contentsOf: file))!
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

#Preview {
    ContentView()
}
