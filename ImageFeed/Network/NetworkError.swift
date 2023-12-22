//
//  NetworkError.swift
//  ImageFeed
//
//  Created by Антон Павлов on 22.12.2023.
//

import Foundation

// MARK: - Network Connection

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
}
