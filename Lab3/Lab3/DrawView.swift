//
//  DrawView.swift
//  Lab3
//
//  Created by XINYI on 2/11/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentPath: PathView? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.red
        print("c")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        
        currentPath = PathView()
        currentPath!.thePath?.points.append(touchPoint)
        
        self.addSubview(currentPath!)
        print(touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        currentPath!.thePath?.points.append(touchPoint)
        print(touchPoint)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        currentPath!.thePath?.points.append(touchPoint)

        currentPath = nil
        print(currentPath)
    }
}
