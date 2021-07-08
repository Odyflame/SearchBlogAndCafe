//
//  UIViewController+.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/07.
//

import Foundation
import UIKit

extension UIViewController {
    func showSortAlertView() {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let first = UIAlertAction(title: "Title", style: .default) { (action) in
            NotificationCenter.default.post(name: NSNotification.Name.sortTypeChanged, object: nil)
        }
        let second = UIAlertAction(title: "DateTime", style: .default) { (action) in
            NotificationCenter.default.post(name: NSNotification.Name.sortTypeChanged, object: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alert.addAction(first)
        alert.addAction(second)
        alert.addAction(cancel)
        present(alert, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
