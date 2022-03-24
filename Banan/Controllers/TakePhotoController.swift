//
//  ViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import UIKit
import AVFoundation
import CoreImage

var takePhotoVC = TakePhotoController()

class TakePhotoController: UIViewController,
                           UINavigationControllerDelegate
                         
{

   
    
    static let instance = TakePhotoController()
    
    var session : AVCaptureSession?
    var output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    var capturedImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        WordViewController.instance.delegate = self
        print("\(OpenCVWrapper.openCVVersionString())")
//        checkCameraPermissions()
    }
//    public func processAnswer() -> UIImage{
//        // we need to handle the camera permissions denied case later (it causes a run failure)
//        //        checkCameraPermissions()
//        viewDidLoad()
//        //        checkCameraPermissions()
//        //            didTapCheck()
//        takePhoto()
//        return capturedImage!
        
        
//    }
    
//    func didCheck() {
//        print("### In Did Check")
//        checkCameraPermissions()
//    }
//
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
            setUpCamera()
            
        case .denied:
            break
        @unknown default:
            break
        }
        
    }
    
    private func setUpCamera(){
        print("##### first lins in setupCamera")
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front){
            if device.isFocusModeSupported(.continuousAutoFocus) {
                // here
                try! device.lockForConfiguration()
//                device.focusMode = .continuousAutoFocus
                device.focusMode = .autoFocus
                device.exposureMode = .autoExpose
                device.unlockForConfiguration()
            }
            do{
                output = AVCapturePhotoOutput()
                let input = try AVCaptureDeviceInput(device: device)
                print("##### outside canAddInput")
                if session.canAddInput(input){
                    print("##### inside canAddInput")
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    print("##### inside addOutput")
                    session.addOutput(output)
                }
//                previewLayer.videoGravity = .resizeAspectFill
//                previewLayer.session = session
                session.startRunning()
                self.session = session
//                checkCameraPermissions()
                
            } catch{
                print(error)
            }
        }
    }
    
    @objc func didTapCheck(){
        let photoSettings = AVCapturePhotoSettings()
        
       
        
        output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    @IBOutlet weak var photoButton: UIButton! {
        didSet {
            
        }
    }
    
    @IBAction func takePhoto() {
        didTapCheck()
    }
    
    func processImage(_ img: UIImage) -> String{
        let croppedImg = OpenCVWrapper.detectFourCorner(img.normalized!)
        let result = OpenCVWrapper.detectRedShapes(in: croppedImg.normalized!)
//        OpenCVWrapper.detectRedShapes(in: croppedImg)
        return result
    }
//    @objc func didGetNotification(_ notification:Notification){
//        let image = notification.object as! UIImage?
//        imageView.image = image
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "sendPhotoToWord" {
//            let dvc = segue.destination as! WordViewController
//            dvc.newImage = capturedImage
//        }
//    }
    
    
}


extension TakePhotoController: AVCapturePhotoCaptureDelegate
{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        print("##### inside extension")
//        if device.isSilentModeOn {
                    AudioServicesDisposeSystemSoundID(1108)
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
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
           // dispose system shutter sound
           AudioServicesDisposeSystemSoundID(1108)
       }
    
    
}


