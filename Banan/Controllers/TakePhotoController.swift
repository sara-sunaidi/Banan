//
//  ViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import UIKit
import AVFoundation
import CoreImage



let takePhotoVC = TakePhotoController()

class TakePhotoController: UIViewController,
                           UINavigationControllerDelegate
                         
{
    var session : AVCaptureSession?
    var output = AVCapturePhotoOutput()
   
    var capturedImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(OpenCVWrapper.openCVVersionString())")

    }

    func checkCameraPermissions(){
        
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .notDetermined:
            print("##### in notDetermined")
            // Request Access
            AVCaptureDevice.requestAccess(for: .video){
                [weak self] granted in guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
            
        case .restricted:
            break
            
        case .authorized:
            print("##### in authorized")
            self.setUpCamera()
            
        case .denied:
            break
        @unknown default:
            break
        }
        
    }
    
    private func setUpCamera(){
        
        print("- first lins in setupCamera")
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front){
            if device.isFocusModeSupported(.continuousAutoFocus) {
                // here
                try! device.lockForConfiguration()
//                device.focusMode = .continuousAutoFocus
                device.focusMode = .continuousAutoFocus
                device.exposureMode = .autoExpose
                device.unlockForConfiguration()
            }
            do{
                
                let input = try AVCaptureDeviceInput(device: device)
                print("- outside canAddInput")
                if session.canAddInput(input){
                    print("- inside canAddInput")
                    session.addInput(input)
                }
                output = AVCapturePhotoOutput()
                if session.canAddOutput(output){
                    print("- inside addOutput")
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                }

                session.startRunning()
                print("- session started")
                self.session = session
               
                
            } catch{
                print(error)
            }
        }
    }
    
    @objc func didTapCheck(){
        print("##### in didTapCheck")
        let photoSettings = AVCapturePhotoSettings()
//        photoSettings.flashMode = .on
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.isAutoStillImageStabilizationEnabled = true
        output.capturePhoto(with: photoSettings, delegate: self as AVCapturePhotoCaptureDelegate)
        print("##### in didTapCheck after output ")
    }
    
    func processImage(_ img: UIImage) -> String{
//        let croppedImg = OpenCVWrapper.detectFourCorner(img.normalized!)
//        let result = OpenCVWrapper.detectRedShapes(in: croppedImg.normalized!)
        let result = OpenCVWrapper.detectRedShapes(in: img.normalized!)
        return result
    }
    
    
}


extension TakePhotoController: AVCapturePhotoCaptureDelegate
{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        print("##### inside extension")
//        if device.isSilentModeOn {
//                    AudioServicesDisposeSystemSoundID(1108)
//                }
        guard let data = photo.fileDataRepresentation() else {
            print("##### inside extension guard")
            return
        }
        print("##### inside extension before image")
        let image = UIImage(data: data)
 
        session?.stopRunning()
        
        if (image != nil){
            print("##### image is NOT nil ")
//            capturedImage = image
//            self.performSegue(withIdentifier: "sendPhotoToWord", sender: self)
//            wordVC.setImage(image!)
//            NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("image"), object: nil)
           
            let result = processImage(image!)
            NotificationCenter.default.post(name: Notification.Name("result"), object: result)
            dismiss(animated: false)
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WordViewController")
//            if vc is WordViewController {
//                vc.newImage = image
//            }
//            vc.modalPresentationStyle = .overFullScreen
//            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "WordViewController" )as! WordViewController
//            vc.newImage = image
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated:  true)
        }else{
            print("##### image is NIL ")
        }
        
        
        
//        func getUIImage () ->UIImage{
//            return image!
//        }
        
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(identifier: "ProcessImageController" )as! ProcessImageController
//                vc.source_image = image
//                vc.modalPresentationStyle = .overFullScreen
//                self.present(vc, animated:  true)
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let pic = storyboard.instantiateViewController(withIdentifier: "ProcessImageController") as! ProcessImageController
        //        pic.source_image = image
        //        self.navigationController?.pushViewController(pic, animated: true)
        
    }
//    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
//           // dispose system shutter sound
//           AudioServicesDisposeSystemSoundID(1108)
//       }
    
    
}


