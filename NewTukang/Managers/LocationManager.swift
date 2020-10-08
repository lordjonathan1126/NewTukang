//
//  LocationManager.swift
//  NewTukang
//
//  Created by Jonathan Ng on 10/8/20.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  let objectWillChange = PassthroughSubject<Void, Never>()

  @Published var status: CLAuthorizationStatus? {
    willSet { objectWillChange.send() }
  }

  @Published var location: CLLocation? {
    willSet { objectWillChange.send() }
  }

  override init() {
    super.init()

    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
