//
//  JournalEntry.swift
//  CoreCo
//
//  Created by roger deutsch on 7/28/23.
//

import Foundation
struct JournalEntry: Codable, Identifiable{
    let ownerId: String
    let id: String
    let title: String
    let description: String
    let notes: String
    let examples : [String]
    let group: String
    let created: Date
    let updated: Date
}
