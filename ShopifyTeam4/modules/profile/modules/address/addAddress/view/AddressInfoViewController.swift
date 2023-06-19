//
//  AddressInfoViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 19/06/2023.
//
import UIKit
import MapKit
import CoreLocation

class AddressInfoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var prevLoc: CLLocation?
    var locationManager: CLLocationManager?
    var delegate : AddAddressProtocol!
    var country =  "unknown"
    var city = "unknown"
    var street = "unknown"
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            locationManager?.startUpdatingLocation()
        case .denied, .restricted:
            print("Please authorize access to location.")
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newLoc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        if prevLoc == nil || prevLoc!.distance(from: newLoc) > 100 {
            getLocationInfo(location: newLoc)
        }
    }
    
    func getLocationInfo(location: CLLocation) {
        prevLoc = location
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first, error == nil else  { return }
            self.country = place.country ?? "unknown"
            self.city = place.administrativeArea ?? "unknown"
            self.street = place.name ?? "unknown"
            self.locationLabel.text = "\(self.country) - \(self.city) - \(self.street)"
        }
    }
    @IBAction func addAddress(_ sender: UIButton) {
        delegate.setAddress(country: country, city: city, street: street)
        self.dismiss(animated: true)
    }
}
