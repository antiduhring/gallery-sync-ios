//
//  FilesCache.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 21.12.23.
//

import Foundation

class FilesCache {
    private let cacheStore = CacheStore()
    
    func clear() throws {
        try cacheStore.clear()
    }
    
    func getAllFiles() throws -> [URL] {
        return try cacheStore.load()
    }
    
    func addFiles(files: [URL]) throws {
        try cacheStore.save(files: files)
    }
    
    func deleteFile(file: URL) throws {
        try cacheStore.delete(file: file)
    }
}

class CacheStore: ObservableObject {
    let FM = FileManager.default
    private func documentDir() -> URL {
        return FM.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func load() throws -> [URL] {
        let dirContent =
        try FM.contentsOfDirectory(at: documentDir(), includingPropertiesForKeys: nil)
        return dirContent
    }
    
    func save(files: [URL]) throws {
        for file in files {
            try save(file: file)
        }
    }
    
    func delete(file: URL) throws {
        if (FM.fileExists(atPath: file.path)) {
            try FM.removeItem(at: file)
        }
    }
    
    private func save(file: URL) throws {
        guard file.startAccessingSecurityScopedResource() else {
                print("NOT ACCESSIBLE TO SAVE \(file)")
                return
        }
        
        defer { file.stopAccessingSecurityScopedResource() }
        
        let data = try Data(contentsOf: file)
        
        let name = file.lastPathComponent
        let dstUrl = documentDir().appendingPathComponent(name)
        if (FM.fileExists(atPath: dstUrl.path)) {
            print("FILE ALREADY EXISTS [\(dstUrl.lastPathComponent)]")
            return
        }
        try data.write(to: dstUrl)
    }
    
    func clear() throws {
        for file in try load() {
            try FM.removeItem(at: file)
        }
    }
}

