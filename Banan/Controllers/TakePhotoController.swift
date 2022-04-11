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
        photoSettings.flashMode = .on
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.isAutoStillImageStabilizationEnabled = true
        output.capturePhoto(with: photoSettings, delegate: self as AVCapturePhotoCaptureDelegate)
        print("##### in didTapCheck after output ")
    }
    
    func processImage(_ img: UIImage) -> String{
        
        let cornersResult = OpenCVWrapper.checkCorners(img.normalized!)
        print("- Corners result is \(cornersResult)")
        if (cornersResult == "true"){
            // corners are detected
            print("- inside corners detected if true")
            let croppedImg =  OpenCVWrapper.detectFourCorner(img.normalized!)
            let result = OpenCVWrapper.detectRedShapes(in: croppedImg.normalized!)
            let coordinatesResult = OpenCVWrapper.getCoordinatesStatus()
            print("- Coordinate result is \(coordinatesResult)")
            if (coordinatesResult == "true"){
                // return Braille result
                return result
            }else{
                // invalid coordinates
                print("- ivalid coordinates false")
                return result
            }
        } else {
            // corners are not detected
            print("- invalid corners false")
            return "failed"
        }

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
            let result = processImage(image!)
            NotificationCenter.default.post(name: Notification.Name("result"), object: result)
            dismiss(animated: false)
        }else{
            print("##### image is NIL ")
        }
    }
}


