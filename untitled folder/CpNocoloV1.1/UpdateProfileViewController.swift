//
//  UpdateProfileViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 9/11/21.
//
import UIKit
import Foundation

import Firebase
import FirebaseDatabase
import FirebaseAuth



class UpdateProfileViewController: UIViewController {

//    @IBOutlet weak var FirstName: UILabel!
//
//    @IBOutlet weak var LastName: UILabel!
//
//    @IBOutlet weak var MobileNo: UILabel!
//
//    @IBOutlet weak var CfId: UILabel!
//
    @IBOutlet weak var blurview: UIView!
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var MobileNo: UITextField!
    
    @IBOutlet weak var cfid_: UITextField!
    
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
        let id : String = appDelegate.Check
        
        print("Idddd : \(appDelegate.Check)")
        
        let ref = Database.database().reference()
        
        
        ref.child("users").child(id).observe(.value, with: { (snapshot) in
           
            let FirstN : String = snapshot.childSnapshot(forPath: "First Name").value as! String ?? "Error"
           
            let LastN : String = snapshot.childSnapshot(forPath: "Last Name").value as! String ?? "Error"
            let MNo : String = snapshot.childSnapshot(forPath: "Mobile").value as! String ?? "Error"
            let cfIDD : String = snapshot.childSnapshot(forPath: "codeforcesId").value as! String ?? "Error"
            
           
            
//            self.FirstName.text = FirstN
//            self.LastName.text = LastN
//            self.cfId.text = cfIDD
//            self.MobileNo.text = MNo
//            
            
            //print(doc_text)
            
            //text = doc_text
           // self.enterdoctext.
            
        })

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
    
    
    @IBAction func updateprofilebutton(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let id : String = appDelegate.Check
        
        print("Idddd : \(appDelegate.Check)")
        
        let ref = Database.database().reference()
        
        
        ref.child("users").child(id).child("First Name").setValue(self.FirstName.text)
        ref.child("users").child(id).child("Last Name").setValue(self.LastName.text)
        ref.child("users").child(id).child("Mobile").setValue(self.MobileNo.text)
        ref.child("users").child(id).child("codeforcesId").setValue(self.cfid_.text)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "userProfile")
        

        
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
