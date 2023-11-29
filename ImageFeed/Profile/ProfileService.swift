//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Антон Павлов on 10.10.2023.
//

import Foundation

final class ProfileService {
    
    static let shared = ProfileService()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private (set) var profile: Profile?
    private let urlRequestFactory: URLRequestFactory
    
    init(urlRequestFactory: URLRequestFactory = .shared) {
        self.urlRequestFactory = urlRequestFactory
    }

    func fetchProfile(
        _ token: String,
        completion: @escaping (Result <Profile, Error>) -> Void
    ) {
        task?.cancel()
        guard let request = profileRequest(token: token) else {
            assertionFailure("Invalid request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        let task = updateUserProfile(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                let profile = Profile(result: body)
                self.profile = profile
                completion(.success(profile))
                self.task = nil
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
    
    private func updateUserProfile(
        for request: URLRequest,
        completion: @escaping (Result<ProfileResult, Error>) -> Void
    ) -> URLSessionTask {
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<ProfileResult, Error> in
                Result { try JSONDecoder().decode(ProfileResult.self, from: data) }
            }
            completion(response)
        }
    }

    private func profileRequest(token: String) -> URLRequest? {
        urlRequestFactory.makeHTTPRequest(
            path: "/me",
            httpMethod: "GET"
        )
    }
}
