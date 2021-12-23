//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }

    // For the search button
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // To collapse the keyboard
        print(searchTextField.text!)
        // searchTextField.text = ""
    }
    
    // For the keyboard return/go button
    // This function's definititon is present inside UITextFieldDelegate protocol and is called inside UITextField class
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) // To collapse the keyboard
        print(searchTextField.text!)
        // searchTextField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // It is useful to do some validation on the data
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter a city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // It is used to reduce the amount of redundant data
        
        // Use searchTextField.text to get the weather  for that city.
        searchTextField.text = ""
    }
}

