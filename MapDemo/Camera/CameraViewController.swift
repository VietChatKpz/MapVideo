//
//  CameraViewController.swift
//  MapDemo
//
//  Created by Nguyễn Đình Việt on 21/06/2022.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController, UINavigationControllerDelegate {
    
    let cameraController = CameraController()
    
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var clickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCameraController()
    }
    
    func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.viewCamera)
        }
    }
    
    @IBAction func cameraOnPress(_ sender: UIButton) {
        do {
            try cameraController.switchCameras()
        }
        
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            return
            
        case .some(.rear):
            return
            
        case .none:
            return
        }
    }
    @IBAction func flashOnPress(_ sender: UIButton) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            
        }
        
        else {
            cameraController.flashMode = .on
        }
    }
    @IBAction func cameraPress(_ sender: UIButton) {
        self.cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            let alert = UIAlertController(title: "Thông báo", message: "Bạn có muốn lưu ảnh vào Photos?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                try? PHPhotoLibrary.shared().performChangesAndWait {
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
}

