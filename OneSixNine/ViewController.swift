//
//  ViewController.swift
//  OneSixNine
//
//  Created by Ray on 03/01/2017.
//  Copyright © 2017 Ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var shootButton: UIButton!
    
    let cameraEngine = CameraEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cameraEngine.startSession()
        shootButton.clipsToBounds = true
        shootButton.layer.cornerRadius = 50
    }
    
    override func viewDidLayoutSubviews() {
        if let layer = self.cameraEngine.previewLayer {
            layer.frame = cameraView.bounds
            cameraView.layer.insertSublayer(layer, at: 0)
            cameraView.layer.masksToBounds = true
        }
        
    }
    
    @IBAction func shootButtonTapped(_ sender: Any) {
        self.cameraEngine.capturePhoto { (image , error) -> (Void) in
            if let image = image {
                
                CameraEngineFileManager.savePhoto(image, blockCompletion: { (success, error) -> (Void) in
                    if success {
                        let alertController =  UIAlertController(title: "Success, image saved !", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
        }
    }
}

