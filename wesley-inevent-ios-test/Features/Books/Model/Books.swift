//
//  Books.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import Foundation

// MARK: - ModelBooks

struct ModelBooks: Codable {
    let kind: String
    let totalItems: Int
    var items: [Item] = []
}

// MARK: - Item

struct Item: Codable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks?
}

// MARK: - ImageLinks

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}
