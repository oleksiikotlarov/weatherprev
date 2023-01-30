//
//  Viewmodel.swift
//  weatherprev
//
//  Created by Алексей  on 29.11.2022.
//

import Foundation
import SwiftUI

class WeatherManager {
    var name: String = "New York"
    var temp: Double = 24
    var icon: String = "cloud.sun.rain.fill"
    var description: String = "_"
    @State  var refreshDone = false
    var places: PlacesWeather
   // @State private var locations = ["Paris", "Madrid", "London"]
    @State var locations = Locations()
    
    func fetchWeather(name: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=141ceea67617929ede8b5ff96f88d1a8&units=metric")
                
        else {
            print("weather fault")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.sync  {
                    
                    self.name = model.name
                    self.temp = model.main.temp
                    self.icon = iconMap[model.weather.first?.iconName ?? ""] ?? defaultIcon
                    self.description = model.weather.description
                    
                    
                    
                    let encoder = JSONEncoder()
                    let item = Place(name: self.name, temp: self.temp, icon: self.icon)
                    
                    if let data = try? encoder.encode(item) {
                        UserDefaults.standard.set(data, forKey: "SavedPlace")
                    }
                    
                    places.items.append(item)
                    
                }
            } catch {
                print("Failed to do it\(name)")
            }
        }
        task.resume()
        print("success weather")
        
        
        
        
    }
    
    func refresh() {
        locations.items.forEach { location in
            fetchWeather(name: location.name)
        }
        
    }
    

    func clear() {
        print("Cleared \(places.items.count)")
        places.items.removeAll()
        
        print("Now there \(places.items.count)")
    }
    
    init() {
        
        places.self = PlacesWeather()
        locations.self = Locations()
        
        refresh()

        print("A1\(locations.items)")
        
    }
    
}

struct WeatherModel: Codable {
    
    
    let weather: [WeatherResponse]
    let main: MainResponse
    let name: String
    
    
    struct WeatherResponse: Codable {
        let description: String
        let iconName: String
        
        enum CodingKeys: String, CodingKey {
            case description
            case iconName = "main"
        }
    }
    
    struct MainResponse: Codable {
        let temp: Double
        
    }
    
    
}




private let defaultIcon = "cloud"
private let iconMap = [
    "Drizzle" : "cloud.drizzle.fill",
    "Thunderstorm" : "cloud.bolt.rain.fill",
    "Rain": "cloud.rain.fill",
    "Snow": "cloud.snow",
    "Clear": "sun.max.fill",
    "Clouds" : "cloud.fill",
]



class PlacesWeather: ObservableObject {
    @Published var items = [Place]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "SavedPlace")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "SavedPlace") {
            if let decodedItems = try? JSONDecoder().decode([Place].self, from: savedItems) {
                items = decodedItems
                print(items)
                return
            }
        }
        
        items = []
    }
}

struct Place: Codable, Identifiable {
    var id = UUID()
    let name: String
    let temp: Double
    let icon: String
    
    
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.1f", self)
    }
}





