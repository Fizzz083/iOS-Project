//
//  SignupViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 4/11/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import Foundation

class SignupViewController: UIViewController {
    

    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordFiled: UITextField!
    
    
    @IBOutlet weak var confirmPassField: UITextField!
    
    var ref: DatabaseReference!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpFinalButton(_ sender: Any) {
        
        if ( passwordFiled.text?.isEmpty == true || emailField.text?.isEmpty == true || isValidEmail(emailField.text!) == false  || firstNameField.text?.isEmpty == true || lastNameField.text?.isEmpty == true )
        {
            let alert = UIAlertController(title: "Hey", message: "Invalid Email or Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if ( confirmPassField.text != passwordFiled.text)
        {
            let alert = UIAlertController(title: "Hey", message: "Confirm your password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
        signUP()
        
                
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func signUP()
    {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordFiled.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                let alert = UIAlertController(title: "Hey", message: "Network error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("Error \(error?.localizedDescription)")
                return
            }
        }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            
            let str1 : String = Auth.auth().currentUser?.uid ?? "Pogk1ROLMXYDFcY8BUDExLQDZCR2"
            
            appDelegate.Check = str1
        
        sleep(2)
            
            print(str1)
            
            
            
            
            
            let firstN = self.firstNameField.text!
            let lastN = self.lastNameField.text!
            let passw = self.passwordFiled.text!
            
            let email = self.emailField.text!
            
            var num =  Int(NSDate().timeIntervalSince1970 * 1000) + Int(arc4random())
            
          //  print("random num : ")
           // print(num)
            
            let str = String(num)
            //let str1 : String = Auth.auth().currentUser?.uid ?? "Error"

          //  print("My id: ... ")//
          //  print(str1)
            
            let userM = [
                
                "First Name": firstN,
                "Last Name": lastN,
                "Id": str1,
                "Email": email,
                "Mobile": "01XXXXXXXXX",
                "doc": "your record..",
                "codeforcesId": "cfid"
                
            ]
            
            
            self.ref.child("users").child(str1).setValue(userM)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "afterLogin")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "afterLogin")
//
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
    }
    
    
    
    

   

}
