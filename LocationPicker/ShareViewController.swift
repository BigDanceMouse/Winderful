//
//  ShareViewController.swift
//  LocationPicker
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import UIKit
import Social
import MapKit

class ShareViewController: SLComposeServiceViewController {
    
    private struct Constants {
        static let mapItemType = "com.apple.mapkit.map-item"
    }

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {
        requestMapItemIfPossible()
    }
    
    private func requestMapItemIfPossible() {
        
        guard let item = extensionContext?.inputItems.first as? NSExtensionItem
            , let mapItemAttachment = item.attachments?.first(where: isApropriateProvider) else {
                completeShareAction()
                return
        }
        mapItemAttachment.loadObject(ofClass: MKMapItem.self, completionHandler: { responseItem, error in
            self.handleItemResponse(responseItem)
        })
    }

    override func configurationItems() -> [Any]! {
        return []
    }

    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }
    
    
    // MARK: - Private
    
    private func completeShareAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func handleItemResponse(_ response: NSItemProviderReading?) {
        
        defer {
            completeShareAction()
        }
        
        guard let maybeURL = coordinates(from: response)
            .map(coordinatsChangeURLString)
            .map(URL.init(string:))
            , let url = maybeURL else {
                return
        }
        _ = openURL(url)
    }
    
    private func coordinates(from responseItem: NSItemProviderReading?) -> CLLocationCoordinate2D? {
        
        guard let mapItem = responseItem as? MKMapItem else {
            return nil
        }
        return mapItem.placemark.coordinate
    }
    
    private func coordinatsChangeURLString(for coordinates: CLLocationCoordinate2D) -> String {
        return SharedProperties.appURLScheme
            + "://"
            + SharedProperties.locationHost
            + "?"
            + "\(coordinates.latitude)&\(coordinates.longitude)"
    }
    
    private func isApropriateProvider(_ provider: NSItemProvider) -> Bool {
        provider.hasItemConformingToTypeIdentifier(Constants.mapItemType)
            && provider.canLoadObject(ofClass: MKMapItem.self)
    }
}

