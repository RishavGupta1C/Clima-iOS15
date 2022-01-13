//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self  // for WeatherManagerDelegate
        searchTextField.delegate = self // for UITextField Delegate
    }

    // For the search button
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // To collapse the keyboard
//        print(searchTextField.text!)
        // searchTextField.text = ""
    }
    
    // For the keyboard return/go button
    // This function's definititon is present inside UITextFieldDelegate protocol and is called inside UITextField class
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) // To collapse the keyboard
//        print(searchTextField.text!)
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
        
        // Use searchTextField.text to get the weather for that city.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
//        weatherManager.fetchWeather(cityName: searchTextField.text!)
        searchTextField.text = ""
    }

// By convention, we always have identity of the object that caused this delegate method in the delegate method
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Dispatch the call to update the label text to the main thread
        DispatchQueue.main.async { // since it is a closure we have to add self
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

