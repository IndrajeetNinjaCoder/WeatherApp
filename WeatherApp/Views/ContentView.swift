//
//  ContentView.swift
//  WeatherApp
//
//  Created by test on 30/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var city: String = ""
    
    @AppStorage("city") var storedCity: String = "Delhi"
    
    var body: some View {
        ZStack {
            
//            LinearGradient(
//                gradient: Gradient(colors: [Color("LightBlue"), .blue]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//                .ignoresSafeArea()
            
            
            Image("bg1")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                SearchView(viewModel: viewModel, city: $city)
                
                Spacer()
                
                TempView(viewModel: viewModel)
                
                Spacer()
                
                BottomView(viewModel: viewModel)
                
                Spacer()
                
            }
            .foregroundColor(.white)
            .padding()
            .task {
                await viewModel.getData(city: storedCity)
            }
        }
        
        
    }
}


struct SearchView: View {
    
    @StateObject var viewModel: ViewModel
    
    @Binding var city: String
    @AppStorage("city") var storedCity: String = ""
   
    var body: some View {
        VStack {
            HStack{
                TextField("City", text: $city)
                
                
                Button {
                    Task {
                        await viewModel.getData(city: city)
                        storedCity = city
                        city = ""
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(10)
            .background(.cyan)
            .cornerRadius(10)
            .shadow(color: .black, radius: 10, x: 0, y: 10)
        }
    }
}
    
struct TempView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack {
            
            Text(viewModel.WeatherData?.name ?? "")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
            
            Text(String(format: "%.0f °C", viewModel.WeatherData?.main.temp ?? 0.0))
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            
            Text(viewModel.WeatherData?.weather[0].main ?? "")
                .foregroundColor(.white)
                .font(.title2)
            
            
        }
        .padding(.top, 30)
        .shadow(color: .black, radius: 10, x: 0, y: 10)
        
    }
}

struct BottomView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack {
            HStack(spacing: 40){
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "thermometer.low")
                            .renderingMode(.original)
                        
                        Text(String(format: "%.0f °C", viewModel.WeatherData?.main.temp_min ?? 0.0))
                            .font(.headline)
                    }
                    Text("Min temp")
                }
                .padding(.vertical)
                
                
                
                
                VStack {
                    HStack {
                        Image(systemName: "thermometer.high")
                            .renderingMode(.original)
                        
                        Text(String(format: "%.0f °C", viewModel.WeatherData?.main.temp_max ?? 0.0))
                            .font(.headline)
                    }
                    Text("Max temp")
                }
                
                VStack {
                    Text(String(format: "%.0f °C", viewModel.WeatherData?.main.feels_like ?? 0.0))
                        .font(.headline)
                    Text("Feels like")
                }
                
            }
            .padding()
            .shadow(color: .black, radius: 10, x: 0, y: 10)
         
            
            HStack(spacing: 40){
                
                
                VStack {
                    
                    HStack {
                        
                        Image(systemName: "humidity.fill")
                            .renderingMode(.original)
                        
                        Text("\(viewModel.WeatherData?.main.humidity ?? 0)")
                            .font(.headline)
                        
                    }
                    
                    Text("Humidity")
                }
                
                VStack {
                    HStack {
                        
                        Image(systemName: "wind")
                            .renderingMode(.original)
                        
                        Text(String(format: "%.2f", viewModel.WeatherData?.wind.speed ?? 0.0))
                            .font(.headline)
                    }
                    Text("Wind Speed")
                }
                
                VStack {
                        Text("\(viewModel.WeatherData?.main.pressure ?? 0)")
                            .font(.headline)
                    
                    Text("Pressure")
                }
                
            }
            .padding()
            .shadow(color: .black, radius: 10, x: 0, y: 10)
            
        }
    }
}


#Preview {
    ContentView()
}


