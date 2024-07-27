//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Антон Павлов on 30.11.2023.
//

import Foundation

final class ProfileImageService {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    private let urlSession = URLSession.shared
    private let urlRequestFactory = URLRequestFactory.shared
    private(set) var avatarURL: String?
    private var task: URLSessionTask?
    
    private init() {}
    
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
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result <UserResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let profilPhoto):
                guard let profileImageURL = profilPhoto.profileImage?.large else { return }
                self.avatarURL = profileImageURL
                completion(.success(profileImageURL))
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: nil
                )
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
    private func profileImageRequest(username: String) -> URLRequest? {
        urlRequestFactory.makeHTTPRequest(
            path: "/users/\(username)",
            httpMethod: "GET"
        )
    }
    
    func clean() {
        avatarURL = nil
        task = nil
    }
}

