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
        cameraEngine.startSession()
    }
    
    override func viewDidLayoutSubviews() {
        if let layer = self.cameraEngine.previewLayer {
            layer.frame = cameraView.bounds
            cameraView.layer.insertSublayer(layer, at: 0)
            cameraView.layer.masksToBounds = true
        }
        
    }
    
    
    func crop(image: UIImage, ratio: CGFloat) -> UIImage? {
        
        let cropHeight = image.size.width * ratio
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: image.size.width, height: cropHeight) , false, image.scale)
        image.draw(at: CGPoint(x: 0, y: -(image.size.height / 2 - cropHeight / 2)))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
    
    
    
    @IBAction func shootButtonTapped(_ sender: Any) {
        cameraEngine.capturePhoto { [weak self] (image , error) -> (Void) in
            
            guard let strongSelf = self else { return }
            
            guard let image = image else {
                // TODO: Capture Fail
                return
            }
            
            guard let croppedImage = strongSelf.crop(image: image, ratio: 9.0 / 16.0) else {
                // TODO: Crop Fail
                return
            }

                
            CameraEngineFileManager.savePhoto(croppedImage, blockCompletion: { [weak self] (success, error) -> (Void) in
                if success {
                    let alertController =  UIAlertController(title: "Success, image saved !", message: nil, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self?.present(alertController, animated: true, completion: nil)
                }
            })
            
            

                
                
                // Test Preview
                
//                let previewView = UIViewController()
//                self.present(previewView, animated: true, completion: nil)
//                
//                let imagePreviewView = UIImageView(frame: previewView.view.frame)
//                previewView.view.addSubview(imagePreviewView)
//                
//                imagePreviewView.image = testCrop()
//                imagePreviewView.contentMode = .scaleAspectFit
            

        }
    }
}

