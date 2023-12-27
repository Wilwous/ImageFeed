//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 11.09.2023.
//

import UIKit
import Kingfisher

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateAvatar()
    func showAlert()
    func switchToSplashScreen()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    var presenter: ProfileViewPresenterProtocol?
    
    // MARK: - Private Properties
    
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var loginNameLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateAvatar()
        presenter?.profileImageObserver()
        updateProfileDetails()
        view.backgroundColor = UIColor.ypBlack
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        setupAvatarImageView()
        setupNameLabel()
        setupLoginNameLabel()
        setupDescriptionLabel()
        setupLogoutButton()
    }
    
    // MARK: - Private Func
    
    private func setupAvatarImageView() {
        avatarImageView = UIImageView(image: UIImage(named: "Avatar"))
        avatarImageView.tintColor = .gray
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.textColor = .ypWhite
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupLoginNameLabel() {
        loginNameLabel = UILabel()
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.font = UIFont.systemFont(ofSize: 13)
        loginNameLabel.textColor = .ypWhiteAlpha
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        
        NSLayoutConstraint.activate([
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginNameLabel.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupLogoutButton() {
        logoutButton = UIButton(type: .custom)
        logoutButton.tintColor = .ypRed
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setImage(UIImage(systemName: "ipad.and.arrow.forward"), for: .normal)
        logoutButton.accessibilityIdentifier = "logoutButton"
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    
    @objc
    private func logoutButtonTapped() {
        showAlert()
    }
}

extension ProfileViewController {
    
    func configure(_ presenter: ProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func updateProfileDetails() {
        guard let profile = presenter?.getProfileDetails() else { return }
        nameLabel.text = profile.name
        loginNameLabel.text = profile.loginName
        descriptionLabel.text = profile.bio
    }
    
    func updateAvatar() {
        guard let url = presenter?.getProfileImageURL() else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 70, backgroundColor: .clear)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "avatar_placeholder"),
            options: [.processor(processor),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)]
        )
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
    
    func showAlert() {
        guard let inputValue = presenter?.prepareAlert() else { return }
        let alert = UIAlertController(
            title: inputValue.title,
            message: inputValue.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: inputValue.actionYes, style: .default) { [weak self] alertAction in
            guard let self = self else { return }
            presenter?.cleanAndSwitchToSplashView()
        })
        alert.addAction(UIAlertAction(title: inputValue.actionNo, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func switchToSplashScreen() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = SplashViewController()
    }
}
