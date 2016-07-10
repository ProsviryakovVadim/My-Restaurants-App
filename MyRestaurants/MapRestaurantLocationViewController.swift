//
//  MapRestaurantLocationViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 06.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import MapKit

class MapRestaurantLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurants!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Delegate
        mapView.delegate = self
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location!, completionHandler: {                    (placemarks: [CLPlacemark]?, error: NSError?) in
           
            if error != nil {
            print(error)
                return
            }
            
            if let placemark = placemarks?[0] {
                let anotation = MKPointAnnotation()
                anotation.title = self.restaurant.name
                anotation.subtitle = self.restaurant.type
                anotation.coordinate = placemark.location!.coordinate
                
                self.mapView.showAnnotations([anotation], animated: true)
                self.mapView.selectAnnotation(anotation, animated: true)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Don't find user geolocation
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CurrentPin")
        if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CurrentPin")
        annotationView?.canShowCallout = true
        }
        
        let leftSideAnnotation = UIImageView(frame: CGRectMake(0, 0, 52, 52))
        leftSideAnnotation.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftSideAnnotation
        
        return annotationView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
