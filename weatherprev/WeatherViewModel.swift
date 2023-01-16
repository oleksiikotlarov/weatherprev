//
//  WeatherViewModel.swift
//  wetherprev
//
//  Created by Алексей  on 08.12.2022.
//

import Foundation
import CoreLocation

private let defaultIcon = "cloud"
private let iconMap = [
    "Drizzle" : "cloud.drizzle.fill",
    "Thunderstorm" : "cloud.bolt.rain.fill",
    "Rain": "cloud.rain.fill",
    "Snow": "cloud.snow",
    "Clear": "sun.max.fill",
    "Clouds" : "cloud.fill",
]

class WeatherViewModel: ObservableObject {
    @Published var name: String = "Your city"
    @Published var temp: Double = 0.0
    @Published var lat = 0.0
    @Published var lon = 0.0
    @Published var weatherDescription: String = "--"
    @Published var img: String = "cloud.sun.rain.fill"
    @Published var shouldShowLocationError: Bool = false
    @Published var min = 0.0
    @Published var max = 0.0
    @Published var feels = 0.0
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func refresh() {
        weatherService.loadWeatherData { weather, error in
            DispatchQueue.main.async {
                if let _ = error {
                    self.shouldShowLocationError = true
                    return
                }
                
                self.shouldShowLocationError = false
                guard let weather = weather else { return }
                self.name = weather.city
                self.temp = weather.temperature
                self.weatherDescription = weather.description.capitalized
                self.img = iconMap[weather.iconName] ?? defaultIcon
                self.min = weather.tempMin
                self.max = weather.tempMax
                self.feels = weather.tempFeel
            }
        }
    }
}


public final class WeatherService: NSObject {
    
    let locationManager = CLLocationManager()
    let API_KEY = "141ceea67617929ede8b5ff96f88d1a8"
    var completionHandler: ((Weather?, LocationAuthError?) -> Void)?
    var dataTask: URLSessionDataTask?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(
        _ completionHandler: @escaping((Weather?, LocationAuthError?) -> Void)
    ) {
        self.completionHandler = completionHandler
        loadDataOrRequestLocationAuth()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString =
                "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response), nil)
            }
        }
        dataTask?.resume()
    }
    
    private func loadDataOrRequestLocationAuth() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            completionHandler?(nil, LocationAuthError())
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        loadDataOrRequestLocationAuth()
    }
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
    let coord: APICoord
}

struct APICoord: Decodable {
    let lon: Double
    let lat: Double
}

struct APIMain: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}

public struct LocationAuthError: Error {}

public struct Weather {
    let city: String
    let temperature: Double
    let description: String
    let iconName: String
    let lon: Double
    let lat: Double
    let tempMin: Double
    let tempMax: Double
    let tempFeel: Double
    
    
    init(response: APIResponse) {
        city = response.name
        temperature = response.main.temp
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        lon = response.coord.lon
        lat = response.coord.lat
        tempMax = response.main.temp_max
        tempMin = response.main.temp_min
        tempFeel = response.main.feels_like
        
    }
}
