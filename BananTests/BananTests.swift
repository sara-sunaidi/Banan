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
        
        
        resetPasswordVC = ResetPasswordViewController()
        resetPasswordVC = mainStoryBoard.instantiateViewController(identifier: "resetPass") as? ResetPasswordViewController
        resetPasswordVC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        emailAndPasswordVC = nil
        dateVC = nil
        genderVC = nil
        nameVC = nil
        resetPasswordVC = nil
        
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
//    func test_invalid_signup_name(){
//        nameVC.email = "sara.alsunaidi58@gmail.com"
//        nameVC.password = "star123"
//        nameVC.dob = "Mar 25, 2016"
//        nameVC.name = "23"
//        nameVC.Name.text = "23"
//
//
////        nameVC.textField(nameVC.Name, shouldChangeCharactersIn: nameVC.Name.text..NSMakeRange(0, <#T##UInt#>), replacementString: nameVC.Name.text ?? "")
//
//        nameVC.CreateAccount(nameVC.submit)
//
//        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "الرجاء إدخال الاسم")
//    }
    
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
//    func test_valid_signup(){
//        nameVC.email = "test@gmail.com"
//        nameVC.password = "star123"
//        nameVC.dob = "Mar 25, 2016"
//        nameVC.sex = "Girl"
//        nameVC.name = "Lujain"
//
//        //        XCTAssert
//    }
    
    
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
    
//    //does not wait
//    func test_valid_reset_password(){
//        resetPasswordVC.oldPass = "triangle"
//        resetPasswordVC.newPass = "star123"
//
//        resetPasswordVC.updatePassword(resetPasswordVC.saveButton)
//        
//        XCTAssertEqual(CustomAcknowledgementViewController.instance.message.text, "تم تغير كلمة المرور بنجاح")
//    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
