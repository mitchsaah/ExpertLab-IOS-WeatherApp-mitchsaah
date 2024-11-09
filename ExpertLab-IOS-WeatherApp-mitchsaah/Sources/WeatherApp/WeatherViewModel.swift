import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "Enter a City"
    @Published var temperature: String = "--°C"
    @Published var description: String = "Weather data will appear here"
    
    private let weatherService = WeatherService()
}
