//
//  networkImage.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import Foundation
import UIKit
import SDWebImage

@IBDesignable
class networkImage: UIImageView {

    // Make cornerRadius inspectable in storyboard
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }

    // Load image from URL
    func setImage(from url: String) {
        if let imageURL = URL(string: url) {
            self.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
        }
    }

    // Called when this view is initialized
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}
