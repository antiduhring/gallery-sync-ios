//
//  Browser.swift
//  Gallery
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import Foundation
import SwiftUI

struct Browser: View {
    let onSelect: (_ files: [URL]) -> Void
    @State var selectedFiles: [String] = []
    @State var openFile = false

    var body: some View {
        VStack {
            ForEach(selectedFiles, id: \.self){
                Text($0)
            }

            Button {
                self.openFile.toggle()
            } label: {
                Text("Open Document Picker")
            }
        }
        .padding()
        .fileImporter( isPresented: $openFile, allowedContentTypes: [.image], allowsMultipleSelection: true, onCompletion: {
                    (Result) in
                    do{
                        let files = try Result.get()
                        self.selectedFiles = files.map{$0.lastPathComponent}
                        onSelect(files)
                    }
                    catch{
                       print("error reading file \(error.localizedDescription)")
                    }
                })
    }
}
