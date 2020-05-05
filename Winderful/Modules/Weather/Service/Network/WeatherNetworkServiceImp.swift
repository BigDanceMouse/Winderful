//
//  WeatherNetworkServiceImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation


/*
 This struct must be just a wrapper for implementation of Moya (or similar) networking pattern,
 but during this demo app, I decided not to bring the third - party frameworks.
 In my opinion this is actually one of few places where one of the pod/carthage/spm framework is really necessary.
 
 It allows to hide the token inserting and describe requests with DCL.
 
 Entire WeatherNetworkServiceImp would be like follows:
 
 func requestWeather(for location: Coordinates, then completion: @escaping (WeatherResult) -> Void) {
     let request = Requests.getWeather(for: coordinates)
     self.provider.requestDecodable(WeatherForecast.self, target: request) { result in
        result
            .map { $0.currently }
            .mapError(WeatherModuleError.fromResponse)
            |>> completion
     }
 }
 
 that's all
 */


// MARK: -

struct WeatherNetworkServiceImp: WeatherNetworkService {
    
    private var token: String {
        "9a2a430241869be96095fd28bbd69506"
    }
    
    func requestWeather(for location: Coordinates, system: SystemOfUnits, then completion: @escaping (WeatherResult) -> Void) {
        guard let url = WeatherRequestURL(for: location, system: system, token: token) else {
            completion(.failure(.incorrectRequestParameters))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            let result = MapResponse(data: maybeData, error: maybeError)
            completion(result)
        }
        task.resume()
    }
}

private func WeatherRequestURL(for coordinates: Coordinates, system: SystemOfUnits, token: String) -> URL? {
    struct Constants {
        static let urlBasePart = "https://api.darksky.net/forecast"
    }
    
    let fullURLString = "\(Constants.urlBasePart)/\(token)/\(coordinates.x),\(coordinates.y)"
    return URL(string: fullURLString)
}

private func MapResponse(data: Data?, error: Error?) -> WeatherResult {
    if let error = error {
        return .failure(.responseError(error))
        
    } else if let data = data {
        return MapData(data)
        
    } else {
        return .failure(.networkTrouble)
    }
}

private func MapData(_ data: Data) -> WeatherResult {
    do {
        let decoder = JSONDecoder()
        let forecast = try decoder.decode(WeatherForecast.self, from: data)
        return .success(forecast.currently)
    } catch {
        return .failure(.responseError(error))
    }
}
