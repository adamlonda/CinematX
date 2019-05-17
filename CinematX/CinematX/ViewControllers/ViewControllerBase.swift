//
//  ViewControllerBase.swift
//  CinematX
//
//  Created by Adam Londa on 17/05/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class ViewControllerBase: UIViewController {
    internal let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    internal func showConnectionError() {
        fatalError("Not implemented")
    }
}
