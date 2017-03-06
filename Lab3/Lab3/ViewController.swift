//
//  ViewController.swift
//  Lab3
//
//  Created by XINYI on 2/11/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //currentColor = colorButton0.backgroundColor
        changeColor(colorButton0)
        updateButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == alphaTextField){
            let threeDigitRegEx = "[0-9]{,3}"
            let threeDigitTest = NSPredicate(format:"SELF MATCHES %@", threeDigitRegEx)
            return threeDigitTest.evaluate(with: string)
        }
        
        return true
    }
    
    @IBOutlet weak var thicknessSlider: UISlider!
    @IBOutlet weak var colorButton0: ColorButton!
    @IBOutlet weak var selectionIndicator: ColorButton!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var alphaTextField: UITextField!
    
    var currentPath: PathView?
    
    var currentColor: UIColor?
    var currentAlpha: Int = 100
    
    var paths: [PathView] = [PathView] () {
        didSet {
            updateButtons()
        }
    }
    
    var redoPaths: [PathView] = [PathView] () {
        didSet {
            updateButtons()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        if (touchPoint.y >= view.frame.height - 70) {
            return
        }
        
        redoPaths = [PathView] ()
        
        let thickness = CGFloat(thicknessSlider.value)
        let alpha = CGFloat(Double(currentAlpha)/100.0)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 70)
        currentPath = PathView(frame: frame)
        
        currentPath!.thePath = BoardPath(points: [touchPoint], thickness: thickness, color: currentColor!, alpha: alpha)
        view.addSubview(currentPath!)
        print(touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        if (currentPath == nil) {
            return
        }
        
        currentPath!.thePath?.points.append(touchPoint)
        print(touchPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        if (currentPath == nil) {
            return
        }
        
        currentPath!.thePath?.points.append(touchPoint)
        paths.append(currentPath!)
        currentPath = nil
        print(String(paths.count) + " paths")
    }

    @IBAction func clearBoard(_ sender: Any) {
        for p in paths{
            p.removeFromSuperview()
        }
        paths = [PathView] ()
        redoPaths = [PathView] ()
        print(String(paths.count) + " paths")
    }
    
    @IBAction func undoBoard(_ sender: Any) {
        if (paths.count <= 0) {
            print(String(paths.count) + " paths")
            return
        }
        
        let p: PathView = paths.removeLast()
        p.removeFromSuperview()
        redoPaths.append(p)
        print(String(paths.count) + " paths")
    }
    
    @IBAction func redoBoard(_ sender: Any) {
        if (redoPaths.count <= 0) {
            print(String(paths.count) + " paths")
            return
        }
        let p: PathView = redoPaths.removeLast()
        view.addSubview(p)
        paths.append(p)
    }
    
    @IBAction func changeColor(_ sender: ColorButton) {
        currentColor = sender.backgroundColor
        let indicatorX = sender.frame.maxX - selectionIndicator.frame.width/2
        let indicatorY = selectionIndicator.frame.origin.y
        selectionIndicator.frame.origin = CGPoint(x:indicatorX, y: indicatorY)
    }
    
    @IBAction func changeAlpha(_ sender: UITextField) {
        let input: Int? = Int(alphaTextField.text!)
        
        if (input == nil) {
            currentAlpha = 100
        } else if (input! > 100) {
            currentAlpha = 100
            alphaTextField.text = String(currentAlpha)
        } else {
            currentAlpha = input!
            alphaTextField.text = String(currentAlpha)
        }
    }
    
    func updateButtons () {
        clearButton.isEnabled = (paths.count > 0)
        undoButton.isEnabled = (paths.count > 0)
        redoButton.isEnabled = (redoPaths.count > 0)
    }
}

