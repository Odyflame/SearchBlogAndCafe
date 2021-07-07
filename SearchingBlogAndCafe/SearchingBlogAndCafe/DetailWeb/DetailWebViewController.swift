//
//  DetailWebViewController.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import UIKit
import WebKit
import SnapKit

class DetailWebViewController: UIViewController {
    
    lazy var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureLayout()
    }
    
    func configureWebview(url: URL) {
        webView.load(URLRequest(url: url))
    }
 
    private func configureLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
