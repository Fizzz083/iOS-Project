//
//  ProfileViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 7/11/21.
//

import UIKit
import Foundation

import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var first_name: UILabel!
    
    @IBOutlet weak var last_name: UILabel!
    
    @IBOutlet weak var emai_l: UILabel!
     
    @IBOutlet weak var mobile: UILabel!
    
    @IBOutlet weak var cfid: UILabel!
    
    var ref: DatabaseReference!
    
  //  let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var blurview: UIView!
    //
//    let u = User()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swipeleft.direction = .left
        swipeleft.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeleft)
        
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swiperight.direction = .right
        swiperight.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swiperight)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       // first_name.text = appDelegate.Check
        let id : String = appDelegate.Check
        
        
     //   print("Idddd : \(appDelegate.Check)")
        
        
      // var m = myvar()
       //     ..first_name.text = myvar.person_str
        
       //     ..   print("hellO:    \(myvar.person_str)")
        
        
        let ref = Database.database().reference()
        
        
        ref.child("users").child(id).observe(.value, with: { (snapshot) in
           
                //print(snapshot.value as Any)
            
               // print(snapshot.childSnapshot(forPath: "Email").value ?? "Error")
            
            //let user = User()
            
           // self.emai_l.text = e_mail
            
            let e_mail : String = snapshot.childSnapshot(forPath: "Email").value as! String ?? "Error"
           
            let ff_name : String = snapshot.childSnapshot(forPath: "First Name").value as! String ?? "Error"
            let ll_name : String = snapshot.childSnapshot(forPath: "Last Name").value as! String ?? "Error"
            let mobile_ : String = snapshot.childSnapshot(forPath: "Mobile").value as! String //?? "Error"
            let cfid_ : String = snapshot.childSnapshot(forPath: "codeforcesId").value as! String  ?? "Error"
          
            print("Email : \(e_mail)  First Name : \(ff_name)")
            //let strr: String  = self.user.f_name ?? "Error"
            //
            
            self.first_name.text = ff_name
            self.last_name.text = ll_name
            self.emai_l.text = e_mail
            self.mobile.text = mobile_
            self.cfid.text = cfid_
            
           
            //print("ekahne aise: \(ProfileViewController.str)")
           // ProfileViewController().addVal(f_name: ff_name, l_name: ll_name, email: e_mail)
            
            
           // users = user
             
            
            
        
            
            
        })
         
         
         
        
//
//
////        let b = ViewController.user
////
//       first_name.text = b.f_name
//        last_name.text = b.l_name
//      emai_l.text = b.email
////
//
       // print(first_name.text)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapforswipe(sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .left {
            UIView.animate(withDuration: 0.35, animations: {
            let moveLeft = CGAffineTransform(translationX: -(self.blurview.bounds.width + 20), y: 0.0)
            self.blurview.transform = moveLeft
            })
        print("left..")
        }
        
        if sender.direction == .right {
            UIView.animate(withDuration: 0.35, animations: {
            let zero = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.blurview.transform = zero
                
            })
            
            print("right..")
            
            //blurview.isHidden = false
        }
        
        
        
    }
   
    
    @IBAction func logoutbutton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.Check = "No id"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginFirstPage")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
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
