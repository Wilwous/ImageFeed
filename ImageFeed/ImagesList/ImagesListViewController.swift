//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.07.2023.
//

import UIKit
import Kingfisher

protocol ImageListViewControllerProtocol: AnyObject {
    var presenter: ImagesListViewPresenterProtocol? { get set }
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int)
}

final class ImagesListViewController: UIViewController, ImageListViewControllerProtocol, ImagesListCellDelegate {
    
    lazy var presenter: ImagesListViewPresenterProtocol? = {
        return ImagesListPresenter()
    }()
    
    // MARK: - Private Properties
    
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - TableView Configuration
    
    private func configureTableView() {
        tableView?.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            guard let viewController = segue.destination as? SingleImageViewController,
                  let indexPath = sender as? IndexPath else { return }
            if let url = presenter?.imagesListService.photos[indexPath.row].fullImageURL,
               let imageURL = URL(string: url) {
                viewController.imageURL = imageURL
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Configuring
    
    func configure(_ presenter: ImagesListViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        if let url =  presenter?.imagesListService.photos[indexPath.row].thumbImageURL,
           let imageURL = URL(string: url) {
            cell.cellImage.kf.indicatorType = .activity
            cell.cellImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "photos_placeholder")) { [weak self] _ in
                    guard let self = self else { return }
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            if let date =  presenter?.imagesListService.photos[indexPath.row].createdAt {
                cell.dateLabel.text = dateFormatter.string(from: date as Date)
            } else {
                cell.dateLabel.text = ""
            }
            guard let like = presenter?.imagesListService.photos[indexPath.row].isLiked else { return }
            cell.setIsLiked(entryValue: like)
        }
    }
    
    // MARK: - Updating Table View Animated
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        tableView.performBatchUpdates {
            let indexPath = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
            tableView.insertRows(at: indexPath, with: .fade)
        } completion: { _ in }
    }
    
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    //    Возможно что то тут не так
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = presenter?.imagesListService.photos[indexPath.row] else { return 0 }
        
        let imageInsert = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsert.left - imageInsert.right
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let scale = imageViewWidth / imageWidth
        let cellHeight = imageHeight * scale + imageInsert.top + imageInsert.bottom
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        imageListCell.delegate = self
        configCell(for: imageListCell, with: indexPath)
        
        
        return imageListCell
    }
    
    func imagesListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter?.imagesListCellDidTapLike(cell, indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let photosCount = presenter?.imagesListService.photos.count else { return 0 }
        return photosCount
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == presenter?.imagesListService.photos.count {
            presenter?.imagesListService.fetchPhotoNextPage()
        }
    }
}



