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
    }
    
    func configCell(for cell:ImagesListCell) {}
}

    extension ImagesListViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    }
    
    extension ImagesListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }

