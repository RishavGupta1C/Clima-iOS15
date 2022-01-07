//
//  WeatherManager.swift
//  Clima
//
//  Created by Rishav Gupta on 25/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=aff032acfe3743859fbbf730d5714b0d&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString) // we don't have to write self.performRequest as swift is doing that under the hood
    }
    
    func performRequest(urlString: String) {
            //  4 steps of networking
            //  1. Create a URL
        if let url = URL(string: urlString) {   // if-let unwrapping as url is optional as url can be nil
            
            //  2. Create a URLSession
            let session = URLSession(configuration: .default)   // It is like browser. It's a thing that can perform networking
            
            //  3. Give the session a task
            
            //  Converting completionHandler to closure
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("The Error is \(error!)")
                    return
                }
                
                //  Passing the data to convert into swift object with properties and methods
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
                    self.parseJSON(weatherData: safeData)  //  Inside the closure we must add self if we are calling the method from the current class.
                }
            }
            //  Error Domain=NSURLErrorDomain Code=-1022 "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection." -> change http to https.
            
            //  When we want to execute some code after the completion of a lengthy task but we don't want to "poll" (to check status) the task continuously to check if it's finished, we use completionHandler.
            
            
            //  4. Start the task
            task.resume()
            //  The function called is resume as in case of tasks they can be suspended, and newly initialized tasks begin in a suspended state. So resume is used to start the task.
            
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.main.temp)
//            print(decodedData.main.humidity)
            let id = decodedData.weather[0].id
            print(getConditionName(weatherId: id))
        }
        catch {
            print(error)
        }
    }
    
//    func handle(data: Data?, response: URLResponse?, error: Error?) {
//        if error != nil {
//            print("The Error is \(error!)")
//            return
//        }
//
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString!)
//        }
//    }
    
    func getConditionName(weatherId: Int) -> String {
        switch(weatherId) {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...771:
            return "sun.dust"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "smoke"
        default:
            return "cloud"
        }
    }
}
