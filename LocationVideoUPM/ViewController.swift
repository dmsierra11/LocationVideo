//
//  ViewController.swift
//  LocationVideoUPM
//
//  Created by Daniel Sierra  F on 12/21/16.
//  Copyright © 2016 danieluchin. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import AVKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let coordinateEtsisi = CLLocation(latitude: 40.389776, longitude: -3.6305987)

    var locationManager:CLLocationManager!
    
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var radius: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsPath.path)
        
        // Carga la lista de archivos del directorio documentos
        let fm = FileManager.default
        let allfiles = try? fm.contentsOfDirectory(atPath: documentsPath.path)
        print(allfiles!)
        
        let destination = segue.destination as!
            AVPlayerViewController
//        let videoPath = documentsPath.path+"/The_Arena_Lindsey_Stirling_4MCjU_Du3eI_18.mov"
//        print(videoPath)
//        let url = URL(string: videoPath)
//        print(url!)
        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        
        if let movieURL = url {
            destination.player = AVPlayer(url: movieURL)
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let coordinateCurrent = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let distanceInMeters = coordinateEtsisi.distance(from: coordinateCurrent)
        print("distance = \(distanceInMeters)")
        radius.text = String(distanceInMeters)
        
        
        if(distanceInMeters <= 100)
        {
            self.btnPlay.isHidden = false
        }
        else
        {
            self.btnPlay.isHidden = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}

