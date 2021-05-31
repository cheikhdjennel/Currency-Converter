//
//  ViewController.swift
//  Price Converter
//
//  Created by Djennelbaroud Hadj Cheikh on 27/05/2021.
//  Copyright © 2021 Djennelbaroud Hadj Cheikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate,CurrencyConverterDelegate  {
    
    func ReturnPriceConverted(_ Price: String) {
        DispatchQueue.main.async{
            self.ResultPrice.text = Price
        }
    }
    
    @IBOutlet weak var PriceCurrencyYouHave: UIPickerView!
    @IBOutlet weak var CurrencyToConvertTo: UIPickerView!
    @IBOutlet weak var PriceToConvert: UITextField!
    @IBOutlet weak var ResultPrice: UITextField!
    @IBOutlet weak var FirstCurrencySignLabel: UILabel!
    @IBOutlet weak var SecondCurrencySignLabel: UILabel!
    var CurrencyManager = CurrencyConverterManager()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyManager.PossibleCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.CurrencyManager.PossibleCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  CurrencyManager.PossibleCurrencies[row] == "EUR" {
            if pickerView == PriceCurrencyYouHave {
                FirstCurrencySignLabel.text = "EUR"
                CurrencyManager.ActualCurrencyYouHave = "EUR"
                
            }else {
                SecondCurrencySignLabel.text = "EUR"
                CurrencyManager.ActualCurrencyToConvertTo = "EUR"
                
            }
        }else if CurrencyManager.PossibleCurrencies[row] == "USD" {
            if pickerView == PriceCurrencyYouHave {
                FirstCurrencySignLabel.text = "USD"
                CurrencyManager.ActualCurrencyYouHave = "USD"
                
            }else {
                SecondCurrencySignLabel.text = "USD"
                CurrencyManager.ActualCurrencyToConvertTo = "USD"
                
            }
        }else {
            if pickerView == PriceCurrencyYouHave {
                FirstCurrencySignLabel.text = "DZD"
                CurrencyManager.ActualCurrencyYouHave = "DZD"
                
            }else {
                SecondCurrencySignLabel.text = "DZD"
                CurrencyManager.ActualCurrencyToConvertTo = "DZD"
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PriceToConvert.delegate = self
        PriceToConvert.text = ""
        FirstCurrencySignLabel.text = "EUR"
        SecondCurrencySignLabel.text = "EUR"
        CurrencyToConvertTo.dataSource = self
        PriceCurrencyYouHave.dataSource = self
        CurrencyToConvertTo.delegate = self
        PriceCurrencyYouHave.delegate = self
        CurrencyManager.delegate = self
    }
    
    @IBAction func ConvertButtonTapped(_ sender: Any) {
        PriceToConvert.endEditing(true)
        
        CurrencyManager.exchangeCurrency(from: CurrencyManager.ActualCurrencyYouHave, to: CurrencyManager.ActualCurrencyToConvertTo, amount: CurrencyManager.ActualPriceYouHave!)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PriceToConvert.endEditing(true)
        CurrencyManager.exchangeCurrency(from: CurrencyManager.ActualCurrencyYouHave, to: CurrencyManager.ActualCurrencyToConvertTo, amount: CurrencyManager.ActualPriceYouHave!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if PriceToConvert.text != "" {
            return true
        }else{
            
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var price = textField.text!
        CurrencyManager.ActualPriceYouHave = price
        print(price)
        
        
    }
    
}

