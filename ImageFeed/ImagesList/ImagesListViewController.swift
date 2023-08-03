//
//  ViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.07.2023.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    func configCell(for cell:ImagesListCell, with indexPath: IndexPath) {
        
        let imagesName = "\(indexPath.row)"
        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        
        lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            return formatter
        }()
        
        guard let image = UIImage(named: imagesName) else {
            return
        }
        
        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from:Date())
        cell.likeButton.setImage(likeImage, for: .normal)
        
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        return imageListCell
    }
}

