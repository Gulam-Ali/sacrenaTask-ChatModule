//
//  profileView.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit

class profileView: UIView {

    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            self.layer.cornerRadius = self.frame.width/2
        }
    }
    @IBOutlet weak var background: UIView!{
        didSet{
            self.layer.cornerRadius = self.frame.width/2
        }
    }
    
     override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         commonInit()
     }

     
     func commonInit(){
         let viewFromxib = Bundle.main.loadNibNamed("profileView", owner: self, options: nil)![0] as! UIView
         viewFromxib.frame = self.bounds
         addSubview(viewFromxib)
     }
    
}
