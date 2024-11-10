import SwiftUI

struct ContentView: View {
    @State private var cityInput: String = ""
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // Updated Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.7), Color.teal]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)  // Covers the entire screen
                
            VStack(spacing: 20) {
                // App Title
                Text("SkyWise")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Input field
                TextField("Enter a city name", text: $cityInput)
                    .padding()
                    .background(Color(.systemGray6).opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)

                // Weather Button
                Button(action: {
                    viewModel.fetchWeather(for: cityInput) {success in
                        if success {
                            cityInput = ""
                        }
                    }
                }) {
                    Text("Show Weather Details")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 29 / 255, green: 185 / 255, blue: 84 / 255))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }

                // Weather Information
                VStack(spacing: 10) {
                    Text(viewModel.cityName)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                    Text(viewModel.temperature)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)

                    Text(viewModel.description)
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.15))
                .cornerRadius(15)
                .padding(.horizontal, 40)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                Spacer()  // Pushes content up a bit
            }
        }
    }
}
