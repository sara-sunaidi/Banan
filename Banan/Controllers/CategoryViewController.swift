//
//  CategoryViewController.swift
//  Banan
//
//  Created by Reema khalaf on 16/08/1443 AH.
//

import UIKit

class CategoryViewController: UIViewController {

    var allWords = [Words]()
    
    var allMaterial = [Words]()
    var allFood = [Words]()
    var allPlace = [Words]()
    var allAnimal = [Words]()

    var completedCategory = [String]()
    var completedWords = [String]()

    var Category : String = ""
    var arabicCategory : String = ""

    @IBOutlet weak var material: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var animal: UIButton!
    
    
    @IBOutlet weak var completedMaterial: UILabel!
    @IBOutlet weak var completedFood: UILabel!
    @IBOutlet weak var completedPlace: UILabel!
    @IBOutlet weak var completedAnimal: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        getChildData()
        getWordsData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        material.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        food.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        place.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        animal.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        
        getChildData()
        getWordsData()
        groupByLevel()
        buttonCategory()

    }
            
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }}
    
    func setChildInfo(child: Child){
        self.completedCategory = child.completedCategories
        self.completedWords = child.completedWords
        
    }
    
    func getWordsData(){
        let word = LocalStorage.allWordsInfo
        if word != nil{
            allWords = word!
        }
    }

    
    func buttonCategory() {
        
    designButton(button: material, completed: completedCategory.contains("Material"), label: completedMaterial, catArray: allMaterial)
    designButton(button: food, completed: completedCategory.contains("Food"), label: completedFood, catArray: allFood)
    designButton(button: place, completed: completedCategory.contains("Place"), label: completedPlace, catArray: allPlace)
    designButton(button: animal, completed: completedCategory.contains("Animal"), label: completedAnimal, catArray: allAnimal)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func materialButton(_ sender: UIButton) {
        //        Category = "Material"
        //        arabicCategory = "أدوات"
        //        allWords = allMaterial
        //        performSegue(withIdentifier: "GoToWords", sender: self)
    }

    @IBAction func foodButton(_ sender: UIButton) {
        Category = "Food"
        arabicCategory = "أطعمة"
        allWords = allFood
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    
    @IBAction func placeButton(_ sender: UIButton) {
        //        Category = "Place"
        //        arabicCategory = "أماكن"
        //        allWords = allPlace
        //        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    
    @IBAction func animalButton(_ sender: UIButton) {
        Category = "Animal"
        arabicCategory = "حيوانات"
        allWords = allAnimal
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    

    
    func designButton(button : UIButton, completed: Bool, label:UILabel, catArray: [Words]){
        let filteredArray = catArray.map{$0.Word}
        let intersect = Set(filteredArray).intersection(completedWords).count
        
        let arabicIntersect = "\(intersect)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let arabicTotal = "\(filteredArray.count)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        if (intersect != 0) {
        label.text = "\(arabicTotal)/\(arabicIntersect) من الكلمات تم دراستها"
        }
        if (completed){
            button.tintColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
    }
    func groupByLevel() {

        allMaterial = allWords.filter({$0.Category == "Material"})
        allFood = allWords.filter({$0.Category == "Food"})
        allPlace = allWords.filter({$0.Category == "Place"})
        allAnimal = allWords.filter({$0.Category == "Animal"})
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToWords" {
            let destinationVC = segue.destination as? WordsViewController
            destinationVC?.category = Category
            destinationVC?.arabicCategory = arabicCategory

            }
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

