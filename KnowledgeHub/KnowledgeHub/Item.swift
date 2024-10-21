//
//  Item.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
