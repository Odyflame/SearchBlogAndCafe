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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWebview(url: URL, title: String) {
        _ = webView.load(URLRequest(url: url))
        self.title = title
    }
 
    private func configureLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
