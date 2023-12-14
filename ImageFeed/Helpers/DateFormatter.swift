//
//  DateFormatter.swift
//  ImageFeed
//
//  Created by Антон Павлов on 14.12.2023.
//

import Foundation

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter
}()
