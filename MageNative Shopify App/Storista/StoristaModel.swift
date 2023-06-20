//
//  StoristaModel.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 06/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct StoristaFeedWidget: Decodable {
    let id, title, type: String?
    let isPublished: Bool?
    let createdAt: String?
    let style: Style?
    let teamID: Int?
    let autoSync: AutoSync?
    let igAccount: String?
    let isImporting: Bool?
    let lastParsedSince: String?
    let products: Bool?
    let data: [WidgetData]?
}

// MARK: - AutoSync
struct AutoSync: Decodable {
    let isActive: Bool?
    let settings: Settings?
}

// MARK: - Settings
struct Settings: Decodable {
    let limit: Int?
}

// MARK: - Datum
struct WidgetData: Decodable {
    let id: Int?
    let title: String?
    let postsCount: Int?
    let previewFile: String?
    let filename: String?
    let stories: [Story]?
}

// MARK: - Story
struct Story: Decodable {
    let id: Int?
    let title, type, postType, mediaType: String?
    let idx: Int?
    let fileUrl: String?
    let file: String?
    let width, height: Int?
//    let button: NSNull?
    let metadata: Metadata?
    let likes, views: Int?
//    let stickers, products: NSNull?
}

// MARK: - Metadata
struct Metadata: Decodable {
    let code: String?
    let thumbnailUrl: String?
}

// MARK: - Style
struct Style: Decodable {
    let size, radius: Int?
    let likesVisible, viewsVisible, playButtonVisible: Bool?
    let layout: String?
    let postSettings: PostSettings?
    let modalSettings: ModalSettings?
    let layoutSettings: LayoutSettings?
}

// MARK: - LayoutSettings
struct LayoutSettings: Decodable {
    let padding, mobileLimit, desktopLimit, mobileColumns: Int?
    let desktopColumns: Int?
}

// MARK: - ModalSettings
struct ModalSettings: Decodable {
    let showLink: Bool?
    let textSize: Int?
    let showLikes: Bool?
    let textColor: String?
    let showProfile: Bool?
    let backgroundColor: String?
}

// MARK: - PostSettings
struct PostSettings: Decodable {
    let padding: Int?
    let openPost: Bool?
    let buttonText, hoverStyle, buttonColor: String?
    let buttonTextSize: Int?
}
