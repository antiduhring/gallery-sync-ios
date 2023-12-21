//
//  ItemsClient.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import Foundation

class HttpClient {
    let SERVER_URL: String = "https://antiduhring-gallery-staging-14336907a0b3.herokuapp.com"
//    let SERVER_URL: String = "http://192.168.2.102:8080"
    let UPLOAD_SERVER_URL: String = "https://antiduhring-gallery-staging-14336907a0b3.herokuapp.com"
//    let UPLOAD_SERVER_URL: String = "http://192.168.2.102:8080"
    let urlSession = URLSession.shared
    
    
    func syncItems(files: [URL]) async {
        for file in files {
            await createItem(file: file)
        }
    }
    
    func clear() async {
        guard let url = URL(string: UPLOAD_SERVER_URL) else { fatalError("Missing URL") }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        request.httpMethod = "DELETE"
        let task = urlSession.dataTask(with: request)
        task.resume()
    }
    
    private func createItem(file: URL) async{
        await uploadFile(file: file)
    }
    
    private func uploadFile(file: URL) async {
        do {
            let data = try Data(contentsOf: file)
            let fileName = file.deletingPathExtension().lastPathComponent.uppercased()
            print("UPLOAD FILE TO SERVER [\(fileName)] \(file)")
            
            await upload(data: data, name: fileName)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func upload(data: Data, name: String) async {
        guard let url = URL(string: UPLOAD_SERVER_URL) else { fatalError("Missing URL") }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        request.httpMethod = "POST"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.setValue(name, forHTTPHeaderField: "name")
        
        let task = urlSession.uploadTask(
            with: request,
            from: data
        )
        
        task.resume()
    }
}
