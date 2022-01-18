//
//  InfoClimatParis.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 12/12/2021.
//

import Foundation

struct Temperature: Decodable {
    let at2m: Double
    // converting Kelvin temperature to Celsius with a String output:
    var celsius: String {
        let input = Measurement(value: at2m, unit: UnitTemperature.kelvin)
        return input.converted(to: .celsius).formatted()
    }
    
    enum CodingKeys: String, CodingKey {
            case at2M = "2m"
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        at2m = try container.decode(Double.self, forKey: CodingKeys.at2M)
    }
}

struct Nebulosite: Decodable {
    let totale: Int
}

struct Forecast: Decodable {
    let temperature: Temperature
    let pluie: Double
    let nebulosite: Nebulosite
    
    // compute emoji icon to display as a function of forecast data:
    var icon: String {
        switch pluie {
        case ...0.0:
            switch nebulosite.totale{
            case ...20: return "☀️"
            case ...35: return "🌤"
            case ...50: return "⛅️"
            case ...65: return "🌥"
            default: return "☁️"
            }
        case ...1.0:
            switch nebulosite.totale {
            case ...20: return "🌦"
            case ...35: return "🌨"
            default: return "🌧"
            }
        default:
            return "💦"
        }
    }
    
    var pluieString: String {
        String(self.pluie)+" mm"
    }

    // 1
    // Define forecast date
    let forecastTimeStamp: String
    
    var shortTime: String {
        let input = forecastTimeStamp
        let formatter = DateFormatter()
        //formatter.locale = Locale(identifier: "fr_FR")
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: input) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "H'h'"
            return formatter.string(from: date)
        }
        return "error when parsing date/time"
    }
    
    // 2
    // Define coding key for decoding use
    enum CodingKeys: CodingKey {
        case temperature
        case pluie
        case nebulosite
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3
        // Decode firstName & lastName
        temperature = try container.decode(Temperature.self, forKey: CodingKeys.temperature)
        pluie = try container.decode(Double.self, forKey: CodingKeys.pluie)
        nebulosite = try container.decode(Nebulosite.self, forKey: CodingKeys.nebulosite)
        
        // 4
        // Extract studentId from coding path
        forecastTimeStamp = container.codingPath.first!.stringValue
    }
}

struct InfoClimatResponse: Decodable {
    

    var request_state: Int = 0
    var request_key: String = ""
    var message: String = ""
    var model_run: String = ""
    var source: String = ""
    let forecasts: [Forecast]
    
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {
        
        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempArray = [Forecast]()
        
        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {
            
            switch key.stringValue {
            case "request_state":
                self.request_state = try container.decode(Int.self, forKey: key)
            case "request_key":
                self.request_key = try container.decode(String.self, forKey: key)
            case "message":
                self.message = try container.decode(String.self, forKey: key)
            case "model_run":
                self.model_run = try container.decode(String.self, forKey: key)
            case "source":
                self.source = try container.decode(String.self, forKey: key)
            default:
                // Decode Student using key & keep decoded Student object in tempArray
                let decodedObject = try container.decode(Forecast.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                tempArray.append(decodedObject)
                
            }

        }
        
        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        forecasts = tempArray
    }
}
