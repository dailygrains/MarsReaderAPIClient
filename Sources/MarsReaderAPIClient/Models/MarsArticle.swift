//
//  Article.swift
//  MarsReader
//
//  Created by Paul Bonneville on 10/18/21.
//

import Foundation

// MARK: - ----- GLOBAL ----- -
// MARK: - ----- PROTOCOLS ----- -
// MARK: - ---------------------------------- -

/// Model object for articles downloaded from the Mars Reader API.
public struct MarsArticle: Codable {

    // MARK: - ----- TYPE ALIASES ----- -
    // MARK: - ----- ENUMS ----- -
    // MARK: - ----- STRUCTS ----- -
    // MARK: - ----- PROPERTIES ----- -
    // MARK: Static properties
    // MARK: - Property wrappers
    // MARK: - Private properties
    // MARK: - Public properties

    /// Display for the article.
    public let title: String

    /// URLs for downloadable images associated with this article.
    public let images: [MarsArticleImage]

    /// Returns the ArticleImage that is to be used at the top of an `Article`, if it exists.
    public var topImage: MarsArticleImage? {
        images.first(where: { $0.topImage == true })
    }

    /// Text content that contains the body of the article.
    public let body: String

    // MARK: - ----- INITIALIZERS ----- -
    // MARK: - ----- STATIC METHODS ----- -
    // MARK: - ----- PUBLIC METHODS ----- -
    // MARK: - ----- PRIVATE METHODS ----- -

    /// Converts this `Article` object into a JSON string.
    /// - Returns: This object as a pretty-printed JSON string.
    public func asJSON() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            return ""
        }
    }
}

// MARK: - ----- EXTENSIONS & SUPPORTING OBJECTS ----- -

/// Details for images associated with an article.
public struct MarsArticleImage: Codable {
    /// Image to use at the top of an article.
    public let topImage: Bool

    /// URL for downloadable image.
    public let url: String
    public let width, height: Int

    public enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case url, width, height
    }
}
