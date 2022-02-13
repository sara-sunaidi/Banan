//
//  StartScreenViewController.swift
//  Banan
//
//  Created by Reema khalaf on 08/07/1443 AH.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func StartAsVisitor(_ sender: Any) {
    }
    
    @IBAction func SignUp1(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp1" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)
    }
    
    @IBAction func SignIn(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
