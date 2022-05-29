//
//  StartScreenViewController.swift
//  Banan
//
//  Created by Reema khalaf on 08/07/1443 AH.
//

import UIKit
//import XCTest

extension String {
    var underlined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}

class StartScreenViewController: UIViewController {

    @IBOutlet weak var SignIn: UIButton!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SignIn.currentTitle?.NSUnderlineStyle
        SignIn.setAttributedTitle("تسجيل الدخول".underlined, for: .normal)
        self.performSegue(withIdentifier: "GoToVisitorHomePage", sender: self)
      //  SignIn.titleLabel?.font = .systemFont(ofSize: 30)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func StartAsVisitor(_ sender: Any) {
        appdelegate.isChild = false
        self.performSegue(withIdentifier: "GoToVisitorHomePage", sender: self)
    }
    
    @IBAction func SignUp1(_ sender: UIButton) {
        appdelegate.isChild = true
        performSegue(withIdentifier: "StartToSignUp1", sender: self)

    }
    
    @IBAction func SignIn(_ sender: UIButton) {
        appdelegate.isChild = true
        performSegue(withIdentifier: "ToLogIn", sender: self)

    }

}
