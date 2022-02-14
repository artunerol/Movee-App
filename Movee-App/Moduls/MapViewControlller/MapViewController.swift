//
//  MapViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 13.02.2022.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    // MARK: - Private outlets

    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Private properties
    let locationManager = CLLocationManager()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCLLocation()
    }

    // MARK: - Private funcs

    private func setupCLLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func render(_ location: CLLocation) {
        let center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )

        let span = MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
        )

        let region = MKCoordinateRegion(
            center: center,
            span: span
        )

        mapView.setRegion(region, animated: true)

        let pin = MKPointAnnotation()
        pin.coordinate = center
        mapView.addAnnotation(pin)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
}
