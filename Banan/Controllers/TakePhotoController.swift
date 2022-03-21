//
//  ViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import UIKit
import AVFoundation


class TakePhotoController: UIViewController,
UINavigationControllerDelegate, WordViewControllerDelegate
{
    func didCheckTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoController") as! TakePhotoController
                  self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    var session : AVCaptureSession?
    let output = AVCapturePhotoOutput()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(OpenCVWrapper.openCVVersionString())")
        checkCameraPermissions()
    }
    
    private func checkCameraPermissions(){
        
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
                device.focusMode = .continuousAutoFocus
                device.unlockForConfiguration()
              }
            do{
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
                session.startRunning()
                self.session = session
            } catch{
                print(error)
            }
        }
    }
    
    @objc private func didTapCheck(){
        let photoSettings = AVCapturePhotoSettings()
        // customize setting here
        
        output.capturePhoto(with: photoSettings, delegate: self)
        
    }

    @IBOutlet weak var photoButton: UIButton! {
        didSet {

        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        didTapCheck()

        
    }
    }


extension TakePhotoController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pic = storyboard.instantiateViewController(withIdentifier: "ProcessImageController") as! ProcessImageController
                   pic.source_image = image
        self.navigationController?.pushViewController(pic, animated: true)
              
    }
}
