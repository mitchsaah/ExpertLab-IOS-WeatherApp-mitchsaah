import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "Enter a City"
    @Published var temperature: String = "--°C"
    @Published var description: String = "Weather data will appear here"
    
    private let weatherService = WeatherService()
    
    func fetchWeather(for city: String, completion: @escaping (Bool) -> Void) {
        weatherService.fetchWeather(for: city) { [weak self] response in
            guard let response = response else {
                DispatchQueue.main.async {
                    self?.cityName = "Error"
                    self?.temperature = "--"
                    self?.description = "Could not load weather data"
                    completion(false)
                }
                return
            }

            // Updates the properties on the main thread with the fetched data
            DispatchQueue.main.async {
                self?.cityName = response.name
                self?.temperature = "\(response.main.temp)°C"
                self?.description = response.weather.first?.description.capitalized ?? ""
                completion(true)
            }
        }
    }
}
