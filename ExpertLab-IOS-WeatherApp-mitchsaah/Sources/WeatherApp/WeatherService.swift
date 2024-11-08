import Foundation
import Alamofire

// Data Models for JSON Response
struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}

class WeatherService {
    private let apiKey = "e44c5b1dfd503e307697d439de360179"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    // A construction method for the URL
    func makeRequestURL(for city: String) -> URL? {
            var components = URLComponents(string: baseURL)
            components?.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            return components?.url
        }
    
    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        // URL
        guard let url = makeRequestURL(for: city) else {
            completion(nil)
            return
        }
        
        // API call w/ Alamofire
        AF.request(url).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                // Completion handler (passed from decoded object)
                completion(weatherResponse)
            case .failure:
                // Error handling
                completion(nil)
            }
        }
    }
}

