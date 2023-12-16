//
//  Item.swift
//  IOS SYNC
//
//  Created by ANDREY STEPANOV on 16.12.23.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: Int
    var name: String
    var imageUrl: String
}
