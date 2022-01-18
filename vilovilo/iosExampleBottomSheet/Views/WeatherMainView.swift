//
//  WeatherView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 06/12/2021.
//

import SwiftUI

struct WeatherMainView: View {
    
    @State private var forecasts = [Forecast]()
    
    @State private var date: Date? = nil
    
    var body: some View {
        VStack {
            
            List(forecasts, id: \.forecastTimeStamp){ forecast in
                GeometryReader{ proxy in
                    HStack{
                        Text(forecast.shortTime)
                            .font(.title2)
                            .frame(width: proxy.size.width*0.25)
                        
                        Spacer()
                        
                        Label(forecast.temperature.celsius, systemImage: "thermometer")
                            .font(.footnote)
                            .frame(width: proxy.size.width*0.25)
                        
                        Label(forecast.pluieString, systemImage: "drop")
                            .font(.footnote)
                            .frame(width: proxy.size.width*0.25)

                        Spacer()
                        
                        Text(forecast.icon)
                            .font(.title2)
                            .frame(width: proxy.size.width*0.2)
                            
                    }
                    .padding(5)
                }
            }
            .listStyle(.plain)
            .padding(.vertical)
            
            Text("InfoClimat actualisé le: " + (self.date?.description ?? ""))
                .font(.footnote)
        }
        .task{
            await loadWeatherData()
        }
    }
    
    func loadWeatherData() async {
        guard let url = URL(string: "https://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=BhxUQ1EvU3EEKQE2UyVReFE5DzpdK1VyBnpRMg1oBXgJYgNiBGRcOgdpVSgPIFFnAC1UN1phUGALYAtzDH4DYgZsVDhROlM0BGsBZFN8UXpRfw9uXX1VcgZsUTQNfgVnCWwDZQR5XD8HYFUwDyFRZwAzVCtaelBpC24LbwxoA2IGZlQ2UTtTMARvAXxTfFFjUWMPPV1mVT4GYFE1DWIFYAluA2QEZlw7B29VKQ82UWMAMVQ8WmNQbQtrC2UMfgN%2FBhxUQ1EvU3EEKQE2UyVReFE3DzFdNg%3D%3D&_c=21c7ffb3136d5e0458a3c0e88817c509")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(InfoClimatResponse.self, from: data){
                // sorting out Forecasts by forecast date:
                let tempForecasts = decodedResponse.forecasts.sorted(by: { $0.forecastTimeStamp < $1.forecastTimeStamp })
                // keeping only a subcollection of the N (=12) initial forecasts:
                self.forecasts = Array(tempForecasts.prefix(12))
                self.date = Date()
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct WeatherMainView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMainView()
    }
}
