//
//  LoginViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 4/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: Any) {
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "mainView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signupView")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    

}
