//
//  WordViewController.swift
//  Banan
//
//  Created by Noura  on 15/08/1443 AH.
//

import Foundation
import UIKit
import SwiftUI

class WordViewController: UIViewController {
    
    @IBOutlet weak var cr1: UIButton!
    @IBOutlet weak var cr2: UIButton!
    @IBOutlet weak var cr3: UIButton!
    @IBOutlet weak var cr4: UIButton!
    @IBOutlet weak var cr5: UIButton!
    @IBOutlet weak var cr6: UIButton!
    @IBOutlet weak var cr11: UIButton!
    @IBOutlet weak var cr22: UIButton!
    @IBOutlet weak var cr33: UIButton!
    @IBOutlet weak var cr44: UIButton!
    @IBOutlet weak var cr55: UIButton!
    @IBOutlet weak var cr66: UIButton!
    @IBOutlet weak var cr111: UIButton!
    @IBOutlet weak var cr222: UIButton!
    @IBOutlet weak var cr333: UIButton!
    @IBOutlet weak var cr444: UIButton!
    @IBOutlet weak var cr555: UIButton!
    @IBOutlet weak var cr666: UIButton!
    @IBOutlet weak var cr1111: UIButton!
    @IBOutlet weak var cr2222: UIButton!
    @IBOutlet weak var cr3333: UIButton!
    @IBOutlet weak var cr4444: UIButton!
    @IBOutlet weak var cr5555: UIButton!
    @IBOutlet weak var cr6666: UIButton!
    @IBOutlet weak var cr11111: UIButton!
    @IBOutlet weak var cr22222: UIButton!
    @IBOutlet weak var cr33333: UIButton!
    @IBOutlet weak var cr44444: UIButton!
    @IBOutlet weak var cr55555: UIButton!
    @IBOutlet weak var cr66666: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideCircle()
        
        addShadow(cr1)
        addShadow(cr2)
        addShadow(cr3)
        addShadow(cr4)
        addShadow(cr5)
        addShadow(cr6)
        addShadow(cr11)
        addShadow(cr22)
        addShadow(cr33)
        addShadow(cr44)
        addShadow(cr55)
        addShadow(cr66)
        addShadow(cr111)
        addShadow(cr222)
        addShadow(cr333)
        addShadow(cr444)
        addShadow(cr555)
        addShadow(cr666)
        addShadow(cr1111)
        addShadow(cr2222)
        addShadow(cr3333)
        addShadow(cr4444)
        addShadow(cr5555)
        addShadow(cr6666)
        addShadow(cr11111)
        addShadow(cr22222)
        addShadow(cr33333)
        addShadow(cr44444)
        addShadow(cr55555)
        addShadow(cr66666)
        showCircle(3)
        
        addColor("101100")
        addColor("010111")
        addColor("101011")
    }
    
    // show circle
    func showCircle(_ num: Int){
        
        if(num == 3){
            cr11.isHidden = false
            cr22.isHidden = false
            cr33.isHidden = false
            cr44.isHidden = false
            cr55.isHidden = false
            cr66.isHidden = false
            
            cr111.isHidden = false
            cr222.isHidden = false
            cr333.isHidden = false
            cr444.isHidden = false
            cr555.isHidden = false
            cr666.isHidden = false
            
            cr1111.isHidden = false
            cr2222.isHidden = false
            cr3333.isHidden = false
            cr4444.isHidden = false
            cr5555.isHidden = false
            cr6666.isHidden = false
        }
        else if(num == 4){
            cr11.isHidden = false
            cr22.isHidden = false
            cr33.isHidden = false
            cr44.isHidden = false
            cr55.isHidden = false
            cr66.isHidden = false
            
            cr111.isHidden = false
            cr222.isHidden = false
            cr333.isHidden = false
            cr444.isHidden = false
            cr555.isHidden = false
            cr666.isHidden = false
            
            cr1111.isHidden = false
            cr2222.isHidden = false
            cr3333.isHidden = false
            cr4444.isHidden = false
            cr5555.isHidden = false
            cr6666.isHidden = false
            
            cr11111.isHidden = false
            cr22222.isHidden = false
            cr33333.isHidden = false
            cr44444.isHidden = false
            cr55555.isHidden = false
            cr66666.isHidden = false
        }
        else{
            cr1.isHidden = false
            cr2.isHidden = false
            cr3.isHidden = false
            cr4.isHidden = false
            cr5.isHidden = false
            cr6.isHidden = false
            
            cr11.isHidden = false
            cr22.isHidden = false
            cr33.isHidden = false
            cr44.isHidden = false
            cr55.isHidden = false
            cr66.isHidden = false
            
            cr111.isHidden = false
            cr222.isHidden = false
            cr333.isHidden = false
            cr444.isHidden = false
            cr555.isHidden = false
            cr666.isHidden = false
            
            cr1111.isHidden = false
            cr2222.isHidden = false
            cr3333.isHidden = false
            cr4444.isHidden = false
            cr5555.isHidden = false
            cr6666.isHidden = false
            
            cr11111.isHidden = false
            cr22222.isHidden = false
            cr33333.isHidden = false
            cr44444.isHidden = false
            cr55555.isHidden = false
            cr66666.isHidden = false
        }
        
    }
    
    // hide circle
    func hideCircle(){
        cr1.isHidden = true
        cr2.isHidden = true
        cr3.isHidden = true
        cr4.isHidden = true
        cr5.isHidden = true
        cr6.isHidden = true
        
        cr11.isHidden = true
        cr22.isHidden = true
        cr33.isHidden = true
        cr44.isHidden = true
        cr55.isHidden = true
        cr66.isHidden = true
        
        cr111.isHidden = true
        cr222.isHidden = true
        cr333.isHidden = true
        cr444.isHidden = true
        cr555.isHidden = true
        cr666.isHidden = true
        
        cr1111.isHidden = true
        cr2222.isHidden = true
        cr3333.isHidden = true
        cr4444.isHidden = true
        cr5555.isHidden = true
        cr6666.isHidden = true
        
        cr11111.isHidden = true
        cr22222.isHidden = true
        cr33333.isHidden = true
        cr44444.isHidden = true
        cr55555.isHidden = true
        cr66666.isHidden = true
    }
    
    // add shadow to circle
    func addShadow(_ crl: UIButton){
        crl.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        crl.layer.shadowOffset = CGSize(width: 1, height: 2)
        crl.layer.shadowOpacity = 2
        crl.layer.shadowRadius = 0.0
        crl.layer.masksToBounds = false
        crl.layer.cornerRadius = 0.5 * crl.bounds.size.width
    }
    
    // add color to circle
    func addColor(_ st: String){
        for (i,s) in st.enumerated() {
            
            if(s=="1"){
                if(i==0){
                    cr1.backgroundColor = UIColor(named: "Color1")
                    cr1.layer.borderWidth = 4
                    cr1.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr11.backgroundColor = UIColor(named: "Color1")
                    cr11.layer.borderWidth = 4
                    cr11.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr111.backgroundColor = UIColor(named: "Color1")
                    cr111.layer.borderWidth = 4
                    cr111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr1111.backgroundColor = UIColor(named: "Color1")
                    cr1111.layer.borderWidth = 4
                    cr1111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr11111.backgroundColor = UIColor(named: "Color1")
                    cr11111.layer.borderWidth = 4
                    cr11111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==1){
                    cr2.backgroundColor = UIColor(named: "Color1")
                    cr2.layer.borderWidth = 4
                    cr2.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr22.backgroundColor = UIColor(named: "Color1")
                    cr22.layer.borderWidth = 4
                    cr22.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr222.backgroundColor = UIColor(named: "Color1")
                    cr222.layer.borderWidth = 4
                    cr222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr2222.backgroundColor = UIColor(named: "Color1")
                    cr2222.layer.borderWidth = 4
                    cr2222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr22222.backgroundColor = UIColor(named: "Color1")
                    cr22222.layer.borderWidth = 4
                    cr22222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==2){
                  cr3.backgroundColor = UIColor(named: "Color1")
                    cr3.layer.borderWidth = 4
                    cr3.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr33.backgroundColor = UIColor(named: "Color1")
                      cr33.layer.borderWidth = 4
                      cr33.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr333.backgroundColor = UIColor(named: "Color1")
                      cr333.layer.borderWidth = 4
                      cr333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr3333.backgroundColor = UIColor(named: "Color1")
                      cr3333.layer.borderWidth = 4
                      cr3333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr33333.backgroundColor = UIColor(named: "Color1")
                      cr33333.layer.borderWidth = 4
                      cr33333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==3){
                    cr4.backgroundColor = UIColor(named: "Color1")
                    cr4.layer.borderWidth = 4
                    cr4.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr44.backgroundColor = UIColor(named: "Color1")
                    cr44.layer.borderWidth = 4
                    cr44.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr444.backgroundColor = UIColor(named: "Color1")
                    cr444.layer.borderWidth = 4
                    cr444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr4444.backgroundColor = UIColor(named: "Color1")
                    cr4444.layer.borderWidth = 4
                    cr4444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr44444.backgroundColor = UIColor(named: "Color1")
                    cr44444.layer.borderWidth = 4
                    cr44444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==4){
                    cr5.backgroundColor = UIColor(named: "Color1")
                    cr5.layer.borderWidth = 4
                    cr5.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr55.backgroundColor = UIColor(named: "Color1")
                    cr55.layer.borderWidth = 4
                    cr55.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr555.backgroundColor = UIColor(named: "Color1")
                    cr555.layer.borderWidth = 4
                    cr555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr5555.backgroundColor = UIColor(named: "Color1")
                    cr5555.layer.borderWidth = 4
                    cr5555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr55555.backgroundColor = UIColor(named: "Color1")
                    cr55555.layer.borderWidth = 4
                    cr55555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    
                }
                else{
                    cr6.backgroundColor = UIColor(named: "Color1")
                    cr6.layer.borderWidth = 4
                    cr6.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr66.backgroundColor = UIColor(named: "Color1")
                    cr66.layer.borderWidth = 4
                    cr66.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr666.backgroundColor = UIColor(named: "Color1")
                    cr666.layer.borderWidth = 4
                    cr666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr6666.backgroundColor = UIColor(named: "Color1")
                    cr6666.layer.borderWidth = 4
                    cr6666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr66666.backgroundColor = UIColor(named: "Color1")
                    cr66666.layer.borderWidth = 4
                    cr66666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
            }
        }
    }
}
