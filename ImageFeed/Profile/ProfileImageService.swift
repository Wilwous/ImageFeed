//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Антон Павлов on 30.11.2023.
//

import Foundation

final class ProfileImageService {
    static let shared = ProfileImageService()
    private let urlSession = URLSession.shared
    private(set) var avatarURL: String?
    private var task: URLSessionTask?

    private let urlRequestFactory: URLRequestFactory

    init(urlRequestFactory: URLRequestFactory = .shared) {
        self.urlRequestFactory = urlRequestFactory
    }

    func fetchProfileImageURL(
        username: String,
        completion: @escaping (Result<String,Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        task?.cancel()
        guard let request = profileImageRequest(username: username) else {
            assertionFailure("Invalid request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        let task = updateUserImagesProfile(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profilPhoto):
                guard let smallImage = profilPhoto.profileImage?.small else { return }
                self.avatarURL = smallImage
                completion(.success(smallImage))
                self.task = nil
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
}

extension ProfileImageService {
    private func updateUserImagesProfile(
        for request: URLRequest,
        completion: @escaping (Result<UserResult, Error>) -> Void
    ) -> URLSessionTask {
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<UserResult, Error> in
                Result { try JSONDecoder().decode(UserResult.self, from: data) }
            }
            completion(response)
        }
    }
    
    private func profileImageRequest(username: String) -> URLRequest? {
        urlRequestFactory.makeHTTPRequest(
            path: "/users/\(username)",
            httpMethod: "GET"
        )
    }
}

