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
    
    func configCell(for cell:ImagesListCell, with: IndexPath) {}
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

