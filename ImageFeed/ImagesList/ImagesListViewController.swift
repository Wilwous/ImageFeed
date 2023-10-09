//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.07.2023.
//

import UIKit

final class ImagesListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let photosName: [String] = Array(0..<20).map { "\($0)" }
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - DateFormatter
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - TableView Configuration
    
    private func configureTableView() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            if let viewController = segue.destination as? SingleImageViewController,
               let indexPath = sender as? IndexPath {
                let imageName = photosName[indexPath.row]
                if let image = UIImage(named: imageName) {
                    viewController.image = image
                }
            } else {
                super.prepare(for: segue, sender: sender)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageName = "\(indexPath.row)"
        
        guard let image = UIImage(named: imageName) else {
            return 0
        }
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        let image = UIImage(named: photosName[indexPath.row])
        let date = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        
        imageListCell.configCell(image: image, date: date, isLiked: isLiked)
        
        return imageListCell
    }
}

