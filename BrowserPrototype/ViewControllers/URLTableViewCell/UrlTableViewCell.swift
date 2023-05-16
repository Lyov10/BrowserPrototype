//
//  UrlTableViewCell.swift
//  BrowserPrototype
//
//  Created by 4steps on 16.05.23.
//

import UIKit

class UrlTableViewCell: UITableViewCell {
    
    static let id = "UrlTableViewCell"

    @IBOutlet weak var urlLabel: UILabel!

    func setupCell(url: String) {
        urlLabel.text = url
    }
    
}
