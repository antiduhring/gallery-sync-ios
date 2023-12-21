//
//  ItemsProvider.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import Foundation

class FilesProvider:ObservableObject {
    private let filesCache = FilesCache()
    @Published var files: [URL] = []
    
    func clear() {
        do {
            try filesCache.clear()
            self.files = []
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadFiles() {
        do {
           self.files = try filesCache.getAllFiles()
       } catch {
           fatalError(error.localizedDescription)
       }
    }
    
    func addFiles(files: [URL]) {
        do {
            try filesCache.addFiles(files: files)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getFiles() -> [URL] {
        if (files.isEmpty) {
            print("URL NOT SET")
            return []
        }
        
        return files
    }
    
    func delete(file: URL) {
        do {
            try filesCache.deleteFile(file: file)
            loadFiles()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

