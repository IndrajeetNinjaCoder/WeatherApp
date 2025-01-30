//
//  ViewModel.swift
//  WeatherApp
//
//  Created by test on 30/01/25.
//

import Foundation

// url: "https://api.openweathermap.org/data/2.5/weather?q=delhi&appid=1b40a6dc6666b5b9f884b3173846e31a&units=metric"

/* url: "https://api.openweathermap.org/data/2.5/weather?q={city}&appid=1b40a6dc6666b5b9f884b3173846e31a&units=metric"
 */

/*
 JSONDecoder().decode()
 JSONDecoder -> it is a class in swift which provides the method to decode the json data to required format
 decode() -> it is a method of JSONDecoder used to actually decode the json data to required format
 
 */

@MainActor
class ViewModel: ObservableObject {
    @Published var WeatherData: Model?
    
    
    func getData(city: String) async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=1b40a6dc6666b5b9f884b3173846e31a&units=metric") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url);
            if let decodedResponse = try? JSONDecoder().decode(Model.self, from: data){
                DispatchQueue.main.async {
                    
                    self.WeatherData = decodedResponse
                }
            }
            
            
            
        } catch {
            print("Invalid Response: \(error.localizedDescription)")
        }
    }
    
}
