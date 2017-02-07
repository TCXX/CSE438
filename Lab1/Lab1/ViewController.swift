//
//  ViewController.swift
//  Lab1
//
//  Created by XINYI on 1/25/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taxPicker: UIPickerView!
    var taxData: [Double] = [-1,
                          4, 0, 5.6, 6.5, 7.5,
                          2.9, 6.35, 0, 6, 4,
                          4, 6, 6.25, 7, 6,
                          6.5, 6, 5, 5.5, 6,
                          6.25, 6, 6.88, 7, 4.23,
                          0, 5.5, 6.85, 0, 7,
                          5.13, 4, 4.75, 5, 5.75,
                          4.5, 0, 6, 7, 6,
                          4.5, 7, 6.25, 5.95, 6,
                          5.3, 6.5, 6, 5, 4,
                          5.75]
    var pickerData: [String] = [String]()
    
    var savedPrice:String = ""
    var savedDis:String = ""
    var savedTax:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateFinalPrice()
        
        //Input constraints
        self.originalPrice.delegate = self
        self.discount.delegate = self
        self.salesTax.delegate = self
        
        self.taxPicker.delegate = self
        self.taxPicker.dataSource = self
        
        //Data sourse from
        //https://taxfoundation.org/state-and-local-sales-tax-rates-midyear-2016
        pickerData = ["--select--",
        
        "Alabama (4.00%)",
        "Alaska (0.00%)",
        "Arizona (5.60%)",
        "Arkansas (6.50%)",
        "California (7.50%)",
        
        "Colorado (2.90%)",
        "Connecticut (6.35%)",
        "Delaware (0.00%)",
        "Florida (6.00%)",
        "Georgia (4.00%)",
        
        "Hawaii (4.00%)",
        "Idaho (6.00%)",
        "Illinois (6.25%)",
        "Indiana (7.00%)",
        "Iowa (6.00%)",
        
        "Kansas (6.50%)",
        "Kentucky (6.00%)",
        "Louisiana (5.00%)",
        "Maine (5.50%)",
        "Maryland (6.00%)",
        
        "Massachusetts (6.25%)",
        "Michigan (6.00%)",
        "Minnesota (6.88%)",
        "Mississippi (7.00%)",
        "Missouri (4.23%)",
        
        "Montana (0.00%)",
        "Nebraska (5.50%)",
        "Nevada (6.85%)",
        "New Hampshire (0.00%)",
        "New Jersey (7.00%)",
        
        "New Mexico (5.13%)",
        "New York (4.00%)",
        "North Carolina (4.75%)",
        "North Dakota (5.00%)",
        "Ohio (5.75%)",
        
        "Oklahoma (4.50%)",
        "Oregon (0.00%)",
        "Pennsylvania (6.00%)",
        "Rhode Island (7.00%)",
        "South Carolina (6.00%)",
        
        "South Dakota (4.50%)",
        "Tennessee (7.00%)",
        "Texas (6.25%)",
        "Utah (5.95%)",
        "Vermont (6.00%)",
        
        "Virginia (5.30%)",
        "Washington (6.50%)",
        "West Virginia (6.00%)",
        "Wisconsin (5.00%)",
        "Wyoming (4.00%)",
        
        "D.C. (5.75%)"]
        
        savedPrice=originalPrice.text!
        savedDis=discount.text!
        savedTax=salesTax.text!
        
        taxPicker.isHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The following three functions from Chris
    //http://codewithchris.com/uipickerview-example/
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row==0){
            salesTax.text=savedDis
            return
        }
        
        let tax = taxData[taxPicker.selectedRow(inComponent: 0)]
        salesTax.text = String(tax)
        standizeInputBox(sender: salesTax)
        updateFinalPrice()
    }
    
    //Outlets
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == originalPrice || textField == discount || textField == salesTax){
            let twoDigitRegEx = "[0-9.]*"
            let twoDigitTest = NSPredicate(format:"SELF MATCHES %@", twoDigitRegEx)
            return twoDigitTest.evaluate(with: string)
        }
        
        return true
    }
    
    @IBAction func priceStarted(_ sender: UITextField) {
        sender.text=savedPrice
    }
    
    @IBAction func priceChanged(_ sender: UITextField) {
        updateFinalPrice()
    }
    
    @IBAction func priceFinished(_ sender: UITextField) {
        savedPrice=sender.text!
        standizeInputBox(sender: sender)
    }
    
    @IBAction func discountStarted(_ sender: UITextField) {
        sender.text=savedDis
    }
    
    @IBAction func discountChanged(_ sender: UITextField) {
        updateFinalPrice()
    }
    
    @IBAction func discountFinished(_ sender: UITextField) {
        savedDis=sender.text!
        standizeInputBox(sender: sender)
    }
    
    @IBAction func taxStarted(_ sender: UITextField) {
        sender.text=savedTax
        taxPicker.isHidden=false
    }
    
    @IBAction func taxChanged(_ sender: UITextField) {
        updateFinalPrice()
    }
    
    @IBAction func taxFinished(_ sender: UITextField) {
        taxPicker.isHidden=true
        savedTax=sender.text!
        standizeInputBox(sender: sender)
    }
    
    func updateFinalPrice(){
        let price=convertInputBox(sender: originalPrice)
        let dis=convertInputBox(sender: discount)
        let tax=convertInputBox(sender: salesTax)
        
        if (price>=0 && dis>=0 && dis<=100 && tax>=0 && tax<=100){
            let intNum = price * (1-dis/100) * (1+tax/100)
            finalPrice.text = "$"+String (format: "%.2f",intNum)
        }else{
            finalPrice.text = "$???"
        }
    
    }
    
    func convertInputBox(sender: UITextField)->Double{
        let strNum:String?=sender.text
        
        if(strNum==nil){
            return 0
        }
        
        let intNum:Double? = Double(strNum!)
        
        if (intNum==nil){
            return 0
        }
        
       return intNum!
    }
    
    func standizeInputBox(sender: UITextField){
        let intNum = convertInputBox(sender: sender)
        if intNum.truncatingRemainder(dividingBy: 1) == 0 {
            sender.text = String(format: "%.0f",intNum)
        }else{
            sender.text = String(format: "%.2f",intNum)
        }
        
    }

}

