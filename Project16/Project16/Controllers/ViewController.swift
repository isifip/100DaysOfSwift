//
//  ViewController.swift
//  Project16
//
//  Created by Irakli Sokhaneishvili on 12.02.22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let mapTypes = [
        "hybrid": MKMapType.hybrid,
        "hybridFlyOver": MKMapType.hybridFlyover,
        "mutedStandard": MKMapType.mutedStandard,
        "satellite": MKMapType.satellite,
        "satelliteFlyover": MKMapType.satelliteFlyover,
        "standard": MKMapType.standard
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", wikipediaUrl: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago", wikipediaUrl: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8546, longitude: 2.3508), info: "Often called the City of Light", wikipediaUrl: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it", wikipediaUrl: "https://en.wikipedia.org/wiki/Rome")
        
        mapView.addAnnotations([london, oslo, paris, rome])
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(selectType))
        
    }
    
    @objc func selectType() {
        let ac = UIAlertController(title: "Map type", message: nil, preferredStyle: .actionSheet)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        for mapType in mapTypes.keys.sorted(by: <) {
            ac.addAction(UIAlertAction(title: mapType, style: .default, handler: mapTypeSelected))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func mapTypeSelected(action: UIAlertAction) {
        guard let title = action.title else { return }
        if let type = mapTypes[title] {
            mapView.mapType = type
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
            
        }
        //annotationView?.tintColor = .blue
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
//    func openWikipedia(url: String) {
//        
//    }
    
}

