//
//  ExtensionViewController.swift
//  MapDemo
//
//  Created by Nguyễn Đình Việt on 20/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showSettingAlert(title: String = "Thông báo", message: String, acceptTitle: String = "Cài đặt", cancelTitle: String = "Hủy") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: acceptTitle, style: UIAlertAction.Style.cancel, handler: { (sender) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        
        let cancel = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default, handler: { (sender) in
        })
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
