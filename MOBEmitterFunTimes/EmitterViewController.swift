//
//  EmitterViewController.swift
//  MOBEmitterFunTimes
//
//  Created by Craig Stanford on 1/07/2014.
//

import UIKit
import QuartzCore

enum EmitterType: String {
    case Bubbles = "Bubbles"
    case Rain = "Rain"
    case Ink = "Ink"
}

class EmitterViewController: UIViewController {
    
    var emitterLayer: CAEmitterLayer?
    
    var _emitterType :EmitterType?
    var emitterType: EmitterType {
    get {
        return _emitterType!
    }
    set {
        _emitterType = newValue
        
        //Remove the old emitterLayer if need be
        if let emitterLayer = emitterLayer {
            emitterLayer.removeFromSuperlayer()
        }
        
        //Create the new emitterLayer
        let cellWidth = CGFloat(60.0);
        self.emitterLayer = CAEmitterLayer();
        if let emitterLayer = emitterLayer {
            var emitterPosition :CGPoint
            var emitterSize :CGSize
            var cells:Array<CAEmitterCell> = Array()
            //TODO: Move this down into the switch and customise more
            if let cell = emitterCell(UIColor.blackColor(), size: CGSizeMake(cellWidth, cellWidth)) {
                cells.append(cell)
            }
            switch _emitterType! {
            case .Bubbles:
                let centerX = CGRectGetWidth(self.view.frame) / 2.0
                let centerY = CGRectGetHeight(self.view.frame) + CGFloat(Double(cellWidth) * Double(2.0))
                emitterPosition = CGPointMake(centerX, centerY)
                emitterSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 0.0)
            case .Rain:
                let centerX = CGRectGetWidth(self.view.frame) / 2.0
                let centerY:CGFloat = 0.0
                emitterPosition = CGPointMake(centerX, centerY)
                emitterSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 0.0)
            case .Ink:
                emitterPosition = CGPointZero
                emitterSize = self.view.bounds.size
            }
            
            emitterLayer.emitterZPosition = 0.0
            emitterLayer.emitterPosition = emitterPosition
            emitterLayer.emitterSize = emitterSize
            emitterLayer.emitterShape = kCAEmitterLayerLine
            emitterLayer.emitterCells = cells
            self.view.layer.addSublayer(emitterLayer)
        }
        
    }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func image(color:UIColor, frame:CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(frame.size);
        var context:CGContextRef = UIGraphicsGetCurrentContext();
        UIBezierPath(roundedRect: frame, cornerRadius: CGRectGetWidth(frame) / 2).addClip()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, frame);
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
    
    func emitterCell(color:UIColor, size:CGSize) -> CAEmitterCell? {
        let emitterCell:CAEmitterCell = CAEmitterCell();
        emitterCell.scale = 0.1;
        emitterCell.scaleRange = 0.7;
        emitterCell.emissionRange = CGFloat(M_PI);
        emitterCell.lifetime = 15.0;
        emitterCell.birthRate = 2.0;
        emitterCell.velocity = 10.0;
        emitterCell.velocityRange = 100.0;
        emitterCell.yAcceleration = -7.0;
        emitterCell.xAcceleration = 0.0;
        if let image = image(color, frame: CGRectMake(0, 0, size.width, size.height)) {
            emitterCell.contents = image.CGImage
        }
        return emitterCell;
        
    }
    
}
