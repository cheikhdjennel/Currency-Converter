//
//  CurrencyConverterManager.swift
//  Price Converter
//
//  Created by Djennelbaroud Hadj Cheikh on 29/05/2021.
//  Copyright © 2021 Djennelbaroud Hadj Cheikh. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyConverterDelegate{
    
    func ReturnPriceConverted(_ Price : String)
}

struct CurrencyConverterManager  {
    
    var PossibleCurrencies = ["EUR","USD","DZD"]
    var ActualCurrencyYouHave : String = ""
    var ActualCurrencyToConvertTo : String = ""
    var ActualPriceYouHave : String?
    var result : String?
    var delegate : CurrencyConverterDelegate?
    
    let apiKey = "a64126012cmshbb04901c715d3aap1a8715jsn871e304434b4"
    
     func exchangeCurrency ( from : String , to : String , amount : String ) {
      

        var url = "https://currency-converter13.p.rapidapi.com/convert?from="+from+"&to="+to+"&amount="+amount
        
        getExchangePrice(stringUrl: url)
        
        
    }
    
     func getExchangePrice(stringUrl : String)   {
       let headers = [
                 "x-rapidapi-key": apiKey ,
                 "x-rapidapi-host": "currency-converter13.p.rapidapi.com"
             ]
        let request = NSMutableURLRequest(url: NSURL(string: stringUrl)! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
             if (error != nil) {
                           print(error!)
                           return
                       }
            if let safeData = data {
                           let decoder = JSONDecoder()
                           do {
                            let jsonResultData = try decoder.decode(ConvertedCurrencyData.self, from: safeData)
//                            let price = String(jsonResultData.amount)
                            let price = String(format: "%.3f", jsonResultData.amount)
                              self.delegate?.ReturnPriceConverted(price)
                            print(price)
                           }catch {
                               print(error)

                           }
        }

        }

        dataTask.resume()
        

        
        
        
    
        
        
        
        
        
        
    }
    
   
    
}
