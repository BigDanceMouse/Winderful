//
//  CoordinatesURLHandler.swift
//  Winderful
//
//  Created by Владимир Елизаров on 05.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGFloat

struct CoordinatesStrategy: URLHandlerStrategy {
    
    func handle(url: URL, appManager: ApplicationManager) -> Bool {
        guard let coordinates = extractCoordinates(fromURL: url) else {
            return false
        }
        appManager.weatherModuleInput?.updateLocation(coordinates)
        return true
    }
    
    
    // MARK: - Private
    
    private let formatter = NumberFormatter()

    private func extractCoordinates(fromURL url: URL) -> Coordinates? {
        guard isURLValid(url)
            , let (srcLatitude, srcLongitude) = srcCoordinats(fromURL: url)
            , let latitude = cgFloat(fromString: srcLatitude)
            , let longitude = cgFloat(fromString: srcLongitude) else {
            return nil
        }
        return Coordinates(x: latitude, y: longitude)
    }

    private func isURLValid(_ url: URL) -> Bool {
        
        return url.scheme == SharedProperties.appURLScheme
            && url.host == SharedProperties.locationHost
    }

    private func srcCoordinats(fromURL url: URL) -> (String, String)? {
        guard let query = url.query else {
            return nil
        }
        let srcCoordinates = query.components(separatedBy: "&")
        guard srcCoordinates.count == 2 else {
            return nil
        }
        return (srcCoordinates[0], srcCoordinates[1])
    }

    private func cgFloat(fromString srcString: String) -> CGFloat? {
        if let extractedNumber = formatter.number(from: srcString) {
            return CGFloat(truncating: extractedNumber)
        }
        return nil
    }

}
