//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.07.2023.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController {

    // MARK: - Private Properties

    private let photosName: [String] = Array(0..<20).map { "\($0)" }
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    private(set) var photos: [Photo] = []
    private let imagesListService = ImagesListService.shared
    private var imagesListServiceObserver: NSObjectProtocol?
    private var initialDataLoaded = false

    // MARK: - IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - TableView Configuration

    private func configureTableView() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        if !initialDataLoaded {
             loadInitialPhotos()
        }
        observeImagesList()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            guard let viewController = segue.destination as? SingleImageViewController,
                  let indexPath = sender as? IndexPath else { return }
            if let url = imagesListService.photos[indexPath.row].fullImageURL,
               let imageURL = URL(string: url) {
                    viewController.imageURL = imageURL
                }
            } else {
                super.prepare(for: segue, sender: sender)
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
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)

        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }

        configCell(for: imageListCell, with: indexPath)

        return imageListCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            imagesListService.fetchPhotoNextPage()
        }
    }

    // MARK: - Configuring Cell
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        if let url = imagesListService.photos[indexPath.row].thumbImageURL,
           let imageURL = URL(string: url) {
            cell.cellImage.kf.indicatorType = .activity
            cell.cellImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "photos_placeholder"),
                completionHandler: { _ in
                    self.tableView.reloadRows(at:[indexPath], with: .automatic)
                }
            )
        }
        cell.dateLabel.text = dateFormatter.string(from: Date()).replacingOccurrences(of: "г.", with: "")

        let isLiked = indexPath.row % 2 == 1
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        cell.likeButton.setImage(likeImage, for: .normal)
    }

    // MARK: - Loading Initial Photos
    
    func loadInitialPhotos() {
        imagesListService.fetchPhotoNextPage()
    }

    // MARK: - Observing Image List Changes
    
    func observeImagesList() {
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.updateTableViewAnimated()
        }
    }

    // MARK: - Updating Table View Animated
    
    func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount {
            tableView.performBatchUpdates {
                if oldCount < newCount {
                    let indexPaths = (oldCount..<newCount).map { i in
                        IndexPath(row: i, section: 0)
                    }
                    tableView.insertRows(at: indexPaths, with: .automatic)
                } else {
                    let indexPaths = (newCount..<oldCount).map { i in
                        IndexPath(row: i, section: 0)
                    }
                    tableView.deleteRows(at: indexPaths, with: .automatic)
                }
            } completion: { _ in }
        }
    }
}

