//
//  NetworkManager.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 10.08.23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getWeather(lat: CGFloat, long: CGFloat, completion: @escaping(WeatherEntity) -> ()) {
        guard let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=\(APIKeys.weatherAPIKey)&q=\(lat),\(long)&days=3&aqi=no&alerts=no") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherDTO.self, from: data)
                    DispatchQueue.main.async {
                        completion(WeatherEntity(from: weatherData))
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()
    }
}
