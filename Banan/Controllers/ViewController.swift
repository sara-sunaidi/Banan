//
//  ViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var photoButton: UIButton!{
        didSet{
            photoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //hello
        //perfect!
        print("\(OpenCVWrapper.openCVVersionString())")

    }

    @IBAction func takePhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeImage as String]

        //picker.mediaTypes =
        //[kCIAttributeTypeImage as String]
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    //user cancel?
    // user hit cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true)
    }
    
    
    //user takes photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage?){
            picker.presentingViewController?.dismiss(animated: true)
            //
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pic = storyboard.instantiateViewController(withIdentifier: "ProcessImageController") as! ProcessImageController
            pic.source_image = image
            self.navigationController?.pushViewController(pic, animated: true)
            //
            //self.performSegue(withIdentifier: "goToProcessImage", sender: self)
            
            //let processImageCV = ProcessImageController()

            //processImageCV.source_image = image
            //self.present(processImageCV, animated: true, completion: nil)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let pic = storyboard.instantiateViewController(withIdentifier: "ProcessImageController") as! ProcessImageController
//            pic.source_image = image
            //self.navigationController?.pushViewController(processImageCV, animated: true)
            
        }
        
    }
    
//    // method performs before any transition (before moving to the next page)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToProcessImage"{
//            let picVC = segue.destination as! ProcessImageController
//            if let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage?){
//               // picker.presentingViewController?.dismiss(animated: true)
//
//                //self.performSegue(withIdentifier: "goToProcessImage", sender: self)
//            }
//            //            destinationVC.bmiValue = calculaterBrain.getBMIVal()
////            destinationVC.advice = calculaterBrain.getAdvice()
////            destinationVC.color = calculaterBrain.getColor()
//           // picVC.source_image = image
//        }
//    }
}

