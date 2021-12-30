//
//  UserLocViewModel.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation
import CoreLocation
import MapKit


class UserLocViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var userLocation: UserLocation?
    private var locationManager = CLLocationManager()
    var authStatut: CLAuthorizationStatus?
    @Published var showLocation = true
    var geo = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        updateLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else {return}
        convertCoords(location: last)
    }
    
    func updateLocation () {
        showLocation ? locationManager.startUpdatingLocation() : locationManager.stopUpdatingLocation()
    }

    func toggleLocation() {
        showLocation.toggle()
        updateLocation()
    }
    
    func convertCoords(location: CLLocation) {
        geo.reverseGeocodeLocation(location, completionHandler: geoCompletion(result:error:))
    }
    
    func convertAdress(adress: String) {
        showLocation = false
        locationManager.stopUpdatingLocation()
        geo.geocodeAddressString(adress, completionHandler: geoCompletion(result:error:))
    }
    
    func geoCompletion(result: [CLPlacemark]?, error: Error?) {
        guard let first = result?.first else {return}
        let coord = first.location?.coordinate
        let lat = coord?.latitude ?? 0
        let long = coord?.longitude ?? 0
        let city = first.locality ?? ""
        let country = first.country ?? ""
        
        let newUserLoc = UserLocation(lat: lat,
                                      long: long,
                                      city: city,
                                      country: country)
        self.userLocation = newUserLoc
    }
    
    func setRegion(user: UserLocation) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: user.lat , longitude: user.long)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        return MKCoordinateRegion(center: center, span: span)
    }
//.
}
