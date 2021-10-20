//
//  MarsReaderAPIClient.swift
//  MarsReaderAPIClient
//
//  Created by Paul Bonneville on 10/17/21.
//

import Combine
import Foundation

// MARK: - ----- GLOBAL ----- -
// MARK: - ----- PROTOCOLS ----- -
// MARK: - ---------------------------------- -

/// The Mars Reader API client library.
///
/// Well...it is not actually a API client, but we are going to pretend it is 😎
@available(iOS 13.0, *)
public class MarsReaderAPIClient {

    // MARK: - ----- TYPE ALIASES ----- -
    // MARK: - ----- ENUMS ----- -

    enum MarsReaderError: LocalizedError {
        case badURLString

        /// 'LocalizedError' compliance value.
        public var errorDescription: String? {
            switch self {
            case .badURLString:
                return NSLocalizedString("invalidURLString", bundle: .module, comment: "")
            }
        }
    }

    // MARK: - ----- STRUCTS ----- -
    // MARK: - ----- PROPERTIES ----- -
    // MARK: Static properties
    // MARK: - Property wrappers
    // MARK: - Private properties
    // MARK: - Public properties

    /// Url for the API as a `String`.
    public var apiURL: String

    /// Publisher use to send out retrieved `Article` array.
    public let articlesSubject = PassthroughSubject<[MarsArticle], Never>()

    // MARK: - ----- INITIALIZERS ----- -

    /// The public initialized required by all Swift packages, even if not used.
    public init(apiURL: String) {
        self.apiURL = apiURL
    }

    // MARK: - ----- STATIC METHODS ----- -
    // MARK: - ----- PUBLIC METHODS ----- -

    /// Retrieves `Articles` from the Mars Reader API and publishes them via the `articles` subject.
    ///
    /// - Throws: Returns a `MarsReaderError` with the associated cause.
    public func getArticles() throws -> AnyPublisher<[MarsArticle], Error> {
        guard let url = URL(string: apiURL) else {
            throw MarsReaderError.badURLString
        }

        // https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine

        return URLSession(configuration: .ephemeral)
            .dataTaskPublisher(for: url)
            .print()
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [MarsArticle].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    // MARK: - ----- PRIVATE METHODS ----- -

    // MARK: - ----- EXTENSIONS & SUPPORTING OBJECTS ----- -
}
