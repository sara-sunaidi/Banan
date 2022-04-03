//
//  FirstViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 02/04/2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLogged = UserDefaults.standard.bool(forKey: "isLogged")
        if(isLogged){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomePageViewController
            view.window?.rootViewController = controller
            view.window?.makeKeyAndVisible()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "startPage") as! StartScreenViewController
            view.window?.rootViewController = controller
            view.window?.makeKeyAndVisible()
        }
    }
    
}
