//
//  LearWordsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 06/08/1443 AH.
//

import UIKit

class LearWordsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func materialButton(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToWords", sender: self)

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
