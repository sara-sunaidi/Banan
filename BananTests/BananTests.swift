//
//  BananTests.swift
//  BananTests
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import XCTest
@testable import Banan

class BananTests: XCTestCase {
    
    var emailAndPasswordVC: SignUp1ViewController!
    var dateVC : SignUp2ViewController!
    var genderVC : SignUp3ViewController!
    var nameVC : SignUp4ViewController!
    var resetPasswordVC : ResetPasswordViewController!
    var editDataVC : EditProfileViewController!
    var GameVC : GameViewController!
    var LoginVC : LogInViewContoller!

    
    
    override func setUp() {
        super.setUp()
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        
        emailAndPasswordVC = SignUp1ViewController()
        emailAndPasswordVC = mainStoryBoard.instantiateViewController(identifier: "SignUp1") as? SignUp1ViewController
        emailAndPasswordVC.loadViewIfNeeded()
        
        //-----
        dateVC = SignUp2ViewController()
        dateVC = mainStoryBoard.instantiateViewController(identifier: "SignUp2") as? SignUp2ViewController
        dateVC.loadViewIfNeeded()
        
        //-----
        genderVC = SignUp3ViewController()
        genderVC = mainStoryBoard.instantiateViewController(identifier: "SignUp3") as? SignUp3ViewController
        genderVC.loadViewIfNeeded()
        
        //-----
        nameVC = SignUp4ViewController()
        nameVC = mainStoryBoard.instantiateViewController(identifier: "SignUp4") as? SignUp4ViewController
        nameVC.loadViewIfNeeded()
        
        //-----
        resetPasswordVC = ResetPasswordViewController()
        resetPasswordVC = mainStoryBoard.instantiateViewController(identifier: "resetPass") as? ResetPasswordViewController
        resetPasswordVC.loadViewIfNeeded()
        
        //-----
        editDataVC = EditProfileViewController()
        editDataVC = mainStoryBoard.instantiateViewController(identifier: "editData") as? EditProfileViewController
        editDataVC.loadViewIfNeeded()
        
        //-----
        GameVC = GameViewController()
        GameVC = mainStoryBoard.instantiateViewController(identifier: "Game") as? GameViewController
        GameVC.loadViewIfNeeded()
        
        //-----
        LoginVC = LogInViewContoller()
        LoginVC = mainStoryBoard.instantiateViewController(identifier: "LogIn") as? LogInViewContoller
        LoginVC.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
        emailAndPasswordVC = nil
        dateVC = nil
        genderVC = nil
        nameVC = nil
        editDataVC = nil
        resetPasswordVC = nil
        GameVC = nil
        LoginVC = nil
        super.tearDown()
    }
    
    //TC1
    func test_empty_signup_email(){
        emailAndPasswordVC.Email.text = ""
        emailAndPasswordVC.Next(emailAndPasswordVC.submit)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال البريد الإلكتروني")
    }
    //TC2
    func test_invalid_signup_email(){
        XCTAssertEqual(emailAndPasswordVC.invalidEmail("test@"),"الرجاء إدخال البريد الإلكتروني بشكل صحيح")
    }
    
    //TC3
    func test_empty_signup_password(){
        emailAndPasswordVC.Email.text = "test@gmail.com"
        emailAndPasswordVC.password = ""
        emailAndPasswordVC.Next(emailAndPasswordVC.submit)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء اختيار شكل لتعيين كلمة المرور")
    }
    
    //TC4
    func test_empty_signup_date(){
        dateVC.email = "test@gmail.com"
        dateVC.password = "star123"
        dateVC.dob = ""
        dateVC.SignUp3(dateVC.submit)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال تاريخ الميلاد")
    }
    
    //TC5
    func test_empty_signup_gender(){
        genderVC.email = "test@gmail.com"
        genderVC.password = "star123"
        genderVC.dob = "Mar 25, 2016"
        genderVC.SignUp4(genderVC.submit)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء اختيار شكل لتعيين الشخصية")
    }
    
    //TC6
    func test_empty_signup_name(){
        nameVC.email = "test@gmail.com"
        nameVC.password = "star123"
        nameVC.dob = "Mar 25, 2016"
        nameVC.CreateAccount(nameVC.submit)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال الاسم")
    }
    
//    //TC7
    func test_invalid_signup_name(){
        nameVC.email = "test@gmail.com"
        nameVC.password = "star123"
        nameVC.dob = "Mar 25, 2016"
        nameVC.Name.text = "23Lujain"

        nameVC.CreateAccount(nameVC.submit)
        
        
        XCTAssertTrue(nameVC.isValid && nameVC.Name.text == "Lujain")

//        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال الاسم")
    }
    
//    //TC8
    
    //it does not wait
//    func test_signup_existing_email(){
//        nameVC.email = "sara.alsunaidi58@gmail.com"
//        nameVC.password = "star123"
//        nameVC.dob = "Mar 25, 2016"
//        nameVC.Name.text = "Sara"
//        nameVC.CreateAccount(nameVC.submit)
//
//        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text,     "هذا المستخدم مسجل بالفعل sara.alsunaidi58@gmail.com"
//)
//    }
    
    
//    //TC8
    // dont know how to test it, it looks like scenario
    func test_valid_signup(){
        nameVC.email = "test@gmail.com"
        nameVC.password = "star123"
        nameVC.dob = "Mar 25, 2016"
        nameVC.sex = "Girl"
        nameVC.Name.text = "ساره"
        nameVC.CreateAccount(nameVC.submit)

        XCTAssertTrue(nameVC.isValid)
    }
    
    
    //TC6
    func test_same_reset_password(){
        resetPasswordVC.oldPass = "star123"
        resetPasswordVC.newPass = "star123"

        resetPasswordVC.updatePassword(resetPasswordVC.saveButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال كلمة مرور جديدة مختلفة عن كلمة المرور السابقة")
    }
    
    
    func test_reset_password_empty_old(){
        resetPasswordVC.newPass = "star123"

        resetPasswordVC.updatePassword(resetPasswordVC.saveButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, " الرجاء إدخال كلمة المرور السابقة")
    }
    
    
    func test_reset_password_empty_new(){
        resetPasswordVC.oldPass = "star123"

        resetPasswordVC.updatePassword(resetPasswordVC.saveButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, " الرجاء إدخال كلمة المرور الجديدة")
    }
    
    //triangle
    
    func test_valid_reset_password(){
        resetPasswordVC.oldPass = "triangle"
        resetPasswordVC.newPass = "star123"

        resetPasswordVC.updatePassword(resetPasswordVC.saveButton)

        XCTAssertTrue(resetPasswordVC.isValid)

    }
    
    func test_edit_empty_name(){
            editDataVC.dob = "12 04, 2000"
            editDataVC.name.text = ""
            editDataVC.gender = "Boy"
            editDataVC.saveButtonPressed(editDataVC.save)
            
            XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال الاسم")
        }
    
    func test_valid_edit(){
            editDataVC.dob = "12 04, 2000"
            editDataVC.name.text = "ساره"
            editDataVC.gender = "Girl"
            editDataVC.saveButtonPressed(editDataVC.save)
            
            XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "تم تغيير المعلومات بنجاح")
        }
    
    func test_empty_login_email(){
        LoginVC.emailTextfield.text = ""
        
        LoginVC.loginPressed(LoginVC.LogInButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال البريد الالكتروني")
    }
    
    func test_invalid_login_email(){
        LoginVC.emailTextfield.text = "@gmail"
        LoginVC.loginPressed(LoginVC.LogInButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال البريد الالكتروني بشكل صحيح")
    }
    
    func test_empty_login_password(){
        LoginVC.emailTextfield.text = "testing@gmail.com"
        LoginVC.loginPressed(LoginVC.LogInButton)
        
        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال كلمة المرور")
    }
    
    func test_valid_login(){
        LoginVC.emailTextfield.text = "testing@gmail.com"
        LoginVC.password = "triangle"
        
        LoginVC.loginPressed(LoginVC.LogInButton)
        
        XCTAssertTrue(LoginVC.isValid)
    }
    
    //test pass level (not last) with and without hint
    func test_calculate_score(){
        let levelGame = [
            Game(AllLetters: ["Baa", "6aa", "Ttt"], Arabic: "بطة", Level: "First", Points: "80", Animal: "Duck", currentPoint: 0),
            Game(AllLetters: ["Kaf", "Lam", "Baa"], Arabic: "كلب", Level: "First", Points: "80", Animal: "Dog", currentPoint: 0),
            Game(AllLetters: ["Faa", "Yaa", "Lam"], Arabic: "فيل", Level: "First", Points: "80", Animal: "Elephant", currentPoint: 0)]
        
        GameVC.currentLevel = levelGame
        GameVC.isLastLevel = false
        GameVC.index = 0
//        GameVC.numOfHeart = 3
        GameVC.calculatePoints()
        
        
        GameVC.index = 1
//        GameVC.pressHint(GameVC.hintBtn)
        //or GameVC.numOfHeart = 2
        GameVC.calculatePoints()

        GameVC.index = 2
        GameVC.numOfHeart = 3 //reset num of hearts
        GameVC.calculatePoints()
        
        GameVC.finishLevel()
        
        let totalPoints = GameVC.levelUserPoints
        print(totalPoints)
        print(GameVC.isLastLevel)
        XCTAssertEqual(LevelDoneViewController.instance.title.text, "رائع")
//        XCTAssertEqual(LevelDoneViewController.instance.levelScore.text, "٢٤٠ +")
//        XCTAssertEqual(totalPoints, 240)
    }
    
    //test 1 incorrect answer  in level
    //remove private keyword from check answer method 
    func test_calculate_score_fail(){
        let levelGame = [
            Game(AllLetters: ["Baa", "6aa", "Ttt"], Arabic: "بطة", Level: "First", Points: "80", Animal: "Duck", currentPoint: 0),
            Game(AllLetters: ["Kaf", "Lam", "Baa"], Arabic: "كلب", Level: "First", Points: "80", Animal: "Dog", currentPoint: 0),
            Game(AllLetters: ["Faa", "Yaa", "Lam"], Arabic: "فيل", Level: "First", Points: "80", Animal: "Elephant", currentPoint: 0)]

        
        GameVC.currentLevel = levelGame
        
        GameVC.isLastLevel = false
        
        GameVC.index = 0
        GameVC.checkAnswer("ارنب")
        
        GameVC.index = 1
        GameVC.checkAnswer("كلب")
        
        GameVC.index = 2
        GameVC.checkAnswer("فيل")
        
        let totalPoints = GameVC.levelUserPoints
        print(totalPoints)
//        XCTAssertEqual(LevelDoneViewController.instance.title.text, "ممتاز")
//        XCTAssertEqual(LevelDoneViewController.instance.levelScore.text, "١٦٠ +")
        XCTAssertEqual(totalPoints, 160)
    }
    
    
    //test 2 incorrect answer  in level and fail
    //remove private keyword from check answer method
    func test_calculate_score_all_fail(){
        let levelGame = [
            Game(AllLetters: ["Baa", "6aa", "Ttt"], Arabic: "بطة", Level: "First", Points: "80", Animal: "Duck", currentPoint: 0),
            Game(AllLetters: ["Kaf", "Lam", "Baa"], Arabic: "كلب", Level: "First", Points: "80", Animal: "Dog", currentPoint: 0),
            Game(AllLetters: ["Faa", "Yaa", "Lam"], Arabic: "فيل", Level: "First", Points: "80", Animal: "Elephant", currentPoint: 0)]

        
        GameVC.currentLevel = levelGame
        
        GameVC.isLastLevel = false
        
        GameVC.viewDidLoad()
        
        
        GameVC.index = 0
        GameVC.checkAnswer("ارنب")
        
        GameVC.index = 1
        GameVC.checkAnswer("ارنب")

        GameVC.index = 2
//        GameVC.pressHint(GameVC.hintBtn)
//        GameVC.pressHint(GameVC.hintBtn)
//        GameVC.pressHint(GameVC.hintBtn)
        GameVC.numOfHeart = 0
        GameVC.checkAnswer("فيل")
        
        let totalPoints = GameVC.levelUserPoints
        print(totalPoints)
//        XCTAssertEqual(LevelFailViewController.instance.title.text, "حاول مرة اخرى")
        XCTAssertEqual(LevelFailViewController.instance.levelScore.text, "٢٠ +")
//        XCTAssertEqual(totalPoints, 20)
    }
    
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
