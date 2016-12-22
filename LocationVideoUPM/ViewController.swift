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

class ViewController: UIViewController {
    
    let coordinatesUPM = CLLocation(latitude: 40.389776, longitude: -3.6305987)

    var locationManager:CLLocationManager!
    
    var entered: Bool = false
    
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
        getCurrentLocation();
    }
    
    func playVideo(){
        performSegue(withIdentifier: "showVideoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        print(documentsPath.path)
        
        // Carga la lista de archivos del directorio documentos
//        let fm = FileManager.default
//        let allfiles = try? fm.contentsOfDirectory(atPath: documentsPath.path)
//        print(allfiles!)
        
        let destination = segue.destination as! AVPlayerViewController
//        let videoPath = documentsPath.path+"/The_Arena_Lindsey_Stirling_4MCjU_Du3eI_18.mov"
//        print(videoPath)
//        let url = URL(string: videoPath)
//        print(url!)
        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        
        if let movieURL = url {
            destination.player = AVPlayer(url: movieURL)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Video Available",
                                      message: "Video available in this area, click to play", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Play", style: .default, handler: { action -> Void in
            self.playVideo()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func getCurrentLocation() {
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
        
        let currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let radiusInMeters = coordinatesUPM.distance(from: currentLocation)
        radius.text = String(radiusInMeters)
        
        if(radiusInMeters <= 100 && !entered)
        {
//            self.btnPlay.isHidden = false
            entered = true
            showAlert()
        }
        else if (radiusInMeters > 100)
        {
            entered = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

