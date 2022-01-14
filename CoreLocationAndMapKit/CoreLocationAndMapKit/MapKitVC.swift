//
//  ViewController.swift
//  CoreLocationAndMapKit
//
//  Created by Ahmet Engin Gökçe on 13.01.2022.
//

import UIKit
import MapKit

class MapKitVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionSize: Double = 12000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationControl()
    }
 
    func locationControl() {
        //Check the permission given by the user
        if CLLocationManager.locationServicesEnabled() {
            //konum servisi açılmış demektir
            setLocationManager()
            permissionControl()
        } else { }
    }
    
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func permissionControl() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            showLocation()
        case .denied: alert(title: "Permission Denied", message: "You need to give permission to use location service.")
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted: alert(title: "Permission Restricted", message: "You need to give permission to use location service.")
        @unknown default:
            fatalError()
        }
    }
    
    func showLocation() {
        if let currentLocation = locationManager.location?.coordinate {
            let region =  MKCoordinateRegion.init(center: currentLocation, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapKitVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Konum güncellenirse tetiklenir
        guard let lastLocation = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //If user changes permission granted to location
        permissionControl()
    }
}

extension MapKitVC {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionSettings = UIAlertAction(title: "Settings", style: .default) { goToSettings in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, completionHandler: nil)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionSettings)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
