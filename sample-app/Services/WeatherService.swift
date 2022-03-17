//
//  WeatherService.swift
//  sample-app
//


import Foundation

class WeatherService {

    static let shared = WeatherService()

    private let endpoint = "https://api.weatherapi.com/v1/current.json?key=2417772cc9494d49933164220202511&q=%f,%f"


    func fetchWeather(coordinates: Coordinates) async -> Weather? {
        guard
            let url = URL(string: String(format: endpoint, coordinates.lat, coordinates.lon)),
            let (data, _) = try? await URLSession.shared.data(from: url)
        else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard
            let dictionary = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any],
            let current = dictionary["current"] as? [String: Any],
            let currentData = try? JSONSerialization.data(withJSONObject: current, options: .prettyPrinted),
            let weatherForecast = try? decoder.decode(WeatherForecast.self, from: currentData),
            let location = dictionary["location"] as? [String: Any],
            let locationData = try? JSONSerialization.data(withJSONObject: location, options: .prettyPrinted),
            let weatherLocation = try? decoder.decode(WeatherLocation.self, from: locationData)
        else {
            return nil
        }

        return Weather(forecast: weatherForecast, location: weatherLocation)
    }
}

struct Coordinates {
    let lat: Double
    let lon: Double
}

struct Weather: Codable {
    let forecast: WeatherForecast?
    let location: WeatherLocation?
}

struct WeatherLocation: Codable {
    let name: String?
    let localtimeEpoch: Date?
    let region: String?
}

struct WeatherForecast: Codable {
    let tempF: Double?
    let tempC: Double?
    let isDay: Int?
    let condition: WeatherCondition?
}

struct WeatherCondition: Codable {
    let code: Int?
    let icon: String?
    let text: String?
}
