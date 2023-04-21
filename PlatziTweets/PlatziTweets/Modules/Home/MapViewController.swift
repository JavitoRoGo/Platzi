//
//  MapViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 20/3/23.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    // MARK: - IBOUTLES
    
    @IBOutlet weak var mapContainer: UIView!
    
    // MARK: - PROPERTIES
    
    var posts = [Post]()
    private var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
    }
    
    // MARK: - METHODS
    
    private func setupMap() {
        map = MKMapView(frame: mapContainer.bounds)
        
        mapContainer.addSubview(map ?? UIView())
        setupMarkers()
    }
    
    private func setupMarkers() {
        posts.forEach { item in
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
            marker.title = item.text
            marker.subtitle = item.author.names
            map?.addAnnotation(marker)
        }
        
        // Buscamos la ubicación del último post publicado (el primero de la lista) para centrar el mapa ahí
        guard let lastPost = posts.first else { return }
        let lastLocation = CLLocationCoordinate2D(latitude: lastPost.location.latitude, longitude: lastPost.location.longitude)
        guard let heading = CLLocationDirection(exactly: 12) else { return }
        map?.camera = MKMapCamera(lookingAtCenter: lastLocation, fromDistance: 100, pitch: .zero, heading: heading)
    }
}
