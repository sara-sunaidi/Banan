//
//  DashboardViewController.swift
//  Banan
//
//  Created by Noura  on 11/09/1443 AH.
//

import UIKit
import SwiftUI

class DashboardViewController: UIViewController {

    @IBOutlet weak var totalLevels: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    
    //get child object
   func getChild(){
        let child = LocalStorage.childValue
        if child != nil{
            gameInfo(child: child!)
            
        }
    }
    
    func gameInfo(child: Child){
        
        let allPoints = child.GameLevels.map({Int($0["UserPoints"]!)!}).reduce(0, +)
        self.totalPoints.text = "\(allPoints)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        let allLevels = child.GameLevels.map({ $0["Level"] })
        self.totalLevels.text = "\(allLevels.count)".convertedDigitsToLocale(Locale(identifier: "AR"))

        
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChild()
    }
    
    @IBSegueAction func uplaodList(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: BoardList())
    }
    
    @IBAction func pressBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
