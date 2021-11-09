//
//  ViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 4/11/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import Foundation

class ViewController: UIViewController {
    
    var ProfilView: ProfileViewController?
    var ref: DatabaseReference!
    
    public var user = User()
    
   


    

    @IBOutlet weak var email: UITextField!
    
    
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("hoitese...")

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func loginButtonn(_ sender: Any) {
        
        validatefileds()
        
    }
    

    @IBAction func signupButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signupView")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    
    func validatefileds() {
//
//        if email.text?.isEmpty == true {
//
//            print("No text in email field")
//            return
//        }
//        if password.text?.isEmpty == true {
//            print("No text in password field")
//            return
//        }
        
        if ( password.text?.isEmpty == true || email.text?.isEmpty == true || isValidEmail(email.text!) == false )
        {
            let alert = UIAlertController(title: "Hey", message: "Invalid Email or Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        LOGIN()
    }
    
    func alertView ( s: String) -> Bool
    {
        let alert = UIAlertController(title: "Hey", message: s, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func LOGIN() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, err in
            guard let strongSelf = self else { return }
            if let err = err {
                
                let alert = UIAlertController(title: "Hey", message: "Invalid Email or Password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
        self.checkUserInfo()
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            
//            self.Myemail = Auth.auth().currentUser?.uid
            print("Hellooo   \(Auth.auth().currentUser?.uid)")
           
            
            let str1 : String = Auth.auth().currentUser?.uid ?? "Pogk1ROLMXYDFcY8BUDExLQDZCR2"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.Check = str1
            
            print("No id..")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "afterLogin")
            
            print("id: \(str1)")
            
            
            
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
       // getUserInfo()
    }
    
    func getUserInfo() {
        let ref = Database.database().reference()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        print("User found in Database   \(uid)")
        //users.removeAll()
        
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
           /* if snapshot.value != nil {
                for child in snapshot.children {
                    let user = User()
                    
                    let childSnapshot = child as! DataSnapshot
                    
                    if childSnapshot.hasChild("Email") {

                       let val = childSnapshot(forKeyPath: "Email").value as! String??
                      // user.email = childSnapshot(forPath: "Email").value as! String
                      if let val = childSnapshot.childSnapshot(forPath: "Email").value as? String ? {
                      if(val == email_)
                      {
                         print(val)                   }

                        }
                   }
                    
                    if childSnapshot.hasChild("First Name")
                    {
                        user.f_name = childSnapshot(forPath: "First Name").value as! String
                    }
                    if childSnapshot.hasChild("Last Name")
                    {
                        user.l_name = childSnapshot(forPath: "First Name").value as! String
                    }
                
                    
                    self.users.append(user)
                    
                }
            
            
            } */
                print(snapshot.value as Any)
            
            print(snapshot.childSnapshot(forPath: "Email").value ?? "Error")
            
            //let user = User()
            
            let e_mail : String = snapshot.childSnapshot(forPath: "Email").value as! String ?? "Error"
            
            self.user.email = e_mail
            
            let ff_name : String = snapshot.childSnapshot(forPath: "First Name").value as! String ?? "Error"
            let ll_name : String = snapshot.childSnapshot(forPath: "Last Name").value as! String ?? "Error"
            
            self.user.f_name = ff_name
            self.user.l_name = ll_name
            
            print("Email : \(e_mail)  First Name : \(ff_name)")
            let strr: String  = self.user.f_name ?? "Error"
            
            
           // ProfileViewController.str =
            
            //print(strr)
            
            let str1 : String = Auth.auth().currentUser?.uid ?? "Error"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.Check = str1
            
            print("ekhane : \(str1)")
        
            //appDelegate.Check = str1
          //  myvar.person_str = str1
           // print("id : \(myvar.person_str)")
            
           // ProfileViewController().addVal(f_name: ff_name, l_name: ll_name, email: e_mail)
            
            
           // users = user
        })
    }
  
    
}
                                  

                                   
