//
//  Extensions.swift
//  CinematX
//
//  Created by Adam Londa on 28/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

extension UIViewController {
    func handleUnexpectedError(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }
}
