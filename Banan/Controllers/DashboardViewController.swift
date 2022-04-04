//
//  DashboardViewController.swift
//  Banan
//
//  Created by Madawi Ahmed on 02/09/1443 AH.
//

import UIKit
import SwiftUI

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBSegueAction func uplaodList(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: BoardList())
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
