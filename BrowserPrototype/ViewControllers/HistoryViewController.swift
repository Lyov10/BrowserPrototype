//
//  HistoryViewController.swift
//  BrowserPrototype
//
//  Created by 4steps on 16.05.23.
//

import UIKit
import CoreData

protocol HistoryViewControllerDelegate: AnyObject {
    func didSelectUrl(url: String)
}

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let urls = LocalDataManager.sharedInstance.getUrls()
    weak var delegate : HistoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: UrlTableViewCell.id, bundle: nil), forCellReuseIdentifier: UrlTableViewCell.id)
    }
    
    
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let url = urls[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: UrlTableViewCell.id, for: indexPath) as? UrlTableViewCell else {return UITableViewCell()}
        cell.setupCell(url: url)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = urls[indexPath.row] else {return}
        delegate?.didSelectUrl(url: url)
        self.navigationController?.popViewController(animated: true)
    }
}
