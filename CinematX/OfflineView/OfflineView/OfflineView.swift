//
//  OfflineView.swift
//  OfflineView
//
//  Created by Adam Londa on 09/03/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

// https://medium.com/flawless-app-stories/getting-started-with-reusable-frameworks-for-ios-development-f00d74827d11
public class OfflineView: UIView {
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!
    
    let nibName = "OfflineView"
    var contentView: UIView!
    
    // MARK: Set Up View
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        errorLabel.text = "# Connection error"
        tryAgainButton.titleLabel?.text = "# Try again"
    }
    
//    public func set(errorLabel text: String) {
//        self.errorLabel.text = text
//    }
//    
//    public func set(tryAgainButtonLabel text: String) {
//        self.tryAgainButton.titleLabel?.text = text
//    }
    
    public func set(isHidden value: Bool) {
        self.contentView.isHidden = value
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
