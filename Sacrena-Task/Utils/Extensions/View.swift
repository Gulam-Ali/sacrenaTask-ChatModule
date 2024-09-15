//
//  View.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import Foundation
import UIKit

extension UIView{
    
    func GetShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func GetColorShadow(color:UIColor){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .init(width: 3, height: 3)
        self.layer.shadowRadius = 2
        
    }
    
    func GetViewBorder(border:CGFloat,color:UIColor){
        
        self.layer.borderWidth = border
        self.layer.borderColor = color.cgColor
    }
    
    func CicularView(){
        self.layer.cornerRadius = self.frame.width/2
    }
    
    
    func drawDottedLine(color:UIColor) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: self.bounds.minX, y: self.bounds.minY), CGPoint(x: self.bounds.maxX, y: self.bounds.minY)])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    
    
}
