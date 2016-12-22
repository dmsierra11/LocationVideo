//
//  VideoPlayerViewController.swift
//  LocationVideoUPM
//
//  Created by Daniel Sierra  F on 12/21/16.
//  Copyright © 2016 danieluchin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController {
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    var playerViewController: AVPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

//        documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsPath.path)
        
        // Carga la lista de archivos del directorio documentos
        let fm = FileManager.default
        let allfiles = try? fm.contentsOfDirectory(atPath: documentsPath.path)
        print(allfiles!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(documentsPath.path+"/The_Arena_Lindsey_Stirling_4MCjU_Du3eI_18.mp4")
        playVideo(uri: documentsPath.path+"/The_Arena_Lindsey_Stirling_4MCjU_Du3eI_18.mp4")
    }
    
    @IBAction func play(_ sender: UIButton) {
        playVideo(uri: documentsPath.path+"/The_Arena_Lindsey_Stirling_4MCjU_Du3eI_18.mp4")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func playVideo (uri: String) {
        self.playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true) {
            let videoURL = URL(string: uri)
            self.playerViewController.player = AVPlayer(url:videoURL!)
            self.playerViewController.player?.play()
        }
    }

}
