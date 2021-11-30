//
//  NineNewsPointDetailsViewController.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 27/11/21.
//

import UIKit
import WebKit

class NineNewsPointDetailsViewController: UIViewController {
    // MARK: - Public Outlets
    public var urlString: String?
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        loadWebView()
    }
    
    ///Informs the observing object when the value at the specified key path relative to the observed object has changed.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.EstimatedProgress {
            print(Float(wkWebView.estimatedProgress))
        }
    }
    
    /// loadWebView
    func loadWebView() {
        let url = URL(string:urlString ?? Constants.BlankString)
        let request = URLRequest(url: url!)
        wkWebView.load(request)
    }

}

extension NineNewsPointDetailsViewController: WKNavigationDelegate {
    
}
