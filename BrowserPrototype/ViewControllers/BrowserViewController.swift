//
//  BrowserViewController.swift
//  BrowserPrototype
//
//  Created by 4steps on 16.05.23.
//

import UIKit
import WebKit
import CoreData

class BrowserViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!{
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    private let historySegue = "HistoryViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case historySegue :
            guard let vc = segue.destination as? HistoryViewController else {return}
            vc.delegate = self
        default :
            break
        }
    }
    private func loadUrl(urlString: String) {
        guard let url = URL(string: urlString), var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {return}
        comps.scheme = "https"
        guard let httpsURL = comps.url else {return}
        LocalDataManager.sharedInstance.saveUrl(url)
        self.webView.load(URLRequest(url: httpsURL))
    }
}


extension BrowserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let urlString = textField.text else {return false}
        loadUrl(urlString: urlString)
        return true
    }
}

extension BrowserViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        decisionHandler(.allow)
    }    
}

extension BrowserViewController: HistoryViewControllerDelegate {
    func didSelectUrl(url: String) {
        loadUrl(urlString: url)
    }
}
